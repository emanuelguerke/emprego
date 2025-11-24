export async function reportError(req, res) {
  try {
    // req.user is set by verifyToken middleware
    if (!req.user) return res.status(401).json({ message: "Invalid token" });
    const body = req.body || {};
    const message = String(body.message || "").trim();
    if (!message) return res.status(400).json({ message: "message required" });

    // apenas logar a mensagem com contexto do usuário
    console.log("========== Client-reported error ==========");
    console.log(`[user id=${req.user.id} role=${req.user.role} username=${req.user.username}] ${message}`);
    console.log("==========================================");

    return res.status(200).json({ message: "ok" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}