import express from "express";
import { createCompany, getCompany, updateCompany, deleteCompany } from "../controller/companyController.js";
import { verifyToken } from "../middleware/authMiddleware.js";

const router = express.Router();

// public registration
router.post("/", createCompany);

// protected
router.get("/:id", verifyToken, getCompany);
router.patch("/:id", verifyToken, updateCompany);
router.put("/:id", verifyToken, updateCompany);
router.delete("/:id", verifyToken, deleteCompany);

export default router;