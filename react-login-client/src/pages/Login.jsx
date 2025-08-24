import React, { useState } from "react";
import { useNavigate, Link } from "react-router-dom";
import { login, setToken } from "../services/authService";
import "../styles/app.css";

export default function Login() {
  const [usuario, setUsuario] = useState("");
  const [senha, setSenha] = useState("");
  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  async function handleSubmit(e) {
    e.preventDefault();
    setError("");
    setLoading(true);
    try {
      const res = await login({ usuario, senha });
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
      <div className="card">
        <h2>Entrar</h2>
        <form onSubmit={handleSubmit}>
          <label>
            Usuário
            <input
              type="text"
              value={usuario}
              onChange={(e) => setUsuario(e.target.value)}
              required
            />
          </label>
          <label>
            Senha
            <input
              type="password"
              value={senha}
              onChange={(e) => setSenha(e.target.value)}
              required
            />
          </label>
          {error && <div className="error">{error}</div>}
          <button type="submit" disabled={loading}>
            {loading ? "Entrando..." : "Entrar"}
          </button>
        </form>

        <div style={{ marginTop: 14, textAlign: "center", fontSize: 14 }}>
          <span>Não tem conta? </span>
          <Link to="/register">Criar conta</Link>
        </div>
      </div>
    </div>
  );
}