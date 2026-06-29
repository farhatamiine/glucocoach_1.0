import {cookies} from "next/headers";
import {NextResponse} from "next/server";
import {ACCESS_TOKEN} from "@/const/cookieName";

/**
 * Server-side proxy to the Spring Boot backend.
 *
 * The browser holds the auth tokens as httpOnly cookies on the Next.js domain, so it
 * can never call the backend directly. Route handlers delegate here: we read the
 * access-token cookie and forward it as a Bearer token.
 *
 * This proxy is deliberately STATELESS — it never refreshes tokens and never mutates
 * cookies. If the access token is missing or the backend answers 401, we simply return
 * 401. Token refresh is coordinated on the client (see lib/apiFetch.ts) and performed
 * once by POST /api/auth/refresh, which is the only safe place to rotate the single-use
 * refresh token when the app runs across many serverless instances.
 */

const BASE = process.env.NEXT_PUBLIC_BASE_URL;

/** Statuses that must not carry a response body. */
const NULL_BODY_STATUS = new Set([204, 205, 304]);

type ProxyInit = {
    method?: "GET" | "POST" | "PUT" | "PATCH" | "DELETE";
    /** JSON-serializable request body (omitted for GET/DELETE). */
    body?: unknown;
};

export async function proxyToBackend(path: string, init: ProxyInit = {}): Promise<NextResponse> {
    const store = await cookies();
    const accessToken = store.get(ACCESS_TOKEN)?.value;

    // No usable access token → tell the client to refresh and retry.
    if (!accessToken) {
        return NextResponse.json({message: "Token expired"}, {status: 401});
    }

    const method = init.method ?? "GET";
    const sendsBody = init.body !== undefined && method !== "GET" && method !== "DELETE";
    const body = sendsBody ? JSON.stringify(init.body) : undefined;

    const upstream = await callBackend(path, method, accessToken, body);
    if (!upstream) {
        return NextResponse.json({message: "Upstream request failed"}, {status: 502});
    }

    return passthrough(upstream);
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

function safeJson(text: string): unknown {
    try {
        return JSON.parse(text);
    } catch {
        return {message: text};
    }
}
