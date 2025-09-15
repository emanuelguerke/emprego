import express from "express";
import { login, logout } from "../controller/authController.js";

const router = express.Router();

// agora endpoints são /login e /logout na raiz
router.post("/login", login);
router.post("/logout", logout);

export default router;