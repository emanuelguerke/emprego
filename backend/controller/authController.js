import jwt from "jsonwebtoken";
import * as UserModel from "../model/userModel.js";
import * as CompanyModel from "../model/companyModel.js";
import * as AuthModel from "../model/authModel.js";

const JWT_SECRET = process.env.JWT_SECRET || "UTFPR";
const DEFAULT_EXPIRES_SECONDS = 60 * 60 * 24; // 24h

export async function login(req, res) {
  try {
    const { username, password } = req.body || {};
    if (!username || !password) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    // try user first
    let actor = await UserModel.getUserByUsuario(username);
    let actorType = "user";
    // if not found as user, try company
    if (!actor) {
      actor = await CompanyModel.getCompanyByUsername(username);
      actorType = actor ? "company" : actorType;
    }

    if (!actor) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    // check password field name differences
    const storedPassword = actor.senha ?? actor.password ?? null;
    if (!storedPassword || storedPassword !== password) {
      return res.status(401).json({ message: "Invalid credentials" });
    }

    const payload = {
      sub: String(actor.id),
      username: actor.usuario ?? actor.username,
      role: actor.role || (actorType === "company" ? "company" : "user"),
    };

    const token = jwt.sign(payload, JWT_SECRET, {
      algorithm: "HS256",
      expiresIn: DEFAULT_EXPIRES_SECONDS,
      noTimestamp: true,
    });

    const expires_in = Math.floor(Date.now() / 1000) + DEFAULT_EXPIRES_SECONDS;
    const expiraemDate = new Date(expires_in * 1000);

    // persist token for revocation — envia também role para indexação correta
    await AuthModel.createToken(actor.id, token, expiraemDate, payload.role);

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

    const record = await AuthModel.getTokenRecord(token);
    if (!record || record.revogado) {
      return res.status(401).json({ message: "Invalid token" });
    }

    await AuthModel.revokeToken(token);
    return res.status(200).json({ message: "ok" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}