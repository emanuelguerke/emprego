import jwt from "jsonwebtoken";
import * as UserModel from "../model/userModel.js";
import * as AuthModel from "../model/authModel.js";

const JWT_SECRET = process.env.JWT_SECRET || "UTFPR"; // trocar em produção
const DEFAULT_EXPIRES_SECONDS = 60 * 60 * 24; // 24h

export async function login(req, res) {
  try {
    // agora espera username e password no body
    const { username, password } = req.body || {};
    if (!username || !password) return res.status(400).json({ message: "username e password obrigatórios" });

    const user = await UserModel.getUserByUsuario(username);
    if (!user) return res.status(401).json({ message: "credenciais inválidas" });

    // ATENÇÃO: se usar bcrypt, troque por bcrypt.compare
    if (user.senha !== password) return res.status(401).json({ message: "credenciais inválidas" });

    const payload = {
      sub: user.id,
      username: user.usuario,
      role: user.role || "user",
    };

    const token = jwt.sign(payload, JWT_SECRET, { algorithm: "HS256", expiresIn: DEFAULT_EXPIRES_SECONDS });

    const expires_in = Math.floor(Date.now() / 1000) + DEFAULT_EXPIRES_SECONDS;
    const expiraemDate = new Date(expires_in * 1000);

    // salvar token para permitir revogação (blacklist)
    await AuthModel.createToken(user.id, token, expiraemDate);

    // NOTE: changed key name to "expires_in" as requested
    return res.status(200).json({ token, expires_in });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

export async function logout(req, res) {
  try {
    const auth = req.headers.authorization || "";
    const parts = auth.split(" ");
    const token = parts.length === 2 && parts[0] === "Bearer" ? parts[1] : null;
    if (!token) return res.status(401).json({ message: "Invalid token" });

    await AuthModel.revokeToken(token);
    return res.status(200).json({ message: "ok" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}