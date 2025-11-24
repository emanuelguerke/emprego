import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { listUserApplications, reportServerError } from "../services/jobService";
import { getToken } from "../services/authService";
import "../styles/app.css";

function decodeToken() {
  try {
    const t = getToken();
    if (!t) return null;
    const parts = t.split(".");
    if (parts.length !== 3) return null;
    return JSON.parse(atob(parts[1].replace(/-/g, "+").replace(/_/g, "/")));
  } catch { return null; }
}

export default function UserApplications() {
  const navigate = useNavigate();
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);

  const payload = decodeToken();
  const userId = payload?.sub || payload?.id;

  useEffect(() => {
    let mounted = true;
    if (!userId) { navigate("/login"); return; }

    (async () => {
      setLoading(true);
      try {
        const res = await listUserApplications(userId);
        if (!res || !Array.isArray(res.items)) {
          await reportServerError("Index 'items' not found in server data for user applications.");
          if (mounted) setItems([]);
          return;
        }
        if (mounted) setItems(res.items || []);
      } catch (err) {
        const status = err?.response?.status;
        if (status === 401) navigate("/login");
        else setItems([]);
      } finally {
        if (mounted) setLoading(false);
      }
    })();

    return () => { mounted = false; };
  }, [navigate, userId]);

  return (
    <div className="page-root">
      <div className="card">
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
          <h2>Minhas Candidaturas</h2>
          <button onClick={() => navigate("/home")} style={{ padding: "6px 10px", borderRadius: 6 }}>Voltar</button>
        </div>

        {loading ? <p>Carregando...</p> : (
          <>
            {items.length === 0 ? <p>Nenhuma candidatura encontrada</p> : (
              <div>
                {items.map(it => (
                  <div
                    key={it.job_id}
                    style={{
                      borderBottom: "1px solid #eee",
                      padding: 8,
                      marginBottom: 8,
                      // destaque se recebeu feedback
                      border: it.feedback ? "2px solid #ef4444" : "1px solid #eee",
                      background: it.feedback ? "#fff7f7" : "transparent",
                      borderRadius: 6
                    }}
                  >
                    <div><strong>{it.title}</strong> — {it.company}</div>
                    <div style={{ fontSize: 13, color: "#666" }}>{it.area} • {it.city} / {it.state}</div>
                    <div style={{ marginTop: 6 }}>{it.description}</div>
                    <div style={{ marginTop: 6 }}>
                      <strong>Salário:</strong> {it.salary != null ? it.salary : "Não informado"}
                    </div>
                    <div style={{ marginTop: 6 }}>
                      <strong>Contato:</strong> {it.contact || "Não informado"}
                    </div>
                    <div style={{ marginTop: 6 }}>
                      <strong>Feedback:</strong> {it.feedback || "Ainda não recebeu feedback"}
                    </div>
                  </div>
                ))}
              </div>
            )}
          </>
        )}
      </div>
    </div>
  );
}