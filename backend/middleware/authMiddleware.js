import jwt from "jsonwebtoken";
import * as AuthModel from "../model/authModel.js";

const JWT_SECRET = process.env.JWT_SECRET || "UTFPR"; //MUDAR ISSO DEPOIS PRO QUE FOR DECIDIDO NO PROTOCOLO

export async function verifyToken(req, res, next) {
  try {
    const auth = req.headers.authorization || "";
    const parts = auth.split(" ");
    if (parts.length !== 2 || parts[0] !== "Bearer") {
      return res.status(401).json({ message: "token ausente ou formato inválido" });
    }
    const token = parts[1];

    let decoded;
    try {
      decoded = jwt.verify(token, JWT_SECRET, { algorithms: ["HS256"] });
    } catch (err) {
      return res.status(401).json({ message: "token inválido ou expirado" });
    }

    // decoded must have sub, username, role
    if (!decoded.sub || !decoded.username || !decoded.role) {
      return res.status(401).json({ message: "token inválido" });
    }

    // check blacklist / revocation and DB expiration
    try {
      const record = await AuthModel.getTokenRecord(token);
      if (!record) {
        // token not found in store -> considered invalid (you can change policy if needed)
        return res.status(401).json({ message: "token inválido" });
      }
      if (record.revogado) {
        return res.status(401).json({ message: "token revogado" });
      }
      if (record.expiraem && new Date(record.expiraem) < new Date()) {
        return res.status(401).json({ message: "token expirado" });
      }
    } catch (err) {
      // DB error -> deny access
      return res.status(401).json({ message: "falha na validação do token" });
    }

    // attach user info to request
    req.user = {
      id: decoded.sub,
      username: decoded.username,
      role: decoded.role,
      exp: decoded.exp,
      rawToken: token,
    };

    next();
  } catch (err) {
    return res.status(401).json({ message: "autenticação falhou" });
  }
}

// helper to check roles (array or single)
export function requireRole(roles) {
  return (req, res, next) => {
    const r = Array.isArray(roles) ? roles : [roles];
    if (!req.user || !r.includes(req.user.role)) {
      return res.status(403).json({ message: "ação não permitida para este role" });
    }
    next();
  };
}