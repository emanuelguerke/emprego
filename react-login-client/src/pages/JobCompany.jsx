import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { createJob, searchCompanyJobs, searchJobs, updateJob, deleteJob } from "../services/jobService";
import { decodeToken } from "../services/authService";
import "../styles/app.css";

export default function JobCompany() {
  const navigate = useNavigate();
  const [payload] = useState(() => decodeToken());
  const [form, setForm] = useState({ title: "", area: "Outros", description: "", state: "", city: "", salary: "" });
  const [jobs, setJobs] = useState([]);
  const [loading, setLoading] = useState(true);

  // filters UI (strings) and applied filters (object sent to server)
  const defaultFormFilters = { title: "", area: "", state: "", city: "", salary_range: { min: "", max: "" } };
  const defaultAppliedFilters = { title: "", area: "", state: "", city: "", salary_range: {} };
  const [formFilters, setFormFilters] = useState(defaultFormFilters);
  const [filters, setFilters] = useState(defaultAppliedFilters);

  const AREAS = ['Administração','Agricultura','Artes','Atendimento ao Cliente','Comercial','Comunicação','Construção Civil','Consultoria','Contabilidade','Design','Educação','Engenharia','Finanças','Jurídica','Logística','Marketing','Produção','Recursos Humanos','Saúde','Segurança','Tecnologia da Informação','Telemarketing','Vendas','Outros'];

  // normalize form filters -> object with numeric salary if present (parseFloat) or empty salary_range object
  function normalizeFormToApplied(form) {
    const sr = {};
    if (form.salary_range?.min !== "" && form.salary_range.min !== undefined) {
      const v = parseFloat(String(form.salary_range.min).replace(",", "."));
      if (!Number.isNaN(v)) sr.min = v;
    }
    if (form.salary_range?.max !== "" && form.salary_range.max !== undefined) {
      const v = parseFloat(String(form.salary_range.max).replace(",", "."));
      if (!Number.isNaN(v)) sr.max = v;
    }
    return {
      title: form.title || "",
      area: form.area || "",
      state: form.state || "",
      city: form.city || "",
      salary_range: Object.keys(sr).length ? sr : {}
    };
  }

  useEffect(()=>{
    if (!payload) { navigate("/login"); return; }
    let mounted = true;
    async function load() {
      setLoading(true);
      try {
        // use company id from token sub
        const companyId = payload.sub;
        // initial load: send current filters (empty => all)
        const applied = filters || defaultAppliedFilters;
        const res = await searchCompanyJobs(companyId, applied);
        if (mounted) setJobs(res.items || []);
      } catch (e) {
        if (mounted) setJobs([]);
      } finally { if (mounted) setLoading(false); }
    }
    load();
    return ()=> { mounted = false; };
  }, [navigate, payload?.sub, filters]);

  async function handleCreate(e) {
    e.preventDefault();
    try {
      if (!payload) { navigate("/login"); return; }
      const salaryVal = String(form.salary || "").trim();
      const salaryNumber = salaryVal === "" ? undefined : parseFloat(salaryVal.replace(",", "."));
      const p = {
        title: form.title,
        area: form.area,
        description: form.description,
        state: form.state,
        city: form.city,
        salary: salaryNumber
      };
      await createJob(p);
      alert("Vaga criada");
      // refresh using currently applied filters
      const res = await searchCompanyJobs(payload.sub, filters || defaultAppliedFilters);
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
      salary: salaryStr === "" ? undefined : parseFloat(String(salaryStr).replace(",", "."))
    };

    try {
      await updateJob(job.job_id, payloadUpdate);
      const res = await searchCompanyJobs(payload.sub, filters || defaultAppliedFilters);
      setJobs(res.items || []);
      alert("Vaga atualizada");
    } catch (err) {
      alert(err?.response?.data?.message || err.message || "Erro ao atualizar");
    }
  }

  function openJobCandidates(jobId) {
    navigate(`/company/jobs/${jobId}`);
  }

  // filter handlers
  function handleFilterChange(e) {
    const { name, value } = e.target;
    setFormFilters(prev => ({ ...prev, [name]: value }));
  }
  function handleFilterSalaryChange(e) {
    const { name, value } = e.target; // min|max
    setFormFilters(prev => ({ ...prev, salary_range: { ...(prev.salary_range||{}), [name]: value } }));
  }
  function handleClearFilters() {
    setFormFilters(defaultFormFilters);
    setFilters(defaultAppliedFilters);
  }
  function handleSearchClick() {
    setFilters(normalizeFormToApplied(formFilters));
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
          <label>Salary (optional)<input type="text" value={form.salary} onChange={e=>setForm({...form,salary:e.target.value})} placeholder="ex: 1523.00" /></label>
          <div style={{ display: "flex", gap: 8 }}>
            <button type="submit">Criar vaga</button>
            <button type="button" onClick={()=>navigate("/company")}>Voltar</button>
          </div>
        </form>

        <hr style={{ margin: "12px 0" }} />

        {/* Filters for company job list (always send all fields even if empty) */}
        <div style={{ marginBottom: 12, padding: 8, border: "1px solid #eee", borderRadius: 6 }}>
          <h4>Filtros</h4>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap", alignItems: "center" }}>
            <input name="title" placeholder="Título" value={formFilters.title} onChange={handleFilterChange} style={{ minWidth: 160 }} />
            <select name="area" value={formFilters.area} onChange={handleFilterChange} style={{ minWidth: 180 }}>
              <option value="">— Área —</option>
              {AREAS.map(a => <option key={a} value={a}>{a}</option>)}
            </select>
            <input name="state" placeholder="Estado" value={formFilters.state} onChange={handleFilterChange} style={{ minWidth: 120 }} />
            <input name="city" placeholder="Cidade" value={formFilters.city} onChange={handleFilterChange} style={{ minWidth: 140 }} />
            <input name="min" placeholder="Salário min" type="text" value={formFilters.salary_range.min} onChange={handleFilterSalaryChange} style={{ width: 120 }} />
            <input name="max" placeholder="Salário max" type="text" value={formFilters.salary_range.max} onChange={handleFilterSalaryChange} style={{ width: 120 }} />
            <div style={{ display: "flex", gap: 8 }}>
              <button onClick={handleSearchClick} type="button">Buscar</button>
              <button onClick={handleClearFilters} type="button">Limpar</button>
            </div>
          </div>
        </div>

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