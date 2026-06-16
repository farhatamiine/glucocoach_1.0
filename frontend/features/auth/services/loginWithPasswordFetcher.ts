export const LoginWithPasswordFetcher = async (email: string, password: string) => {
    if (email.trim() === '' || password.trim() === '') {
        throw new Error('email or password are required');
    }
const {} = axios
};