import React from 'react';
import { Container, Typography, Box, Grid, Card, CardContent, CardMedia } from '@mui/material';
import { families, happyFamiliesCount } from '../data/families';

const OurFamilies: React.FC = () => {
    return (
        <Container>
            <Box sx={{ mt: 5 }}>
                <Typography variant="h4" gutterBottom align="center" sx={{ fontWeight: 600 }}>
                    Our Families
                </Typography>
                <Typography variant="body1" gutterBottom align="center" sx={{ mb: 4 }}>
                    Hear from some of the <strong>{happyFamiliesCount}</strong> families who have found happiness with us.
                </Typography>
                <Grid container spacing={4}>
                    {families.map((family, index) => (
                        <Grid item xs={12} sm={6} md={4} key={index}>
                            <Card>
                                <CardMedia
                                    component="img"
                                    height="200"
                                    image={family.image}
                                    alt={family.name}
                                />
                                <CardContent>
                                    <Typography variant="h6" gutterBottom>
                                        {family.name}
                                    </Typography>
                                    <Typography variant="body2" color="text.secondary">
                                        {family.message}
                                    </Typography>
                                </CardContent>
                            </Card>
                        </Grid>
                    ))}
                </Grid>
            </Box>
        </Container>
    );
};

export default OurFamilies;