import { db } from "../db.js";

const activeTokens = new Map(); // token -> username

export function createToken(id_usuario, token, expiraem) {
    return new Promise((resolve, reject) => {
        const sql = "INSERT INTO token_usuarios (id_usuario, token, expiraem) VALUES (?, ?, ?)";
        db.query(sql, [id_usuario, token, expiraem], (err, result) => {
            if (err) return reject(err);
            // obter username para indexar lista em memória
            db.query("SELECT usuario FROM usuario WHERE id = ?", [id_usuario], (err2, results2) => {
                const username = (!err2 && results2 && results2[0] && results2[0].usuario) ? results2[0].usuario : `id:${id_usuario}`;
                addActiveToken(username, token);
                printActiveTokens();
                resolve({ id: result.insertId, id_usuario, token, expiraem, username });
            });
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

// remove todos os token do usuario (usado para exclusão de conta)
export function revokeTokensByUser(id_usuario) {
    return new Promise((resolve, reject) => {
        const sql = "UPDATE token_usuarios SET revogado = TRUE WHERE id_usuario = ?";
        db.query(sql, [id_usuario], (err, result) => {
            if (err) return reject(err);
            // obter username para remover todos tokens correspondentes na lista em memória
            db.query("SELECT usuario FROM usuario WHERE id = ?", [id_usuario], (err2, results2) => {
                const username = (!err2 && results2 && results2[0] && results2[0].usuario) ? results2[0].usuario : null;
                if (username) {
                  removeActiveTokensByUsername(username);
                } else {
                 
                }
                printActiveTokens();
                resolve(result);
            });
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

// inicializa a lista em memória a partir do DB (tokens não revogados e não expirados)
export function initActiveTokens() {
    return new Promise((resolve, reject) => {
        const sql = `
          SELECT t.token, u.usuario
          FROM token_usuarios t
          LEFT JOIN usuario u ON u.id = t.id_usuario
          WHERE COALESCE(t.revogado, FALSE) = FALSE
            AND (t.expiraem IS NULL OR t.expiraem > NOW())
        `;
        db.query(sql, [], (err, results) => {
            if (err) return reject(err);
            activeTokens.clear();
            results.forEach((r) => {
                const token = r.token;
                const username = r.usuario || `id:unknown`;
                activeTokens.set(token, username);
            });
            printActiveTokens();
            resolve(activeTokens);
        });
    });
}

// funções para manipular a lista em memória
export function addActiveToken(username, token) {
    if (!token) return;
    activeTokens.set(token, username || `unknown`);
}

export function removeActiveToken(token) {
    if (!token) return;
    activeTokens.delete(token);
}

export function removeActiveTokensByUsername(username) {
    if (!username) return;
    for (const [token, user] of activeTokens.entries()) {
        if (user === username) activeTokens.delete(token);
    }
}

export function getActiveTokens() {
    // retorna array de { token, username }
    const arr = [];
    for (const [token, username] of activeTokens.entries()) {
        arr.push({ token, username });
    }
    return arr;
}

export function printActiveTokens() {
    try {
      console.log("============================== ***Lista de token ativos (usuarios logados)*** ==============================");
      let i = 1;
      for (const [token, username] of activeTokens.entries()) {
        console.log(`${i} - Usuario: ${username} - Token: ${token}`);
        i++;
      }
      if (i === 1) console.log("***nenhum token ativo***");
      console.log("=============================================================================================================");
    } catch (e) {
      console.error("Falha ao imprimir tokens ativos:", e);
    }
}