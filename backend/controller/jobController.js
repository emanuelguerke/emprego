import * as JobModel from "../model/jobModel.js";
import * as CompanyModel from "../model/companyModel.js";
import * as UserModel from "../model/userModel.js";
import { getTokenRecord } from "../model/authModel.js";

// validação provisória até eu fazer algo melhor kkkkkkkk
const AREAS = ['administração','Administração','ADMINISTRAÇÃO','agricultura','Agricultura', 'AGRICULTURA','artes','Artes','ARTES','atendimento ao cliente','Atendimento ao Cliente', 'ATENDIMENTO AO CLIENTE','comercial','Comercial', 'COMERCIAL','comunicacao','COMUNICAÇÃO','Comunicação','construcao civil','Construção Civil','CONSTRUÇÃO CIVIL','consultoria','Consultoria','CONSULTORIA','contabilidade','Contabilidade','CONTABILIDADE','design','Design','DESIGN','educacao','Educação','EDUCAÇÃO','engenharia','Engenharia','ENGENHARIA','finanças','Finanças','FINANÇAS','jurídica','Jurídica','JURÍDICA','logística','Logística','LOGÍSTICA','Marketing','marketing','MARKETING','produção','Produção','PRODUÇÃO','recursos humanos','Recursos Humanos','RECURSOS HUMANOS','saúde','Saúde','SAÚDE','segurança','Segurança','SEGURANÇA','Tecnologia da Informação','tecnologia da informação','TECNOLOGIA DA INFORMAÇÃO','telemarketing','Telemarketing','TELEMARKETING','vendas','Vendas','VENDAS','outros','Outros','OUTROS'];

function isValidTitle(t){ const s = String(t||"").trim(); return s.length>=3 && s.length<=150; }
function isValidArea(a){ return AREAS.includes(String(a||"")); }
function isValidDescription(d){ const s=String(d||"").trim(); return s.length>=10 && s.length<=5000; }
function isValidState(s){ return !!String(s||"").trim(); }
function isValidCity(s){ return !!String(s||"").trim(); }
function isValidSalary(s){ if (s===undefined || s===null || s==="") return true; return typeof s === "number" && s>0; }

// POST /jobs  (create)
export async function createJob(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "Invalid token" });
    if (req.user.role !== "company") return res.status(403).json({ message: "Forbidden" });

    const payload = req.body || {};
    const errors = [];
    if (!isValidTitle(payload.title)) errors.push({ field: "title", error: "too_short" });
    if (!isValidArea(payload.area)) errors.push({ field: "area", error: "invalid_value" });
    if (!isValidDescription(payload.description)) errors.push({ field: "description", error: "invalid_format" });
    if (!isValidState(payload.state)) errors.push({ field: "state", error: "invalid_format" });
    if (!isValidCity(payload.city)) errors.push({ field: "city", error: "invalid_format" });
    if (!isValidSalary(payload.salary)) errors.push({ field: "salary", error: "must_be_number" });

    if (errors.length) return res.status(422).json({ message: "Validation error", code: "UNPROCESSABLE", details: errors });

    // ensure company exists
    const company = await CompanyModel.getCompanyById(req.user.id);
    if (!company) return res.status(404).json({ message: "Company not found" });

    const job = {
      company_id: req.user.id,
      title: payload.title.trim(),
      area: payload.area,
      description: payload.description.trim(),
      state: payload.state.trim(),
      city: payload.city.trim(),
      salary: payload.salary !== undefined ? Number(payload.salary) : null,
      contact_email: company.email || null
    };

    await JobModel.createJob(job);
    return res.status(201).json({ message: "Created" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

// POST /jobs/search
export async function searchJobs(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "Invalid token" });
    const body = req.body || {};
    const filters = (body.filters && body.filters[0]) ? body.filters[0] : {};
    const results = await JobModel.searchJobs(filters || {});
    if (!results || results.length === 0) return res.status(404).json({ message: "Job not found" });
    return res.status(200).json({ items: results });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

// GET /jobs/:id
export async function getJob(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "Invalid token" });
    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id<=0) return res.status(404).json({ message: "Job not found" });
    const job = await JobModel.getJobById(id);
    if (!job) return res.status(404).json({ message: "Job not found" });
    return res.status(200).json({
      job_id: job.id,
      title: job.title,
      area: job.area,
      description: job.description,
      company: job.company_name || "",
      city: job.city,
      state: job.state,
      contact: job.contact_email || job.company_email || null,
      salary: job.salary !== null ? Number(job.salary) : null
    });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

