import {proxyToBackend} from "@/lib/serverFetch";

export async function PUT(req: Request, {params}: { params: Promise<{ id: string }> }) {
    const {id} = await params;
    return proxyToBackend(`/meals/${id}`, {method: "PUT", body: await req.json()});
}

export async function DELETE(_req: Request, {params}: { params: Promise<{ id: string }> }) {
    const {id} = await params;
    return proxyToBackend(`/meals/${id}`, {method: "DELETE"});
}
