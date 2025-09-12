import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { register } from "../services/authService";
import "../styles/app.css";

export default function Register() {
  const [nome, setNome] = useState("");
  const [usuario, setUsuario] = useState("");
  const [senha, setSenha] = useState("");
  const [email, setEmail] = useState("");
  const [telefone, setTelefone] = useState("");
  const [error, setError] = useState("");
  const [fieldErrors, setFieldErrors] = useState([]);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  function clientValidate() {
    const errs = [];
    if (!nome || nome.trim().length < 4) errs.push({ field: "nome", error: "too short" });
    if (!usuario || !/^[A-Za-z0-9_]{3,20}$/.test(usuario)) errs.push({ field: "usuario", error: "invalid format" });
    if (!senha || !/^[A-Za-z0-9]{3,20}$/.test(senha)) errs.push({ field: "senha", error: "invalid format" });
    if (email && !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) errs.push({ field: "email", error: "invalid email" });
    if (telefone && !/^\d{10,14}$/.test(telefone)) errs.push({ field: "telefone", error: "invalid phone" });
    return errs;
  }

  async function handleSubmit(e) {
    e.preventDefault();
    setError("");
    setFieldErrors([]);
    const errs = clientValidate();
    if (errs.length) {
      setFieldErrors(errs);
      return;
    }

    setLoading(true);
    try {
      await register({ nome, usuario, senha, email, telefone });
      alert("Conta criada com sucesso. Faça login.");
      navigate("/");
    } catch (err) {
      const data = err?.response?.data;
      if (data?.code === "UNPROCESSABLE" && Array.isArray(data.detail)) {
        setFieldErrors(data.detail);
      } else {
        setError(data?.message || err.message || "Erro no cadastro");
      }
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
            {fieldErrors.find(f=>f.field==="nome") && <div className="error">{fieldErrors.find(f=>f.field==="nome").error}</div>}
          </label>

          <label>
            Usuário
            <input type="text" value={usuario} onChange={(e) => setUsuario(e.target.value)} required />
            {fieldErrors.find(f=>f.field==="usuario") && <div className="error">{fieldErrors.find(f=>f.field==="usuario").error}</div>}
          </label>

          <label>
            Senha
            <input type="password" value={senha} onChange={(e) => setSenha(e.target.value)} required />
            {fieldErrors.find(f=>f.field==="senha") && <div className="error">{fieldErrors.find(f=>f.field==="senha").error}</div>}
          </label>

          <label>
            Email (opcional)
            <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
            {fieldErrors.find(f=>f.field==="email") && <div className="error">{fieldErrors.find(f=>f.field==="email").error}</div>}
          </label>

          <label>
            Telefone (opcional)
            <input type="text" value={telefone} onChange={(e) => setTelefone(e.target.value)} />
            {fieldErrors.find(f=>f.field==="telefone") && <div className="error">{fieldErrors.find(f=>f.field==="telefone").error}</div>}
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