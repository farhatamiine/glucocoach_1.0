import {proxyToBackend} from "@/lib/serverFetch";

export async function DELETE(_req: Request, {params}: { params: Promise<{ id: string }> }) {
    const {id} = await params;
    return proxyToBackend(`/bolus/${id}`, {method: "DELETE"});
}
