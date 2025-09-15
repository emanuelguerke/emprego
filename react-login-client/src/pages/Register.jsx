import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { register } from "../services/authService";
import "../styles/app.css";

export default function Register() {
  const [name, setName] = useState("");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [email, setEmail] = useState("");
  const [phone, setPhone] = useState("");
  const [error, setError] = useState("");
  const [fieldErrors, setFieldErrors] = useState([]);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  function clientValidate() {
    const errs = [];
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
      // payload property names match backend: name, username, password, email, phone
      await register({ name, username, password, email, phone });
      alert("Conta criada com sucesso. Faça login.");
      navigate("/");
    } catch (err) {
      const data = err?.response?.data;
      if (data?.code === "UNPROCESSABLE" && Array.isArray(data.detail)) {
        setFieldErrors(data.detail);
      } else if (err?.response?.status === 409) {
        // username conflict
        setError(data?.message || "username already exists");
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
            <input type="text" value={name} onChange={(e) => setName(e.target.value)} />
            {fieldErrors.find(f=>f.field==="name") && <div className="error">{fieldErrors.find(f=>f.field==="name").error}</div>}
          </label>

          <label>
            Usuário
            <input type="text" value={username} onChange={(e) => setUsername(e.target.value)} />
            {fieldErrors.find(f=>f.field==="username") && <div className="error">{fieldErrors.find(f=>f.field==="username").error}</div>}
          </label>

          <label>
            Senha
            <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} />
            {fieldErrors.find(f=>f.field==="password") && <div className="error">{fieldErrors.find(f=>f.field==="password").error}</div>}
          </label>

          <label>
            Email (opcional)
            <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} />
            {fieldErrors.find(f=>f.field==="email") && <div className="error">{fieldErrors.find(f=>f.field==="email").error}</div>}
          </label>

          <label>
            Telefone (opcional)
            <input type="text" value={phone} onChange={(e) => setPhone(e.target.value)} />
            {fieldErrors.find(f=>f.field==="phone") && <div className="error">{fieldErrors.find(f=>f.field==="phone").error}</div>}
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