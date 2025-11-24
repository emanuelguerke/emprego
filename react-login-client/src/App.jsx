import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Home from "./pages/Home";
import Profile from "./pages/Profile";
import Setup from "./pages/Setup";
import CompanyHome from "./pages/CompanyHome";
import CompanyRegister from "./pages/CompanyRegister";
import CompanyProfile from "./pages/CompanyProfile";
import Jobs from "./pages/Jobs";
import JobCompany from "./pages/JobCompany";
import CompanyJobDetail from "./pages/CompanyJobDetail";
import JobDetail from "./pages/JobDetail";
import UserApplications from "./pages/UserApplications";
import ProtectedRoute from "./components/ProtectedRoute";
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
          path="/company"
          element={
            <ProtectedRoute>
              <CompanyHome />
            </ProtectedRoute>
          }
        />
        <Route
          path="/company/profile"
          element={
            <ProtectedRoute>
              <CompanyProfile />
            </ProtectedRoute>
          }
        />

        <Route
          path="/company/jobs"
          element={
            <ProtectedRoute>
              <JobCompany />
            </ProtectedRoute>
          }
        />

        <Route
          path="/company/jobs/:id"
          element={
            <ProtectedRoute>
              <CompanyJobDetail />
            </ProtectedRoute>
          }
        />

        <Route
          path="/home"
          element={
            <ProtectedRoute>
              <Home />
            </ProtectedRoute>
          }
        />
        <Route
          path="/jobs"
          element={
            <ProtectedRoute>
              <Jobs />
            </ProtectedRoute>
          }
        />

        <Route
          path="/my-applications"
          element={
            <ProtectedRoute>
              <UserApplications />
            </ProtectedRoute>
          }
        />

        <Route
          path="/jobs/:id"
          element={
            <ProtectedRoute>
              <JobDetail />
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
      </Routes>
    </Router>
  );
}

export default App;