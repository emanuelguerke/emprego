import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { registerCompany } from "../services/authService";
import "../styles/app.css";

export default function CompanyRegister() {
  const [name, setName] = useState("");
  const [business, setBusiness] = useState("");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [street, setStreet] = useState("");
  const [number, setNumber] = useState("");
  const [city, setCity] = useState("");
  const [stateField, setStateField] = useState("");
  const [phone, setPhone] = useState("");
  const [email, setEmail] = useState("");
  const [error, setError] = useState("");
  const [fieldErrors, setFieldErrors] = useState([]);
  const [loading, setLoading] = useState(false);
  const navigate = useNavigate();

  async function handleSubmit(e) {
    e.preventDefault();
    setError("");
    setFieldErrors([]);
    setLoading(true);
    try {
      await registerCompany({ name, business, username, password, street, number, city, state: stateField, phone, email });
      alert("Empresa criada com sucesso. Faça login.");
      navigate("/login");
    } catch (err) {
      const data = err?.response?.data;
      if (data?.code === "UNPROCESSABLE" && Array.isArray(data.details)) {
        setFieldErrors(data.details);
      } else if (err?.response?.status === 409) {
        setError(data?.message || "Conflict");
      } else {
        setError(data?.message || err.message || "Erro no cadastro");
      }
    } finally {
      setLoading(false);
    }
  }

  function fieldError(field) {
    return fieldErrors.find(f => f.field === field)?.error;
  }

  return (
    <div className="page-root">
      <div className="card">
        <h2>Criar conta empresa</h2>
        <form onSubmit={handleSubmit}>
          <label>Name
            <input value={name} onChange={e=>setName(e.target.value)} required />
            {fieldError("name") && <div className="error">{fieldError("name")}</div>}
          </label>

          <label>Business
            <input value={business} onChange={e=>setBusiness(e.target.value)} required />
            {fieldError("business") && <div className="error">{fieldError("business")}</div>}
          </label>

          <label>Usuário
            <input value={username} onChange={e=>setUsername(e.target.value)} required />
            {fieldError("username") && <div className="error">{fieldError("username")}</div>}
          </label>

          <label>Senha
            <input type="password" value={password} onChange={e=>setPassword(e.target.value)} required />
            {fieldError("password") && <div className="error">{fieldError("password")}</div>}
          </label>

          <label>Street
            <input value={street} onChange={e=>setStreet(e.target.value)} required />
            {fieldError("street") && <div className="error">{fieldError("street")}</div>}
          </label>

          <label>Number
            <input value={number} onChange={e=>setNumber(e.target.value)} required />
            {fieldError("number") && <div className="error">{fieldError("number")}</div>}
          </label>

          <label>City
            <input value={city} onChange={e=>setCity(e.target.value)} required />
            {fieldError("city") && <div className="error">{fieldError("city")}</div>}
          </label>

          <label>State
            <input value={stateField} onChange={e=>setStateField(e.target.value)} required />
            {fieldError("state") && <div className="error">{fieldError("state")}</div>}
          </label>

          <label>Phone
            <input value={phone} onChange={e=>setPhone(e.target.value)} required />
            {fieldError("phone") && <div className="error">{fieldError("phone")}</div>}
          </label>

          <label>Email
            <input value={email} onChange={e=>setEmail(e.target.value)} required />
            {fieldError("email") && <div className="error">{fieldError("email")}</div>}
          </label>

          {error && <div className="error">{error}</div>}
          <button type="submit" disabled={loading}>{loading ? "Cadastrando..." : "Criar conta"}</button>
        </form>
      </div>
    </div>
  );
}