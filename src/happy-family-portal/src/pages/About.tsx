// src/pages/About.tsx
import React from 'react';
import { Typography } from '@mui/material';

const About: React.FC = () => {
    return (
        <div>
            <Typography variant="h2" color="primary">About Page</Typography>
            <Typography variant="body1" color="textSecondary">
                This is the About page. Learn more about our mission and values.
            </Typography>
        </div>
    );
};

export default About;
