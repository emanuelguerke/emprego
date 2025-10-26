import jwt from "jsonwebtoken";
import * as AuthModel from "../model/authModel.js";

const JWT_SECRET = process.env.JWT_SECRET || "UTFPR"; // keep until env configured

export async function verifyToken(req, res, next) {
  try {
    const auth = req.headers.authorization || "";
    const parts = auth.split(" ");
    const token = parts.length === 2 && parts[0] === "Bearer" ? parts[1] : null;
    if (!token) return res.status(401).json({ message: "invalid token" });

    // verify signature and expiration
    let payload;
    try {
      payload = jwt.verify(token, JWT_SECRET, { algorithms: ["HS256"] });
    } catch (e) {
      return res.status(401).json({ message: "invalid token" });
    }

    // ensure payload has required fields
    if (!payload || typeof payload !== "object" || !payload.sub || !payload.role) {
      return res.status(401).json({ message: "invalid token" });
    }

    // sub must be numeric (id). Reject otherwise.
    const subNum = Number(payload.sub);
    if (!Number.isInteger(subNum) || subNum <= 0) {
      return res.status(401).json({ message: "invalid token" });
    }

    // check token exists in DB and not revoked
    const record = await AuthModel.getTokenRecord(token);
    if (!record || record.revogado) {
      return res.status(401).json({ message: "invalid token" });
    }

    // attach normalized user info to req.user
    req.user = {
      id: subNum,
      role: String(payload.role),
      username: payload.username || null,
      token,
    };

    return next();
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

/**
 * requireRole(roles)
 * roles: string or array of strings
 * usage: app.get("/x", verifyToken, requireRole("company"), handler)
 */
export function requireRole(roles) {
  const allowed = Array.isArray(roles) ? roles : [roles];
  return (req, res, next) => {
    if (!req.user) return res.status(401).json({ message: "invalid token" });
    if (!allowed.includes(req.user.role)) return res.status(403).json({ message: "forbidden" });
    next();
  };
}