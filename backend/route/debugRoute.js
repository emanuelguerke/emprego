import express from "express";
import { apiActiveTokens, serveTokensPage } from "../controller/debugController.js";

const router = express.Router();

// open endpoints for local testing
router.get("/api/tokens", apiActiveTokens);
router.get("/tokens", serveTokensPage);

export default router;