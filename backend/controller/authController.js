import jwt from "jsonwebtoken";
import * as UserModel from "../model/userModel.js";

const JWT_SECRET = process.env.JWT_SECRET || "change_this_secret_in_production";
const DEFAULT_EXPIRES_SECONDS = 60 * 60 * 24; // 24h

export async function login(req, res) {
  try {
    const { usuario, senha } = req.body || {};
    if (!usuario || !senha) return res.status(400).json({ message: "usuario e senha obrigatórios" });

    const user = await UserModel.getUserByUsuario(usuario);
    if (!user) return res.status(401).json({ message: "credenciais inválidas" });

    // ATENÇÃO: se you store hashed passwords use bcrypt.compare here
    if (user.senha !== senha) return res.status(401).json({ message: "credenciais inválidas" });

    const payload = {
      sub: user.id,
      username: user.usuario,
      role: user.role || "user",
    };

    const token = jwt.sign(payload, JWT_SECRET, { algorithm: "HS256", expiresIn: DEFAULT_EXPIRES_SECONDS, noTimestamp: true });

    const exp = Math.floor(Date.now() / 1000) + DEFAULT_EXPIRES_SECONDS;

    return res.status(200).json({ token, exp });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

export async function logout(req, res) {
  // With stateless JWT we don't need to do server-side revocation here.
  // If you want revocation, implement a blacklist store.
  return res.status(204).end();
}