import express from "express";
import { getUsers, getUser, createUser, updateUser, deleteUser } from "../controller/userController.js";
import { verifyToken } from "../middleware/authMiddleware.js";

const router = express.Router();

// POST /users -> registro público
router.post("/", createUser);

// Rotas protegidas por token
//pegar todos os usuarios desativada pois ainda não decidiram por administrador no protocolo
//router.get("/", verifyToken, getUsers);

router.get("/:id", verifyToken, getUser);
// aceitar tanto PUT quanto PATCH para atualização
router.put("/:id", verifyToken, updateUser);
router.patch("/:id", verifyToken, updateUser);
router.delete("/:id", verifyToken, deleteUser);

export default router;