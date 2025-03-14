import React from 'react';
import { Container, Typography, Button, Box, Grid, Card, CardContent } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import { happyFamiliesCount } from '../data/families';

const Home: React.FC = () => {
    const navigate = useNavigate();

    const handleJoinClick = () => {
        navigate('/join'); // Navigate to the /join route
    };
    const handleOurFamiliesClick = () => {
        navigate('/our-families'); // Navigate to the /our-families route
    };

    return (
        <Box>
            {/* Hero Section */}
            <Box textAlign="center" mt={5}>
                <Typography variant="h1" gutterBottom sx={{ fontWeight: 700, color: 'primary.main' }}>
                    Welcome to Happy Family
                </Typography>
                <Typography variant="h5" gutterBottom sx={{ color: 'text.secondary', mb: 4 }}>
                    Building Stronger Families, One Step at a Time
                </Typography>
                <Typography variant="h6" gutterBottom sx={{ color: 'text.secondary', mb: 4 }}>
                    Join over <strong>{happyFamiliesCount}</strong> happy families who have found joy with us!
                </Typography>
                <Button variant="contained" color="primary" size="large" sx={{ mt: 3, mr: 2 }} onClick={handleJoinClick}>
                    Join Us Today
                </Button>
                <Button
                    variant="outlined"
                    color="primary"
                    size="large"
                    sx={{ mt: 3 }}
                    onClick={handleOurFamiliesClick}
                >
                    Meet Our Families
                </Button>
            </Box>

            {/* About Us Section */}
            <Box sx={{ bgcolor: 'background.paper', py: 8 }}>
                <Container>
                    <Grid container spacing={4} alignItems="center">
                        <Grid item xs={12} md={6}>
                            <img
                                src="images/happy-family-image.jpg"
                                alt="Happy Family"
                                style={{ width: '100%', borderRadius: '8px' }}
                            />
                        </Grid>
                        <Grid item xs={12} md={6}>
                            <Typography variant="h4" gutterBottom sx={{ fontWeight: 600 }}>
                                About Happy Family
                            </Typography>
                            <Typography variant="body1" gutterBottom sx={{ mb: 2 }}>
                                At Happy Family, we believe that every family deserves to thrive. Our mission is to provide families with the tools, resources, and support they need to build stronger, healthier relationships.
                            </Typography>
                            <Typography variant="body1" gutterBottom>
                                Whether you're newlyweds or have been together for years, we’re here to help you navigate life’s challenges and celebrate its joys.
                            </Typography>
                            <Button variant="outlined" color="primary" size="large" sx={{ mt: 3 }}>
                                Learn More
                            </Button>
                        </Grid>
                    </Grid>
                </Container>
            </Box>

            {/* Our Services Section */}
            <Box sx={{ py: 8 }}>
                <Container>
                    <Typography variant="h4" gutterBottom align="center" sx={{ fontWeight: 600, mb: 6 }}>
                        Our Services
                    </Typography>
                    <Grid container spacing={4}>
                        <Grid item xs={12} md={4}>
                            <Card sx={{ height: '100%' }}>
                                <CardContent>
                                    <Typography variant="h6" gutterBottom sx={{ fontWeight: 600 }}>
                                        Family Registration
                                    </Typography>
                                    <Typography variant="body2" gutterBottom>
                                        Register your family with us and gain access to exclusive resources, workshops, and support systems designed to strengthen your relationships.
                                    </Typography>
                                </CardContent>
                            </Card>
                        </Grid>
                        <Grid item xs={12} md={4}>
                            <Card sx={{ height: '100%' }}>
                                <CardContent>
                                    <Typography variant="h6" gutterBottom sx={{ fontWeight: 600 }}>
                                        Relationship Guidelines
                                    </Typography>
                                    <Typography variant="body2" gutterBottom>
                                        Follow our expert-curated guidelines to maintain a healthy and happy relationship with your loved ones.
                                    </Typography>
                                </CardContent>
                            </Card>
                        </Grid>
                        <Grid item xs={12} md={4}>
                            <Card sx={{ height: '100%' }}>
                                <CardContent>
                                    <Typography variant="h6" gutterBottom sx={{ fontWeight: 600 }}>
                                        Dispute Resolution
                                    </Typography>
                                    <Typography variant="body2" gutterBottom>
                                        Our support system is here to help you resolve conflicts and avoid legal complications, ensuring a harmonious family life.
                                    </Typography>
                                </CardContent>
                            </Card>
                        </Grid>
                    </Grid>
                </Container>
            </Box>

            {/* Testimonials Section */}
            <Box sx={{ bgcolor: 'background.paper', py: 8 }}>
                <Container>
                    <Typography variant="h4" gutterBottom align="center" sx={{ fontWeight: 600, mb: 6 }}>
                        What Families Are Saying
                    </Typography>
                    <Grid container spacing={4}>
                        <Grid item xs={12} md={4}>
                            <Card>
                                <CardContent>
                                    <Typography variant="body2" gutterBottom sx={{ fontStyle: 'italic' }}>
                                        "Happy Family has transformed our relationship. The guidelines and support system are invaluable!"
                                    </Typography>
                                    <Typography variant="subtitle1" sx={{ fontWeight: 600, mt: 2 }}>
                                        – John & Sarah
                                    </Typography>
                                </CardContent>
                            </Card>
                        </Grid>
                        <Grid item xs={12} md={4}>
                            <Card>
                                <CardContent>
                                    <Typography variant="body2" gutterBottom sx={{ fontStyle: 'italic' }}>
                                        "The workshops helped us communicate better and resolve conflicts without stress."
                                    </Typography>
                                    <Typography variant="subtitle1" sx={{ fontWeight: 600, mt: 2 }}>
                                        – Emily & Mark
                                    </Typography>
                                </CardContent>
                            </Card>
                        </Grid>
                        <Grid item xs={12} md={4}>
                            <Card>
                                <CardContent>
                                    <Typography variant="body2" gutterBottom sx={{ fontStyle: 'italic' }}>
                                        "We’re so grateful for the resources and support. Happy Family truly lives up to its name!"
                                    </Typography>
                                    <Typography variant="subtitle1" sx={{ fontWeight: 600, mt: 2 }}>
                                        – David & Laura
                                    </Typography>
                                </CardContent>
                            </Card>
                        </Grid>
                    </Grid>
                </Container>
            </Box>

            {/* Call-to-Action Section */}
            <Box sx={{ py: 8, bgcolor: 'primary.main', color: 'white' }}>
                <Container>
                    <Typography variant="h4" gutterBottom align="center" sx={{ fontWeight: 600, mb: 3 }}>
                        Ready to Strengthen Your Family?
                    </Typography>
                    <Typography variant="body1" align="center" sx={{ mb: 4 }}>
                        Join Happy Family today and take the first step towards a happier, healthier relationship.
                    </Typography>
                    <Box textAlign="center">
                        <Button variant="contained" color="secondary" size="large" onClick={handleJoinClick}>
                            Get Started
                        </Button>
                    </Box>
                </Container>
            </Box>
        </Box>
    );
};

export default Home;