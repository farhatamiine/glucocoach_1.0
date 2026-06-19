import {NextRequest, NextResponse} from "next/server";
import {authRoutes, protectedRoutes, readAuthCookie} from "@/lib/middleware.helper";
import {DASHBOARD_PATH} from "@/const/pathNames";

export async function middleware(req: NextRequest) {
    const {pathname} = req.nextUrl;

    const {refreshToken, accessToken} = readAuthCookie(req)

    const isLoggedIn = Boolean(accessToken || refreshToken);
    const isProtectedRoute = protectedRoutes.some((route) =>
        pathname.startsWith(route)
    );
    const isAuthRoute = authRoutes.some((route) =>
        pathname.startsWith(route)
    );


    if (isProtectedRoute && !isLoggedIn) {
        const loginUrl = new URL('/login', req.url);
        loginUrl.searchParams.set('callbackUrl', req.nextUrl.pathname);
        return NextResponse.redirect(loginUrl);
    }

    if (isAuthRoute && isLoggedIn) {
        const callbackUrl = req.nextUrl.searchParams.get('callbackUrl');

        return NextResponse.redirect(
            new URL(callbackUrl || DASHBOARD_PATH, req.url)
        );
    }


}

export const config = {
    matcher: [
        '/activity-sleep/:path*',
        '/ai-coach/:path*',
        '/alerts/:path*',
        '/glucose-analytics/:path*',
        '/health-metrics/:path*',
        '/history/:path*',
        '/hydration/:path*',
        '/insights-patterns/:path*',
        '/insulin/:path*',
        '/lab-results/:path*',
        '/meal-scanner/:path*',
        '/meals/:path*',
        '/quick-log/:path*',
        '/report/:path*',
        '/dashboard',
        '/login',
        '/register',
    ],
};