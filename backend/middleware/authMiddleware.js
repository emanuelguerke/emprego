import * as AuthModel from "../model/authModel.js";
import * as UserModel from "../model/userModel.js";

export async function verifyToken(req, res, next) {
    try {
        const auth = req.headers.authorization || "";
        const parts = auth.split(" ");
        const token = parts.length === 2 ? parts[1] : null;
        if (!token) return res.status(401).json({ message: "token ausente" });

        const record = await AuthModel.getTokenRecord(token);
        if (!record) return res.status(401).json({ message: "token inválido" });
        if (record.revogado) return res.status(401).json({ message: "token revogado" });
        if (record.expiraem && new Date(record.expiraem) < new Date()) return res.status(401).json({ message: "token expirado" });

        const user = await UserModel.getUserById(record.id_usuario);
        if (!user) return res.status(401).json({ message: "usuário não existe" });

        req.user = user;
        next();
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}