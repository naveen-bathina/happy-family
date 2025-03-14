import React, { useState } from 'react';
import { Container, Typography, Box, TextField, Button, List, ListItem, ListItemText, Paper, Avatar, Divider } from '@mui/material';

// Mock data for chat windows and messages
const chatWindows = [
    { id: 1, name: 'Family Group', avatar: 'https://picsum.photos/40?random=1', isGroup: true },
    { id: 2, name: 'John Doe', avatar: 'https://picsum.photos/40?random=2', isGroup: false },
    { id: 3, name: 'Jane Doe', avatar: 'https://picsum.photos/40?random=3', isGroup: false },
    { id: 4, name: 'Alice Smith', avatar: 'https://picsum.photos/40?random=4', isGroup: false },
];

const initialMessages = {
    'Family Group': [
        { id: 1, sender: 'John Doe', text: 'Hello everyone!', timestamp: '10:00 AM' },
        { id: 2, sender: 'Jane Doe', text: 'Hi John! How are you?', timestamp: '10:05 AM' },
        { id: 3, sender: 'Alice Smith', text: 'Good morning!', timestamp: '10:10 AM' },
    ],
    'John Doe': [
        { id: 1, sender: 'John Doe', text: 'Hey, how are you?', timestamp: '10:15 AM' },
        { id: 2, sender: 'You', text: 'I’m good, thanks!', timestamp: '10:20 AM' },
    ],
    'Jane Doe': [
        { id: 1, sender: 'Jane Doe', text: 'Can we meet today?', timestamp: '10:25 AM' },
        { id: 2, sender: 'You', text: 'Sure, let’s meet at 5 PM.', timestamp: '10:30 AM' },
    ],
    'Alice Smith': [
        { id: 1, sender: 'Jane Doe', text: 'Can we meet today?', timestamp: '10:25 AM' },
        { id: 2, sender: 'You', text: 'Sure, let’s meet at 5 PM.', timestamp: '10:30 AM' },
    ],
};

const Chat: React.FC = () => {
    const [selectedChat, setSelectedChat] = useState('Family Group'); // Default to Family Group
    const [messages, setMessages] = useState(initialMessages[selectedChat]);
    const [newMessage, setNewMessage] = useState('');

    const handleSelectChat = (chatName: string) => {
        setSelectedChat(chatName);
        setMessages(initialMessages[chatName]);
    };

    const handleSendMessage = () => {
        if (newMessage.trim()) {
            const message = {
                id: messages.length + 1,
                sender: 'You', // Replace with logged-in user's name
                text: newMessage,
                timestamp: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
            };
            setMessages([...messages, message]);
            setNewMessage('');
        }
    };

    return (
        <Container>
            <Box sx={{ mt: 5, display: 'flex', gap: 3 }}>
                {/* Left Pane: List of Chat Windows */}
                <Paper elevation={3} sx={{ width: '30%', p: 2 }}>
                    <Typography variant="h6" gutterBottom>
                        Chats
                    </Typography>
                    <List>
                        {chatWindows.map((chat) => (
                            <ListItem
                                key={chat.id}
                                button
                                selected={selectedChat === chat.name}
                                onClick={() => handleSelectChat(chat.name)}
                                sx={{ borderRadius: 1 }}
                            >
                                <Avatar src={chat.avatar} sx={{ mr: 2 }} />
                                <ListItemText
                                    primary={chat.name}
                                    secondary={chat.isGroup ? 'Group' : 'Individual'}
                                />
                            </ListItem>
                        ))}
                    </List>
                </Paper>

                {/* Right Pane: Selected Chat History */}
                <Paper elevation={3} sx={{ flex: 1, p: 3, display: 'flex', flexDirection: 'column' }}>
                    <Typography variant="h6" gutterBottom>
                        {selectedChat}
                    </Typography>
                    <Divider sx={{ mb: 2 }} />

                    {/* Chat Window */}
                    <Box sx={{ flex: 1, overflowY: 'auto', mb: 2 }}>
                        {messages.map((message) => (
                            <Box
                                key={message.id}
                                sx={{
                                    display: 'flex',
                                    alignItems: 'flex-start',
                                    gap: 2,
                                    mb: 2,
                                    flexDirection: message.sender === 'You' ? 'row-reverse' : 'row',
                                }}
                            >
                                <Avatar src={chatWindows.find((chat) => chat.name === message.sender)?.avatar} />
                                <Box
                                    sx={{
                                        bgcolor: message.sender === 'You' ? 'primary.light' : 'background.paper',
                                        p: 2,
                                        borderRadius: 2,
                                        maxWidth: '70%',
                                    }}
                                >
                                    <Typography variant="subtitle2" sx={{ fontWeight: 'bold' }}>
                                        {message.sender}
                                    </Typography>
                                    <Typography variant="body1">{message.text}</Typography>
                                    <Typography variant="caption" color="text.secondary">
                                        {message.timestamp}
                                    </Typography>
                                </Box>
                            </Box>
                        ))}
                    </Box>

                    {/* Message Input */}
                    <Box sx={{ display: 'flex', gap: 2 }}>
                        <TextField
                            fullWidth
                            variant="outlined"
                            placeholder="Type a message..."
                            value={newMessage}
                            onChange={(e) => setNewMessage(e.target.value)}
                            onKeyPress={(e) => e.key === 'Enter' && handleSendMessage()}
                        />
                        <Button variant="contained" color="primary" onClick={handleSendMessage}>
                            Send
                        </Button>
                    </Box>
                </Paper>
            </Box>
        </Container>
    );
};

export default Chat;