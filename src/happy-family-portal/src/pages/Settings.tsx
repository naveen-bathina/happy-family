import React, { useState } from 'react';
import { Container, Typography, Paper, Box, Switch, FormControlLabel, Button, MenuItem, Select, InputLabel, FormControl } from '@mui/material';

interface SettingsProps {
    toggleDarkMode: () => void; // Function to toggle dark mode
}

const Settings: React.FC<SettingsProps> = ({ toggleDarkMode }) => {
    const [emailNotifications, setEmailNotifications] = useState<boolean>(true);
    const [language, setLanguage] = useState<string>('en');
    const [darkMode, setDarkMode] = useState<boolean>(false);
    const [profileVisibility, setProfileVisibility] = useState<boolean>(true);

    const handleEmailNotificationChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setEmailNotifications(event.target.checked);
    };

    const handleDarkModeChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setDarkMode(event.target.checked);
    };

    const handleProfileVisibilityChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setProfileVisibility(event.target.checked);
    };

    const handleLanguageChange = (event: React.ChangeEvent<{ value: unknown }>) => {
        setLanguage(event.target.value as string);
    };

    const handleSaveSettings = () => {
        // You can save these settings to a server or local storage as needed
        alert('Settings saved!');
    };


    return (
        <Container maxWidth="sm" sx={{ mt: 5 }}>
            <Paper elevation={3} sx={{ padding: 3 }}>
                <Typography variant="h5" gutterBottom align="center">
                    Application Settings
                </Typography>

                {/* Email Notifications */}
                <Box sx={{ mb: 2 }}>
                    <FormControlLabel
                        control={
                            <Switch
                                checked={emailNotifications}
                                onChange={handleEmailNotificationChange}
                                color="primary"
                            />
                        }
                        label="Email Notifications"
                    />
                </Box>

                {/* Language Preference */}
                <Box sx={{ mb: 2 }}>
                    <FormControl fullWidth>
                        <InputLabel>Language</InputLabel>
                        <Select
                            value={language}
                            onChange={handleLanguageChange}
                            label="Language"
                        >
                            <MenuItem value="en">English</MenuItem>
                            <MenuItem value="es">Spanish</MenuItem>
                            <MenuItem value="fr">French</MenuItem>
                            <MenuItem value="de">German</MenuItem>
                        </Select>
                    </FormControl>
                </Box>

                {/* Dark Mode */}
                <Box sx={{ mb: 2 }}>
                    <FormControlLabel
                        control={
                            <Switch
                                checked={darkMode}
                                onChange={toggleDarkMode}
                                color="primary"
                            />
                        }
                        label="Dark Mode"
                    />
                </Box>

                {/* Profile Visibility */}
                <Box sx={{ mb: 2 }}>
                    <FormControlLabel
                        control={
                            <Switch
                                checked={profileVisibility}
                                onChange={handleProfileVisibilityChange}
                                color="primary"
                            />
                        }
                        label="Profile Visibility"
                    />
                </Box>

                {/* Save Button */}
                <Box sx={{ display: 'flex', justifyContent: 'center' }}>
                    <Button
                        variant="contained"
                        color="primary"
                        onClick={handleSaveSettings}
                    >
                        Save Settings
                    </Button>
                </Box>
            </Paper>
        </Container>
    );
};

export default Settings;
