import React, { useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import { login, setToken } from "../services/authService";
import "../styles/app.css";

export default function Login() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  async function handleSubmit(e) {
    e.preventDefault();
    setError("");
    setLoading(true);
    try {
      const res = await login({ username, password });
      if (!res || !res.token) {
        throw new Error(res?.message || "Resposta inválida do servidor");
      }
      setToken(res.token);
      navigate("/dashboard");
    } catch (err) {
      setError(err?.response?.data?.message || err.message || "Erro no login");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="page-root">
      <div className="card" style={{ position: "relative" }}>
        {/* gear button to go back to Setup */}
        <button
          type="button"
          aria-label="Configurar API"
          onClick={() => navigate("/setup")}
          style={{
            position: "absolute",
            top: 12,
            right: 12,
            background: "transparent",
            border: "none",
            padding: 6,
            cursor: "pointer",
            color: "var(--accent)",
          }}
          title="Configurar API"
        >
          {/* simple SVG gear */}
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden>
            <path d="M12 15.5A3.5 3.5 0 1 0 12 8.5a3.5 3.5 0 0 0 0 7z" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/>
            <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 1 1-4 0v-.09a1.65 1.65 0 0 0-1-1.51 1.65 1.65 0 0 0-1.82.33l-.06.06A2 2 0 1 1 2.27 16.9l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 1 1 0-4h.09c.68 0 1.28-.37 1.51-1a1.65 1.65 0 0 0-.33-1.82l-.06-.06A2 2 0 1 1 7.06 2.27l.06.06c.44.44 1.05.69 1.71.69.26 0 .52-.03.77-.09.36-.09.73-.04 1.04.17.31.21.5.56.5.95v.09c0 .28.18.54.44.63.25.09.52.02.72-.17.25-.24.58-.41.95-.5.25-.06.51-.09.77-.09.66 0 1.27.25 1.71.69l.06.06a2 2 0 1 1-2.83 2.83l-.06-.06c-.44-.44-1.05-.69-1.71-.69-.26 0-.52.03-.77.09-.36.09-.73.04-1.04-.17-.31-.21-.5-.56-.5-.95v-.09c0-.28-.18-.54-.44-.63-.25-.09-.52-.02-.72.17-.25.24-.58.41-.95.5-.25.06-.51.09-.77.09-.66 0-1.27-.25-1.71-.69l-.06-.06A2 2 0 0 1 4.6 9" stroke="currentColor" strokeWidth="1" strokeLinecap="round" strokeLinejoin="round"/>
          </svg>
        </button>

        <h2>Entrar</h2>
        <form onSubmit={handleSubmit}>
          <label>
            Usuário
            <input
              type="text"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              required
            />
          </label>
          <label>
            Senha
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
            />
          </label>
          {error && <div className="error">{error}</div>}
          <button type="submit" disabled={loading}>
            {loading ? "Entrando..." : "Entrar"}
          </button>
        </form>

        <div style={{ marginTop: 14, textAlign: "center", fontSize: 14 }}>
          <div>
            <span>Não tem conta? </span>
            <Link to="/users">Criar conta</Link>
          </div>
          <div style={{ marginTop: 8 }}>
            <span>Não tem conta empresa? </span>
            <Link to="/companies">Criar conta empresa</Link>
          </div>
        </div>
      </div>
    </div>
  );
}