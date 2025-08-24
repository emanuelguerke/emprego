import React, { useEffect, useState } from "react";
import api, { logout, logoutServer } from "../services/authService";
import { useNavigate } from "react-router-dom";
import "../styles/app.css";

export default function Dashboard() {
    const [users, setUsers] = useState([]);
    const [loading, setLoading] = useState(true);
    const navigate = useNavigate();

    useEffect(() => {
        let mounted = true;
        async function load() {
            try {
                const res = await api.get("/users");
                if (mounted) setUsers(res.data);
            } catch (err) {
                // se token inválido/expirado -> deslogar e redirecionar
                logout();
                navigate("/");
            } finally {
                if (mounted) setLoading(false);
            }
        }
        load();
        return () => (mounted = false);
    }, [navigate]);

    async function handleLogout() {
        // tenta revogar no servidor; em qualquer caso limpa local e redireciona
        try {
            await logoutServer();
        } catch (err) {
            // ignorar - logoutServer já remove o token localmente no finally
        } finally {
            navigate("/");
        }
    }

    return (
        <div className="page-root">
            <div className="card">
                <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
                    <h2>Dashboard</h2>
                    <button onClick={handleLogout} style={{ padding: "8px 12px", borderRadius: 8, background: "#ef4444", color: "#fff", border: "none", cursor: "pointer" }}>
                        Logout
                    </button>
                </div>

                {loading ? (
                    <p>Carregando...</p>
                ) : (
                    <>
                        <p>Usuários:</p>
                        <ul>
                            {users.map((u) => (
                                <li key={u.id}>
                                    {u.nome ? `${u.nome} (${u.usuario})` : u.usuario}
                                </li>
                            ))}
                        </ul>
                    </>
                )}
            </div>
        </div>
    );
}