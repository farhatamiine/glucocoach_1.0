import {proxyToBackend} from "@/lib/serverFetch";

export async function GET() {
    return proxyToBackend("/meals");
}

export async function POST(req: Request) {
    return proxyToBackend("/meals", {method: "POST", body: await req.json()});
}
