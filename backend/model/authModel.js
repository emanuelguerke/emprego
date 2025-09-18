import { db } from "../db.js";

export function createToken(id_usuario, token, expiraem) {
    return new Promise((resolve, reject) => {
        const sql = "INSERT INTO token_usuarios (id_usuario, token, expiraem) VALUES (?, ?, ?)";
        db.query(sql, [id_usuario, token, expiraem], (err, result) => {
            if (err) return reject(err);
            resolve({ id: result.insertId, id_usuario, token, expiraem });
        });
    });
}

export function revokeToken(token) {
    return new Promise((resolve, reject) => {
        const sql = "UPDATE token_usuarios SET revogado = TRUE WHERE token = ?";
        db.query(sql, [token], (err, result) => {
            if (err) return reject(err);
            resolve(result);
        });
    });
}

// revoke all tokens for a given user (useful on account deletion)
export function revokeTokensByUser(id_usuario) {
    return new Promise((resolve, reject) => {
        const sql = "UPDATE token_usuarios SET revogado = TRUE WHERE id_usuario = ?";
        db.query(sql, [id_usuario], (err, result) => {
            if (err) return reject(err);
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