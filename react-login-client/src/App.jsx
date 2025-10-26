import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Home from "./pages/Home";
import Profile from "./pages/Profile";
import Setup from "./pages/Setup";
import ProtectedRoute from "./components/ProtectedRoute";
import CompanyRegister from "./pages/CompanyRegister";
import CompanyHome from "./pages/CompanyHome";
import "./styles/app.css";

function App() {
    return (
        <Router>
            <Routes>
                <Route path="/" element={<Setup />} />
                <Route path="/setup" element={<Setup />} />
                <Route path="/login" element={<Login />} />
                <Route path="/users" element={<Register />} />
                <Route path="/companies" element={<CompanyRegister />} />
                <Route
                    path="/home"
                    element={
                        <ProtectedRoute>
                            <Home />
                        </ProtectedRoute>
                    }
                />
                <Route
                    path="/profile/:id"
                    element={
                        <ProtectedRoute>
                            <Profile />
                        </ProtectedRoute>
                    }
                />
                <Route
                    path="/company"
                    element={
                        <ProtectedRoute>
                            <CompanyHome />
                        </ProtectedRoute>
                    }
                />
            </Routes>
        </Router>
    );
}

export default App;