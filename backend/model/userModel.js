import { db } from "../db.js";

export function getAllUsers() {
    return new Promise((resolve, reject) => {
        const sql = "SELECT * FROM usuario";
        db.query(sql, (err, results) => {
            if (err) return reject(err);
            resolve(results);
        });
    });
}

export function getUserByUsuario(usuario) {
    return new Promise((resolve, reject) => {
        const sql = "SELECT * FROM usuario WHERE usuario = ?";
        db.query(sql, [usuario], (err, results) => {
            if (err) return reject(err);
            resolve(results[0]);
        });
    });
}

export function getUserById(id) {
    return new Promise((resolve, reject) => {
        const sql = "SELECT * FROM usuario WHERE id = ?";
        db.query(sql, [id], (err, results) => {
            if (err) return reject(err);
            resolve(results[0]);
        });
    });
}

export function createUser(user) {
    return new Promise((resolve, reject) => {
        const sql = "INSERT INTO usuario (id, nome, usuario, senha, email, telefone, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        db.query(sql, [user.id, user.nome, user.usuario, user.senha, user.email || null, user.telefone || null, user.role || "user"], (err, result) => {
            if (err) return reject(err);
            resolve({ id: user.id, ...user });
        });
    });
}

export function updateUser(id, user) {
    return new Promise((resolve, reject) => {
        const sql = "UPDATE usuario SET nome = ?, usuario = ?, senha = ?, email = ?, telefone = ?, role = ? WHERE id = ?";
        db.query(sql, [user.nome, user.usuario, user.senha, user.email || null, user.telefone || null, user.role || "user", id], (err, result) => {
            if (err) return reject(err);
            resolve(result);
        });
    });
}

export function deleteUser(id) {
    return new Promise((resolve, reject) => {
        const sql = "DELETE FROM usuario WHERE id = ?";
        db.query(sql, [id], (err, result) => {
            if (err) return reject(err);
            resolve(result);
        });
    });
}
