import {proxyToBackend} from "@/lib/serverFetch";

export async function GET() {
    return proxyToBackend("/users/me");
}

export async function PUT(req: Request) {
    return proxyToBackend("/users/me", {method: "PUT", body: await req.json()});
}
