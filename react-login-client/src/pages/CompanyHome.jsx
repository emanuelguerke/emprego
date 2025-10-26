import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import api, { decodeToken, logoutServer } from "../services/authService";
import "../styles/app.css";

export default function CompanyHome() {
  const navigate = useNavigate();
  const [company, setCompany] = useState(null);
  const [loading, setLoading] = useState(true);
  const [editMode, setEditMode] = useState(false);
  const [form, setForm] = useState({ name: "", business: "", street: "", number: "", city: "", state: "", phone: "", email: "" });
  const [error, setError] = useState("");
  const [fieldErrors, setFieldErrors] = useState([]);

  useEffect(() => {
    let mounted = true;
    async function load() {
      try {
        const payload = decodeToken();
        if (!payload || !payload.sub) {
          navigate("/login");
          return;
        }
        const res = await api.get(`/companies/${payload.sub}`);
        if (mounted) {
          setCompany(res.data);
          setForm({
            name: res.data.name || "",
            business: res.data.business || "",
            street: res.data.street || "",
            number: res.data.number || "",
            city: res.data.city || "",
            state: res.data.state || "",
            phone: res.data.phone || "",
            email: res.data.email || "",
          });
        }
      } catch (err) {
        const status = err?.response?.status;
        if (status === 401) {
          await logoutServer();
          navigate("/login");
        } else if (status === 403) {
          setError("forbidden");
        } else if (status === 404) {
          setError("company not found");
        } else {
          setError("Erro ao carregar dados da empresa");
        }
      } finally {
        if (mounted) setLoading(false);
      }
    }
    load();
    return () => (mounted = false);
  }, [navigate]);

  function handleChange(e) {
    setForm({ ...form, [e.target.name]: e.target.value });
  }

  async function handleSave(e) {
    e.preventDefault();
    setError("");
    setFieldErrors([]);
    try {
      const payload = {};
      if (form.name !== company.name) payload.name = form.name;
      if (form.business !== company.business) payload.business = form.business;
      if (form.street !== company.street) payload.street = form.street;
      if (form.number !== company.number) payload.number = form.number;
      if (form.city !== company.city) payload.city = form.city;
      if (form.state !== company.state) payload.state = form.state;
      if (form.phone !== company.phone) payload.phone = form.phone;
      if (form.email !== company.email) payload.email = form.email;

      if (Object.keys(payload).length === 0) {
        setEditMode(false);
        return;
      }

      const payloadToken = decodeToken();
      await api.patch(`/companies/${payloadToken.sub}`, payload);
      const res = await api.get(`/companies/${payloadToken.sub}`);
      setCompany(res.data);
      setEditMode(false);
      alert("Atualizado com sucesso");
    } catch (err) {
      const status = err?.response?.status;
      if (status === 401) {
        await logoutServer();
        navigate("/login");
      } else if (status === 403) {
        setError("forbidden");
      } else if (status === 404) {
        setError("company not found");
      } else if (status === 422) {
        const data = err.response.data;
        setFieldErrors(data?.details || []);
      } else {
        setError("Erro ao atualizar");
      }
    }
  }

  async function handleDelete() {
    const ok = window.confirm("Deseja realmente deletar sua empresa? Esta ação é irreversível.");
    if (!ok) return;
    try {
      const payloadToken = decodeToken();
      await api.delete(`/companies/${payloadToken.sub}`);
      await logoutServer();
      navigate("/");
    } catch (err) {
      const status = err?.response?.status;
      if (status === 401) {
        await logoutServer();
        navigate("/login");
      } else if (status === 403) {
        setError("forbidden");
      } else if (status === 404) {
        setError("company not found");
      } else {
        setError("Erro ao deletar empresa");
      }
    }
  }

  if (loading) return <div className="page-root"><div className="card"><p>Carregando...</p></div></div>;

  return (
    <div className="page-root">
      <div className="card" style={{ position: "relative" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
          <h2>Empresa</h2>
          <button onClick={() => { logoutServer().finally(()=>navigate("/")); }} style={{ padding: "8px 12px", borderRadius: 8, background: "#ef4444", color: "#fff", border: "none", cursor: "pointer" }}>
            Logout
          </button>
        </div>

        {error && <div className="error">{error}</div>}

        {!editMode ? (
          <>
            <p><strong>Name:</strong> {company?.name}</p>
            <p><strong>Business:</strong> {company?.business}</p>
            <p><strong>Username:</strong> {company?.username}</p>
            <p><strong>Street:</strong> {company?.street}</p>
            <p><strong>Number:</strong> {company?.number}</p>
            <p><strong>City:</strong> {company?.city}</p>
            <p><strong>State:</strong> {company?.state}</p>
            <p><strong>Phone:</strong> {company?.phone}</p>
            <p><strong>Email:</strong> {company?.email}</p>

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
            <label>Name<input name="name" value={form.name} onChange={handleChange} /></label>
            <label>Business<input name="business" value={form.business} onChange={handleChange} /></label>
            <label>Street<input name="street" value={form.street} onChange={handleChange} /></label>
            <label>Number<input name="number" value={form.number} onChange={handleChange} /></label>
            <label>City<input name="city" value={form.city} onChange={handleChange} /></label>
            <label>State<input name="state" value={form.state} onChange={handleChange} /></label>
            <label>Phone<input name="phone" value={form.phone} onChange={handleChange} /></label>
            <label>Email<input name="email" value={form.email} onChange={handleChange} /></label>

            {fieldErrors.map((f, i) => <div key={i} className="error">{f.field}: {f.error}</div>)}
            {error && <div className="error">{error}</div>}

            <div style={{ display: "flex", gap: 8, marginTop: 12 }}>
              <button type="submit" style={{ padding: "8px 12px", borderRadius: 8, background: "#2563eb", color: "#fff", border: "none", cursor: "pointer" }}>Salvar</button>
              <button type="button" onClick={() => { setEditMode(false); setFieldErrors([]); setError(""); }} style={{ padding: "8px 12px", borderRadius: 8 }}>Cancelar</button>
            </div>
          </form>
        )}
      </div>
    </div>
  );
}