import { db } from "../db.js";

// estrutura de tabelas esperada:
// jobs: id, company_id, title, area, description, state, city, salary (nullable), contact_email, created_at
// applications: id, job_id, user_id, name, email, phone, education, experience, feedback (nullable), created_at

export function createJob(job) {
  return new Promise((resolve, reject) => {
    const sql = `INSERT INTO jobs (company_id, title, area, description, state, city, salary, contact_email) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`;
    db.query(sql, [job.company_id, job.title, job.area, job.description, job.state, job.city, job.salary || null, job.contact_email || null], (err, result) => {
      if (err) return reject(err);
      resolve({ id: result.insertId, ...job });
    });
  });
}

export function getJobById(id) {
  return new Promise((resolve, reject) => {
    const sql = `SELECT j.*, c.name AS company_name, c.email AS company_email FROM jobs j LEFT JOIN companies c ON c.id = j.company_id WHERE j.id = ?`;
    db.query(sql, [id], (err, results) => {
      if (err) return reject(err);
      resolve(results[0]);
    });
  });
}

export function updateJob(id, job) {
  return new Promise((resolve, reject) => {
    const sql = `UPDATE jobs SET title=?, area=?, description=?, state=?, city=?, salary=?, contact_email=? WHERE id = ?`;
    db.query(sql, [job.title, job.area, job.description, job.state, job.city, job.salary || null, job.contact_email || null, id], (err, result) => {
      if (err) return reject(err);
      resolve(result);
    });
  });
}

export function deleteJob(id) {
  return new Promise((resolve, reject) => {
    const sql = `DELETE FROM jobs WHERE id = ?`;
    db.query(sql, [id], (err, result) => {
      if (err) return reject(err);
      resolve(result);
    });
  });
}

export function searchJobs(filters) {
  return new Promise((resolve, reject) => {
    // Simple search builder - all filters optional
    let sql = `SELECT j.id AS job_id, j.title, j.area, COALESCE(c.name, '') AS company, j.description, j.state, j.city, j.salary, COALESCE(j.contact_email, c.email) AS contact
               FROM jobs j
               LEFT JOIN companies c ON c.id = j.company_id
               WHERE 1=1`;
    const params = [];
    if (filters.title) {
      sql += " AND j.title LIKE ?";
      params.push(`%${filters.title}%`);
    }
    if (filters.area) {
      sql += " AND j.area = ?";
      params.push(filters.area);
    }
    if (filters.company) {
      sql += " AND c.name LIKE ?";
      params.push(`%${filters.company}%`);
    }
    if (filters.state) {
      sql += " AND j.state LIKE ?";
      params.push(`%${filters.state}%`);
    }
    if (filters.city) {
      sql += " AND j.city LIKE ?";
      params.push(`%${filters.city}%`);
    }
    if (filters.salary_range) {
      if (filters.salary_range.min != null) { sql += " AND j.salary >= ?"; params.push(filters.salary_range.min); }
      if (filters.salary_range.max != null) { sql += " AND j.salary <= ?"; params.push(filters.salary_range.max); }
    }

    db.query(sql, params, (err, results) => {
      if (err) return reject(err);
      resolve(results || []);
    });
  });
}

// NEW: search jobs filtered by specific company_id
export function searchJobsByCompany(company_id, filters) {
  return new Promise((resolve, reject) => {
    let sql = `SELECT j.id AS job_id, j.title, j.area, COALESCE(c.name, '') AS company, j.description, j.state, j.city, j.salary, COALESCE(j.contact_email, c.email) AS contact
               FROM jobs j
               LEFT JOIN companies c ON c.id = j.company_id
               WHERE j.company_id = ?`;
    const params = [company_id];

    if (filters.title) {
      sql += " AND j.title LIKE ?";
      params.push(`%${filters.title}%`);
    }
    if (filters.area) {
      sql += " AND j.area = ?";
      params.push(filters.area);
    }
    if (filters.state) {
      sql += " AND j.state LIKE ?";
      params.push(`%${filters.state}%`);
    }
    if (filters.city) {
      sql += " AND j.city LIKE ?";
      params.push(`%${filters.city}%`);
    }
    if (filters.salary_range) {
      if (filters.salary_range.min != null) { sql += " AND j.salary >= ?"; params.push(filters.salary_range.min); }
      if (filters.salary_range.max != null) { sql += " AND j.salary <= ?"; params.push(filters.salary_range.max); }
    }

    db.query(sql, params, (err, results) => {
      if (err) return reject(err);
      resolve(results || []);
    });
  });
}

// applications
export function createApplication(application) {
  return new Promise((resolve, reject) => {
    const sql = `INSERT INTO applications (job_id, user_id, name, email, phone, education, experience) VALUES (?, ?, ?, ?, ?, ?, ?)`;
    db.query(sql, [application.job_id, application.user_id || null, application.name, application.email || null, application.phone || null, application.education, application.experience], (err, result) => {
      if (err) return reject(err);
      resolve({ id: result.insertId, ...application });
    });
  });
}

export function getApplicationsByJob(job_id) {
  return new Promise((resolve, reject) => {
    // Retorna apenas os campos solicitados pelo cliente
    const sql = `SELECT a.user_id, a.name, a.email, a.phone, a.education, a.experience
                 FROM applications a
                 WHERE a.job_id = ?`;
    db.query(sql, [job_id], (err, results) => {
      if (err) return reject(err);
      // garante formato consistente
      const items = (results || []).map(r => ({
        user_id: r.user_id,
        name: r.name,
        email: r.email,
        phone: r.phone,
        education: r.education,
        experience: r.experience
      }));
      resolve(items);
    });
  });
}

export function getUserApplications(user_id) {
  return new Promise((resolve, reject) => {
    const sql = `
      SELECT
        j.id AS job_id,
        j.title,
        j.area,
        COALESCE(c.name, '') AS company,
        j.description,
        j.state,
        j.city,
        j.salary,
        COALESCE(j.contact_email, c.email) AS contact,
        a.feedback
      FROM applications a
      LEFT JOIN jobs j ON j.id = a.job_id
      LEFT JOIN companies c ON c.id = j.company_id
      WHERE a.user_id = ?`;
    db.query(sql, [user_id], (err, results) => {
      if (err) return reject(err);
      const items = (results || []).map(r => ({
        job_id: r.job_id,
        title: r.title,
        area: r.area,
        company: r.company,
        description: r.description,
        state: r.state,
        city: r.city,
        salary: r.salary !== null ? Number(r.salary) : null,
        contact: r.contact,
        feedback: r.feedback || null
      }));
      resolve(items);
    });
  });
}

export function addFeedback(applicationId, feedback) {
  return new Promise((resolve, reject) => {
    const sql = `UPDATE applications SET feedback = ? WHERE id = ?`;
    db.query(sql, [feedback, applicationId], (err, result) => {
      if (err) return reject(err);
      resolve(result);
    });
  });
}

// adiciona atualização de feedback por job_id + user_id (usado quando não expomos id da aplicação)
export function addFeedbackByJobUser(job_id, user_id, feedback) {
  return new Promise((resolve, reject) => {
    const sql = `UPDATE applications SET feedback = ? WHERE job_id = ? AND user_id = ?`;
    db.query(sql, [feedback, job_id, user_id], (err, result) => {
      if (err) return reject(err);
      resolve(result);
    });
  });
}