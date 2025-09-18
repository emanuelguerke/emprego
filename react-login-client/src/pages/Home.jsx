import React from "react";
import { useNavigate } from "react-router-dom";
import { getToken, logoutServer, getApiBase } from "../services/authService";
import "../styles/app.css";

export default function Home() {
  const navigate = useNavigate();

  // decode token to get username / sub quickly (no external lib)
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
    // call server to revoke token, then navigate (logoutServer removes token locally in finally)
    try {
      await logoutServer();
    } finally {
      navigate("/");
    }
  }

  function goToProfile() {
    if (!payload || !payload.sub) {
      // no token -> go to login
      navigate("/login");
      return;
    }
    navigate(`/profile/${payload.sub}`);
  }

  return (
    <div className="page-root">
      <div className="card">
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
          <h2>Home</h2>
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
            Perfil
          </button>
        </div>
      </div>
    </div>
  );
}