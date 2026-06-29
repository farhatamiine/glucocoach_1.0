import {request} from "@/features/logging/services/client";
import type {GlucoseSummary} from "@/features/analytics/types/analytics.types";

export function getGlucoseSummary(days: number) {
    return request<GlucoseSummary>(`/api/glucose/summary?days=${days}`, {cache: "no-store"});
}
