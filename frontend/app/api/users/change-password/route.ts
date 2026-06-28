import {proxyToBackend} from "@/lib/serverFetch";

export async function PUT(req: Request) {
    return proxyToBackend("/users/change-password", {method: "PUT", body: await req.json()});
}
