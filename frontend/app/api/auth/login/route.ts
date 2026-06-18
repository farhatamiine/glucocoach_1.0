import {NextResponse} from "next/server";
import {ACCESS_TOKEN, REFRESH_TOKEN} from "@/const/cookieName";

export async function POST(req: Request) {
    const body = await req.json();
    const response = await fetch(`${process.env.NEXT_PUBLIC_BASE_URL}/auth/login`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(body),
    });
    const data = await response.json();
    if (!response.ok) {
        return NextResponse.json(data, {status: response.status})
    }
    const res = NextResponse.json({success: true});

    res.cookies.set(ACCESS_TOKEN, data.accessToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'lax',
        path: '/',
    });
    res.cookies.set(REFRESH_TOKEN, data.refreshToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'lax',
        path: '/',
    });
    return res;
}