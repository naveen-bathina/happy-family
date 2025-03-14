import React from 'react';
import { Box, Typography, Container } from '@mui/material';

const Footer: React.FC = () => {
    return (
        <Box sx={{ bgcolor: 'primary.main', color: 'white', py: 3, mt: 'auto' }}>
            <Container>
                <Typography variant="body1" align="center">
                    &copy; {new Date().getFullYear()} Happy Family. All rights reserved.
                </Typography>
            </Container>
        </Box>
    );
};

export default Footer;