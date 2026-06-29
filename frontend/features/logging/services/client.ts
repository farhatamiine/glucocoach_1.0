import {apiFetch} from "@/lib/apiFetch";

/** Thin fetch wrapper for the logging feature — talks to the Next.js /api proxies. */
export async function request<T>(path: string, init?: RequestInit): Promise<T> {
    const res = await apiFetch(path, {
        headers: {"Content-Type": "application/json", ...(init?.headers ?? {})},
        ...init,
    });

    const isJson = res.headers.get("content-type")?.includes("application/json");
    const data = isJson ? await res.json() : null;

    if (!res.ok) {
        const message =
            data && typeof data === "object" && "message" in data
                ? String((data as { message: unknown }).message)
                : `Request failed (${res.status})`;
        throw new Error(message);
    }

    return data as T;
}
