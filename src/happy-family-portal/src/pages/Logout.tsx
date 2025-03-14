import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';

const Logout: React.FC = () => {
    const navigate = useNavigate();
    const { logout } = useAuth(); // Use the logout function from AuthContext

    useEffect(() => {
        logout(); // Call logout function
        navigate('/login'); // Redirect to login page
    }, [logout, navigate]);

    return null; // No UI needed
};

export default Logout;