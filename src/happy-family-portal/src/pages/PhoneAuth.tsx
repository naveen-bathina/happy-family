import React, { useState } from 'react';
import { TextField, Button, Snackbar, Alert, CircularProgress, InputAdornment } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import { auth, RecaptchaVerifier, signInWithPhoneNumber, PhoneAuthProvider, signInWithCredential } from '../utils/firebase';

const PhoneAuth = () => {
    const [phoneNumber, setPhoneNumber] = useState('');
    const [verificationCode, setVerificationCode] = useState('');
    const [user, setUser] = useState<any>(null);
    const [verificationId, setVerificationId] = useState<string>('');
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState<string | null>(null);
    const [openSnackbar, setOpenSnackbar] = useState(false);
    const [snackbarMessage, setSnackbarMessage] = useState('');
    const navigate = useNavigate();

    // Step 1: Send verification code to phone number
    const handlePhoneNumberSubmit = async () => {
        if (!phoneNumber) return;

        setLoading(true);

        const recaptchaVerifier = new RecaptchaVerifier(auth, 'recaptcha-container', {
            size: 'invisible',
            callback: () => {
                console.log('reCAPTCHA solved');
            },
        });

        try {
            const confirmationResult = await signInWithPhoneNumber(auth, phoneNumber, recaptchaVerifier);
            setVerificationId(confirmationResult.verificationId);
            setLoading(false);
        } catch (error: any) {
            setError('Failed to send verification code. Please try again.');
            setLoading(false);
            setOpenSnackbar(true);
        }
    };

    // Step 2: Verify the code sent to the phone
    const handleVerificationCodeSubmit = async () => {
        if (!verificationId || !verificationCode) return;

        setLoading(true);

        const credential = PhoneAuthProvider.credential(verificationId, verificationCode);

        try {
            const result = await signInWithCredential(auth, credential);
            const user = result.user;
            setUser(user);

            // Save user information in localStorage
            localStorage.setItem('user', JSON.stringify(user));

            setLoading(false);
            navigate('/dashboard'); // Navigate to dashboard after successful login
        } catch (error) {
            setError('Invalid verification code. Please try again.');
            setLoading(false);
            setOpenSnackbar(true);
        }
    };

    return (
        <div style={{ padding: 20 }}>
            <h1>Phone Authentication</h1>

            {user ? (
                <div>
                    <h2>Welcome, {user.phoneNumber}</h2>
                </div>
            ) : (
                <div>
                    <div id="recaptcha-container" style={{ marginBottom: 20 }}></div>
                    <TextField
                        label="Phone Number"
                        variant="outlined"
                        fullWidth
                        value={phoneNumber}
                        onChange={(e) => setPhoneNumber(e.target.value)}
                        style={{ marginBottom: 20 }}
                        slotProps={{
                            input: {
                                startAdornment: <InputAdornment position="start">+91</InputAdornment>,
                            },
                        }}
                    />
                    <Button
                        variant="contained"
                        color="primary"
                        fullWidth
                        onClick={handlePhoneNumberSubmit}
                        disabled={loading}
                    >
                        {loading ? <CircularProgress size={24} color="inherit" /> : 'Send Verification Code'}
                    </Button>

                    {verificationId && (
                        <div style={{ marginTop: 20 }}>
                            <TextField
                                label="Verification Code"
                                variant="outlined"
                                fullWidth
                                value={verificationCode}
                                onChange={(e) => setVerificationCode(e.target.value)}
                                style={{ marginBottom: 20 }}
                            />
                            <Button
                                variant="contained"
                                color="primary"
                                fullWidth
                                onClick={handleVerificationCodeSubmit}
                                disabled={loading}
                            >
                                {loading ? <CircularProgress size={24} color="inherit" /> : 'Verify Code'}
                            </Button>
                        </div>
                    )}
                </div>
            )}

            <Snackbar
                open={openSnackbar}
                autoHideDuration={6000}
                onClose={() => setOpenSnackbar(false)}
            >
                <Alert onClose={() => setOpenSnackbar(false)} severity="error" sx={{ width: '100%' }}>
                    {error}
                </Alert>
            </Snackbar>
        </div>
    );
};

export default PhoneAuth;
