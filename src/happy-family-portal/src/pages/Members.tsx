import React from 'react';
import { Container, Grid, Typography, Paper, List, ListItem, ListItemText, Avatar, IconButton, Box, Card, CardMedia } from '@mui/material';
import { Call as CallIcon, Chat as ChatIcon } from '@mui/icons-material';

// Mock data for family members
const familyMembers = [
    { id: 1, name: 'John Doe', role: 'Family Head', relation: 'Father', avatar: 'https://picsum.photos/40?random=1' },
    { id: 2, name: 'Jane Doe', role: 'Family Member', relation: 'Mother', avatar: 'https://picsum.photos/40?random=2' },
    { id: 3, name: 'Alice Smith', role: 'Family Member', relation: 'Sister', avatar: 'https://picsum.photos/40?random=3' },
    { id: 4, name: 'You', role: 'Family Member', relation: 'Self', avatar: 'https://picsum.photos/40?random=4' }, // logged-in user
];

// Sample family photo URL
const familyPhotoUrl = 'images/happy-family-image.jpg';
const familyName = 'The Doe Family'; // Family name to be displayed below the photo

const Members: React.FC = () => {
    const loggedInUserId = 4; // assuming logged-in user ID is 4 (You)

    const handleCall = (memberName: string) => {
        alert(`Calling ${memberName}...`);
    };

    const handleChat = (memberName: string) => {
        alert(`Starting chat with ${memberName}...`);
    };

    return (
        <Container sx={{ mt: 5 }}>
            {/* Grid for Family Photo and Members List */}
            <Grid container spacing={4} justifyContent="center">
                {/* Family Photo Section */}
                <Grid item xs={12} md={6} container justifyContent="center">
                    <Card sx={{ borderRadius: 2, boxShadow: 4, overflow: 'hidden' }}>
                        <CardMedia
                            component="img"
                            height="400"
                            image={familyPhotoUrl}
                            alt="Family Photo"
                            sx={{
                                objectFit: 'cover',
                            }}
                        />

                        {/* Family Name below the Family Photo */}
                        <Typography variant="h5" align="center" sx={{ mt: 2, fontWeight: 'bold' }}>
                            {familyName}
                        </Typography>
                    </Card>
                </Grid>

                {/* Members List Section */}
                <Grid item xs={12} md={6} container justifyContent="center">
                    {/* Members List */}
                    <Paper elevation={3} sx={{ padding: 3, borderRadius: 2 }}>
                        <Typography variant="h5" align="center" sx={{ fontWeight: 'bold', marginBottom: 3 }}>
                            Family Members
                        </Typography>
                        <hr style={{ marginBottom: 20 }} />
                        <List>
                            {familyMembers.map((member) => (
                                <ListItem
                                    key={member.id}
                                    sx={{
                                        display: 'flex',
                                        justifyContent: 'space-between',
                                        alignItems: 'center',
                                        padding: 2,
                                        backgroundColor: member.id === loggedInUserId ? '#f1f1f1' : 'inherit',
                                        '&:hover': { backgroundColor: '#e0e0e0' },
                                        borderRadius: 1,
                                        transition: 'background-color 0.3s ease',
                                    }}
                                >
                                    {/* Avatar and Member Info */}
                                    <Box sx={{ display: 'flex', alignItems: 'center' }}>
                                        <Avatar
                                            src={member.avatar}
                                            sx={{
                                                marginRight: 2,
                                                width: 50,
                                                height: 50,
                                                borderRadius: '50%',
                                                border: '2px solid #fff',
                                                boxShadow: '0 2px 4px rgba(0,0,0,0.1)',
                                            }}
                                        />
                                        <ListItemText
                                            primary={member.name}
                                            secondary={`${member.role} (${member.relation})`}
                                            sx={{
                                                textOverflow: 'ellipsis',
                                                overflow: 'hidden',
                                                whiteSpace: 'nowrap',
                                            }}
                                        />
                                    </Box>

                                    {/* Call and Chat Options */}
                                    {member.id !== loggedInUserId && (
                                        <Box sx={{ display: 'flex', gap: 2 }}>
                                            <IconButton
                                                color="primary"
                                                onClick={() => handleCall(member.name)}
                                                sx={{
                                                    '&:hover': {
                                                        backgroundColor: '#f0f0f0',
                                                    },
                                                }}
                                            >
                                                <CallIcon />
                                            </IconButton>
                                            <IconButton
                                                color="primary"
                                                onClick={() => handleChat(member.name)}
                                                sx={{
                                                    '&:hover': {
                                                        backgroundColor: '#f0f0f0',
                                                    },
                                                }}
                                            >
                                                <ChatIcon />
                                            </IconButton>
                                        </Box>
                                    )}

                                    {/* Mark Logged-In User as "You" */}
                                    {member.id === loggedInUserId && (
                                        <Typography variant="body2" sx={{ color: 'text.secondary', fontStyle: 'italic' }}>
                                            (You)
                                        </Typography>
                                    )}
                                </ListItem>
                            ))}
                        </List>
                    </Paper>
                </Grid>
            </Grid>
        </Container>
    );
};

export default Members;
