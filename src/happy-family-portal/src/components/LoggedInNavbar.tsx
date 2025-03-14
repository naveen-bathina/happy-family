import React, { useState } from 'react';
import { AppBar, Toolbar, Typography, Button, IconButton, Menu, MenuItem, Box, Container, Avatar } from '@mui/material';
import MenuIcon from '@mui/icons-material/Menu';
import { Link } from 'react-router-dom'; // Import Link for navigation
import { useAuth } from '../context/AuthContext';
import { Person, Settings as SettingsIcon, Redeem, Storefront } from '@mui/icons-material';
import { People as PeopleIcon, Chat as ChatIcon, EventNote as DiaryIcon, HelpOutline as SupportIcon, ExitToApp as LogoutIcon } from '@mui/icons-material';

const LoggedInNavbar: React.FC = () => {
    const { logout } = useAuth(); // Get logout function from AuthContext
    const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null); // For hamburger menu
    const [profileMenuAnchor, setProfileMenuAnchor] = useState<null | HTMLElement>(null); // For profile menu

    const handleMenuOpen = (event: React.MouseEvent<HTMLElement>) => {
        setAnchorEl(event.currentTarget); // Open the hamburger menu
    };

    const handleMenuClose = () => {
        setAnchorEl(null); // Close the hamburger menu
    };

    const handleProfileMenuOpen = (event: React.MouseEvent<HTMLElement>) => {
        setProfileMenuAnchor(event.currentTarget); // Open the profile menu
    };

    const handleProfileMenuClose = () => {
        setProfileMenuAnchor(null); // Close the profile menu
    };

    return (
        <AppBar position="static" color="primary">
            <Container>
                <Toolbar>
                    {/* Logo/Brand Name */}
                    <Typography variant="h6" component="div" sx={{ flexGrow: 1 }}>
                        <Link to="/dashboard" style={{ textDecoration: 'none', color: 'inherit', display: 'flex', alignItems: 'center' }}>
                            <Avatar
                                alt="Logo"
                                src="images/favicon.png" // Replace with your logo URL
                                sx={{ width: 40, height: 40, marginRight: 1, background: 'white' }} // Adjust size as needed
                            />
                            <Typography variant="h6" component="div" sx={{ color: 'white' }}>
                                Happy Family
                            </Typography>
                        </Link>
                    </Typography>

                    {/* Main Menu Items (Visible on larger screens) */}
                    <Box sx={{ display: { xs: 'none', sm: 'flex' }, gap: 2 }}>
                        <Button color="inherit" component={Link} to="/members" startIcon={<PeopleIcon />}>
                            Members
                        </Button>
                        <Button color="inherit" component={Link} to="/chat" startIcon={<ChatIcon />}>
                            Chat
                        </Button>
                        <Button color="inherit" component={Link} to="/diary" startIcon={<DiaryIcon />}>
                            Diary
                        </Button>
                        <Button color="inherit" component={Link} to="/support" startIcon={<SupportIcon />}>
                            Support
                        </Button>
                        <Button color="inherit" component={Link} to="/services" startIcon={<Storefront />}>
                            Services
                        </Button>
                    </Box>

                    {/* Profile Avatar and Menu (Visible on all screens) */}
                    <Box sx={{ display: 'flex', alignItems: 'center' }}>
                        <IconButton color="inherit" onClick={handleProfileMenuOpen}>
                            <Avatar
                                src="https://picsum.photos/40?random=1" // Placeholder profile picture
                                sx={{ width: 40, height: 40, border: '2px solid white' }}
                            />
                        </IconButton>

                        {/* Profile Menu */}
                        <Menu
                            anchorEl={profileMenuAnchor}
                            open={Boolean(profileMenuAnchor)}
                            onClose={handleProfileMenuClose}
                            sx={{ mt: '45px' }} // Adjust for proper positioning of the menu
                        >
                            <MenuItem component={Link} to="/profile" onClick={handleProfileMenuClose}>
                                <Person sx={{ marginRight: 2 }} />
                                View Profile
                            </MenuItem>
                            <MenuItem component={Link} to="/settings" onClick={handleProfileMenuClose}>
                                <SettingsIcon sx={{ marginRight: 2 }} />
                                Settings
                            </MenuItem>
                            <MenuItem component={Link} to="/" onClick={logout}>
                                <LogoutIcon sx={{ marginRight: 2 }} />
                                Logout
                            </MenuItem>
                        </Menu>
                    </Box>

                    {/* Hamburger Menu (Visible on smaller screens) */}
                    <Box sx={{ display: { xs: 'flex', sm: 'none' } }}>
                        <IconButton color="inherit" onClick={handleMenuOpen}>
                            <MenuIcon />
                        </IconButton>
                        <Menu
                            anchorEl={anchorEl}
                            open={Boolean(anchorEl)}
                            onClose={handleMenuClose}
                            sx={{ display: { xs: 'block', sm: 'none' } }}
                        >
                            <MenuItem component={Link} to="/members" onClick={handleMenuClose}>
                                <PeopleIcon sx={{ marginRight: 2 }} />
                                Members
                            </MenuItem>
                            <MenuItem component={Link} to="/chat" onClick={handleMenuClose}>
                                <ChatIcon sx={{ marginRight: 2 }} />
                                Chat
                            </MenuItem>
                            <MenuItem component={Link} to="/diary" onClick={handleMenuClose}>
                                <DiaryIcon sx={{ marginRight: 2 }} />
                                Diary
                            </MenuItem>
                            <MenuItem component={Link} to="/support" onClick={handleMenuClose}>
                                <SupportIcon sx={{ marginRight: 2 }} />
                                Support
                            </MenuItem>
                            <MenuItem onClick={logout}>
                                <LogoutIcon sx={{ marginRight: 2 }} />
                                Logout
                            </MenuItem>
                        </Menu>
                    </Box>
                </Toolbar>
            </Container>
        </AppBar>
    );
};

export default LoggedInNavbar;
