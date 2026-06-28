"use client";

import {Area, ComposedChart, Line, ReferenceArea, ReferenceLine, XAxis, YAxis} from "recharts";
import {Card, CardContent} from "@/components/ui/card";
import {type ChartConfig, ChartContainer} from "@/components/ui/chart";
import {cn, GLUCOSE_THRESHOLDS} from "@/lib/utils";

export type AGPPoint = {
    /** Minutes since midnight (0–1440) or any monotonic x. */
    t: number;
    /** Axis label shown for this point, e.g. "6a". */
    label?: string;
    median: number;
    /** [p25, p75] inter-quartile band. */
    iqr: [number, number];
    /** [p5, p95] outer band. */
    outer: [number, number];
};

const chartConfig = {
    median: {label: "Median", color: "var(--color-chart-1)"},
} satisfies ChartConfig;

/** Deterministic sample profile so the chart renders meaningfully without data. */
function sampleProfile(): AGPPoint[] {
    const pts: AGPPoint[] = [];
    for (let h = 0; h <= 24; h += 1) {
        const t = h * 60;
        // Calm overnight, breakfast + lunch + dinner bumps.
        const base =
            108 +
            18 * Math.sin((h / 24) * Math.PI * 2 - 1) +
            34 * Math.exp(-(((h - 8) / 1.6) ** 2)) +
            28 * Math.exp(-(((h - 13) / 1.8) ** 2)) +
            32 * Math.exp(-(((h - 19) / 2) ** 2));
        const median = Math.round(base);
        const iqrSpread = 16 + 8 * Math.exp(-(((h - 8) / 2) ** 2)) + 8 * Math.exp(-(((h - 19) / 2) ** 2));
        const outerSpread = iqrSpread * 2.3;
        const label = h === 0 || h === 24 ? "12a" : h === 12 ? "12p" : h < 12 ? `${h}a` : `${h - 12}p`;
        pts.push({
            t,
            label: h % 6 === 0 ? label : undefined,
            median,
            iqr: [Math.round(median - iqrSpread), Math.round(median + iqrSpread)],
            outer: [Math.round(median - outerSpread), Math.round(median + outerSpread)],
        });
    }
    return pts;
}

type AGPChartProps = {
    data?: AGPPoint[];
    title?: string;
    subtitle?: string;
    className?: string;
};

/**
 * Ambulatory Glucose Profile — overlays many days into one representative day:
 * 5–95th and 25–75th percentile bands around the median, against the 70–180 target zone.
 */
export const AGPChart = ({
                             data,
                             title = "Ambulatory glucose profile",
                             subtitle = "5th–95th percentile bands · target zone 70–180",
                             className,
                         }: AGPChartProps) => {
    const points = data ?? sampleProfile();

    return (
        <Card className={cn("rounded-lg", className)}>
            <CardContent className="flex flex-col gap-3.5">
                <div className="flex flex-wrap items-center justify-between gap-2">
                    <div>
                        <div className="text-sm font-bold text-foreground">{title}</div>
                        <div className="mt-0.5 text-xs text-muted-foreground">{subtitle}</div>
                    </div>
                    <div className="flex items-center gap-3.5 text-xs text-muted-foreground">
                        <span className="flex items-center gap-1.5">
                            <span className="inline-block h-[2.5px] w-5 rounded bg-chart-1"/> Median
                        </span>
                        <span className="flex items-center gap-1.5">
                            <span className="inline-block h-2 w-5 rounded bg-chart-1/30"/> 25–75%
                        </span>
                        <span className="flex items-center gap-1.5">
                            <span className="inline-block h-2 w-5 rounded bg-chart-1/15"/> 5–95%
                        </span>
                    </div>
                </div>

                <ChartContainer config={chartConfig} className="h-[240px] w-full">
                    <ComposedChart data={points} margin={{top: 8, right: 8, bottom: 4, left: 4}}>
                        <ReferenceArea
                            y1={GLUCOSE_THRESHOLDS.low}
                            y2={GLUCOSE_THRESHOLDS.high}
                            fill="var(--color-glucose-in-range)"
                            fillOpacity={0.08}
                        />
                        <ReferenceLine
                            y={GLUCOSE_THRESHOLDS.high}
                            stroke="var(--color-glucose-in-range)"
                            strokeDasharray="4 4"
                            strokeOpacity={0.6}
                        />
                        <ReferenceLine
                            y={GLUCOSE_THRESHOLDS.low}
                            stroke="var(--color-glucose-in-range)"
                            strokeDasharray="4 4"
                            strokeOpacity={0.6}
                        />
                        <XAxis
                            dataKey="label"
                            tickLine={false}
                            axisLine={false}
                            tickMargin={8}
                            fontSize={11}
                            interval={0}
                            tick={{fill: "var(--muted-foreground)"}}
                        />
                        <YAxis
                            domain={[40, 350]}
                            ticks={[54, 70, 180, 250, 350]}
                            tickLine={false}
                            axisLine={false}
                            tickMargin={6}
                            width={32}
                            fontSize={11}
                            tick={{fill: "var(--muted-foreground)"}}
                        />
                        <Area
                            dataKey="outer"
                            type="monotone"
                            stroke="none"
                            fill="var(--color-chart-1)"
                            fillOpacity={0.15}
                            isAnimationActive={false}
                        />
                        <Area
                            dataKey="iqr"
                            type="monotone"
                            stroke="none"
                            fill="var(--color-chart-1)"
                            fillOpacity={0.25}
                            isAnimationActive={false}
                        />
                        <Line
                            dataKey="median"
                            type="monotone"
                            stroke="var(--color-chart-1)"
                            strokeWidth={2.5}
                            dot={false}
                            isAnimationActive={false}
                        />
                    </ComposedChart>
                </ChartContainer>
            </CardContent>
        </Card>
    );
};
