import axios from "axios";

const DEFAULT_BASE = "http://localhost:8080";

function getStoredBase() {
  try {
    return localStorage.getItem("api_base") || DEFAULT_BASE;
  } catch {
    return DEFAULT_BASE;
  }
}

const api = axios.create({
  baseURL: getStoredBase(),
  headers: { "Content-Type": "application/json" },
});

api.interceptors.request.use((config) => {
  const token = localStorage.getItem("token");
  if (token) config.headers.Authorization = `Bearer ${token}`;
  return config;
});

export async function login({ username, password }) {
  const res = await api.post("/login", { username, password });
  return res.data; // { token, expires_in }
}

export async function register(payload) {
  const res = await api.post("/users", payload);
  return res.data;
}

export function setToken(token) {
  if (token) localStorage.setItem("token", token);
  else localStorage.removeItem("token");
}

export function getToken() {
  return localStorage.getItem("token");
}

export function decodeToken() {
  try {
    const t = getToken();
    if (!t) return null;
    const parts = t.split(".");
    if (parts.length !== 3) return null;
    const payload = JSON.parse(atob(parts[1].replace(/-/g, "+").replace(/_/g, "/")));
    return payload;
  } catch {
    return null;
  }
}

export function isAuthenticated() {
  return !!getToken();
}

export function logout() {
  localStorage.removeItem("token");
}

export async function logoutServer() {
  try {
    await api.post("/logout");
  } catch {
    // ignore
  } finally {
    localStorage.removeItem("token");
  }
}

export function setApiBase(baseUrl) {
  const final = baseUrl || DEFAULT_BASE;
  try { localStorage.setItem("api_base", final); } catch {}
  api.defaults.baseURL = final;
}

export function getApiBase() {
  return api.defaults.baseURL || getStoredBase();
}

export default api;