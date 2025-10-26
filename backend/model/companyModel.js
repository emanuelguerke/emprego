import { db } from "../db.js";

export function getCompanyByUsername(username) {
  return new Promise((resolve, reject) => {
    const sql = "SELECT * FROM companies WHERE username = ?";
    db.query(sql, [username], (err, results) => {
      if (err) return reject(err);
      resolve(results[0]);
    });
  });
}

export function getCompanyByName(name) {
  return new Promise((resolve, reject) => {
    const sql = "SELECT * FROM companies WHERE name = ?";
    db.query(sql, [name], (err, results) => {
      if (err) return reject(err);
      resolve(results[0]);
    });
  });
}

export function createCompany(company) {
  return new Promise((resolve, reject) => {
    const sql = `INSERT INTO companies
      (name, business, username, password, street, number, city, state, phone, email, role)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
    db.query(
      sql,
      [
        company.name,
        company.business,
        company.username,
        company.password,
        company.street,
        company.number,
        company.city,
        company.state,
        company.phone,
        company.email,
        company.role || "company",
      ],
      (err, result) => {
        if (err) return reject(err);
        resolve({ id: result.insertId, ...company });
      }
    );
  });
}

export function getCompanyById(id) {
  return new Promise((resolve, reject) => {
    const sql = "SELECT * FROM companies WHERE id = ?";
    db.query(sql, [id], (err, results) => {
      if (err) return reject(err);
      resolve(results[0]);
    });
  });
}

export function updateCompany(id, company) {
  return new Promise((resolve, reject) => {
    const sql = `UPDATE companies SET
      name = ?, business = ?, username = ?, password = ?, street = ?, number = ?, city = ?, state = ?, phone = ?, email = ?, role = ?
      WHERE id = ?`;
    db.query(
      sql,
      [
        company.name,
        company.business,
        company.username,
        company.password,
        company.street,
        company.number,
        company.city,
        company.state,
        company.phone,
        company.email,
        company.role || "company",
        id,
      ],
      (err, result) => {
        if (err) return reject(err);
        resolve(result);
      }
    );
  });
}

export function deleteCompany(id) {
  return new Promise((resolve, reject) => {
    const sql = "DELETE FROM companies WHERE id = ?";
    db.query(sql, [id], (err, result) => {
      if (err) return reject(err);
      resolve(result);
    });
  });
}