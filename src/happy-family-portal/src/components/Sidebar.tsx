// src/components/Sidebar.tsx

import React from 'react';
import { List, ListItem, ListItemButton, ListItemText } from '@mui/material';

interface SidebarProps {
    events: string[];
    onEventClick: (event: string) => void;
}

const Sidebar: React.FC<SidebarProps> = ({ events, onEventClick }) => {
    return (
        <div style={{ width: 250, padding: 20, backgroundColor: '#f4f4f4', height: '100vh' }}>
            <h3>Events</h3>
            <List>
                {events.map((event, index) => (
                    <ListItem key={index} disablePadding>
                        <ListItemButton onClick={() => onEventClick(event)}>
                            <ListItemText primary={event} />
                        </ListItemButton>
                    </ListItem>
                ))}
            </List>
        </div>
    );
};

export default Sidebar;
