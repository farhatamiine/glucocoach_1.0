import {proxyToBackend} from "@/lib/serverFetch";

export async function GET() {
    return proxyToBackend("/glucose/trend");
}
