import axios from 'axios';

const API_URL = 'http://localhost:5280/api/';

export interface JoinRequest {
    firstName: string;
    lastName: string;
    familyName: string;
    emailAddress: string;
    contactNumber: string;
    gender: string;
    address: string;
}

// Axios instance for reusability & global settings
export const apiClient = axios.create({
    baseURL: API_URL,
    headers: {
        'Content-Type': 'application/json',
    },
});

// Function to submit join request
export const submitJoinRequest = async (data: JoinRequest) => {
    try {
        const response = await apiClient.post('family/join', data);
        return response.data;
    } catch (error: any) {
        console.error('API Error:', error.response?.data || error.message);
        throw new Error(error.response?.data?.message || 'Failed to submit request.');
    }
};


