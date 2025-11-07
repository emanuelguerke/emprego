import * as UserModel from "../model/userModel.js";
import * as AuthModel from "../model/authModel.js";
//import * as CompanyModel from "../model/companyModel.js";

// validações simples reutilizáveis
function isValidEmail(email) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(String(email).toLowerCase());
}
function isValidPhone(phone) {
  const digitsOnly = phone.replace(/\D/g, ''); // remove tudo que não é número
  return /^\d{10,14}$/.test(digitsOnly);
}
function isValidName(name) {
  const s = (name || "").toString().trim();
  return s.length >= 4 && s.length <= 150;
}
function isValidPassword(pw) {
  return /^[A-Za-z0-9]{3,20}$/.test(String(pw));
}
function isValidLongString(s) {
  if (s === undefined || s === null) return true;
  const str = String(s).trim();
  if (str === "") return true; // optional
  return str.length >= 10 && str.length <= 600;
}

// GET /users -> (mantém existente) ...
export async function getUsers(req, res) {
  try {
    const users = await UserModel.getAllUsers();
    res.status(200).json(users);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
}

// GET /users/:id -> retorna apenas o próprio usuário (ownership)
export async function getUser(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "invalid token" });

    const idParam = Number(req.params.id);
    if (!Number.isInteger(idParam) || idParam <= 0) return res.status(404).json({ message: "user not found" });

    // ownership guard: only the same user with role 'user' can read
    if (req.user.role !== "user" || req.user.id !== idParam) {
      return res.status(403).json({ message: "forbidden" });
    }

    const user = await UserModel.getUserById(idParam);
    if (!user) return res.status(404).json({ message: "user not found" });

    return res.status(200).json({
      name: user.nome,
      username: user.usuario,
      email: user.email,
      phone: user.telefone,
      experience: user.experience || null,
      education: user.education || null
    });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

export async function updateUser(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "invalid token" });

    const idParam = Number(req.params.id);
    if (!Number.isInteger(idParam) || idParam <= 0) return res.status(404).json({ message: "user not found" });

    if (req.user.role !== "user" || req.user.id !== idParam) {
      return res.status(403).json({ message: "forbidden" });
    }

    const payload = req.body || {};
    // username immutable
    if (payload.username !== undefined && payload.username !== null && payload.username !== "") {
      return res.status(422).json({ message: "Validation error", code: "UNPROCESSABLE", details: [{ field: "username", error: "immutable" }] });
    }

    const errors = [];
    if (payload.name !== undefined && !isValidName(payload.name)) errors.push({ field: "name", error: "invalid_format" });
    if (payload.password !== undefined && payload.password !== "" && !isValidPassword(payload.password)) errors.push({ field: "password", error: "invalid_format" });
    if (payload.email !== undefined && payload.email !== "" && !isValidEmail(payload.email)) errors.push({ field: "email", error: "invalid_format" });
    if (payload.phone !== undefined && payload.phone !== "" && !isValidPhone(payload.phone)) errors.push({ field: "phone", error: "invalid_format" });
    if (payload.experience !== undefined && payload.experience !== "" && !isValidLongString(payload.experience)) errors.push({ field: "experience", error: "invalid_format" });
    if (payload.education !== undefined && payload.education !== "" && !isValidLongString(payload.education)) errors.push({ field: "education", error: "invalid_format" });

    if (errors.length) {
      return res.status(422).json({ message: "Validation error", code: "UNPROCESSABLE", details: errors });
    }

    const current = await UserModel.getUserById(idParam);
    if (!current) return res.status(404).json({ message: "user not found" });

    const toSave = {
      nome: payload.name !== undefined ? payload.name.trim() : current.nome,
      usuario: current.usuario, // never change
      senha: payload.password !== undefined && payload.password !== "" ? payload.password : current.senha,
      email: payload.email !== undefined ? (payload.email.trim() || null) : current.email,
      telefone: payload.phone !== undefined ? payload.phone : current.telefone,
      experience: payload.experience !== undefined ? payload.experience : current.experience,
      education: payload.education !== undefined ? payload.education : current.education,
      role: current.role || "user",
    };

    await UserModel.updateUser(idParam, toSave);
    return res.status(200).json({ message: "updated" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

export async function deleteUser(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "invalid token" });

    const idParam = Number(req.params.id);
    if (!Number.isInteger(idParam) || idParam <= 0) return res.status(404).json({ message: "user not found" });

    if (req.user.role !== "user" || req.user.id !== idParam) {
      return res.status(403).json({ message: "forbidden" });
    }

    const current = await UserModel.getUserById(idParam);
    if (!current) return res.status(404).json({ message: "user not found" });

    // revoke tokens for this user (if needed) handled elsewhere
    await UserModel.deleteUser(idParam);
    return res.status(200).json({ message: "User deleted successfully" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

// (removida geração de UUID — agora o DB fornece o id autoincrement)
// export async function createUser(req, res) { ... }  (substituído abaixo)

export async function createUser(req, res) {
  try {
    const payload = req.body || {};
    const errors = [];

    // name required, 4-150
    if (!payload.name || !isValidName(payload.name)) {
      errors.push({ field: "name", error: "too short" });
    }

    // username required, 3-20, letters/numbers/underscore
    if (!payload.username || !/^[A-Za-z0-9_]{3,20}$/.test(payload.username)) {
      errors.push({ field: "username", error: "invalid format" });
    }

    // password required, 3-20, alphanumeric
    if (!payload.password || !isValidPassword(payload.password)) {
      errors.push({ field: "password", error: "invalid format" });
    }

    // email optional, if present validate
    if (payload.email !== undefined && payload.email !== null && payload.email !== "") {
      if (!isValidEmail(payload.email)) errors.push({ field: "email", error: "invalid_format" });
    }

    // phone optional, if present validate
    if (payload.phone !== undefined && payload.phone !== null && payload.phone !== "") {
      if (!isValidPhone(payload.phone)) errors.push({ field: "phone", error: "invalid_format" });
    }

    // experience optional, if present validate 10-600 chars
    if (payload.experience !== undefined && payload.experience !== null && payload.experience !== "") {
      if (!isValidLongString(payload.experience)) errors.push({ field: "experience", error: "invalid_format" });
    }

    // education optional, if present validate 10-600 chars
    if (payload.education !== undefined && payload.education !== null && payload.education !== "") {
      if (!isValidLongString(payload.education)) errors.push({ field: "education", error: "invalid_format" });
    }

    // username uniqueness -> 409 if exists
    if (payload.username) {
      const existing = await UserModel.getUserByUsuario(payload.username);
      const existingCompanyUser = await UserModel.getCompanyByUsername(payload.username);
      if (existing || existingCompanyUser) {
        return res.status(409).json({ message: "username already exists" });
      }
    }

    if (errors.length) {
      return res.status(422).json({ message: "validation erro", code: "UNPROCESSABLE", details: errors });
    }
    
    // prepare user — do NOT set id, DB will assign auto-increment id
    const user = {
      nome: (payload.name || "").toString().trim().toUpperCase(),
      usuario: payload.username,
      senha: payload.password,
      email: payload.email || null,
      telefone: payload.phone || null,
      role: "user",
      experience: payload.experience || null,
      education: payload.education || null,
    };

    await UserModel.createUser(user);
    return res.status(201).json({ message: "created" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}
