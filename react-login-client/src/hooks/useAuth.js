import { useState, useEffect } from 'react';
import { loginUser } from '../services/authService';

const useAuth = () => {
    const [user, setUser] = useState(null);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        const storedUser = JSON.parse(localStorage.getItem('user'));
        if (storedUser) {
            setUser(storedUser);
        }
        setLoading(false);
    }, []);

    const login = async (credentials) => {
        setLoading(true);
        setError(null);
        try {
            const loggedInUser = await loginUser(credentials);
            setUser(loggedInUser);
            localStorage.setItem('user', JSON.stringify(loggedInUser));
        } catch (err) {
            setError(err.message);
        } finally {
            setLoading(false);
        }
    };

    const logout = () => {
        setUser(null);
        localStorage.removeItem('user');
    };

    const isAuthenticated = () => {
        return user !== null;
    };

    return {
        user,
        loading,
        error,
        login,
        logout,
        isAuthenticated,
    };
};

export default useAuth;