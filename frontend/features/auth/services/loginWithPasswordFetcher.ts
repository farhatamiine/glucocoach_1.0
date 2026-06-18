import apiClient from "@/lib/axiosConfig";

export const loginWithPasswordFetcher = async (email: string, password: string) => {
    if (email.trim() === '' || password.trim() === '') {
        throw new Error('email or password are required');
    }
    console.log(email, password);
    const {data} = await apiClient.post('/auth/login', {email, password});
    return data;
};