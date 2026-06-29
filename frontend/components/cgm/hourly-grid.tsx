"use client";

import type {ReactNode} from "react";
import {Bar, BarChart, Cell, ReferenceArea, ReferenceLine, XAxis, YAxis} from "recharts";
import {Card, CardContent} from "@/components/ui/card";
import {type ChartConfig, ChartContainer, ChartTooltip, ChartTooltipContent} from "@/components/ui/chart";
import {InfoHint} from "@/components/cgm/info-hint";
import {cn, getGlucoseZone, GLUCOSE_THRESHOLDS, GLUCOSE_ZONE_COLOR_VAR,} from "@/lib/utils";
import {type HourAverage, hourLabel} from "@/features/analytics/transform";

type HourlyGridProps = {
    data: HourAverage[];
    title?: string;
    hint?: ReactNode;
    className?: string;
};

const chartConfig = {
    value: {label: "Avg glucose", color: "var(--color-chart-1)"},
} satisfies ChartConfig;

/** Average glucose by hour of the day (24-hour clock) — spot times that run high or low. */
export function HourlyGrid({data, title = "Average glucose by hour", hint, className}: HourlyGridProps) {
    const chartData = data.map((d) => ({label: hourLabel(d.hour), value: Math.round(d.value)}));

    return (
        <Card className={cn("rounded-lg", className)}>
            <CardContent className="flex flex-col gap-3">
                <div>
                    <div className="flex items-center gap-1">
                        <div className="text-sm font-bold text-foreground">{title}</div>
                        {hint && <InfoHint label="Average glucose by hour">{hint}</InfoHint>}
                    </div>
                    <div className="mt-0.5 text-xs text-muted-foreground">
                        Times use the 24-hour clock (00:00 = midnight). Bars inside the green band are in the healthy
                        range.
                    </div>
                </div>

                {chartData.length === 0 ? (
                    <p className="py-6 text-center text-[13px] text-muted-foreground">Not enough data yet.</p>
                ) : (
                    <ChartContainer config={chartConfig} className="h-[220px] w-full">
                        <BarChart data={chartData} margin={{top: 8, right: 8, bottom: 4, left: 4}}>
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
                                strokeOpacity={0.5}
                            />
                            <ReferenceLine
                                y={GLUCOSE_THRESHOLDS.low}
                                stroke="var(--color-glucose-in-range)"
                                strokeDasharray="4 4"
                                strokeOpacity={0.5}
                            />
                            <XAxis
                                dataKey="label"
                                tickLine={false}
                                axisLine={false}
                                tickMargin={8}
                                fontSize={10}
                                interval={2}
                                tick={{fill: "var(--muted-foreground)"}}
                            />
                            <YAxis
                                domain={[40, 320]}
                                ticks={[70, 180, 250]}
                                tickLine={false}
                                axisLine={false}
                                tickMargin={6}
                                width={32}
                                fontSize={11}
                                tick={{fill: "var(--muted-foreground)"}}
                            />
                            <ChartTooltip cursor={false} content={<ChartTooltipContent/>}/>
                            <Bar dataKey="value" radius={[3, 3, 0, 0]} isAnimationActive={false}>
                                {chartData.map((d) => (
                                    <Cell key={d.label} fill={GLUCOSE_ZONE_COLOR_VAR[getGlucoseZone(d.value)]}/>
                                ))}
                            </Bar>
                        </BarChart>
                    </ChartContainer>
                )}
            </CardContent>
        </Card>
    );
}
