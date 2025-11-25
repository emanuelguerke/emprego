import * as AuthModel from "../model/authModel.js";

// GET /debug/api/tokens -> returns JSON list of active tokens (safe for local testing)
export async function apiActiveTokens(req, res) {
  try {
    const map = await AuthModel.initActiveTokens();
    const tokens = Array.from(map.entries()).map(([token, info]) => ({
      token,
      username: info.username || null,
      role: info.role || null,
      id_usuario: info.id_usuario || null
    }));
    return res.status(200).json({ items: tokens });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}

// GET /debug/tokens -> simple HTML page that fetches /debug/api/tokens
export async function serveTokensPage(req, res) {
  const html = `<!doctype html>
<html>
<head>
<meta charset="utf-8" />
<title>Logados — Active Tokens</title>
<meta name="viewport" content="width=device-width,initial-scale=1" />
<style>
  :root{ --blue:#0b5ed7; --navy:#062a57; --muted:#6b7280; --card:#ffffff; }
  body{ margin:0; font-family:Inter,Arial,Helvetica,sans-serif; background:linear-gradient(180deg,#eaf2ff 0%, #ffffff 100%); color:var(--navy); }
  .wrap{ max-width:1100px; margin:28px auto; padding:16px; }
  .card{ background:var(--card); border-radius:10px; padding:18px; box-shadow:0 6px 20px rgba(11,78,215,0.08); }
  h1{ margin:0 0 8px 0; color:var(--navy); }
  .meta{ color:var(--muted); font-size:13px; margin-bottom:12px; }
  table{ width:100%; border-collapse:collapse; margin-top:12px; font-size:13px; }
  th,td{ text-align:left; padding:10px 8px; border-bottom:1px solid #f1f5ff; vertical-align:top; }
  th{ background:#f0f7ff; color:var(--blue); font-weight:600; }
  pre{ margin:0; white-space:nowrap; overflow:auto; max-width:520px; font-size:12px; }
  .btn{ background:var(--blue); color:#fff; border:none; padding:8px 12px; border-radius:8px; cursor:pointer; }
  .row-actions{ display:flex; gap:8px; align-items:center; }
  .copy{ background:#0b76ff33; border:1px solid #0b76ff66; color:var(--blue); padding:6px 8px; border-radius:6px; cursor:pointer; font-size:12px; }
  .empty{ color:var(--muted); padding:14px 0; text-align:center; }
</style>
</head>
<body>
  <div class="wrap">
    <div class="card">
      <div style="display:flex;justify-content:space-between;align-items:center;">
        <div>
          <h1>Usuários logados</h1>
          <div class="meta">Lista de tokens ativos (debug local)</div>
        </div>
        <div style="display:flex;gap:8px;align-items:center;">
          <button class="btn" onclick="load()">Refresh</button>
        </div>
      </div>

      <table id="tbl" aria-live="polite">
        <thead><tr><th>#</th><th>Role</th><th>Username</th><th>UserId</th><th>Token</th><th></th></tr></thead>
        <tbody></tbody>
      </table>
      <div style="margin-top:10px;color:var(--muted);font-size:12px;">Rota de teste pública local: <code>/logados</code></div>
    </div>
  </div>

<script>
async function load(){
  const t = document.querySelector('#tbl tbody');
  t.innerHTML = '<tr><td colspan="6" style="padding:14px">Loading...</td></tr>';
  try {
    const r = await fetch('/debug/api/tokens');
    if (!r.ok) throw new Error('HTTP ' + r.status);
    const data = await r.json();
    const items = data.items || [];
    if (items.length === 0) {
      t.innerHTML = '<tr><td colspan="6" class="empty">Nenhum token ativo</td></tr>';
      return;
    }
    t.innerHTML = items.map((it, idx) => {
      const tokenShort = (it.token||'').length > 120 ? (it.token.slice(0,120)+'...') : (it.token||'');
      return '<tr>' +
        '<td>' + (idx+1) + '</td>' +
        '<td>' + (it.role||'unknown') + '</td>' +
        '<td>' + (it.username||'unknown') + '</td>' +
        '<td>' + (it.id_usuario||'') + '</td>' +
        '<td><pre>' + escapeHtml(tokenShort) + '</pre></td>' +
        '<td class="row-actions"><button class="copy" onclick="copyToken(' + idx + ')">Copy</button></td>' +
      '</tr>';
    }).join('');
    // store tokens for copy
    window.__tokens = items.map(it => it.token || '');
  } catch (e) {
    t.innerHTML = '<tr><td colspan="6" style="padding:14px;color:#b91c1c">Erro: ' + (e.message||e) + '</td></tr>';
  }
}

function escapeHtml(s){ return String(s).replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }

function copyToken(idx){
  const t = (window.__tokens && window.__tokens[idx]) || '';
  navigator.clipboard?.writeText(t).then(()=>{ alert('Token copiado para a área de transferência'); }, ()=>{ prompt('Copie o token abaixo', t); });
}

load();
</script>
</body>
</html>`;
  res.setHeader("Content-Type", "text/html; charset=utf-8");
  res.send(html);
}