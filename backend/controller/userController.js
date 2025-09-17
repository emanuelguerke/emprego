import * as UserModel from "../model/userModel.js";
import { v4 as uuidv4 } from "uuid";

// validações simples reutilizáveis
function isValidEmail(email) {
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return re.test(String(email).toLowerCase());
}
function isValidPhone(phone) {
  return /^\d{10,14}$/.test(String(phone));
}
function isValidName(name) {
  const s = (name || "").toString().trim();
  return s.length >= 4 && s.length <= 150;
}
function isValidPassword(pw) {
  return /^[A-Za-z0-9]{3,20}$/.test(String(pw));
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
    // middleware de autenticação deve preencher req.user
    if (!req.user) return res.status(401).json({ message: "invalid token" });

    const id = req.params.id;
    // ownership check: só pode ver próprio perfil
    if (req.user.id !== id) return res.status(403).json({ message: "forbidden" });

    const user = await UserModel.getUserById(id);
    if (!user) return res.status(404).json({ message: "user not found" });

    return res.status(200).json({
      name: user.nome || "",
      username: user.usuario || "",
      email: user.email || "",
      phone: user.telefone || "",
    });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
}

// PATCH /users/:id -> atualiza (apenas próprio usuário). username não pode ser alterado.
export async function updateUser(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "invalid token" });

    const id = req.params.id;
    if (req.user.id !== id) return res.status(403).json({ message: "forbidden" });

    const payload = req.body || {};
    // username must not be changed
    if (payload.username !== undefined && payload.username !== null && payload.username !== "") {
      // reject any attempt to change username
      return res.status(422).json({
        message: "Validation error",
        code: "UNPROCESSABLE",
        details: [{ field: "username", error: "immutable" }],
      });
    }

    const errors = [];
    if (payload.name !== undefined && !isValidName(payload.name)) {
      errors.push({ field: "name", error: "invalid_format" });
    }
    if (payload.email !== undefined && payload.email !== "" && !isValidEmail(payload.email)) {
      errors.push({ field: "email", error: "invalid_format" });
    }
    if (payload.phone !== undefined && payload.phone !== "" && !isValidPhone(payload.phone)) {
      errors.push({ field: "phone", error: "invalid_format" });
    }
    if (payload.password !== undefined && payload.password !== "" && !isValidPassword(payload.password)) {
      errors.push({ field: "password", error: "invalid_format" });
    }

    if (errors.length) {
      return res.status(422).json({
        message: "Validation error",
        code: "UNPROCESSABLE",
        details: errors,
      });
    }

    const current = await UserModel.getUserById(id);
    if (!current) return res.status(404).json({ message: "user not found" });

    // prepare fields (preserve existing where not provided)
    const toSave = {
      nome: payload.name !== undefined ? payload.name.toString().trim().toUpperCase() : current.nome,
      usuario: current.usuario, // username cannot change
      senha: payload.password !== undefined && payload.password !== "" ? payload.password : current.senha,
      email: payload.email !== undefined ? (payload.email || null) : current.email,
      telefone: payload.phone !== undefined ? (payload.phone || null) : current.telefone,
      role: current.role || "user",
    };

    await UserModel.updateUser(id, toSave);
    return res.status(200).json({ message: "sucess" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
}

// DELETE /users/:id -> apenas próprio usuário
export async function deleteUser(req, res) {
  try {
    if (!req.user) return res.status(401).json({ message: "invalid token" });

    const id = req.params.id;
    if (req.user.id !== id) return res.status(403).json({ message: "forbidden" });

    const current = await UserModel.getUserById(id);
    if (!current) return res.status(404).json({ message: "user not found" });

    await UserModel.deleteUser(id);
    return res.status(200).json({ message: "User deleted successfully" });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
}

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

    // username uniqueness -> 409 if exists
    if (payload.username) {
      const existing = await UserModel.getUserByUsuario(payload.username);
      if (existing) {
        return res.status(409).json({ message: "username already exists" });
      }
    }

    if (errors.length) {
      return res.status(404).json({ message: "validation erro", code: "UNPROCESSABLE", detail: errors });
    }

    const id = uuidv4();
    const user = {
      id,
      nome: (payload.name || "").toString().trim().toUpperCase(),
      usuario: payload.username,
      senha: payload.password,
      email: payload.email || null,
      telefone: payload.phone || null,
      role: "user",
    };

    await UserModel.createUser(user);
    return res.status(201).json({ message: "created" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}
