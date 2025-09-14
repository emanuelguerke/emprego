import jwt from "jsonwebtoken";
import * as UserModel from "../model/userModel.js";
import * as AuthModel from "../model/authModel.js";

const JWT_SECRET = process.env.JWT_SECRET || "UTFPR"; //MUDAR ISSO DEPOIS PRO QUE FOR DECIDIDO NO PROTOCOLO
const DEFAULT_EXPIRES_SECONDS = 60 * 60 * 24; // 24h

export async function login(req, res) {
  try {
    const { usuario, senha } = req.body || {};
    if (!usuario || !senha) return res.status(400).json({ message: "usuario e senha obrigatórios" });

    const user = await UserModel.getUserByUsuario(usuario);
    if (!user) return res.status(401).json({ message: "credenciais inválidas" });

    // ATENÇÃO: se você armazenar senhas hasheadas use bcrypt.compare aqui
    if (user.senha !== senha) return res.status(401).json({ message: "credenciais inválidas" });

    const payload = {
      sub: user.id,
      username: user.usuario,
      role: user.role || "user",
    };

    // sign token (exp será set pelo jwt)
    const token = jwt.sign(payload, JWT_SECRET, { algorithm: "HS256", expiresIn: DEFAULT_EXPIRES_SECONDS });

    // compute expiration timestamp (seconds since epoch) and store Date for DB
    const expires_in = Math.floor(Date.now() / 1000) + DEFAULT_EXPIRES_SECONDS;
    const expiraemDate = new Date(expires_in * 1000);

    // persist token in token_usuarios (blacklist store and for later revocation checks)
    await AuthModel.createToken(user.id, token, expiraemDate);

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
    if (!token) return res.status(400).json({ message: "token faltando" });

    // marca token como revogado
    await AuthModel.revokeToken(token);
    return res.status(204).end();
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}