import {proxyToBackend} from "@/lib/serverFetch";

export async function GET() {
    return proxyToBackend("/profile");
}

export async function POST(req: Request) {
    return proxyToBackend("/profile", {method: "POST", body: await req.json()});
}

export async function PUT(req: Request) {
    return proxyToBackend("/profile", {method: "PUT", body: await req.json()});
}
