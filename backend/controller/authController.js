import crypto from "crypto";
import * as UserModel from "../model/userModel.js";
import * as AuthModel from "../model/authModel.js";

const DEFAULT_EXPIRES_MS = 1000 * 60 * 60 * 24 * 365; // 1 ano

export async function login(req, res) {
    try {
        const { usuario, senha } = req.body;
        if (!usuario || !senha) return res.status(400).json({ message: "usuario e senha obrigatórios" });

        const user = await UserModel.getUserByUsuario(usuario);
        if (!user) return res.status(401).json({ message: "credenciais inválidas" });

        // ATENÇÃO: se usa senhas em texto plano, substitua por bcrypt.compare
        if (user.senha !== senha) return res.status(401).json({ message: "credenciais inválidas" });

        const token = crypto.randomBytes(48).toString("hex");
        const expiraem = new Date(Date.now() + DEFAULT_EXPIRES_MS);

        await AuthModel.createToken(user.id, token, expiraem);
        res.status(200).json({ token, expiraem });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}

export async function logout(req, res) {
    try {
        // espera header Authorization: Bearer <token>
        const auth = req.headers.authorization || "";
        const parts = auth.split(" ");
        const token = parts.length === 2 ? parts[1] : null;
        if (!token) return res.status(400).json({ message: "token faltando" });

        await AuthModel.revokeToken(token);
        res.status(200).json({ message: "logout realizado" });
    } catch (err) {
        res.status(500).json({ error: err.message });
    }
}