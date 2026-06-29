import {proxyToBackend} from "@/lib/serverFetch";

export async function GET(req: Request) {
    const days = new URL(req.url).searchParams.get("days") ?? "30";
    return proxyToBackend(`/glucose/health-data?days=${encodeURIComponent(days)}`);
}
