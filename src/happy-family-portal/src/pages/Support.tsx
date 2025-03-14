import React, { useState } from 'react';
import { Container, Typography, Box, TextField, Button, Snackbar, Alert } from '@mui/material';

const Support: React.FC = () => {
    const [title, setTitle] = useState<string>('');
    const [details, setDetails] = useState<string>('');
    const [openSnackbar, setOpenSnackbar] = useState<boolean>(false);
    const [snackbarMessage, setSnackbarMessage] = useState<string>('');
    const [snackbarSeverity, setSnackbarSeverity] = useState<'success' | 'error'>('success');

    // Handle the form submission
    const handleSubmit = () => {
        if (!title || !details) {
            setSnackbarMessage('Please provide both a title and details.');
            setSnackbarSeverity('error');
            setOpenSnackbar(true);
            return;
        }

        // Here you would send the support request to your server or backend service
        // For now, we simulate a successful submission

        setSnackbarMessage('Your support request has been submitted successfully!');
        setSnackbarSeverity('success');
        setOpenSnackbar(true);

        // Reset form fields
        setTitle('');
        setDetails('');
    };

    return (
        <Container sx={{ mt: 5 }}>
            <Typography variant="h4" gutterBottom align="center">
                Support Request
            </Typography>
            <Typography variant="body1" gutterBottom align="center" sx={{ mb: 3 }}>
                If you need assistance, please provide the details below, and we'll get back to you as soon as possible.
            </Typography>

            {/* Support Request Form */}
            <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}>
                <TextField
                    label="Title"
                    variant="outlined"
                    fullWidth
                    value={title}
                    onChange={(e) => setTitle(e.target.value)}
                />
                <TextField
                    label="Details"
                    variant="outlined"
                    fullWidth
                    multiline
                    rows={4}
                    value={details}
                    onChange={(e) => setDetails(e.target.value)}
                />

                <Button
                    variant="contained"
                    color="primary"
                    onClick={handleSubmit}
                    sx={{ mt: 2 }}
                >
                    Submit Support Request
                </Button>
            </Box>

            {/* Snackbar for feedback */}
            <Snackbar
                open={openSnackbar}
                autoHideDuration={6000}
                onClose={() => setOpenSnackbar(false)}
            >
                <Alert
                    onClose={() => setOpenSnackbar(false)}
                    severity={snackbarSeverity}
                    sx={{ width: '100%' }}
                >
                    {snackbarMessage}
                </Alert>
            </Snackbar>
        </Container>
    );
};

export default Support;
