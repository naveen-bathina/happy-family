import React from 'react';
import { Container, Typography, TextField, Button, Box, Paper } from '@mui/material';

const Register: React.FC = () => {
    return (
        <Container>
            <Box sx={{ mt: 5, display: 'flex', justifyContent: 'center' }}>
                <Paper elevation={3} sx={{ p: 4, maxWidth: 600, width: '100%' }}>
                    <Typography variant="h4" gutterBottom align="center">
                        Register Your Family
                    </Typography>
                    <Typography variant="body1" gutterBottom align="center" sx={{ mb: 3 }}>
                        Join Happy Family and start your journey towards a better relationship.
                    </Typography>
                    <Box component="form" sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}>
                        <TextField label="Full Name" variant="outlined" required />
                        <TextField label="Email" variant="outlined" type="email" required />
                        <TextField label="Phone Number" variant="outlined" type="tel" required />
                        <TextField label="Wedding Date" variant="outlined" type="date" InputLabelProps={{ shrink: true }} required />
                        <TextField label="Password" variant="outlined" type="password" required />
                        <Button variant="contained" color="primary" size="large" sx={{ mt: 2 }}>
                            Register
                        </Button>
                    </Box>
                </Paper>
            </Box>
        </Container>
    );
};

export default Register;