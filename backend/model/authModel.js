import { db } from "../db.js";

const activeTokens = new Map(); // token -> { username, role, id_usuario }

export function createToken(id_usuario, token, expiraem, role = "user") {
  return new Promise((resolve, reject) => {
    const sql = "INSERT INTO token_usuarios (id_usuario, token, expiraem) VALUES (?, ?, ?)";
    db.query(sql, [id_usuario, token, expiraem], (err, result) => {
      if (err) return reject(err);

      // Try to resolve username preferring the provided role but fallback to the other table if not found
      const tryCompany = (cb) =>
        db.query("SELECT username FROM companies WHERE id = ?", [id_usuario], (e, rows) => cb(e, rows && rows[0] ? rows[0].username : null));
      const tryUser = (cb) =>
        db.query("SELECT usuario FROM usuario WHERE id = ?", [id_usuario], (e, rows) => cb(e, rows && rows[0] ? rows[0].usuario : null));

      const finalize = (usernameResolved, resolvedRole) => {
        addActiveToken(usernameResolved || null, token, resolvedRole || role || "user", id_usuario);
        printActiveTokens();
        resolve({ id: result.insertId, id_usuario, token, expiraem, username: usernameResolved, role: resolvedRole || role });
      };

      if (role === "company") {
        tryCompany((err2, uname) => {
          if (err2) {
            // fallback to user table
            tryUser((err3, uname2) => {
              finalize(uname2, uname ? "company" : "user");
            });
          } else if (uname) {
            finalize(uname, "company");
          } else {
            tryUser((err3, uname2) => finalize(uname2, uname2 ? "user" : "company"));
          }
        });
      } else {
        // role === "user" or other: try user first, fallback to company
        tryUser((err2, uname) => {
          if (err2) {
            tryCompany((err3, uname2) => finalize(uname2, uname2 ? "company" : "user"));
          } else if (uname) {
            finalize(uname, "user");
          } else {
            tryCompany((err3, uname2) => finalize(uname2, uname2 ? "company" : "user"));
          }
        });
      }
    });
  });
}

export function revokeToken(token) {
  return new Promise((resolve, reject) => {
    const sql = "UPDATE token_usuarios SET revogado = TRUE WHERE token = ?";
    db.query(sql, [token], (err, result) => {
      if (err) return reject(err);
      removeActiveToken(token);
      printActiveTokens();
      resolve(result);
    });
  });
}

export function revokeTokensByUser(id_usuario) {
  return new Promise((resolve, reject) => {
    const sql = "UPDATE token_usuarios SET revogado = TRUE WHERE id_usuario = ?";
    db.query(sql, [id_usuario], (err, result) => {
      if (err) return reject(err);
      removeActiveTokensByUserId(id_usuario);
      printActiveTokens();
      resolve(result);
    });
  });
}

export function getTokenRecord(token) {
  return new Promise((resolve, reject) => {
    const sql = "SELECT * FROM token_usuarios WHERE token = ?";
    db.query(sql, [token], (err, results) => {
      if (err) return reject(err);
      resolve(results[0]);
    });
  });
}

export function initActiveTokens() {
  return new Promise((resolve, reject) => {
    const sql = `
      SELECT t.token, t.id_usuario,
             -- prefer company username when present
             COALESCE(c.username, u.usuario) AS username,
             CASE WHEN c.id IS NOT NULL THEN 'company' ELSE 'user' END AS role
      FROM token_usuarios t
      LEFT JOIN usuario u ON u.id = t.id_usuario
      LEFT JOIN companies c ON c.id = t.id_usuario
      WHERE COALESCE(t.revogado, FALSE) = FALSE
        AND (t.expiraem IS NULL OR t.expiraem > NOW())
    `;
    db.query(sql, [], (err, results) => {
      if (err) return reject(err);
      activeTokens.clear();
      results.forEach((r) => {
        const uname = r.username || null;
        activeTokens.set(r.token, { username: uname, role: r.role || "user", id_usuario: r.id_usuario });
      });
      printActiveTokens();
      resolve(activeTokens);
    });
  });
}

// helpers to manipulate in-memory list
export function addActiveToken(username, token, role = "user", id_usuario = null) {
  if (!token) return;
  activeTokens.set(token, { username: username || null, role: role || "user", id_usuario });
}

export function removeActiveToken(token) {
  if (!token) return;
  activeTokens.delete(token);
}

export function removeActiveTokensByUserId(userId) {
  if (userId === undefined || userId === null) return;
  for (const [token, info] of activeTokens.entries()) {
    if (String(info.id_usuario) === String(userId)) activeTokens.delete(token);
  }
}

export function getActiveTokens() {
  const arr = [];
  for (const [token, info] of activeTokens.entries()) {
    arr.push({ token, ...info });
  }
  return arr;
}

export function printActiveTokens() {
  try {
    console.log("============================== ***Lista de token ativos (usuarios logados)*** ==============================");
    let i = 1;
    for (const [token, info] of activeTokens.entries()) {
      const nameToShow = info.username ? info.username : "unknown";
      console.log(`${i} - Role: ${info.role} - Username: ${nameToShow} - Token: ${token}`);
      i++;
    }
    if (i === 1) console.log("***nenhum token ativo***");
    console.log("=============================================================================================================");
  } catch (e) {
    console.error("Falha ao imprimir tokens ativos:", e);
  }
}