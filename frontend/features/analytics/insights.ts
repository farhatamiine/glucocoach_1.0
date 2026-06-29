import type {GlucoseSummary} from "@/features/analytics/types/analytics.types";
import type {HourAverage} from "@/features/analytics/transform";

export type InsightTone = "high" | "low" | "good" | "info";
export type Insight = { tone: InsightTone; area: string; text: string };

const PERIODS = [
    {word: "overnight", label: "Overnight", from: 0, to: 5},
    {word: "the morning", label: "Mornings", from: 6, to: 11},
    {word: "the afternoon", label: "Afternoons", from: 12, to: 17},
    {word: "the evening", label: "Evenings", from: 18, to: 23},
];

const mean = (nums: number[]) => nums.reduce((a, b) => a + b, 0) / nums.length;

/**
 * Turn the glucose summary into a few plain-language observations with gentle,
 * non-prescriptive suggestions. Never recommends a specific dose — defers to the
 * user's care team (see the disclaimer rendered alongside these).
 */
export function buildInsights(summary: GlucoseSummary, hourly: HourAverage[]): Insight[] {
    const out: Insight[] = [];

    for (const p of PERIODS) {
        const vals = hourly.filter((h) => h.hour >= p.from && h.hour <= p.to).map((h) => h.value);
        if (vals.length === 0) continue;
        const avg = Math.round(mean(vals));
        if (avg > 180) {
            out.push({
                tone: "high",
                area: p.label,
                text: `Your glucose averages ${avg} mg/dL in ${p.word} — above the 180 target. A steady high at the same time each day is worth reviewing with your care team, who may suggest adjusting insulin or food timing around then.`,
            });
        } else if (avg < 80) {
            out.push({
                tone: "low",
                area: p.label,
                text: `Your glucose tends to run low in ${p.word} (around ${avg} mg/dL). Lows that keep happening at the same time are worth flagging to your care team.`,
            });
        }
    }

    if (typeof summary.tir === "number") {
        const tir = Math.round(summary.tir);
        out.push(
            tir >= 70
                ? {
                    tone: "good",
                    area: "Time in range",
                    text: `You spent ${tir}% of the day in the healthy range — at or above the 70% goal. Nice and steady.`,
                }
                : {
                    tone: "info",
                    area: "Time in range",
                    text: `You're in range ${tir}% of the day; a common goal is 70%+. The hour-by-hour chart below can show where the day slips out of range.`,
                },
        );
    }

    if (summary.hypos && summary.hypos > 0) {
        const sev = summary.severeHypos ? `, ${summary.severeHypos} of them severe` : "";
        out.push({
            tone: "low",
            area: "Lows",
            text: `You had ${summary.hypos} low${summary.hypos > 1 ? "s" : ""}${sev} (under 70 mg/dL). Reducing lows is usually the first priority — it helps to note what happened just before each one.`,
        });
    }

    if (typeof summary.cv === "number" && summary.cv > 36) {
        out.push({
            tone: "info",
            area: "Variability",
            text: `Your glucose is fairly bumpy (variability ${Math.round(summary.cv)}%, goal under 36%). Steadier glucose usually comes from consistent meal and insulin timing.`,
        });
    }

    if (out.length === 0) {
        out.push({
            tone: "info",
            area: "Overview",
            text: "Keep wearing your sensor and logging — once there's more data, time-of-day patterns and tips will show up here.",
        });
    }

    return out.slice(0, 5);
}
