import jwt from "jsonwebtoken";

const JWT_SECRET = process.env.JWT_SECRET || "change_this_secret_in_production";

export function verifyToken(req, res, next) {
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

    // attach user info to request
    req.user = {
      id: decoded.sub,
      username: decoded.username,
      role: decoded.role,
      exp: decoded.exp,
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