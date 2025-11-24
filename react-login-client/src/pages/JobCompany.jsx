import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { createJob, searchJobs, updateJob, deleteJob } from "../services/jobService";
import { decodeToken } from "../services/authService";
import "../styles/app.css";

export default function JobCompany() {
  const navigate = useNavigate();
  const [payload] = useState(() => decodeToken());
  const [form, setForm] = useState({ title: "", area: "Outros", description: "", state: "", city: "", salary: "" });
  const [jobs, setJobs] = useState([]);
  const [loading, setLoading] = useState(true);

  const AREAS = ['Administração','Agricultura','Artes','Atendimento ao Cliente','Comercial','Comunicação','Construção Civil','Consultoria','Contabilidade','Design','Educação','Engenharia','Finanças','Jurídica','Logística','Marketing','Produção','Recursos Humanos','Saúde','Segurança','Tecnologia da Informação','Telemarketing','Vendas','Outros'];

  useEffect(()=>{
    if (!payload) { navigate("/login"); return; }
    let mounted = true;
    async function load() {
      setLoading(true);
      try {
        const res = await searchJobs({ company: payload.username });
        if (mounted) setJobs(res.items || []);
      } catch (e) {
        if (mounted) setJobs([]);
      } finally { if (mounted) setLoading(false); }
    }
    load();
    return ()=> { mounted = false; };
  }, [navigate, payload?.username]);

  async function handleCreate(e) {
    e.preventDefault();
    try {
      if (!payload) { navigate("/login"); return; }
      const p = {
        title: form.title,
        area: form.area,
        description: form.description,
        state: form.state,
        city: form.city,
        salary: form.salary ? Number(form.salary) : undefined
      };
      await createJob(p);
      alert("Vaga criada");
      const res = await searchJobs({ company: payload.username });
      setJobs(res.items || []);
      setForm({ title: "", area: "Outros", description: "", state: "", city: "", salary: "" });
    } catch (err) {
      alert(err?.response?.data?.message || err.message || "Erro");
    }
  }

  async function handleDelete(jobId) {
    if (!confirm("Confirma exclusão da vaga?")) return;
    try {
      await deleteJob(jobId);
      setJobs(prev => prev.filter(j => Number(j.job_id) !== Number(jobId)));
      alert("Vaga deletada");
    } catch (err) {
      alert(err?.response?.data?.message || err.message || "Erro ao deletar");
    }
  }

  async function handleEdit(job) {
    const title = prompt("Título:", job.title);
    if (title === null) return;
    const area = prompt("Área:", job.area);
    if (area === null) return;
    const description = prompt("Descrição (10-5000 chars):", job.description);
    if (description === null) return;
    const state = prompt("Estado:", job.state);
    if (state === null) return;
    const city = prompt("Cidade:", job.city);
    if (city === null) return;
    const salaryStr = prompt("Salário (deixe vazio para NULL):", job.salary != null ? String(job.salary) : "");
    if (salaryStr === null) return;

    const payloadUpdate = {
      title: String(title).trim(),
      area: String(area).trim(),
      description: String(description).trim(),
      state: String(state).trim(),
      city: String(city).trim(),
      salary: salaryStr === "" ? undefined : Number(salaryStr)
    };

    try {
      await updateJob(job.job_id, payloadUpdate);
      const res = await searchJobs({ company: payload.username });
      setJobs(res.items || []);
      alert("Vaga atualizada");
    } catch (err) {
      alert(err?.response?.data?.message || err.message || "Erro ao atualizar");
    }
  }

  function openJobCandidates(jobId) {
    navigate(`/company/jobs/${jobId}`);
  }

  return (
    <div className="page-root">
      {/* use wide card for company pages */}
      <div className="card card--wide">
        <h2>Vagas da Empresa</h2>
        <form onSubmit={handleCreate}>
          <label>Title<input value={form.title} onChange={e=>setForm({...form,title:e.target.value})} required/></label>
          <label>Area
            <select value={form.area} onChange={e=>setForm({...form,area:e.target.value})}>
              {AREAS.map(a=> <option key={a} value={a}>{a}</option>)}
            </select>
          </label>
          <label>Description<textarea value={form.description} onChange={e=>setForm({...form,description:e.target.value})} required rows={4}/></label>
          <label>State<input value={form.state} onChange={e=>setForm({...form,state:e.target.value})} required/></label>
          <label>City<input value={form.city} onChange={e=>setForm({...form,city:e.target.value})} required/></label>
          <label>Salary (optional)<input type="number" step="0.01" value={form.salary} onChange={e=>setForm({...form,salary:e.target.value})}/></label>
          <div style={{ display: "flex", gap: 8 }}>
            <button type="submit">Criar vaga</button>
            <button type="button" onClick={()=>navigate("/company")}>Voltar</button>
          </div>
        </form>

        <hr style={{ margin: "12px 0" }} />

        <div>
          <h3>Vagas</h3>
          {loading ? <p>Carregando...</p> : jobs.length===0 ? <p>Nenhuma vaga</p> : jobs.map(j=>(
            <div key={j.job_id} className="job-row">
              <div className="job-content">
                <div className="job-title"><strong>{j.title}</strong></div>
                <div style={{ fontSize: 13, color: "#666" }}>{j.area} • {j.city}/{j.state}</div>
              </div>

              <div className="job-actions">
                <button onClick={()=>openJobCandidates(j.job_id)}>Ver candidatos</button>
                <button onClick={()=>handleEdit(j)}>Editar</button>
                <button className="delete" onClick={()=>handleDelete(j.job_id)}>Deletar</button>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}