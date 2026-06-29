import type {ReactNode} from "react";
import {Card, CardContent} from "@/components/ui/card";
import {InfoHint} from "@/components/cgm/info-hint";
import {cn} from "@/lib/utils";
import type {DayTIR} from "@/features/analytics/transform";

type TIRCalendarProps = {
    data: DayTIR[];
    title?: string;
    hint?: ReactNode;
    className?: string;
};

const DAY_LABELS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

const pad = (n: number) => String(n).padStart(2, "0");
const keyOf = (d: Date) => `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;

/** Daily time-in-range heatmap. Green ≥70% (good), amber ≥55% (okay), red <55% (low). */
function tone(tir: number) {
    if (tir >= 70) return {
        text: "text-glucose-in-range",
        bg: "bg-glucose-in-range/15",
        border: "border-glucose-in-range/40"
    };
    if (tir >= 55) return {text: "text-glucose-high", bg: "bg-glucose-high/15", border: "border-glucose-high/40"};
    return {text: "text-glucose-low", bg: "bg-glucose-low/15", border: "border-glucose-low/40"};
}

const LEGEND = [
    {label: "Good · 70%+", className: "bg-glucose-in-range"},
    {label: "Okay · 55–69%", className: "bg-glucose-high"},
    {label: "Low · under 55%", className: "bg-glucose-low"},
];

export function TIRCalendar({data, title = "Daily time in range", hint, className}: TIRCalendarProps) {
    const map = new Map(data.map((d) => [d.date, d.tir]));
    const dates = data.map((d) => new Date(d.date)).sort((a, b) => a.getTime() - b.getTime());

    const cells: { date: Date; tir?: number }[] = [];
    if (dates.length > 0) {
        const first = dates[0];
        const last = dates[dates.length - 1];
        const start = new Date(first);
        start.setDate(first.getDate() - first.getDay()); // back to Sunday
        for (let d = new Date(start); d.getTime() <= last.getTime(); d.setDate(d.getDate() + 1)) {
            const day = new Date(d);
            cells.push({date: day, tir: map.get(keyOf(day))});
        }
    }

    return (
        <Card className={cn("rounded-lg", className)}>
            <CardContent className="flex flex-col gap-3">
                <div>
                    <div className="flex items-center gap-1">
                        <div className="text-sm font-bold text-foreground">{title}</div>
                        {hint && <InfoHint label="Daily time in range">{hint}</InfoHint>}
                    </div>
                    <div className="mt-0.5 text-xs text-muted-foreground">
                        Each square is one day. The number is the share of that day your glucose stayed healthy
                        (70–180). Greener is better — aim for green.
                    </div>
                </div>

                {cells.length === 0 ? (
                    <p className="py-6 text-center text-[13px] text-muted-foreground">Not enough data yet.</p>
                ) : (
                    <>
                        <div className="grid grid-cols-7 gap-1.5">
                            {DAY_LABELS.map((d) => (
                                <div
                                    key={d}
                                    className="text-center text-[10px] font-bold tracking-wide text-muted-foreground"
                                >
                                    {d}
                                </div>
                            ))}
                            {cells.map(({date, tir}, i) => {
                                if (tir === undefined) {
                                    return (
                                        <div
                                            key={i}
                                            className="aspect-square rounded-md border border-border bg-muted/40"
                                        />
                                    );
                                }
                                const t = tone(tir);
                                return (
                                    <div
                                        key={i}
                                        title={`${keyOf(date)} · ${Math.round(tir)}% of the day in range`}
                                        className={cn(
                                            "flex aspect-square flex-col items-center justify-center rounded-md border",
                                            t.bg,
                                            t.border,
                                        )}
                                    >
                                        <span className={cn("text-[13px] font-bold tabular-nums", t.text)}>
                                            {Math.round(tir)}
                                        </span>
                                        <span className="text-[9px] text-muted-foreground">{date.getDate()}</span>
                                    </div>
                                );
                            })}
                        </div>

                        <div
                            className="flex flex-wrap items-center gap-x-4 gap-y-1.5 text-[11px] text-muted-foreground">
                            {LEGEND.map((l) => (
                                <span key={l.label} className="flex items-center gap-1.5">
                                    <span className={cn("size-2.5 rounded-[3px]", l.className)}/>
                                    {l.label}
                                </span>
                            ))}
                        </div>
                    </>
                )}
            </CardContent>
        </Card>
    );
}
