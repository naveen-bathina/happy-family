import { apiClient } from "./familyService";


export const requestOtp = async (phoneNumber: string) => {
    try {
        const response = await apiClient.post('auth/request-otp', { phoneNumber });
        return response.data;
    } catch (error: any) {
        console.error('API Error:', error.response?.data || error.message);
        throw new Error(error.response?.data?.message || 'Failed to request OTP.');
    }
};

export const verifyOtp = async (phoneNumber: string, otp: string) => {
    try {
        const response = await apiClient.post('auth/verify-otp', { phoneNumber, otp });
        return response.data;
    } catch (error: any) {
        console.error('API Error:', error.response?.data || error.message);
        throw new Error(error.response?.data?.message || 'Failed to verify OTP.');
    }
};