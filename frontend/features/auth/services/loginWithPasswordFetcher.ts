export const loginWithPasswordFetcher = async (email: string, password: string) => {
    if (email.trim() === '' || password.trim() === '') {
        throw new Error('email or password are required');
    }
    const response = await fetch('api/auth/login', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({email, password}),
    });
    const result = await response.json();

    if (!response.ok) {
        throw new Error(result.message || 'Login failed');
    }

    return result;
};