import * as UserModel from "../model/userModel.js";
import { v4 as uuidv4 } from "uuid";

// validações conforme especificação
function validateUserPayload(payload, isUpdate = false) {
    const errors = [];
    
    // nome: required on create, length 4-150, store uppercase
    if (!isUpdate || (payload.name !== undefined)) {
        const nome = (payload.name || "").toString().trim();
        if (!nome) {
            errors.push({ field: "nome", error: "required" });
        } else if (nome.length < 4) {
            errors.push({ field: "nome", error: "too short" });
        } else if (nome.length > 150) {
            errors.push({ field: "nome", error: "too long" });
        }
    }

    // usuario: required on create, unique, 3-20, no spaces, no special chars
    if (!isUpdate || (payload.username !== undefined)) {
        const usuario = (payload.username || "").toString();
        const usernameRegex = /^[A-Za-z0-9_]{3,20}$/;
        if (!usuario) {
            errors.push({ field: "usuario", error: "required" });
        } else if (!usernameRegex.test(usuario)) {
            errors.push({ field: "usuario", error: "invalid format" });
        }
    }

    // senha: required on create, 3-20, no spaces/special
    if (!isUpdate || (payload.password !== undefined)) {
        const senha = (payload.password || "").toString();
        const senhaRegex = /^[A-Za-z0-9]{3,20}$/;
        if (!senha) {
            errors.push({ field: "senha", error: "required" });
        } else if (!senhaRegex.test(senha)) {
            errors.push({ field: "senha", error: "invalid format" });
        }
    }

    // email: optional, if present must be valid
    if (payload.email !== undefined && payload.email !== null && payload.email !== "") {
        const email = (payload.email || "").toString().trim();
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            errors.push({ field: "email", error: "invalid email" });
        }
    }

    // telefone: optional, 10-14 digits
    if (payload.phone !== undefined && payload.phone !== null && payload.phone !== "") {
        const telefone = (payload.phone || "").toString().trim();
        const telRegex = /^\d{10,14}$/;
        if (!telRegex.test(telefone)) {
            errors.push({ field: "telefone", error: "invalid phone" });
        }
    }

    return errors;
}

export async function getUsers(req, res) {
    try {
        const users = await UserModel.getAllUsers();
        res.status(200).json(users);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

export async function getUser(req, res) {
    try {
        const user = await UserModel.getUserById(req.params.id);
        if (!user) return res.status(404).json({ message: "User not found" });
        res.json(user);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

export async function createUser(req, res) {
    try {
        const payload = req.body || {};
        const errors = validateUserPayload(payload, false);

        // check uniqueness of usuario
        if (payload.username) {
            const existing = await UserModel.getUserByUsuario(payload.username);
            if (existing) errors.push({ field: "usuario", error: "already exists" });
        }

        if (errors.length) {
            return res.status(404).json({ message: "validation erro", code: "UNPROCESSABLE", detail: errors });
        }

        // prepare user
        const id = uuidv4();
        const user = {
            id,
            nome: (payload.name || "").toString().trim().toUpperCase(),
            usuario: payload.username,
            senha: payload.password,
            email: payload.email || null,
            telefone: payload.phone || null,
        };

        const created = await UserModel.createUser(user);
        res.status(201).json(created);
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

export async function updateUser(req, res) {
    try {
        const id = req.params.id;
        const payload = req.body || {};

        // require authentication info present
        if (!req.user) return res.status(401).json({ message: "autenticação necessária" });

        // ownership: user can update only own resource unless role allows
        if (req.user.role !== "company" && req.user.id !== id) {
            return res.status(403).json({ message: "ação não permitida para este usuário" });
        }

        // rest of validation and update logic (reuse existing validateUserPayload)
        const errors = validateUserPayload(payload, true);

        if (payload.usuario) {
            const existing = await UserModel.getUserByUsuario(payload.usuario);
            if (existing && existing.id !== id) {
                errors.push({ field: "usuario", error: "already exists" });
            }
        }

        if (errors.length) {
            return res.status(404).json({ message: "validation erro", code: "UNPROCESSABLE", detail: errors });
        }

        const current = await UserModel.getUserById(id);
        if (!current) return res.status(404).json({ message: "User not found" });

        const toSave = {
            nome: payload.nome !== undefined ? payload.nome.toString().trim().toUpperCase() : current.nome,
            usuario: payload.usuario !== undefined ? payload.usuario : current.usuario,
            senha: payload.senha !== undefined ? payload.senha : current.senha,
            email: payload.email !== undefined ? payload.email : current.email,
            telefone: payload.telefone !== undefined ? payload.telefone : current.telefone,
            role: payload.role !== undefined ? payload.role : current.role,
        };

        await UserModel.updateUser(id, toSave);
        res.status(204).end();
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

export async function deleteUser(req, res) {
    try {
        const id = req.params.id;
        if (!req.user) return res.status(401).json({ message: "autenticação necessária" });

        // ownership: only owner or company role can delete
        if (req.user.role !== "company" && req.user.id !== id) {
            return res.status(403).json({ message: "ação não permitida para este usuário" });
        }

        await UserModel.deleteUser(id);
        res.status(204).end();
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}
