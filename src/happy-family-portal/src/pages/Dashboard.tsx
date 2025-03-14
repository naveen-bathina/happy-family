import React, { useState } from 'react';
import { Grid, Container, Typography } from '@mui/material';
import { useNavigate } from 'react-router-dom';
import Sidebar from '../components/Sidebar';
import GalleryItem from '../components/GalleryItem';

const Dashboard: React.FC = () => {
    const navigate = useNavigate();
    const isLoggedIn = localStorage.getItem('isLoggedIn') === 'true'; // Check login state
    const [selectedEvent, setSelectedEvent] = useState<string | null>(null);
    const [mediaItems, setMediaItems] = useState<{ type: string; src: string }[]>([]);

    // Redirect to login if not authenticated
    if (!isLoggedIn) {
        navigate('/login');
        return null;
    }

    const eventsData = {
        'Family Reunion 2023': [
            { type: 'image', src: 'https://picsum.photos/200/300' },
            { type: 'video', src: 'https://www.youtube.com/watch?v=EngW7tLk6R8' },
        ],
        'Birthday Party 2024': [
            { type: 'image', src: 'https://picsum.photos/200/300' },
            { type: 'video', src: 'https://www.youtube.com/watch?v=EngW7tLk6R8' },
        ],
    };

    const handleEventClick = (event: string) => {
        setSelectedEvent(event);
        setMediaItems(eventsData[event]);
    };

    return (
        <div style={{ display: 'flex', height: '100vh' }}>
            <Sidebar events={Object.keys(eventsData)} onEventClick={handleEventClick} />

            <Container style={{ flexGrow: 1, padding: 20 }}>
                {selectedEvent && (
                    <>
                        <Typography variant="h4" gutterBottom>
                            {selectedEvent}
                        </Typography>
                        <Grid container spacing={2}>
                            {mediaItems.map((item, index) => (
                                <Grid item xs={12} sm={6} md={4} key={index}>
                                    <GalleryItem type={item.type as 'image' | 'video'} src={item.src} />
                                </Grid>
                            ))}
                        </Grid>
                    </>
                )}
            </Container>
        </div>
    );
};

export default Dashboard;