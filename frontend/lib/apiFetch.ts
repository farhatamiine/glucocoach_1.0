/**
 * Client-side fetch wrapper with coordinated token refresh.
 *
 * The backend issues single-use (rotating) refresh tokens, so the refresh call
 * must happen exactly once even when many requests fail at the same time. The
 * browser is the only single instance in the system (server routes run on many
 * Vercel instances), so refresh is coordinated here:
 *
 *   request → 401 → refreshSession() (single-flighted) → retry once
 *
 * `refreshSession` shares one in-flight promise, so N parallel 401s trigger a
 * single POST /api/auth/refresh and all retry with the rotated access cookie.
 */

type RefreshResult = "refreshed" | "expired" | "error";

let refreshPromise: Promise<RefreshResult> | null = null;

async function doRefresh(): Promise<RefreshResult> {
    try {
        const res = await fetch("/api/auth/refresh", {method: "POST"});
        if (res.ok) return "refreshed";
        if (res.status === 401) return "expired"; // refresh token rejected → real logout
        return "error"; // transient (network/5xx) → keep session, let caller retry later
    } catch {
        return "error";
    }
}

/** Refresh the session, sharing one in-flight call across concurrent callers. */
export function refreshSession(): Promise<RefreshResult> {
    if (!refreshPromise) {
        refreshPromise = doRefresh().finally(() => {
            refreshPromise = null;
        });
    }
    return refreshPromise;
}

function redirectToLogin(): void {
    if (typeof window === "undefined") return;
    if (window.location.pathname.startsWith("/login")) return;
    const callbackUrl = encodeURIComponent(window.location.pathname + window.location.search);
    window.location.assign(`/login?callbackUrl=${callbackUrl}`);
}

/**
 * fetch() that transparently refreshes the access token on a 401 and retries once.
 * On a dead refresh token it sends the user to /login; on a transient refresh
 * error it surfaces the original 401 without logging out.
 */
export async function apiFetch(input: string, init?: RequestInit): Promise<Response> {
    const res = await fetch(input, init);
    if (res.status !== 401) return res;

    const result = await refreshSession();

    if (result === "refreshed") {
        const retry = await fetch(input, init);
        if (retry.status === 401) redirectToLogin(); // still rejected with a fresh token → bail
        return retry;
    }

    if (result === "expired") {
        redirectToLogin();
    }
    // "error" → transient; return the original 401 so React Query can retry later.
    return res;
}
