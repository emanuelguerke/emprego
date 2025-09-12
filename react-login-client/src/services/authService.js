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
    return res.data;
}

export async function register({ nome, usuario, senha, email, telefone }) {
    let name = nome;
    let username = usuario;
    let password = senha;
    let phone = telefone;

    const res = await api.post("/users", { name, username, password, email, phone });
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

// remove token localmente (sincroniza com server via logoutServer quando desejado)
export function logout() {
    localStorage.removeItem("token");
}

// chama o endpoint /auth/logout para revogar o token no servidor e limpa localmente
export async function logoutServer() {
    try {
        await api.post("/auth/logout");
    } catch (err) {
        // ignore server errors, sempre limpa token localmente
    } finally {
        localStorage.removeItem("token");
    }
}

export default api;