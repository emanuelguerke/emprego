import axios from "axios";

const api = axios.create({
    baseURL: "http://localhost:8080",
    headers: { "Content-Type": "application/json" },
});

// anexa Authorization: Bearer <token> automaticamente
api.interceptors.request.use((config) => {
    const token = localStorage.getItem("token");
    if (token) config.headers.Authorization = `Bearer ${token}`;
    return config;
});

export async function login({ usuario, senha }) {
    const res = await api.post("/auth/login", { usuario, senha });
    return res.data; // { token, exp }
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

// named export 'logout' expected by Dashboard.jsx
export function logout() {
    localStorage.removeItem("token");
}

// named export to call server logout (if implemented); always clears local token
export async function logoutServer() {
    try {
        await api.post("/auth/logout");
    } catch (err) {
        // ignore server errors
    } finally {
        localStorage.removeItem("token");
    }
}

export default api;