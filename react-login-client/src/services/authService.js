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

// anexa Authorization: Bearer <token> automaticamente
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

export function isAuthenticated() {
    return !!getToken();
}

// local logout
export function logout() {
    localStorage.removeItem("token");
}

// server logout (revoga token no servidor)
export async function logoutServer() {
    try {
        await api.post("/logout");
    } catch (err) {
        // ignore
    } finally {
        localStorage.removeItem("token");
    }
}

// allow runtime update of baseURL (Setup page will call this)
export function setApiBase(baseUrl) {
    const final = baseUrl || DEFAULT_BASE;
    try { localStorage.setItem("api_base", final); } catch {}
    api.defaults.baseURL = final;
}

// expose current base for UI
export function getApiBase() {
    return api.defaults.baseURL || DEFAULT_BASE;
}

export default api;