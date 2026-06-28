import {cookies} from "next/headers";
import {NextResponse} from "next/server";
import {ACCESS_TOKEN, REFRESH_TOKEN} from "@/const/cookieName";

/**
 * Server-side proxy to the Spring Boot backend.
 *
 * The browser holds the auth tokens as httpOnly cookies on the Next.js domain,
 * so it can never call the backend directly. Route handlers delegate here: we read
 * the access-token cookie and forward it as a Bearer token.
 *
 * Transparent refresh: if the access token is missing or the backend answers 401,
 * we call POST /auth/refresh with the refresh-token cookie, set the rotated tokens
 * as new cookies, and retry the original request once. If refresh fails, the auth
 * cookies are cleared and a 401 is returned so the client can redirect to login.
 *
 * Mirrors the cookie handling in app/api/auth/login/route.ts.
 */

const BASE = process.env.NEXT_PUBLIC_BASE_URL;

/** Statuses that must not carry a response body. */
const NULL_BODY_STATUS = new Set([204, 205, 304]);

type ProxyInit = {
    method?: "GET" | "POST" | "PUT" | "PATCH" | "DELETE";
    /** JSON-serializable request body (omitted for GET/DELETE). */
    body?: unknown;
};

type Tokens = { accessToken: string; refreshToken: string };

export async function proxyToBackend(path: string, init: ProxyInit = {}): Promise<NextResponse> {
    const store = await cookies();
    let accessToken = store.get(ACCESS_TOKEN)?.value;
    const refreshToken = store.get(REFRESH_TOKEN)?.value;

    if (!accessToken && !refreshToken) {
        return NextResponse.json({message: "Not authenticated"}, {status: 401});
    }

    const method = init.method ?? "GET";
    const sendsBody = init.body !== undefined && method !== "GET" && method !== "DELETE";
    const body = sendsBody ? JSON.stringify(init.body) : undefined;

    let rotated: Tokens | null = null;

    // No access token but we have a refresh token → refresh up front.
    if (!accessToken && refreshToken) {
        rotated = await tryRefresh(refreshToken);
        if (!rotated) return clearedUnauthorized();
        accessToken = rotated.accessToken;
    }

    let upstream = await callBackend(path, method, accessToken!, body);
    if (!upstream) {
        return NextResponse.json({message: "Upstream request failed"}, {status: 502});
    }

    // Access token rejected → refresh once and retry.
    if (upstream.status === 401 && refreshToken) {
        rotated = await tryRefresh(refreshToken);
        if (!rotated) return clearedUnauthorized();
        accessToken = rotated.accessToken;
        upstream = await callBackend(path, method, accessToken, body);
        if (!upstream) {
            return NextResponse.json({message: "Upstream request failed"}, {status: 502});
        }
    }

    const res = await passthrough(upstream);
    if (rotated) setAuthCookies(res, rotated);
    return res;
}

async function callBackend(
    path: string,
    method: string,
    token: string,
    body?: string,
): Promise<Response | null> {
    const headers: Record<string, string> = {
        Accept: "application/json",
        Authorization: `Bearer ${token}`,
    };
    if (body !== undefined) headers["Content-Type"] = "application/json";

    try {
        return await fetch(`${BASE}${path}`, {method, headers, body, cache: "no-store"});
    } catch {
        return null;
    }
}

/** Exchange a refresh token for a fresh token pair, or null on failure. */
async function tryRefresh(refreshToken: string): Promise<Tokens | null> {
    try {
        const res = await fetch(`${BASE}/auth/refresh`, {
            method: "POST",
            headers: {"Content-Type": "application/json", Accept: "application/json"},
            body: JSON.stringify({refreshToken}),
            cache: "no-store",
        });
        if (!res.ok) return null;
        const data = (await res.json()) as Partial<Tokens>;
        if (!data.accessToken || !data.refreshToken) return null;
        return {accessToken: data.accessToken, refreshToken: data.refreshToken};
    } catch {
        return null;
    }
}

/** Forward the upstream status/body, respecting null-body statuses (e.g. 204). */
async function passthrough(upstream: Response): Promise<NextResponse> {
    const status = upstream.status;
    if (NULL_BODY_STATUS.has(status)) {
        return new NextResponse(null, {status});
    }
    const text = await upstream.text();
    if (!text) {
        return new NextResponse(null, {status});
    }
    return NextResponse.json(safeJson(text), {status});
}

function setAuthCookies(res: NextResponse, tokens: Tokens): void {
    const secure = process.env.NODE_ENV === "production";
    res.cookies.set(ACCESS_TOKEN, tokens.accessToken, {
        httpOnly: true,
        secure,
        sameSite: "lax",
        path: "/",
        maxAge: 60 * 15, // 15 min
    });
    res.cookies.set(REFRESH_TOKEN, tokens.refreshToken, {
        httpOnly: true,
        secure,
        sameSite: "lax",
        path: "/",
        maxAge: 60 * 60 * 24 * 7, // 7 days
    });
}

/** 401 + clear stale auth cookies so the client redirects to login. */
function clearedUnauthorized(): NextResponse {
    const res = NextResponse.json({message: "Session expired"}, {status: 401});
    res.cookies.delete(ACCESS_TOKEN);
    res.cookies.delete(REFRESH_TOKEN);
    return res;
}

function safeJson(text: string): unknown {
    try {
        return JSON.parse(text);
    } catch {
        return {message: text};
    }
}
