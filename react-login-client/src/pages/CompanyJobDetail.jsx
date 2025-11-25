import React, { useEffect, useState } from "react";
import { useNavigate, useParams } from "react-router-dom";
import { getJob, listCompanyApplicants, sendFeedback } from "../services/jobService";
import { decodeToken } from "../services/authService";
import "../styles/app.css";

export default function CompanyJobDetail() {
  const { id } = useParams();
  const navigate = useNavigate();
  // decode token once (stable)
  const [payload] = useState(() => decodeToken());
  const companyId = payload?.sub || payload?.id || null;

  const [job, setJob] = useState(null);
  const [applicants, setApplicants] = useState([]);
  const [loading, setLoading] = useState(true);
  const [feedbacks, setFeedbacks] = useState({}); // user_id -> message
  const [sending, setSending] = useState({}); // user_id -> boolean

  useEffect(() => {
    if (!companyId) { navigate("/login"); return; }
    if (payload?.role !== "company") { alert("Acesso restrito a empresas"); navigate("/company"); return; }

    let mounted = true;

    (async () => {
      setLoading(true);
      try {
        const jobData = await getJob(Number(id));
        if (mounted) setJob(jobData);
      } catch (err) {
        alert("Erro ao carregar vaga");
        navigate("/company/jobs");
        return;
      }

      try {
        const res = await listCompanyApplicants(companyId, Number(id));
        if (mounted) setApplicants(res.items || []);
      } catch (err) {
        if (mounted) setApplicants([]);
      } finally {
        if (mounted) setLoading(false);
      }
    })();

    return () => { mounted = false; };
  }, [id, navigate, companyId, payload?.role]);

  async function handleSendFeedback(applicant) {
    const userId = applicant.user_id;
    const msg = String(feedbacks[userId] || "").trim();
    if (!msg || msg.length < 10) { alert("Mensagem deve ter entre 10 e 600 caracteres"); return; }
    setSending(prev => ({ ...prev, [userId]: true }));
    try {
      await sendFeedback(Number(id), { user_id: userId, message: msg });
      alert("Feedback enviado");
      setFeedbacks(prev => ({ ...prev, [userId]: "" }));
    } catch (err) {
      alert(err?.response?.data?.message || err.message || "Erro ao enviar feedback");
    } finally {
      setSending(prev => ({ ...prev, [userId]: false }));
    }
  }

  if (loading) return <div className="page-root"><div className="card"><p>Carregando...</p></div></div>;
  if (!job) return <div className="page-root"><div className="card"><p>Vaga não encontrada</p></div></div>;

  return (
    <div className="page-root">
      <div className="card">
        <h2>{job.title}</h2>
        <div style={{ fontSize: 13, color: "#666" }}>{job.area} • {job.city}/{job.state} — {job.company}</div>
        <p style={{ marginTop: 12 }}>{job.description}</p>

        <hr style={{ margin: "12px 0" }} />

        <h3>Candidatos ({applicants.length})</h3>
        {applicants.length === 0 && <p>Nenhum candidato até o momento</p>}
        {applicants.map((app, idx) => (
          <div key={app.user_id ?? idx} style={{ borderBottom: "1px solid #eee", padding: 8 }}>
            <div><strong>{app.name}</strong> {app.user_name ? `(${app.user_name})` : ""}</div>
            <div style={{ fontSize: 13, color: "#666" }}>{app.email || "—"} • {app.phone || "—"}</div>
            <div style={{ marginTop: 8 }}>
              <div><strong>Formação</strong></div>
              <div style={{ whiteSpace: "pre-wrap" }}>{app.education}</div>
              <div style={{ marginTop: 6 }}><strong>Experiência</strong></div>
              <div style={{ whiteSpace: "pre-wrap" }}>{app.experience}</div>
            </div>

            <div style={{ marginTop: 8 }}>
              {/* removed "Feedback atual" display per protocol (server doesn't return feedback field) */}
              {app.user_id ? (
                <>
                  <textarea
                    placeholder="Escreva um feedback (10-600 chars)"
                    rows={3}
                    value={feedbacks[app.user_id] || ""}
                    onChange={e => setFeedbacks(prev => ({ ...prev, [app.user_id]: e.target.value }))}
                    style={{ width: "100%", marginTop: 6 }}
                  />
                  <div style={{ display: "flex", gap: 8, marginTop: 6 }}>
                    <button onClick={() => handleSendFeedback(app)} disabled={!!sending[app.user_id]}>
                      {sending[app.user_id] ? "Enviando..." : "Enviar feedback"}
                    </button>
                    <button onClick={() => setFeedbacks(prev => ({ ...prev, [app.user_id]: "" }))}>Limpar</button>
                  </div>
                </>
              ) : (
                <div style={{ marginTop: 6, color: "#666" }}>Aplicação sem usuário vinculado — não é possível enviar feedback por usuário.</div>
              )}
            </div>
          </div>
        ))}

        <div style={{ marginTop: 12 }}>
          <button onClick={() => navigate("/company/jobs")}>Voltar</button>
        </div>
      </div>
    </div>
  );
}