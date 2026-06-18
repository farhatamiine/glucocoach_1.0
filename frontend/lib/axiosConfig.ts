import axios, {AxiosError} from "axios";

export const apiClient = axios.create({
    baseURL: '/',
    withCredentials: true,
    headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
    },
});

apiClient.interceptors.response.use(
    (response) => response,
    (error: AxiosError) => {
        return Promise.reject(error);
    },
);

export default apiClient;
