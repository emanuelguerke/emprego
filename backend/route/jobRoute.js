import express from "express";
import * as JobController from "../controller/jobController.js";
import { verifyToken } from "../middleware/authMiddleware.js";

const router = express.Router();

// create job (company)
router.post("/jobs", verifyToken, JobController.createJob);

// search jobs (POST to include body)
router.post("/jobs/search", verifyToken, JobController.searchJobs);

// read job
router.get("/jobs/:id", verifyToken, JobController.getJob);

// edit / delete (company owner)
router.patch("/jobs/:id", verifyToken, JobController.updateJob);
router.put("/jobs/:id", verifyToken, JobController.updateJob);
router.delete("/jobs/:id", verifyToken, JobController.deleteJob);

// apply to job (user)
router.post("/jobs/:id", verifyToken, JobController.applyToJob);

// company list applicants
router.get("/companies/:company_id/jobs/:job_id", verifyToken, JobController.listApplicants);

// company send feedback
router.post("/companies/:company_id/jobs/:job_id/feedback", verifyToken, JobController.sendFeedback);

// user list own applications
router.get("/users/:user_id/jobs", verifyToken, JobController.listUserApplications);

export default router;