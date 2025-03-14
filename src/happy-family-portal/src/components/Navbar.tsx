import React from 'react';
import { useAuth } from '../context/AuthContext';
import LoggedInNavbar from './LoggedInNavbar';
import PublicNavbar from './PublicNavbar'; // Assuming you have a PublicNavbar component

const Navbar: React.FC = () => {
    const { isLoggedIn } = useAuth(); // Get login state

    return isLoggedIn ? <LoggedInNavbar /> : <PublicNavbar />;
};

export default Navbar;