import {type ClassValue, clsx} from "clsx"
import {twMerge} from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
    return twMerge(clsx(inputs))
}


export enum TrendDirection {
    None = "None",
    DoubleUp = "DoubleUp",
    SingleUp = "SingleUp",
    FortyFiveUp = "FortyFiveUp",
    Flat = "Flat",
    FortyFiveDown = "FortyFiveDown",
    SingleDown = "SingleDown",
    DoubleDown = "DoubleDown",
    NotComputable = "NOT COMPUTABLE",
    RateOutOfRange = "RATE OUT OF RANGE",
}

export const TREND_CONFIG: Record<TrendDirection, { rotation: number; label: string }> = {
    [TrendDirection.DoubleUp]: {rotation: -90, label: "Rising fast"},
    [TrendDirection.SingleUp]: {rotation: -67.5, label: "Rising"},
    [TrendDirection.FortyFiveUp]: {rotation: -45, label: "Rising"},
    [TrendDirection.Flat]: {rotation: 0, label: "Steady"},
    [TrendDirection.FortyFiveDown]: {rotation: 45, label: "Falling"},
    [TrendDirection.SingleDown]: {rotation: 67.5, label: "Falling"},
    [TrendDirection.DoubleDown]: {rotation: 90, label: "Falling fast"},
    [TrendDirection.NotComputable]: {rotation: 0, label: "Unknown"},
    [TrendDirection.RateOutOfRange]: {rotation: 0, label: "Unknown"},
    [TrendDirection.None]: {rotation: 0, label: "—"},
};


export const getGlucoseTrendCardColor = (value: number) => {
    switch (true) {
        case value < 70:
            return "#e53e3e";
        case value > 70 && value < 180 :
            return "#10b981";
        case value > 180 && value < 250 :
            return "#f59e0b";
        case value > 250 :
            return "#d97706";
    }
}

export const getGlucoseTrendArrowBg = (value: number) => {
    switch (true) {
        case value <= 70:
            return "#fca5a5"; // light red
        case value > 70 && value < 180:
            return "#6ee7b7"; // light green
        case value >= 180 && value <= 250:
            return "#fcd34d"; // light amber
        case value > 250:
            return "#fdba74"; // light orange
    }
};

/* ------------------------------------------------------------------
   Glucose zones — the semantic spine of the GlucoCoach design system.
   Thresholds follow the standard CGM consensus (70 / 180 / 250 mg/dL).
   Red is reserved for hypoglycemia ("low") only — never a generic error.
------------------------------------------------------------------ */
export type GlucoseZone = "low" | "inRange" | "high" | "veryHigh";

export const GLUCOSE_THRESHOLDS = {
    low: 70,
    high: 180,
    veryHigh: 250,
} as const;

export function getGlucoseZone(value: number): GlucoseZone {
    if (value < GLUCOSE_THRESHOLDS.low) return "low";
    if (value <= GLUCOSE_THRESHOLDS.high) return "inRange";
    if (value <= GLUCOSE_THRESHOLDS.veryHigh) return "high";
    return "veryHigh";
}

/* Human label per zone (sentence case, per brand voice). */
export const GLUCOSE_ZONE_LABEL: Record<GlucoseZone, string> = {
    low: "Low",
    inRange: "In range",
    high: "High",
    veryHigh: "Very high",
};

/* Resolvable CSS color (works in Tailwind classes and inline SVG fills). */
export const GLUCOSE_ZONE_COLOR_VAR: Record<GlucoseZone, string> = {
    low: "var(--color-glucose-low)",
    inRange: "var(--color-glucose-in-range)",
    high: "var(--color-glucose-high)",
    veryHigh: "var(--color-glucose-very-high)",
};

/* Tailwind class bundles per zone. Literal strings so Tailwind v4 detects them. */
export const GLUCOSE_ZONE_CLASSES: Record<
    GlucoseZone,
    { text: string; bg: string; bgSubtle: string; dot: string; border: string }
> = {
    low: {
        text: "text-glucose-low",
        bg: "bg-glucose-low",
        bgSubtle: "bg-glucose-low/10",
        dot: "bg-glucose-low",
        border: "border-glucose-low/30",
    },
    inRange: {
        text: "text-glucose-in-range",
        bg: "bg-glucose-in-range",
        bgSubtle: "bg-glucose-in-range/10",
        dot: "bg-glucose-in-range",
        border: "border-glucose-in-range/30",
    },
    high: {
        text: "text-glucose-high",
        bg: "bg-glucose-high",
        bgSubtle: "bg-glucose-high/10",
        dot: "bg-glucose-high",
        border: "border-glucose-high/30",
    },
    veryHigh: {
        text: "text-glucose-very-high",
        bg: "bg-glucose-very-high",
        bgSubtle: "bg-glucose-very-high/10",
        dot: "bg-glucose-very-high",
        border: "border-glucose-very-high/30",
    },
};

/* Relative time per brand voice: "2 min ago" → "1 h ago" → absolute clock. */
export function formatRelativeTime(date: Date | number, now: Date | number = Date.now()): string {
    const then = typeof date === "number" ? date : date.getTime();
    const ref = typeof now === "number" ? now : now.getTime();
    const mins = Math.round((ref - then) / 60000);
    if (mins < 1) return "just now";
    if (mins < 60) return `${mins} min ago`;
    const hrs = Math.round(mins / 60);
    if (hrs < 6) return `${hrs} h ago`;
    return new Date(then).toLocaleTimeString([], {hour: "numeric", minute: "2-digit"});
}