import express from "express";
import { reportError } from "../controller/errorController.js";
import { verifyToken } from "../middleware/authMiddleware.js";

const router = express.Router();

// POST /error
router.post("/error", verifyToken, reportError);

export default router;