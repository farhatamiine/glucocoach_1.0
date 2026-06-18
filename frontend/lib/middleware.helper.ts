import {NextRequest} from "next/server";
import {ACCESS_TOKEN, REFRESH_TOKEN} from "@/const/cookieName";

export function readAuthCookie(req: NextRequest) {
    return {
        accessToken: req.cookies.get(ACCESS_TOKEN)?.value,
        refreshToken: req.cookies.get(REFRESH_TOKEN)?.value
    }
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
];

export const authRoutes = ['/login', '/register'];