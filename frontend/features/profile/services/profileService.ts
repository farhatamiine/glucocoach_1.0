import {request} from "@/features/logging/services/client";
import type {ProfileResponse, UserResponse} from "@/features/profile/types/profile.types";
import type {AccountFormValues} from "@/features/profile/schemas/account.schema";
import type {ProfileFormValues} from "@/features/profile/schemas/profile.schema";
import type {PasswordFormValues} from "@/features/profile/schemas/password.schema";

/* ---- Account (users/me) ---- */

export function getUser() {
    return request<UserResponse>("/api/users/me", {cache: "no-store"});
}

export function updateUser(values: AccountFormValues) {
    return request<UserResponse>("/api/users/me", {method: "PUT", body: JSON.stringify(values)});
}

/* ---- Diabetes profile ---- */

/** Tolerant read: returns null when no profile exists yet (so the form can POST to create). */
export async function getProfile(): Promise<ProfileResponse | null> {
    const res = await fetch("/api/profile", {
        headers: {Accept: "application/json"},
        cache: "no-store",
    });
    if (res.status === 404) return null;
    if (!res.ok) {
        const data = await res.json().catch(() => null);
        throw new Error((data as { message?: string })?.message ?? `Request failed (${res.status})`);
    }
    const text = await res.text();
    return text ? (JSON.parse(text) as ProfileResponse) : null;
}

function profilePayload(v: ProfileFormValues) {
    return JSON.stringify({
        diabetesType: v.diabetesType,
        glucoseUnit: v.glucoseUnit,
        height: v.height,
        diabetesSince: v.diabetesSince || undefined,
        basalInsulinName: v.basalInsulinName || undefined,
        bolusInsulinName: v.bolusInsulinName || undefined,
        prescribedBasalDose: v.prescribedBasalDose,
    });
}

/** Create (POST) when no profile exists yet, otherwise update (PUT). */
export function saveProfile(values: ProfileFormValues, exists: boolean) {
    return request<ProfileResponse>("/api/profile", {
        method: exists ? "PUT" : "POST",
        body: profilePayload(values),
    });
}

/* ---- Password ---- */

export function changePassword(values: PasswordFormValues) {
    return request<void>("/api/users/change-password", {
        method: "PUT",
        body: JSON.stringify({oldPassword: values.oldPassword, newPassword: values.newPassword}),
    });
}