// PATCH /jobs/:id (edit) - only company owner
export async function updateJob(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "Invalid token" });
    if (req.user.role !== "company") return res.status(403).json({ message: "Forbidden" });

    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id<=0) return res.status(404).json({ message: "Job not found" });

    const current = await JobModel.getJobById(id);
    if (!current) return res.status(404).json({ message: "Job not found" });
    if (String(current.company_id) !== String(req.user.id)) return res.status(403).json({ message: "Forbidden" });

    const payload = req.body || {};
    const errors = [];
    if (!isValidTitle(payload.title)) errors.push({ field: "title", error: "too_short" });
    if (!isValidArea(payload.area)) errors.push({ field: "area", error: "invalid_value" });
    if (!isValidDescription(payload.description)) errors.push({ field: "description", error: "invalid_format" });
    if (!isValidState(payload.state)) errors.push({ field: "state", error: "invalid_format" });
    if (!isValidCity(payload.city)) errors.push({ field: "city", error: "invalid_format" });
    if (!isValidSalary(payload.salary)) errors.push({ field: "salary", error: "must_be_number" });

    if (errors.length) return res.status(422).json({ message: "Validation error", code: "UNPROCESSABLE", details: errors });

    const toSave = {
      title: payload.title.trim(),
      area: payload.area,
      description: payload.description.trim(),
      state: payload.state.trim(),
      city: payload.city.trim(),
      salary: payload.salary !== undefined ? Number(payload.salary) : null,
      contact_email: payload.contact || current.contact_email
    };

    await JobModel.updateJob(id, toSave);
    return res.status(200).json({ message: "Job updated successfully" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

// DELETE /jobs/:id
export async function deleteJob(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "Invalid token" });
    if (req.user.role !== "company") return res.status(403).json({ message: "Forbidden" });

    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id<=0) return res.status(404).json({ message: "Job not found" });

    const current = await JobModel.getJobById(id);
    if (!current) return res.status(404).json({ message: "Job not found" });
    if (String(current.company_id) !== String(req.user.id)) return res.status(403).json({ message: "Forbidden" });

    await JobModel.deleteJob(id);
    return res.status(200).json({ message: "Job deleted successfully" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

// POST /jobs/:id  -> apply (role=user)
export async function applyToJob(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "Invalid token" });
    if (req.user.role !== "user") return res.status(403).json({ message: "Forbidden" });

    const id = Number(req.params.id);
    if (!Number.isInteger(id) || id<=0) return res.status(404).json({ message: "Job not found" });
    const job = await JobModel.getJobById(id);
    if (!job) return res.status(404).json({ message: "Job not found" });

    const payload = req.body || {};
    if (!payload.name || !payload.education || !payload.experience) {
      return res.status(422).json({ message: "Validation error", code: "UNPROCESSABLE", details: [{ field: "name|education|experience", error: "required" }] });
    }
    if (String(payload.education).length > 600 || String(payload.experience).length > 600) {
      return res.status(422).json({ message: "Validation error", code: "UNPROCESSABLE", details: [{ field: "education|experience", error: "too_long" }] });
    }

    const application = {
      job_id: id,
      user_id: req.user.id,
      name: payload.name,
      email: payload.email || null,
      phone: payload.phone || null,
      education: payload.education,
      experience: payload.experience
    };

    await JobModel.createApplication(application);
    return res.status(200).json({ message: "Applied successfully" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

// GET /companies/:company_id/jobs/:job_id -> list applicants (company only owner)
export async function listApplicants(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "Invalid token" });
    if (req.user.role !== "company") return res.status(403).json({ message: "Forbidden" });

    const company_id = Number(req.params.company_id);
    const job_id = Number(req.params.job_id);
    if (String(req.user.id) !== String(company_id)) return res.status(403).json({ message: "Forbidden" });

    const job = await JobModel.getJobById(job_id);
    if (!job) return res.status(404).json({ message: "Job not found" });
    if (String(job.company_id) !== String(company_id)) return res.status(403).json({ message: "Forbidden" });

    const items = await JobModel.getApplicationsByJob(job_id);
    return res.status(200).json({ items });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

// POST feedback: /companies/:company_id/jobs/:job_id/feedback
export async function sendFeedback(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "Invalid token" });
    if (req.user.role !== "company") return res.status(403).json({ message: "Forbidden" });

    const company_id = Number(req.params.company_id);
    const job_id = Number(req.params.job_id);
    const { user_id, message } = req.body || {};

    //if (String(req.user.id) !== String(company_id)) return res.status(403).json({ message: "Forbidden" });

    const job = await JobModel.getJobById(job_id);
    if (!job) return res.status(404).json({ message: "Job not found" });
    //if (String(job.company_id) !== String(company_id)) return res.status(403).json({ message: "Forbidden" });

    if (!user_id) return res.status(422).json({ message: "Validation error", code: "UNPROCESSABLE", details: [{ field: "user_id", error: "required" }] });

    // busca candidaturas (retorna apenas campos públicos) e verifica existência
    const apps = await JobModel.getApplicationsByJob(job_id);
    const app = apps.find(a => String(a.user_id) === String(user_id));
    if (!app) return res.status(404).json({ message: "Job or User not found" });

    if (!message || String(message).trim().length < 10 || String(message).trim().length > 600) {
      return res.status(422).json({ message: "Validation error", code: "UNPROCESSABLE", details: [{ field: "message", error: "invalid_format" }] });
    }

    // atualiza por job_id + user_id (não dependemos do id da aplicação exposto)
    await JobModel.addFeedbackByJobUser(job_id, user_id, String(message).trim());
    return res.status(200).json({ message: "Feedback sent successfully" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

// GET /users/:user_id/jobs -> user's applications
export async function listUserApplications(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "Invalid token" });
    if (req.user.role !== "user") return res.status(403).json({ message: "Forbidden" });

    const user_id = Number(req.params.user_id);
    if (req.user.id !== user_id) return res.status(403).json({ message: "Forbidden" });

    const items = await JobModel.getUserApplications(user_id);
    return res.status(200).json({ items });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

// POST /companies/:company_id/jobs  -> company-specific search (requires company owner)
export async function searchCompanyJobs(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "Invalid token" });

    const company_id = Number(req.params.company_id);
    if (!Number.isInteger(company_id) || company_id <= 0) return res.status(404).json({ message: "Job not found" });

    // only the company owner may call this endpoint for its id
    if (req.user.role !== "company" || Number(req.user.id) !== company_id) {
      return res.status(403).json({ message: "Forbidden" });
    }

    const body = req.body || {};
    const filters = (body.filters && Array.isArray(body.filters) && body.filters[0]) ? body.filters[0] : {};

    // validate filter fields
    const errors = [];
    if (filters.title !== undefined && typeof filters.title !== "string") errors.push({ field: "title", error: "invalid_format" });
    if (filters.area !== undefined && typeof filters.area !== "string") errors.push({ field: "area", error: "invalid_format" });
    if (filters.state !== undefined && typeof filters.state !== "string") errors.push({ field: "state", error: "invalid_format" });
    if (filters.city !== undefined && typeof filters.city !== "string") errors.push({ field: "city", error: "invalid_format" });
    if (filters.salary_range !== undefined) {
      if (typeof filters.salary_range !== "object" || filters.salary_range === null) {
        errors.push({ field: "salary_range", error: "invalid_format" });
      } else {
        const { min, max } = filters.salary_range;
        if (min !== undefined && min !== null && typeof min !== "number") errors.push({ field: "salary_range.min", error: "invalid_format" });
        if (max !== undefined && max !== null && typeof max !== "number") errors.push({ field: "salary_range.max", error: "invalid_format" });
      }
    }

    if (errors.length) return res.status(422).json({ message: "Validation error", code: "UNPROCESSABLE", details: errors });

    // model
    const results = await JobModel.searchJobsByCompany(company_id, filters || {});
    if (!results || results.length === 0) return res.status(404).json({ message: "Job not found" });

    // normalize salary to numeric/null
    const items = results.map(r => ({
      job_id: r.job_id,
      title: r.title,
      area: r.area,
      company: r.company || "",
      description: r.description,
      state: r.state,
      city: r.city,
      salary: r.salary !== null ? Number(r.salary) : null,
      contact: r.contact || null
    }));

    return res.status(200).json({ items });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}