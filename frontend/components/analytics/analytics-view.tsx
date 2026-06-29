"use client";

import {useState} from "react";
import {Card, CardContent} from "@/components/ui/card";
import {Skeleton} from "@/components/ui/skeleton";
import {InfoHint} from "@/components/cgm/info-hint";
import {StatCard} from "@/components/cgm/stat-card";
import {TIRRing} from "@/components/cgm/tir-ring";
import {AGPChart} from "@/components/cgm/agp-chart";
import {TIRCalendar} from "@/components/cgm/tir-calendar";
import {HourlyGrid} from "@/components/cgm/hourly-grid";
import {PeriodPicker} from "@/components/cgm/period-picker";
import {InsightsCard} from "@/components/analytics/insights-card";
import {useGlucoseSummary} from "@/features/analytics/hooks/useGlucoseSummary";
import {transformAgp, transformHourly, transformTirByDay} from "@/features/analytics/transform";
import {buildInsights} from "@/features/analytics/insights";

const PERIODS: { label: string; days: number }[] = [
    {label: "7d", days: 7},
    {label: "14d", days: 14},
    {label: "30d", days: 30},
    {label: "90d", days: 90},
];

const round = (n?: number) => (typeof n === "number" ? Math.round(n) : undefined);
const one = (n?: number) => (typeof n === "number" ? n.toFixed(1) : "—");
const show = (n?: number) => (n === undefined ? "—" : String(n));

const HINTS = {
    gmi: "A stand-in for your A1C lab number, estimated from sensor data — it reflects your average glucose over weeks. Under 7% is a common goal.",
    avg: "Your average sensor reading over this window. Many people with diabetes aim for under ~154 mg/dL (about a 7% A1C).",
    cv: "How much your glucose bounces around. Under 36% is considered steady; higher means bigger swings between highs and lows.",
    hypos: "How many times your glucose dropped below 70 mg/dL (a 'low'). Lows can feel bad and are worth keeping rare.",
    agp: "Your typical day folded into one chart. The line is your usual glucose at each time of day; the shaded bands show how much it varies. You want the line flat and inside the green target zone.",
    tir: "The share of the day your glucose stayed healthy (70–180, green) versus too high (amber) or too low (red). Aim for green at least 70% of the day.",
    risk: "LBGI and HBGI score how often and how far you go low or high — lower is safer. Std deviation is your swing size; insulin sensitivity is roughly how much one unit of insulin lowers your glucose.",
    calendar: "Each square is one day; greener squares are days you spent more time in the healthy range.",
    hourly: "Your average glucose at each hour of the day (24-hour clock), so you can spot a time that regularly runs high or low.",
};

