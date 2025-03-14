import React from 'react';
import { AppBar, Toolbar, Typography, Button, Container, Box, Avatar } from '@mui/material';
import { Link } from 'react-router-dom';
import { GroupAdd as GroupAddIcon, Login as LoginIcon, FamilyRestroom as FamilyRestroomIcon } from '@mui/icons-material';

const PublicNavbar: React.FC = () => {
    return (
        <AppBar position="static" color="primary">
            <Container>
                <Toolbar>
                    {/* Logo before Brand Name */}
                    <Link to="/" style={{ textDecoration: 'none', color: 'inherit', display: 'flex', alignItems: 'center' }}>
                        <Avatar
                            alt="Logo"
                            src="images/favicon.png" // Replace with your logo URL
                            sx={{ width: 40, height: 40, marginRight: 1, background: 'white' }} // Adjust size as needed
                        />
                        <Typography variant="h6" component="div" sx={{ color: 'white' }}>
                            Happy Family
                        </Typography>
                    </Link>

                    {/* Navigation Links with Icons */}
                    <Box sx={{ display: { xs: 'none', sm: 'flex' }, gap: 2, ml: 'auto' }}>
                        <Button color="inherit" component={Link} to="/join" startIcon={<GroupAddIcon />}>
                            Join
                        </Button>
                        <Button color="inherit" component={Link} to="/login" startIcon={<LoginIcon />}>
                            Login
                        </Button>
                        <Button color="inherit" component={Link} to="/our-families" startIcon={<FamilyRestroomIcon />}>
                            Our Families
                        </Button>
                    </Box>

                    {/* Mobile Menu (Optional) */}
                    <Box sx={{ display: { xs: 'flex', sm: 'none' } }}>
                        <Button color="inherit" component={Link} to="/join" startIcon={<GroupAddIcon />}>
                            Join
                        </Button>
                        <Button color="inherit" component={Link} to="/login" startIcon={<LoginIcon />}>
                            Login
                        </Button>
                        <Button color="inherit" component={Link} to="/our-families" startIcon={<FamilyRestroomIcon />}>
                            Our Families
                        </Button>
                    </Box>
                </Toolbar>
            </Container>
        </AppBar>
    );
};

export default PublicNavbar;
