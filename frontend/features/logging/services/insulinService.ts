import {request} from "@/features/logging/services/client";
import type {BasalResponse, BolusResponse} from "@/features/logging/types/logging.types";
import type {BasalFormValues, BolusFormValues} from "@/features/logging/schemas/insulin.schema";
import {localInputToIso} from "@/features/logging/datetime";

/* ---- Bolus ---- */

export function listBoluses() {
    return request<BolusResponse[]>("/api/bolus");
}

export function createBolus(values: BolusFormValues) {
    return request<BolusResponse>("/api/bolus", {
        method: "POST",
        body: JSON.stringify({
            amount: values.amount,
            bolusType: values.bolusType,
            timestamp: localInputToIso(values.timestamp),
        }),
    });
}

export function deleteBolus(id: number) {
    return request<void>(`/api/bolus/${id}`, {method: "DELETE"});
}

/* ---- Basal ---- */

export function listBasals() {
    return request<BasalResponse[]>("/api/basal");
}

export function createBasal(values: BasalFormValues) {
    return request<BasalResponse>("/api/basal", {
        method: "POST",
        body: JSON.stringify({
            amount: values.amount,
            injectedAt: localInputToIso(values.injectedAt),
        }),
    });
}

export function deleteBasal(id: number) {
    return request<void>(`/api/basal/${id}`, {method: "DELETE"});
}
