import React, { useEffect, useState } from "react";
import { useNavigate, useLocation } from "react-router-dom";
import { setApiBase, getApiBase } from "../services/authService";
import "../styles/app.css";

export default function Setup() {
  const navigate = useNavigate();
  const location = useLocation();
  const [host, setHost] = useState("localhost");
  const [port, setPort] = useState("8080");
  const [error, setError] = useState("");

  useEffect(() => {
    // if already configured -> go to login (but allow manual edit on /setup)
    try {
      const base = localStorage.getItem("api_base");
      // redirect to login only when base exists AND we are on root (not /setup)
      if (base && location.pathname === "/") {
        navigate("/login", { replace: true });
      }
    } catch {
      // ignore
    }
  }, [navigate, location.pathname]);

  function buildBase(h, p) {
    if (!h) h = "localhost";
    h = h.trim();
    // if user included protocol, keep it
    const hasProto = /^https?:\/\//i.test(h);
    const hostPart = hasProto ? h.replace(/\/+$/,"") : `http://${h}`;
    const portPart = p ? `:${p}` : "";
    return `${hostPart}${portPart}`;
  }

  function handleDefault() {
    const base = buildBase("localhost", "8080");
    setApiBase(base);
    navigate("/login");
  }

  function handleSubmit(e) {
    e.preventDefault();
    setError("");
    try {
      if (!/^\d{1,5}$/.test(port) || Number(port) < 1 || Number(port) > 65535) {
        setError("porta inválida");
        return;
      }
      const base = buildBase(host, port);
      setApiBase(base);
      navigate("/login");
    } catch (err) {
      setError("erro ao salvar");
    }
  }

  return (
    <div className="page-root">
      <div className="card">
        <h2>Configurar API</h2>
        <form onSubmit={handleSubmit}>
          <label>
            Host (ex: localhost ou http://api.meuhost.com)
            <input value={host} onChange={(e)=>setHost(e.target.value)} />
          </label>

          <label>
            Porta (ex: 8080)
            <input value={port} onChange={(e)=>setPort(e.target.value)} />
          </label>

          {error && <div className="error">{error}</div>}

          <div style={{ display: "flex", gap: 8, marginTop: 8 }}>
            <button type="submit">Salvar</button>
            <button type="button" onClick={handleDefault}>Usar padrão</button>
          </div>
        </form>

        <div style={{ marginTop: 12, fontSize: 13, color: "#666" }}>
          Base atual: <strong>{getApiBase()}</strong>
        </div>
      </div>
    </div>
  );
}