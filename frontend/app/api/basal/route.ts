import {proxyToBackend} from "@/lib/serverFetch";

export async function GET() {
    return proxyToBackend("/basal");
}

export async function POST(req: Request) {
    return proxyToBackend("/basal", {method: "POST", body: await req.json()});
}
