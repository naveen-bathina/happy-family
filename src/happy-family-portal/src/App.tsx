import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Home from './pages/Home';
import Login from './pages/Login';
import Dashboard from './pages/Dashboard';
import OurFamilies from './pages/OurFamilies';
import Logout from './pages/Logout';
import Members from './pages/Members';
import Chat from './pages/Chat';
import Diary from './pages/Diary';
import Support from './pages/Support';
import Settings from './pages/Settings';
import Navbar from './components/Navbar';
import Footer from './components/Footer';
import { CssBaseline, Box } from '@mui/material';
import { AuthProvider } from './context/AuthContext';
import Profile from './pages/Profile';
import PhoneAuth from './pages/PhoneAuth';
import Services from './pages/Services';
import JoinForm from './pages/JoinForm';

interface AppProps {
  toggleDarkMode: () => void; // Passed from Index
}

const App: React.FC<AppProps> = ({ toggleDarkMode }) => {

  return (
    <AuthProvider>
      <Router>
        <CssBaseline />
        <Navbar />
        <Box sx={{ minHeight: '100vh', display: 'flex', flexDirection: 'column' }}>
          <Routes>
            <Route path="/" element={<Home />} />
            <Route path="/join" element={<JoinForm />} />
            <Route path="/login" element={<Login />} />
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/our-families" element={<OurFamilies />} />
            <Route path="/logout" element={<Logout />} />
            <Route path="/members" element={<Members />} />
            <Route path="/chat" element={<Chat />} />
            <Route path="/diary" element={<Diary />} />
            <Route path="/support" element={<Support />} />
            <Route path="/profile" element={<Profile />} />
            <Route path="/settings" element={<Settings toggleDarkMode={toggleDarkMode} />} />
            <Route path="/auth" element={<PhoneAuth />} />
            <Route path="/services" element={<Services />} />
          </Routes>
          <Footer />
        </Box>
      </Router>
    </AuthProvider>
  );
};

export default App;