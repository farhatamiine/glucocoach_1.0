import {NextRequest} from "next/server";
import {ACCESS_TOKEN, REFRESH_TOKEN} from "@/const/cookieName";
import axios from "axios";

export function readAuthCookie(req: NextRequest) {
    return {
        accessToken: req.cookies.get(ACCESS_TOKEN)?.value,
        refreshToken: req.cookies.get(REFRESH_TOKEN)?.value
    }
}


export function fetchWithAuth(path: string, option: any, req: NextRequest) {
    const {accessToken, refreshToken} = readAuthCookie(req);
    if (accessToken && refreshToken) {
        option.headers.set('Authorization', `Bearer ${accessToken}`);
    }
    axios.post(path, option).then(res => {
        return res.data;
    }).catch((error) => {
        if (error.response.status === 401) {
            axios.post('/api/auth/refresh-token', {refreshToken}).then(res => {

            })
        }
    });
}

export const protectedRoutes = [
    '/activity-sleep',
    '/ai-coach',
    '/alerts',
    '/glucose-analytics',
    '/health-metrics',
    '/history',
    '/hydration',
    '/insights-patterns',
    '/insulin',
    '/lab-results',
    '/meal-scanner',
    '/meals',
    '/report',
    '/quick-log',
    '/dashboard'
];

export const authRoutes = ['/login', '/register'];