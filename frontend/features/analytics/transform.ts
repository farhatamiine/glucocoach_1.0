import type {AGPPoint} from "@/components/cgm/agp-chart";

/** First finite number found among candidate keys. */
function pick(o: Record<string, unknown> | undefined, keys: string[]): number | undefined {
    if (!o) return undefined;
    for (const k of keys) {
        const v = o[k];
        if (typeof v === "number" && Number.isFinite(v)) return v;
    }
    return undefined;
}

/** 24-hour clock label, e.g. 0 → "00:00", 14 → "14:00". */
export function hourLabel(h: number): string {
    return `${String(h % 24).padStart(2, "0")}:00`;
}

/**
 * Backend `agp` is loosely typed (hour → percentile map). Tolerate several key namings
 * (p50/median/50, p25/25, …) and skip hours without a median.
 */
export function transformAgp(agp?: Record<string, Record<string, number>>): AGPPoint[] {
    if (!agp) return [];
    const points: AGPPoint[] = [];
    for (const [key, val] of Object.entries(agp)) {
        const hour = Number(key);
        if (!Number.isInteger(hour) || hour < 0 || hour > 24 || !val || typeof val !== "object") continue;
        const median = pick(val, ["p50", "median", "50"]);
        if (median === undefined) continue;
        const p25 = pick(val, ["p25", "25"]);
        const p75 = pick(val, ["p75", "75"]);
        const p5 = pick(val, ["p5", "5"]);
        const p95 = pick(val, ["p95", "95"]);
        points.push({
            t: hour * 60,
            label: hour % 6 === 0 ? hourLabel(hour) : undefined,
            median,
            iqr: [p25 ?? median, p75 ?? median],
            outer: [p5 ?? p25 ?? median, p95 ?? p75 ?? median],
        });
    }
    return points.sort((a, b) => a.t - b.t);
}

export type HourAverage = { hour: number; value: number };

export function transformHourly(map?: Record<string, number>): HourAverage[] {
    if (!map) return [];
    return Object.entries(map)
        .map(([k, v]) => ({hour: Number(k), value: v}))
        .filter((x) => Number.isInteger(x.hour) && typeof x.value === "number" && Number.isFinite(x.value))
        .sort((a, b) => a.hour - b.hour);
}

export type DayTIR = { date: string; tir: number };

export function transformTirByDay(map?: Record<string, number>): DayTIR[] {
    if (!map) return [];
    return Object.entries(map)
        .map(([date, tir]) => ({date, tir}))
        .filter((x) => typeof x.tir === "number" && Number.isFinite(x.tir))
        .sort((a, b) => (a.date < b.date ? -1 : 1));
}
