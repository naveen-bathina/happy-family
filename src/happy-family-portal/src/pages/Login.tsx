import React, { useState } from 'react';
import { Container, Typography, TextField, Button, Box, Paper, Alert, CircularProgress } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../context/AuthContext';
import { requestOtp, verifyOtp } from '../services/authService';



const Login: React.FC = () => {

    const [emailOrPhone, setEmailOrPhone] = useState('');
    const [otp, setOtp] = useState('');
    const [step, setStep] = useState<'input' | 'otp'>('input');
    const [message, setMessage] = useState('');
    const [isLoading, setIsLoading] = useState(false);
    const navigate = useNavigate();
    const { login } = useAuth(); // Use the login function from AuthContext

    const handleSendOtp = async () => {
        // Validate email or phone number
        if (!emailOrPhone) {
            setMessage('Please enter your email or phone number.');
            return;
        }
        setIsLoading(true);
        try {
            const response = await requestOtp(emailOrPhone);

            console.log(response);

            if (response.success && response.message) {
                setMessage(response.data.message);
                setStep('otp');
            } else {
                setMessage(response.data.message || 'Failed to send OTP.');
            }

            // Simulate sending OTP
            setIsLoading(false);
            //setMessage('OTP sent to your email/phone.');


        } catch (error: any) {
            console.error('API Error:', error.response?.message || error.message);
            setMessage(error.response?.message || 'Failed to send OTP.');
        } finally {
            setIsLoading(true);
        }

    };

    const handleVerifyOtp = async () => {
        // Validate OTP
        if (!otp) {

            setIsLoading(true);
            const response = await verifyOtp(emailOrPhone, otp);
            console.log(response);
            setIsLoading(false);
            setMessage('Please enter the OTP.');
            return;
        }

        // Simulate OTP verification
        setIsLoading(true);
        setTimeout(() => {
            setIsLoading(false);
            if (otp === '123456') { // Replace with actual OTP validation logic
                setMessage('Login successful! Redirecting to dashboard...');
                login(); // Update login state
                localStorage.setItem('user', JSON.stringify({ name: 'John Doe', email: 'john@example.com' })); // Store user data
                navigate('/dashboard'); // Redirect to dashboard
            } else {
                setMessage('Invalid OTP. Please try again.');
            }
        }, 2000); // Simulate a 2-second delay
    };
    return (
        <Container>
            <Box sx={{ mt: 5, display: 'flex', justifyContent: 'center' }}>
                <Paper elevation={3} sx={{ p: 4, maxWidth: 600, width: '100%' }}>
                    <Typography variant="h4" gutterBottom align="center">
                        Login
                    </Typography>
                    <Typography variant="body1" gutterBottom align="center" sx={{ mb: 3 }}>
                        Enter your email or phone number to receive an OTP.
                    </Typography>
                    {message && (
                        <Alert severity={message.includes('success') ? 'success' : 'error'} sx={{ mb: 3 }}>
                            {message}
                        </Alert>
                    )}
                    {step === 'input' ? (
                        <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}>
                            <TextField
                                label="Email or Phone Number"
                                variant="outlined"
                                value={emailOrPhone}
                                onChange={(e) => setEmailOrPhone(e.target.value)}
                                required
                                fullWidth
                            />
                            <Button
                                variant="contained"
                                color="primary"
                                size="large"
                                onClick={handleSendOtp}
                                disabled={isLoading}
                                sx={{ mt: 2 }}
                            >
                                {isLoading ? <CircularProgress size={24} /> : 'Send OTP'}
                            </Button>
                        </Box>
                    ) : (
                        <Box sx={{ display: 'flex', flexDirection: 'column', gap: 2 }}>
                            <TextField
                                label="OTP"
                                variant="outlined"
                                value={otp}
                                onChange={(e) => setOtp(e.target.value)}
                                required
                                fullWidth
                            />
                            <Button
                                variant="contained"
                                color="primary"
                                size="large"
                                onClick={handleVerifyOtp}
                                disabled={isLoading}
                                sx={{ mt: 2 }}
                            >
                                {isLoading ? <CircularProgress size={24} /> : 'Verify OTP'}
                            </Button>
                        </Box>
                    )}
                </Paper>
            </Box>
        </Container>
    );
};

export default Login;