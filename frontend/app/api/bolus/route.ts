import {proxyToBackend} from "@/lib/serverFetch";

export async function GET() {
    return proxyToBackend("/bolus");
}

export async function POST(req: Request) {
    return proxyToBackend("/bolus", {method: "POST", body: await req.json()});
}
