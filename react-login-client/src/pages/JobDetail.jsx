import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { getJob, applyToJob, reportServerError } from "../services/jobService";
import { decodeToken } from "../services/authService";
import "../styles/app.css";

export default function JobDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  const [job, setJob] = useState(null);
  const [loading, setLoading] = useState(true);
  const [submitting, setSubmitting] = useState(false);
  const [form, setForm] = useState({ name: "", email: "", phone: "", education: "", experience: "" });

  const payload = decodeToken();

  useEffect(() => {
    let mounted = true;
    async function load() {
      setLoading(true);
      try {
        const data = await getJob(Number(id));
        if (!data || !data.job_id) {
          await reportServerError("Index 'job_id' not found in server data.");
          if (mounted) setJob(null);
          return;
        }
        if (mounted) setJob(data);
      } catch (err) {
        const status = err?.response?.status;
        if (status === 401) navigate("/login");
        else if (status === 404) {
          alert("Vaga não encontrada");
          navigate("/jobs");
        } else {
          await reportServerError(`Failed to load job ${id}: ${err?.message || "unknown"}`);
        }
      } finally {
        if (mounted) setLoading(false);
      }
    }
    load();
    return () => { mounted = false; };
  }, [id, navigate]);

  async function handleApply(e) {
    e.preventDefault();
    if (!payload) { navigate("/login"); return; }
    if (payload.role !== "user") { alert("Apenas usuário pode se candidatar"); return; }

    if (!form.name || !form.education || !form.experience) {
      alert("Preencha os campos obrigatórios");
      return;
    }

    setSubmitting(true);
    try {
      // enviar todos os campos mesmo que vazios
      await applyToJob(Number(id), {
        name: form.name || "",
        email: form.email || "",
        phone: form.phone || "",
        education: form.education || "",
        experience: form.experience || ""
      });
      alert("Candidatura enviada com sucesso");
      navigate("/jobs");
    } catch (err) {
      const status = err?.response?.status;
      if (status === 401) navigate("/login");
      else alert(err?.response?.data?.message || err.message || "Erro");
    } finally {
      setSubmitting(false);
    }
  }

  if (loading) return <div className="page-root"><div className="card"><p>Carregando...</p></div></div>;
  if (!job) return <div className="page-root"><div className="card"><p>Vaga não disponível</p></div></div>;

  return (
    <div className="page-root">
      <div className="card">
        <h2>{job.title}</h2>
        <div style={{ fontSize: 13, color: "#666" }}>{job.area} • {job.city}/{job.state} — {job.company}</div>
        <p style={{ marginTop: 12 }}>{job.description}</p>
        <div><strong>Salário:</strong> {job.salary != null ? job.salary : "Não informado"}</div>
        <div><strong>Contato:</strong> {job.contact || "Não informado"}</div>

        <hr style={{ margin: "12px 0" }} />

        {payload?.role === "user" ? (
          <form onSubmit={handleApply}>
            <h3>Candidate-se</h3>
            <label>Nome completo<input value={form.name} onChange={e=>setForm({...form,name:e.target.value})} required/></label>
            <label>E-mail (opcional)<input value={form.email} onChange={e=>setForm({...form,email:e.target.value})}/></label>
            <label>Telefone (opcional)<input value={form.phone} onChange={e=>setForm({...form,phone:e.target.value})}/></label>
            <label>Formação (obrigatório)<textarea value={form.education} onChange={e=>setForm({...form,education:e.target.value})} required rows={3}/></label>
            <label>Experiência (obrigatório)<textarea value={form.experience} onChange={e=>setForm({...form,experience:e.target.value})} required rows={3}/></label>
            <div style={{ display: "flex", gap: 8 }}>
              <button type="submit" disabled={submitting}>Enviar candidatura</button>
              <button type="button" onClick={()=>navigate("/jobs")}>Voltar</button>
            </div>
          </form>
        ) : (
          <div>
            <button onClick={()=>navigate("/jobs")}>Voltar</button>
          </div>
        )}
      </div>
    </div>
  );
}