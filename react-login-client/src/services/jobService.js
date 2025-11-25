import api from "./authService";

// report a protocol mismatch / fallback from client to server
export async function reportServerError(message) {
  try {
    await api.post("/error", { message });
  } catch (e) {
    // ignore report failure
    console.warn("Failed to report server error:", e?.response?.data || e.message);
  }
}

// job endpoints
export async function createJob(payload) {
  const res = await api.post("/jobs", payload);
  return res.data;
}

export async function searchJobs(filters) {
  const res = await api.post("/jobs/search", { filters: [filters || {}] });
  return res.data;
}

// NEW: search jobs for a specific company (POST /companies/{company_id}/jobs)
// sends filters array with a single object even if fields empty
export async function searchCompanyJobs(company_id, filters) {
  const res = await api.post(`/companies/${company_id}/jobs`, { filters: [filters || { title:"", area:"", state:"", city:"", salary_range: {} }] });
  return res.data;
}

export async function getJob(id) {
  const res = await api.get(`/jobs/${id}`);
  return res.data;
}

export async function updateJob(id, payload) {
  const res = await api.patch(`/jobs/${id}`, payload);
  return res.data;
}

export async function deleteJob(id) {
  const res = await api.delete(`/jobs/${id}`);
  return res.data;
}

export async function applyToJob(id, payload) {
  const res = await api.post(`/jobs/${id}`, payload);
  return res.data;
}

export async function listCompanyApplicants(company_id, job_id) {
  const res = await api.get(`/companies/${company_id}/jobs/${job_id}`);
  return res.data;
}

export async function sendFeedback(job_id, payload) {
  const res = await api.post(`jobs/${job_id}/feedback`, payload);
  return res.data;
}

export async function listUserApplications(user_id) {
  const res = await api.get(`/users/${user_id}/jobs`);
  return res.data;
}