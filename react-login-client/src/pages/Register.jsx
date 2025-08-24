import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { register } from "../services/authService";
import "../styles/app.css";

export default function Register() {
  const [nome, setNome] = useState("");
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
      await register({ nome, usuario, senha });
      alert("Conta criada com sucesso. Faça login.");
      navigate("/");
    } catch (err) {
      setError(err?.response?.data?.message || err.message || "Erro no cadastro");
    } finally {
      setLoading(false);
    }
  }

  return (
    <div className="page-root">
      <div className="card">
        <h2>Criar conta</h2>
        <form onSubmit={handleSubmit}>
          <label>
            Nome
            <input type="text" value={nome} onChange={(e) => setNome(e.target.value)} required />
          </label>
          <label>
            Usuário
            <input type="text" value={usuario} onChange={(e) => setUsuario(e.target.value)} required />
          </label>
          <label>
            Senha
            <input type="password" value={senha} onChange={(e) => setSenha(e.target.value)} required />
          </label>
          {error && <div className="error">{error}</div>}
          <button type="submit" disabled={loading}>
            {loading ? "Cadastrando..." : "Criar conta"}
          </button>
        </form>
      </div>
    </div>
  );
}