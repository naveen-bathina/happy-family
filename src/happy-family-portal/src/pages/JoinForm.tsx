import React, { useState, useCallback } from 'react';
import {
    Container, Typography, TextField, Button, Box, Paper, Alert, Grid, InputAdornment, MenuItem, CircularProgress
} from '@mui/material';
import { Person, Email, Phone, FamilyRestroom, Wc, Home } from '@mui/icons-material';
import { submitJoinRequest, JoinRequest } from '../services/familyService';

const JoinForm: React.FC = () => {
    const [join, setJoin] = useState<JoinRequest>({
        firstName: '',
        lastName: '',
        familyName: '',
        emailAddress: '',
        contactNumber: '',
        gender: '',
        address: '',
    });

    const [message, setMessage] = useState<string>('');
    const [success, setSuccess] = useState<boolean | null>(null);
    const [loading, setLoading] = useState<boolean>(false);

    const handleChange = useCallback(
        (e: React.ChangeEvent<HTMLInputElement | { name?: string; value: unknown }>) => {
            const { name, value } = e.target;
            setJoin((prev) => ({ ...prev, [name as string]: value }));
        },
        []
    );

    const handleSubmit = async (e: React.FormEvent) => {
        e.preventDefault();

        if (!join.firstName || !join.lastName || !join.familyName || !join.emailAddress || !join.contactNumber || !join.gender || !join.address) {
            setSuccess(false);
            setMessage('All fields are required. Please fill in all details.');
            return;
        }

        try {
            setLoading(true);
            setMessage('');
            setSuccess(null);

            const response = await submitJoinRequest(join);

            setSuccess(true);
            setMessage('Your request to join Happy Family has been submitted successfully! We will connect with you soon.');

            setJoin({
                firstName: '',
                lastName: '',
                familyName: '',
                emailAddress: '',
                contactNumber: '',
                gender: '',
                address: '',
            });
        } catch (error: any) {
            setSuccess(false);
            setMessage(error.message || 'Failed to submit request. Please try again.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <Container>
            <Box sx={{ mt: 5, display: 'flex', justifyContent: 'center' }}>
                <Paper elevation={3} sx={{ p: 4, maxWidth: 600, width: '100%' }}>
                    <Typography variant="h4" gutterBottom align="center">
                        Join Happy Family
                    </Typography>
                    <Typography variant="body1" gutterBottom align="center" sx={{ mb: 3 }}>
                        Request to join our community and start your journey towards a happier family life.
                    </Typography>
                    {message && (
                        <Alert severity={success ? 'success' : 'error'} sx={{ mb: 3 }}>
                            {message}
                        </Alert>
                    )}
                    <Box component="form" onSubmit={handleSubmit} sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}>
                        <Grid container spacing={2}>
                            <Grid item xs={6}>
                                <TextField
                                    label="First Name"
                                    name="firstName"
                                    variant="outlined"
                                    fullWidth
                                    value={join.firstName}
                                    onChange={handleChange}
                                    required
                                    InputProps={{
                                        startAdornment: (
                                            <InputAdornment position="start">
                                                <Person />
                                            </InputAdornment>
                                        ),
                                    }}
                                />
                            </Grid>
                            <Grid item xs={6}>
                                <TextField
                                    label="Last Name"
                                    name="lastName"
                                    variant="outlined"
                                    fullWidth
                                    value={join.lastName}
                                    onChange={handleChange}
                                    required
                                    InputProps={{
                                        startAdornment: (
                                            <InputAdornment position="start">
                                                <Person />
                                            </InputAdornment>
                                        ),
                                    }}
                                />
                            </Grid>
                        </Grid>

                        <TextField
                            label="Family Name"
                            name="familyName"
                            variant="outlined"
                            fullWidth
                            value={join.familyName}
                            onChange={handleChange}
                            required
                            InputProps={{
                                startAdornment: (
                                    <InputAdornment position="start">
                                        <FamilyRestroom />
                                    </InputAdornment>
                                ),
                            }}
                        />

                        <TextField
                            select
                            label="Gender"
                            name="gender"
                            variant="outlined"
                            fullWidth
                            value={join.gender}
                            onChange={handleChange}
                            required
                            InputProps={{
                                startAdornment: (
                                    <InputAdornment position="start">
                                        <Wc />
                                    </InputAdornment>
                                ),
                            }}
                        >
                            <MenuItem value="Male">Male</MenuItem>
                            <MenuItem value="Female">Female</MenuItem>
                            <MenuItem value="Other">Other</MenuItem>
                        </TextField>

                        <TextField
                            label="Email"
                            name="emailAddress"
                            variant="outlined"
                            type="email"
                            fullWidth
                            value={join.emailAddress}
                            onChange={handleChange}
                            required
                            InputProps={{
                                startAdornment: (
                                    <InputAdornment position="start">
                                        <Email />
                                    </InputAdornment>
                                ),
                            }}
                        />

                        <TextField
                            label="Phone Number"
                            name="contactNumber"
                            variant="outlined"
                            type="tel"
                            fullWidth
                            value={join.contactNumber}
                            onChange={handleChange}
                            required
                            InputProps={{
                                startAdornment: (
                                    <InputAdornment position="start">
                                        <Phone />
                                        <Typography sx={{ ml: 1, fontWeight: 'bold' }}>+91</Typography>
                                    </InputAdornment>
                                ),
                            }}
                        />

                        <TextField
                            label="Address"
                            name="address"
                            variant="outlined"
                            multiline
                            rows={3}
                            fullWidth
                            value={join.address}
                            onChange={handleChange}
                            required
                            InputProps={{
                                startAdornment: (
                                    <InputAdornment position="start">
                                        <Home />
                                    </InputAdornment>
                                ),
                            }}
                        />

                        <Button variant="contained" color="primary" size="large" type="submit" sx={{ mt: 2 }} disabled={loading}>
                            {loading ? <CircularProgress size={24} color="inherit" /> : 'Submit Request'}
                        </Button>
                    </Box>
                </Paper>
            </Box>
        </Container>
    );
};

export default JoinForm;
