// src/Profile.tsx
import React, { useState } from 'react';
import { Container, Grid, TextField, Button, Typography, IconButton, Box, Select, MenuItem, InputLabel, FormControl } from '@mui/material';
import { CameraAlt } from '@mui/icons-material';

const Profile: React.FC = () => {
    const [profile, setProfile] = useState({
        firstName: 'John',
        lastName: 'Doe',
        addressLine1: '123 Main St',
        city: 'Cityville',
        state: 'Stateville',
        country: 'Countryland',
        pinCode: '123456',
        dob: '1990-01-01',
        gender: 'Male',
        phone: '123-456-7890',
        mobile: '987-654-3210',
        email: 'john.doe@example.com',
        facebook: 'https://facebook.com/johndoe',
        instagram: 'https://instagram.com/johndoe',
        profilePicture: '', // path to the profile picture
    });

    // Handle profile picture change
    const handleProfilePictureChange = (e: React.ChangeEvent<HTMLInputElement>) => {
        if (e.target.files && e.target.files[0]) {
            const file = URL.createObjectURL(e.target.files[0]);
            setProfile((prevProfile) => ({ ...prevProfile, profilePicture: file }));
        }
    };

    // Handle input change
    const handleInputChange = (field: string, value: string) => {
        setProfile((prevProfile) => ({ ...prevProfile, [field]: value }));
    };

    // Handle gender change
    const handleGenderChange = (event: React.ChangeEvent<{ value: unknown }>) => {
        setProfile((prevProfile) => ({ ...prevProfile, gender: event.target.value as string }));
    };

    return (
        <Container>
            <Typography variant="h4" gutterBottom>
                Profile Page
            </Typography>
            <Grid container spacing={4}>
                {/* Left Section: Profile Picture */}
                <Grid item xs={12} sm={4} container direction="column" alignItems="center">
                    <Box
                        sx={{
                            position: 'relative',
                            width: 150,
                            height: 150,
                            borderRadius: '50%',
                            overflow: 'hidden',
                            border: '2px solid #ddd',
                        }}
                    >
                        <img
                            src={profile.profilePicture || 'https://via.placeholder.com/150'}
                            alt="Profile"
                            style={{ width: '100%', height: '100%', objectFit: 'cover' }}
                        />
                        <label htmlFor="profile-picture-upload">
                            <IconButton
                                component="span"
                                sx={{
                                    position: 'absolute',
                                    bottom: 8, // Move the icon slightly above the bottom to ensure it's fully visible
                                    left: '50%', // Center the icon horizontally
                                    transform: 'translateX(-50%)', // Adjust positioning to truly center the icon
                                    backgroundColor: 'rgba(0, 0, 0, 0.5)',
                                    color: 'white',
                                    zIndex: 2, // Ensure it’s above the profile picture
                                    padding: '8px', // Add padding to make the icon larger and clickable
                                    fontSize: '2rem', // Increase icon size
                                }}
                            >
                                <CameraAlt />
                            </IconButton>
                        </label>
                        <input
                            type="file"
                            id="profile-picture-upload"
                            style={{ display: 'none' }}
                            onChange={handleProfilePictureChange}
                        />
                    </Box>
                    <Typography variant="body1" mt={2}>
                        {profile.firstName} {profile.lastName}
                    </Typography>
                </Grid>

                {/* Right Section: Form Fields */}
                <Grid item xs={12} sm={8}>
                    <Typography variant="h6" gutterBottom>
                        Personal Information
                    </Typography>

                    {/* First Name and Last Name in a single row */}
                    <Grid container spacing={2}>
                        <Grid item xs={12} sm={6}>
                            <TextField
                                fullWidth
                                label="First Name"
                                value={profile.firstName}
                                onChange={(e) => handleInputChange('firstName', e.target.value)}
                                margin="normal"
                            />
                        </Grid>
                        <Grid item xs={12} sm={6}>
                            <TextField
                                fullWidth
                                label="Last Name"
                                value={profile.lastName}
                                onChange={(e) => handleInputChange('lastName', e.target.value)}
                                margin="normal"
                            />
                        </Grid>
                    </Grid>

                    {/* Date of Birth and Gender in a single row */}
                    <Grid container spacing={2}>
                        <Grid item xs={12} sm={6}>
                            <TextField
                                fullWidth
                                label="Date of Birth"
                                type="date"
                                value={profile.dob}
                                onChange={(e) => handleInputChange('dob', e.target.value)}
                                margin="normal"
                                InputLabelProps={{
                                    shrink: true,
                                }}
                            />
                        </Grid>
                        <Grid item xs={12} sm={6}>
                            <FormControl fullWidth margin="normal">
                                <InputLabel>Gender</InputLabel>
                                <Select
                                    value={profile.gender}
                                    onChange={handleGenderChange}
                                    label="Gender"
                                >
                                    <MenuItem value="Male">Male</MenuItem>
                                    <MenuItem value="Female">Female</MenuItem>
                                </Select>
                            </FormControl>
                        </Grid>
                    </Grid>

                    <Typography variant="h6" mt={4}>
                        Contact Information
                    </Typography>

                    {/* Phone and Mobile in a single row */}
                    <Grid container spacing={2}>
                        <Grid item xs={12} sm={6}>
                            <TextField
                                fullWidth
                                label="Phone"
                                value={profile.phone}
                                onChange={(e) => handleInputChange('phone', e.target.value)}
                                margin="normal"
                            />
                        </Grid>
                        <Grid item xs={12} sm={6}>
                            <TextField
                                fullWidth
                                label="Mobile"
                                value={profile.mobile}
                                onChange={(e) => handleInputChange('mobile', e.target.value)}
                                margin="normal"
                            />
                        </Grid>
                    </Grid>

                    <TextField
                        fullWidth
                        label="Email"
                        value={profile.email}
                        onChange={(e) => handleInputChange('email', e.target.value)}
                        margin="normal"
                    />

                    <Typography variant="h6" mt={4}>
                        Address
                    </Typography>

                    {/* Address fields: Address Line 1, City, State, Country, Pin code */}
                    <Grid container spacing={2}>
                        <Grid item xs={12}>
                            <TextField
                                fullWidth
                                label="Address Line 1"
                                value={profile.addressLine1}
                                onChange={(e) => handleInputChange('addressLine1', e.target.value)}
                                margin="normal"
                            />
                        </Grid>
                        <Grid item xs={12} sm={6}>
                            <TextField
                                fullWidth
                                label="City"
                                value={profile.city}
                                onChange={(e) => handleInputChange('city', e.target.value)}
                                margin="normal"
                            />
                        </Grid>
                        <Grid item xs={12} sm={6}>
                            <TextField
                                fullWidth
                                label="State"
                                value={profile.state}
                                onChange={(e) => handleInputChange('state', e.target.value)}
                                margin="normal"
                            />
                        </Grid>
                        <Grid item xs={12} sm={6}>
                            <TextField
                                fullWidth
                                label="Country"
                                value={profile.country}
                                onChange={(e) => handleInputChange('country', e.target.value)}
                                margin="normal"
                            />
                        </Grid>
                        <Grid item xs={12} sm={6}>
                            <TextField
                                fullWidth
                                label="Pin Code"
                                value={profile.pinCode}
                                onChange={(e) => handleInputChange('pinCode', e.target.value)}
                                margin="normal"
                            />
                        </Grid>
                    </Grid>

                    <Typography variant="h6" mt={4}>
                        Social Media Links
                    </Typography>
                    <TextField
                        fullWidth
                        label="Facebook"
                        value={profile.facebook}
                        onChange={(e) => handleInputChange('facebook', e.target.value)}
                        margin="normal"
                    />
                    <TextField
                        fullWidth
                        label="Instagram"
                        value={profile.instagram}
                        onChange={(e) => handleInputChange('instagram', e.target.value)}
                        margin="normal"
                    />

                    <Button variant="contained" color="primary" sx={{ mt: 4 }}>
                        Save Changes
                    </Button>
                </Grid>
            </Grid>
        </Container>
    );
};

export default Profile;
