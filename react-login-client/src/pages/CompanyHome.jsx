import React from "react";
import { useNavigate } from "react-router-dom";
import { getToken, logoutServer, getApiBase } from "../services/authService";
import "../styles/app.css";

export default function CompanyHome() {
  const navigate = useNavigate();

  function decodeToken() {
    try {
      const t = getToken();
      if (!t) return null;
      const parts = t.split(".");
      if (parts.length !== 3) return null;
      const payload = JSON.parse(atob(parts[1].replace(/-/g, "+").replace(/_/g, "/")));
      return payload;
    } catch {
      return null;
    }
  }

  const payload = decodeToken();

  async function handleLogout() {
    try {
      await logoutServer();
    } finally {
      navigate("/");
    }
  }

  function goToProfile() {
    if (!payload || !payload.sub) {
      navigate("/login");
      return;
    }
    navigate("/company/profile");
  }

  return (
    <div className="page-root">
      <div className="card">
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
          <h2>Company Home</h2>
          <div style={{ display: "flex", gap: 8 }}>
            <div style={{ fontSize: 12, color: "#666", alignSelf: "center" }}>{getApiBase()}</div>
            <button onClick={handleLogout} style={{ padding: "8px 12px", borderRadius: 8, background: "#ef4444", color: "#fff", border: "none", cursor: "pointer" }}>
              Logout
            </button>
          </div>
        </div>

        <p>Bem-vindo{payload?.username ? `, ${payload.username}` : ""}.</p>

        <div style={{ marginTop: 12 }}>
          <button onClick={goToProfile} style={{ padding: "8px 12px", borderRadius: 8, background: "#2563eb", color: "#fff", border: "none", cursor: "pointer" }}>
            Perfil da Empresa
          </button>
          <button onClick={()=>navigate("/company/jobs")} style={{ marginLeft: 8, padding: "8px 12px", borderRadius: 8, background: "#06b6d4", color: "#fff", border: "none", cursor: "pointer" }}>
            Minhas Vagas
          </button>
        </div>
      </div>
    </div>
  );
}