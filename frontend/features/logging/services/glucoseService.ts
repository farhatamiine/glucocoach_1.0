import {request} from "@/features/logging/services/client";
import type {CurrentGlucose} from "@/features/logging/types/logging.types";
import {TrendDirection} from "@/lib/utils";

const VALID_DIRECTIONS = new Set<string>(Object.values(TrendDirection));

function toNumber(v: unknown): number | undefined {
    return typeof v === "number" && Number.isFinite(v) ? v : undefined;
}

function toDirection(v: unknown): TrendDirection {
    return typeof v === "string" && VALID_DIRECTIONS.has(v) ? (v as TrendDirection) : TrendDirection.None;
}

/**
 * `/glucose/trend` is loosely typed in the OpenAPI spec (Nightscout-shaped).
 * Normalize defensively: pull sgv/direction/delta/time from the top level,
 * falling back to a nested entry if the value is wrapped.
 */
export async function getCurrentGlucose(): Promise<CurrentGlucose> {
    const raw = await request<Record<string, unknown>>("/api/glucose/trend", {cache: "no-store"});
    const src =
        toNumber(raw?.sgv) === undefined && raw && typeof raw === "object"
            ? ((Object.values(raw).find((v) => v && typeof v === "object") as Record<string, unknown>) ?? raw)
            : raw;

    return {
        sgv: toNumber(src?.sgv) ?? toNumber(raw?.sgv) ?? 0,
        direction: toDirection(src?.direction ?? raw?.direction),
        delta: toNumber(src?.delta) ?? toNumber(raw?.delta) ?? 0,
        at:
            typeof src?.sysTime === "string"
                ? src.sysTime
                : typeof raw?.sysTime === "string"
                    ? raw.sysTime
                    : undefined,
    };
}
