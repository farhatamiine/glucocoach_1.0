import {NextResponse} from "next/server";
import {cookies} from "next/headers";
import {ACCESS_TOKEN, REFRESH_TOKEN} from "@/const/cookieName";

/**
 * Single token-refresh endpoint. The client calls this (coordinated, once) when a
 * data request returns 401. It rotates the single-use refresh token exactly once
 * and sets the new cookie pair.
 *
 * Failure handling distinguishes:
 *  - refresh token rejected by the backend (401) → session is really over, clear cookies.
 *  - transient/network error (503) → keep cookies so the client can retry later.
 */

const BASE = process.env.NEXT_PUBLIC_BASE_URL;

export async function POST() {
    const store = await cookies();
    const refreshToken = store.get(REFRESH_TOKEN)?.value;

    if (!refreshToken) {
        return cleared(NextResponse.json({message: "Not authenticated"}, {status: 401}));
    }

    let backend: Response;
    try {
        backend = await fetch(`${BASE}/auth/refresh`, {
            method: "POST",
            headers: {"Content-Type": "application/json", Accept: "application/json"},
            body: JSON.stringify({refreshToken}),
            cache: "no-store",
        });
    } catch {
        // Network blip — don't destroy the session, let the client retry.
        return NextResponse.json({message: "Refresh temporarily unavailable"}, {status: 503});
    }

    if (backend.status >= 500) {
        return NextResponse.json({message: "Refresh temporarily unavailable"}, {status: 503});
    }
    if (!backend.ok) {
        // 4xx → refresh token is invalid/expired/spent. Real logout.
        return cleared(NextResponse.json({message: "Session expired"}, {status: 401}));
    }

    const data = (await backend.json().catch(() => null)) as
        | { accessToken?: string; refreshToken?: string }
        | null;
    if (!data?.accessToken || !data?.refreshToken) {
        return cleared(NextResponse.json({message: "Session expired"}, {status: 401}));
    }

    const res = NextResponse.json({success: true});
    setAuthCookies(res, data.accessToken, data.refreshToken);
    return res;
}

function setAuthCookies(res: NextResponse, accessToken: string, refreshToken: string): void {
    const secure = process.env.NODE_ENV === "production";
    res.cookies.set(ACCESS_TOKEN, accessToken, {
        httpOnly: true,
        secure,
        sameSite: "lax",
        path: "/",
        maxAge: 60 * 15, // 15 min
    });
    res.cookies.set(REFRESH_TOKEN, refreshToken, {
        httpOnly: true,
        secure,
        sameSite: "lax",
        path: "/",
        maxAge: 60 * 60 * 24 * 7, // 7 days
    });
}

function cleared(res: NextResponse): NextResponse {
    res.cookies.delete(ACCESS_TOKEN);
    res.cookies.delete(REFRESH_TOKEN);
    return res;
}
