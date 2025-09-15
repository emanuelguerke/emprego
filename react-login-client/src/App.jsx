import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Dashboard from "./pages/Dashboard";
import Setup from "./pages/Setup";
import ProtectedRoute from "./components/ProtectedRoute";
import "./styles/app.css";

function App() {
    return (
        <Router>
            <Routes>
                {/* root shows Setup (first run) and explicit /setup allows editing later */}
                <Route path="/" element={<Setup />} />
                <Route path="/setup" element={<Setup />} />
                <Route path="/login" element={<Login />} />
                {/* register now available at /users */}
                <Route path="/users" element={<Register />} />
                <Route
                    path="/dashboard"
                    element={
                        <ProtectedRoute>
                            <Dashboard />
                        </ProtectedRoute>
                    }
                />
            </Routes>
        </Router>
    );
}

export default App;