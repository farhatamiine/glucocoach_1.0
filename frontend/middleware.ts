import {NextRequest, NextResponse} from "next/server";
import {authRoutes, protectedRoutes, readAuthCookie} from "@/lib/middleware.helper";

export async function middleware(req: NextRequest) {
    const {pathname} = req.nextUrl;

    const {refreshToken, accessToken} = readAuthCookie(req)

    const isLoggedIn = Boolean(accessToken || refreshToken);
    const isAuthRoute = authRoutes.some((route) =>
        pathname.startsWith(route)
    );
    const isProtectedRoute = protectedRoutes.some((route) =>
        pathname.startsWith(route)
    );

    if (isProtectedRoute && !isLoggedIn) {
        return NextResponse.redirect(new URL('/login', req.url));
    }

    if (isAuthRoute && isLoggedIn) {
        return NextResponse.redirect(new URL('/', req.url));
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
        '/report/:path*',
        '/',
        '/login',
        '/register',
    ],
};