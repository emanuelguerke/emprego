import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import api, { getToken, logout, logoutServer } from "../services/authService";
import "../styles/app.css";

export default function Profile() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [profile, setProfile] = useState(null);
  const [loading, setLoading] = useState(true);
  const [editMode, setEditMode] = useState(false);
  const [form, setForm] = useState({ name: "", email: "", phone: "", password: "" });
  const [error, setError] = useState("");
  const [fieldErrors, setFieldErrors] = useState([]);

  useEffect(() => {
    let mounted = true;
    async function load() {
      try {
        const res = await api.get(`/users/${id}`);
        if (mounted) {
          setProfile(res.data);
          setForm({ name: res.data.name || "", email: res.data.email || "", phone: res.data.phone || "", password: "" });
        }
      } catch (err) {
        const status = err?.response?.status;
        if (status === 401) {
          logout();
          navigate("/login");
        } else if (status === 403) {
          setError("forbidden");
        } else if (status === 404) {
          setError("user not found");
        } else {
          setError("Erro ao carregar perfil");
        }
      } finally {
        if (mounted) setLoading(false);
      }
    }
    load();
    return () => (mounted = false);
  }, [id, navigate]);

  function handleChange(e) {
    setForm({ ...form, [e.target.name]: e.target.value });
  }

  async function handleSave(e) {
    e.preventDefault();
    setError("");
    setFieldErrors([]);
    try {
      const payload = {};
      if (form.name !== profile.name) payload.name = form.name;
      if (form.email !== profile.email) payload.email = form.email;
      if (form.phone !== profile.phone) payload.phone = form.phone;
      if (form.password) payload.password = form.password;

      if (Object.keys(payload).length === 0) {
        setEditMode(false);
        return;
      }

      await api.patch(`/users/${id}`, payload);
      const res = await api.get(`/users/${id}`);
      setProfile(res.data);
      setEditMode(false);
      alert("Atualizado com sucesso");
    } catch (err) {
      const status = err?.response?.status;
      if (status === 401) {
        logout();
        navigate("/login");
      } else if (status === 403) {
        setError("forbidden");
      } else if (status === 404) {
        setError("user not found");
      } else if (status === 422) {
        const data = err.response.data;
        setFieldErrors(data?.details || []);
      } else {
        setError("Erro ao atualizar");
      }
    }
  }

  async function handleDelete() {
    const ok = window.confirm("Deseja realmente deletar seu usuário? Esta ação é irreversível.");
    if (!ok) return;
    try {
      await api.delete(`/users/${id}`);
      await logoutServer();
      navigate("/");
    } catch (err) {
      const status = err?.response?.status;
      if (status === 401) {
        logout();
        navigate("/login");
      } else if (status === 403) {
        setError("forbidden");
      } else if (status === 404) {
        setError("user not found");
      } else {
        setError("Erro ao deletar usuário");
      }
    }
  }

  if (loading) return <div className="page-root"><div className="card"><p>Carregando...</p></div></div>;

  if (!profile) return (
    <div className="page-root">
      <div className="card">
        <h2>Perfil</h2>
        <div className="error">{error || "Nenhum dado"}</div>
      </div>
    </div>
  );

  return (
    <div className="page-root">
      <div className="card" style={{ position: "relative", paddingTop: 20 }}>
        {/* header row: back arrow (larger) and title below aligned with page content */}
        <div style={{ display: "flex", alignItems: "center", marginBottom: 12 }}>
          <button
            type="button"
            onClick={() => navigate("/home")}
            style={{
              background: "transparent",
              border: "none",
              padding: "6px 10px",
              cursor: "pointer",
              color: "var(--accent)",
              fontSize: 28, // larger arrow
              lineHeight: 1,
              display: "inline-flex",
              alignItems: "center",
              justifyContent: "center",
            }}
            title="Voltar para Home"
            aria-label="Voltar"
          >
            ←
          </button>
        </div>

        <h2 style={{ marginTop: 0, marginBottom: 8 }}>Perfil</h2>

        {/* gear toggles edit mode (keeps absolute right) */}
        <button
          type="button"
          aria-label="Editar perfil"
          onClick={() => setEditMode((s) => !s)}
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
          title="Editar perfil"
        >
          <svg width="18" height="18" viewBox="0 0 24 24" fill="none"><path d="M12 15.5A3.5 3.5 0 1 0 12 8.5a3.5 3.5 0 0 0 0 7z" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round"/></svg>
        </button>

        {!editMode ? (
          <>
            <p><strong>Nome:</strong> {profile.name}</p>
            <p><strong>Usuário:</strong> {profile.username}</p>
            <p><strong>Email:</strong> {profile.email || "-"}</p>
            <p><strong>Telefone:</strong> {profile.phone || "-"}</p>

            {error && <div className="error">{error}</div>}

            <div style={{ display: "flex", gap: 8, marginTop: 12 }}>
              <button onClick={() => setEditMode(true)} style={{ padding: "8px 12px", borderRadius: 8, background: "#2563eb", color: "#fff", border: "none", cursor: "pointer" }}>
                Editar
              </button>
              <button onClick={handleDelete} style={{ padding: "8px 12px", borderRadius: 8, background: "#ef4444", color: "#fff", border: "none", cursor: "pointer" }}>
                Deletar conta
              </button>
            </div>
          </>
        ) : (
          <form onSubmit={handleSave}>
            <label>
              Nome
              <input name="name" value={form.name} onChange={handleChange} />
              {fieldErrors.find(f=>f.field==="name") && <div className="error">{fieldErrors.find(f=>f.field==="name").error}</div>}
            </label>

            <label>
              Email
              <input name="email" value={form.email} onChange={handleChange} />
              {fieldErrors.find(f=>f.field==="email") && <div className="error">{fieldErrors.find(f=>f.field==="email").error}</div>}
            </label>

            <label>
              Telefone
              <input name="phone" value={form.phone} onChange={handleChange} />
              {fieldErrors.find(f=>f.field==="phone") && <div className="error">{fieldErrors.find(f=>f.field==="phone").error}</div>}
            </label>

            <label>
              Nova Senha (opcional)
              <input name="password" type="password" value={form.password} onChange={handleChange} />
              {fieldErrors.find(f=>f.field==="password") && <div className="error">{fieldErrors.find(f=>f.field==="password").error}</div>}
            </label>

            {error && <div className="error">{error}</div>}

            <div style={{ display: "flex", gap: 8, marginTop: 8 }}>
              <button type="submit" style={{ padding: "8px 12px", borderRadius: 8, background: "#2563eb", color: "#fff", border: "none", cursor: "pointer" }}>
                Salvar
              </button>
              <button type="button" onClick={() => { setEditMode(false); setFieldErrors([]); setError(""); }} style={{ padding: "8px 12px", borderRadius: 8 }}>
                Cancelar
              </button>
            </div>
          </form>
        )}
      </div>
    </div>
  );
}