export function AnalyticsView() {
    const [period, setPeriod] = useState("30d");
    const days = PERIODS.find((p) => p.label === period)?.days ?? 30;
    const {data, isLoading, isError} = useGlucoseSummary(days);

    const agpPoints = transformAgp(data?.agp);
    const hourly = transformHourly(data?.dailyAverageByHour);
    const tirByDay = transformTirByDay(data?.tirByDay);
    const insights = data ? buildInsights(data, hourly) : [];

    return (
        <div className="flex flex-col gap-5 p-6">
            <div className="flex flex-wrap items-end justify-between gap-3">
                <div>
                    <h1 className="text-xl font-semibold tracking-tight">Glucose analytics</h1>
                    <p className="mt-0.5 text-sm text-muted-foreground">
                        Your glucose patterns in plain language — hover any{" "}
                        <span className="inline-flex translate-y-0.5">
                            <InfoHint
                                label="Example">Hover these icons for a plain-language explanation of each metric.</InfoHint>
                        </span>{" "}
                        to learn what it means.
                    </p>
                </div>
                <PeriodPicker value={period} onChange={setPeriod} options={PERIODS.map((p) => p.label)}/>
            </div>

            {isError ? (
                <Card className="rounded-lg">
                    <CardContent className="py-8 text-center text-sm text-muted-foreground">
                        Couldn&apos;t load your analytics. Try again in a moment.
                    </CardContent>
                </Card>
            ) : isLoading || !data ? (
                <div className="flex flex-col gap-5">
                    <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
                        {[0, 1, 2, 3].map((i) => (
                            <Skeleton key={i} className="h-24 w-full rounded-lg"/>
                        ))}
                    </div>
                    <Skeleton className="h-72 w-full rounded-lg"/>
                    <div className="grid grid-cols-1 gap-5 lg:grid-cols-2">
                        <Skeleton className="h-48 w-full rounded-lg"/>
                        <Skeleton className="h-48 w-full rounded-lg"/>
                    </div>
                </div>
            ) : (
                <>
                    <div className="grid grid-cols-2 gap-4 lg:grid-cols-4">
                        <StatCard label={`GMI · ${days} d`} value={one(data.gmi)} unit="%" sub="Est. HbA1c"
                                  hint={HINTS.gmi}/>
                        <StatCard label="Avg glucose" value={show(round(data.average))} unit="mg/dL" hint={HINTS.avg}/>
                        <StatCard
                            label="CV · variability"
                            value={show(round(data.cv))}
                            unit="%"
                            sub="Target < 36%"
                            hint={HINTS.cv}
                        />
                        <StatCard
                            label={`Hypos · ${days} d`}
                            value={show(data.hypos)}
                            unit="events"
                            sub={data.severeHypos ? `${data.severeHypos} severe (< 54)` : undefined}
                            valueColor={data.hypos ? "var(--color-glucose-low)" : undefined}
                            hint={HINTS.hypos}
                        />
                    </div>

                    <InsightsCard insights={insights}/>

                    {agpPoints.length >= 2 ? (
                        <AGPChart data={agpPoints} subtitle={`5th–95th percentile bands · ${days} days`}
                                  hint={HINTS.agp}/>
                    ) : (
                        <Card className="rounded-lg">
                            <CardContent className="py-8 text-center text-sm text-muted-foreground">
                                Not enough data for an ambulatory glucose profile yet.
                            </CardContent>
                        </Card>
                    )}

                    <div className="grid grid-cols-1 gap-5 lg:grid-cols-2">
                        <TIRRing
                            tir={round(data.tir) ?? 0}
                            tbr={round(data.tbr) ?? 0}
                            tar={round(data.tar) ?? 0}
                            label={`Time in range · ${days} d`}
                            hint={HINTS.tir}
                        />
                        <RiskPanel
                            lbgi={data.lbgi}
                            hbgi={data.hbgi}
                            stdDev={data.stdDev}
                            estimatedIsf={data.estimatedIsf}
                        />
                    </div>

                    <TIRCalendar data={tirByDay} hint={HINTS.calendar}/>
                    <HourlyGrid data={hourly} hint={HINTS.hourly}/>
                </>
            )}
        </div>
    );
}

function RiskPanel({
                       lbgi,
                       hbgi,
                       stdDev,
                       estimatedIsf,
                   }: {
    lbgi?: number;
    hbgi?: number;
    stdDev?: number;
    estimatedIsf?: number;
}) {
    const rows = [
        {label: "Low blood glucose index", value: one(lbgi), hint: "Hypo risk"},
        {label: "High blood glucose index", value: one(hbgi), hint: "Hyper risk"},
        {label: "Std deviation", value: show(round(stdDev)), unit: "mg/dL"},
        {label: "Est. insulin sensitivity", value: show(round(estimatedIsf)), unit: "mg/dL/u"},
    ];
    return (
        <Card className="rounded-lg">
            <CardContent className="flex flex-col gap-3">
                <div className="flex items-center gap-1">
                    <div className="text-sm font-bold text-foreground">Risk &amp; variability</div>
                    <InfoHint label="Risk and variability">{HINTS.risk}</InfoHint>
                </div>
                <div className="flex flex-col">
                    {rows.map((r) => (
                        <div
                            key={r.label}
                            className="flex items-center justify-between border-t border-divider py-2.5 text-[13px] first:border-t-0"
                        >
                            <span className="text-muted-foreground">
                                {r.label}
                                {r.hint &&
                                    <span className="ml-1.5 text-[11px] text-muted-foreground/70">· {r.hint}</span>}
                            </span>
                            <span className="font-bold text-foreground tabular-nums">
                                {r.value}
                                {r.unit && <span
                                    className="ml-1 text-[11px] font-medium text-muted-foreground">{r.unit}</span>}
                            </span>
                        </div>
                    ))}
                </div>
            </CardContent>
        </Card>
    );
}
