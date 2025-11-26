import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import { searchJobs, reportServerError } from "../services/jobService";
import { decodeToken } from "../services/authService";
import "../styles/app.css";

export default function Jobs() {
  const navigate = useNavigate();

  // UI form state (strings for inputs) and applied filters (sent to server)
  const defaultFormFilters = {
    title: "",
    area: "",
    state: "",
    city: "",
    company: "", // new
    salary_range: { min: "", max: "" }
  };
  const defaultAppliedFilters = {
    title: "",
    area: "",
    state: "",
    city: "",
    company: "", // new
    salary_range: { min: null, max: null } // changed: always include min/max (null when empty)
  };

  const [formFilters, setFormFilters] = useState(defaultFormFilters);
  const [filters, setFilters] = useState(defaultAppliedFilters);
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);

  const AREAS = ['','Administração','Agricultura','Artes','Atendimento ao Cliente','Comercial','Comunicação','Construção Civil','Consultoria','Contabilidade','Design','Educação','Engenharia','Finanças','Jurídica','Logística','Marketing','Produção','Recursos Humanos','Saúde','Segurança','Tecnologia da Informação','Telemarketing','Vendas','Outros'];

  useEffect(() => {
    let mounted = true;
    async function load() {
      setLoading(true);
      try {
        const data = await searchJobs(filters);
        if (!data || !Array.isArray(data.items)) {
          await reportServerError("Index 'items' not found in server data.");
          if (mounted) setItems([]);
          return;
        }
        const first = data.items[0];
        if (first && typeof first.title === "undefined") {
          await reportServerError("Index 'title' not found in server data.");
        }
        if (mounted) setItems(data.items || []);
      } catch (err) {
        const status = err?.response?.status;
        if (status === 401) navigate("/login");
        else if (status === 404) {
          if (mounted) setItems([]);
        } else {
          await reportServerError(`Failed to load jobs: ${err?.message || "unknown"}`);
        }
      } finally {
        if (mounted) setLoading(false);
      }
    }
    load();
    return () => { mounted = false; };
  }, [filters, navigate]);

  const payload = decodeToken();

  function goToApply(jobId) {
    if (!payload) { navigate("/login"); return; }
    navigate(`/jobs/${jobId}`);
  }

  // normalize form -> applied filters (numbers or null)
  function normalizeFormToApplied(form) {
    const sr = { min: null, max: null };
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
      company: form.company || "",
      salary_range: sr
    };
  }

  // handlers for filter form (modify only formFilters)
  function handleInputChange(e) {
    const { name, value } = e.target;
    setFormFilters(prev => ({ ...prev, [name]: value }));
  }
  function handleSalaryRangeChange(e) {
    const { name, value } = e.target; // name = min|max
    setFormFilters(prev => ({ ...prev, salary_range: { ...(prev.salary_range||{}), [name]: value } }));
  }
  function handleClearFilters() {
    setFormFilters(defaultFormFilters);
    setFilters(defaultAppliedFilters);
  }

  // execute search only when user clicks "Buscar"
  function handleSearchClick() {
    setFilters(normalizeFormToApplied(formFilters));
  }

  return (
    <div className="page-root">
      <div className="card">
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
          <h2>Vagas</h2>
          <button onClick={() => navigate("/home")} style={{ padding: "6px 10px", borderRadius: 6 }}>
            Voltar
          </button>
        </div>

        <div style={{ marginTop: 12, marginBottom: 12, padding: 8, border: "1px solid #eee", borderRadius: 6 }}>
          <h4>Filtros</h4>
          <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
            <input name="title" placeholder="Título" value={formFilters.title} onChange={handleInputChange} style={{ minWidth: 160 }} />
            <select name="area" value={formFilters.area} onChange={handleInputChange} style={{ minWidth: 200 }}>
              {AREAS.map(a => <option key={a} value={a}>{a || "— Área —"}</option>)}
            </select>
            <input name="company" placeholder="Empresa" value={formFilters.company} onChange={handleInputChange} style={{ minWidth: 160 }} />
            <input name="state" placeholder="Estado" value={formFilters.state} onChange={handleInputChange} style={{ minWidth: 100 }} />
            <input name="city" placeholder="Cidade" value={formFilters.city} onChange={handleInputChange} style={{ minWidth: 120 }} />
            <input name="min" placeholder="Salário min" type="text" value={formFilters.salary_range.min} onChange={handleSalaryRangeChange} style={{ width: 120 }} />
            <input name="max" placeholder="Salário max" type="text" value={formFilters.salary_range.max} onChange={handleSalaryRangeChange} style={{ width: 120 }} />
            <div style={{ display: "flex", gap: 8 }}>
              <button onClick={handleSearchClick}>Buscar</button>
              <button onClick={handleClearFilters} type="button">Limpar</button>
            </div>
          </div>
        </div>

        {loading ? <p>Carregando...</p> : (
          <>
            {items.length === 0 ? <div>Nenhuma vaga encontrada</div> : (
              <div>
                {items.map(it=>(
                  <div key={it.job_id} style={{ borderBottom: "1px solid #eee", padding: 8 }}>
                    <div><strong>{it.title}</strong> — {it.company}</div>
                    <div style={{ fontSize: 13, color: "#666" }}>{it.area} • {it.city} / {it.state}</div>
                    <div style={{ marginTop: 6 }}>{it.description}</div>
                    <div style={{ marginTop: 6 }}>
                      <button onClick={()=>goToApply(it.job_id)} style={{ padding: "6px 10px", borderRadius: 6 }}>Ver / Candidatar</button>
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