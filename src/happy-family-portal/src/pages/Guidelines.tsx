import React from 'react';
import { Container, Typography, Box, List, ListItem, ListItemText, Paper } from '@mui/material';

const Guidelines: React.FC = () => {
    return (
        <Container>
            <Box sx={{ mt: 5 }}>
                <Paper elevation={3} sx={{ p: 4 }}>
                    <Typography variant="h4" gutterBottom align="center">
                        Family Guidelines
                    </Typography>
                    <Typography variant="body1" gutterBottom align="center" sx={{ mb: 3 }}>
                        Follow these guidelines to maintain a healthy relationship.
                    </Typography>
                    <List>
                        <ListItem>
                            <ListItemText primary="1. Communicate openly and honestly with each other." />
                        </ListItem>
                        <ListItem>
                            <ListItemText primary="2. Spend quality time together regularly." />
                        </ListItem>
                        <ListItem>
                            <ListItemText primary="3. Respect each other's opinions and boundaries." />
                        </ListItem>
                        <ListItem>
                            <ListItemText primary="4. Resolve conflicts calmly and constructively." />
                        </ListItem>
                        <ListItem>
                            <ListItemText primary="5. Support each other's personal growth and goals." />
                        </ListItem>
                    </List>
                </Paper>
            </Box>
        </Container>
    );
};

export default Guidelines;