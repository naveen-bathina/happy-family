import { useState } from 'react'
import './index.css'
import App from './App.tsx'
import { createTheme, ThemeProvider } from '@mui/material/styles';
import { CssBaseline } from '@mui/material';
import theme from './theme'; // Import the theme you've created

const Index: React.FC = () => {
    const [darkMode, setDarkMode] = useState<boolean>(false);

    // Function to toggle dark mode
    const toggleDarkMode = () => {
        setDarkMode((prevMode: boolean) => !prevMode);
    };

    // Create a theme based on the darkMode state
    const customTheme = createTheme({
        ...theme, // Spread the base theme
        palette: {
            ...theme.palette, // Retain original palette colors
            mode: darkMode ? 'dark' : 'light', // Switch between dark and light mode
            background: {
                default: darkMode ? '#121212' : '#F8F8F8', // Background color based on mode
            },
        },
    });

    return (
        <ThemeProvider theme={customTheme}>
            <CssBaseline />
            <App toggleDarkMode={toggleDarkMode} />
        </ThemeProvider>
    );
};

export default Index;