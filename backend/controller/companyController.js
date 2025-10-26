import * as CompanyModel from "../model/companyModel.js";
import * as AuthModel from "../model/authModel.js";

function isValidEmail(email) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(String(email).toLowerCase());
}
function isValidPhone(phone) {
  const digits = String(phone || "").replace(/\D/g, "");
  return /^\d{10,14}$/.test(digits);
}
function isValidNameField(s, min = 3, max = 150) {
  const v = String(s || "").trim();
  return v.length >= min && v.length <= max;
}
function isValidUsername(u) {
  return /^[A-Za-z0-9_]{3,20}$/.test(String(u || ""));
}
function isValidPassword(pw) {
  return /^[A-Za-z0-9]{3,20}$/.test(String(pw || ""));
}
function isValidNumberField(n) {
  if (n === "") return true; // allow empty string per spec
  if (!/^\d+$/.test(String(n))) return false;
  const len = String(n).length;
  return len >= 1 && len <= 8;
}

export async function createCompany(req, res) {
  try {
    const payload = req.body || {};
    const errors = [];

    if (!isValidNameField(payload.name, 4, 150)) errors.push({ field: "name", error: "invalid_format" });
    if (!isValidNameField(payload.business, 4, 150)) errors.push({ field: "business", error: "invalid_format" });
    if (!isValidUsername(payload.username)) errors.push({ field: "username", error: "invalid_format" });
    if (!isValidPassword(payload.password)) errors.push({ field: "password", error: "invalid_format" });
    if (!isValidNameField(payload.street, 3, 150)) errors.push({ field: "street", error: "invalid_format" });
    if (!isValidNumberField(payload.number)) errors.push({ field: "number", error: "must_be_positive_int" });
    if (!isValidNameField(payload.city, 3, 150)) errors.push({ field: "city", error: "invalid_format" });
    if (!isValidNameField(payload.state, 2, 150)) errors.push({ field: "state", error: "invalid_format" });
    if (!isValidPhone(payload.phone)) errors.push({ field: "phone", error: "invalid_format" });
    if (!isValidEmail(payload.email) || !isValidNameField(payload.email, 10, 150)) errors.push({ field: "email", error: "invalid_format" });

    if (errors.length) {
      return res.status(422).json({ message: "One or more fields are incorrect.", code: "UNPROCESSABLE", details: errors });
    }

    // uniqueness checks
    const existingName = await CompanyModel.getCompanyByName(payload.name);
    if (existingName) return res.status(409).json({ message: "Company name already exists" });

    const existingUser = await CompanyModel.getCompanyByUsername(payload.username);
    if (existingUser) return res.status(409).json({ message: "Username already exists" });

    const company = {
      name: payload.name.trim(),
      business: payload.business.trim(),
      username: payload.username,
      password: payload.password,
      street: payload.street.trim(),
      number: payload.number,
      city: payload.city.trim(),
      state: payload.state.trim(),
      phone: payload.phone,
      email: payload.email.trim(),
      role: "company",
    };

    await CompanyModel.createCompany(company);
    return res.status(200).json({ message: "Created" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

export async function getCompany(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "invalid token" });

    const id = req.params.id;
    // only same id and role=company allowed
    if (String(req.user.id) !== String(id) || req.user.role !== "company") return res.status(403).json({ message: "forbidden" });

    const company = await CompanyModel.getCompanyById(id);
    if (!company) return res.status(404).json({ message: "company not found" });

    return res.status(200).json({
      name: company.name,
      business: company.business,
      username: company.username,
      street: company.street,
      number: company.number,
      city: company.city,
      state: company.state,
      phone: company.phone,
      email: company.email,
    });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

export async function updateCompany(req, res) {
  try {
    if (!req.is || !req.is("application/json")) {
      return res.status(400).json({ message: "request must be application/json" });
    }
    if (!req.user) return res.status(401).json({ message: "invalid token" });

    const id = req.params.id;
    if (String(req.user.id) !== String(id) || req.user.role !== "company") return res.status(403).json({ message: "forbidden" });

    const payload = req.body || {};
    // username not editable
    if (payload.username !== undefined && payload.username !== null && payload.username !== "") {
      return res.status(422).json({ message: "Validation error", code: "UNPROCESSABLE", details: [{ field: "username", error: "immutable" }] });
    }

    const errors = [];
    if (payload.name !== undefined && !isValidNameField(payload.name, 4, 150)) errors.push({ field: "name", error: "invalid_format" });
    if (payload.business !== undefined && !isValidNameField(payload.business, 4, 150)) errors.push({ field: "business", error: "invalid_format" });
    if (payload.password !== undefined && payload.password !== "" && !isValidPassword(payload.password)) errors.push({ field: "password", error: "invalid_format" });
    if (payload.street !== undefined && !isValidNameField(payload.street, 3, 150)) errors.push({ field: "street", error: "invalid_format" });
    if (payload.number !== undefined && !isValidNumberField(payload.number)) errors.push({ field: "number", error: "must_be_positive_int" });
    if (payload.city !== undefined && !isValidNameField(payload.city, 3, 150)) errors.push({ field: "city", error: "invalid_format" });
    if (payload.state !== undefined && !isValidNameField(payload.state, 2, 150)) errors.push({ field: "state", error: "invalid_format" });
    if (payload.phone !== undefined && !isValidPhone(payload.phone)) errors.push({ field: "phone", error: "invalid_format" });
    if (payload.email !== undefined && (!isValidEmail(payload.email) || !isValidNameField(payload.email, 10, 150))) errors.push({ field: "email", error: "invalid_format" });

    if (errors.length) {
      return res.status(422).json({ message: "Validation error", code: "UNPROCESSABLE", details: errors });
    }

    const current = await CompanyModel.getCompanyById(id);
    if (!current) return res.status(404).json({ message: "company not found" });

    const toSave = {
      name: payload.name !== undefined ? payload.name.trim() : current.name,
      business: payload.business !== undefined ? payload.business.trim() : current.business,
      username: current.username,
      password: payload.password !== undefined && payload.password !== "" ? payload.password : current.password,
      street: payload.street !== undefined ? payload.street.trim() : current.street,
      number: payload.number !== undefined ? payload.number : current.number,
      city: payload.city !== undefined ? payload.city.trim() : current.city,
      state: payload.state !== undefined ? payload.state.trim() : current.state,
      phone: payload.phone !== undefined ? payload.phone : current.phone,
      email: payload.email !== undefined ? (payload.email.trim() || null) : current.email,
      role: current.role || "company",
    };

    await CompanyModel.updateCompany(id, toSave);
    return res.status(200).json({ message: "updated" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

export async function deleteCompany(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "invalid token" });

    const id = req.params.id;
    if (String(req.user.id) !== String(id) || req.user.role !== "company") return res.status(403).json({ message: "forbidden" });

    const current = await CompanyModel.getCompanyById(id);
    if (!current) return res.status(404).json({ message: "company not found" });

    // revoke current token + all tokens for this id
    try {
      const auth = req.headers.authorization || "";
      const parts = auth.split(" ");
      const token = parts.length === 2 && parts[0] === "Bearer" ? parts[1] : null;
      if (token) await AuthModel.revokeToken(token).catch(()=>{});
      await AuthModel.revokeTokensByUser(id).catch(()=>{});
    } catch (e) {}

    await CompanyModel.deleteCompany(id);
    return res.status(200).json({ message: "Company deleted successfully" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}