"use client";

import type {LucideIcon} from "lucide-react";
import {ArrowDown, ArrowUp, CheckCircle2, Lightbulb} from "lucide-react";
import {Card, CardContent} from "@/components/ui/card";
import {InfoHint} from "@/components/cgm/info-hint";
import {cn} from "@/lib/utils";
import type {Insight, InsightTone} from "@/features/analytics/insights";

const toneStyle: Record<InsightTone, { Icon: LucideIcon; chip: string }> = {
    high: {Icon: ArrowUp, chip: "bg-glucose-high/10 text-glucose-high"},
    low: {Icon: ArrowDown, chip: "bg-glucose-low/10 text-glucose-low"},
    good: {Icon: CheckCircle2, chip: "bg-glucose-in-range/10 text-glucose-in-range"},
    info: {Icon: Lightbulb, chip: "bg-muted text-muted-foreground"},
};

export function InsightsCard({insights}: { insights: Insight[] }) {
    return (
        <Card className="rounded-lg">
            <CardContent className="flex flex-col gap-3">
                <div className="flex items-center gap-1">
                    <div className="text-sm font-bold text-foreground">Insights &amp; tips</div>
                    <InfoHint label="Insights">
                        Plain-language patterns we noticed in your data, with gentle suggestions. These are
                        observations,
                        not medical advice.
                    </InfoHint>
                </div>

                <div className="flex flex-col gap-2.5">
                    {insights.map((ins, i) => {
                        const {Icon, chip} = toneStyle[ins.tone];
                        return (
                            <div key={i} className="flex gap-3">
                                <span
                                    className={cn("flex size-7 shrink-0 items-center justify-center rounded-lg", chip)}>
                                    <Icon className="size-4"/>
                                </span>
                                <div className="min-w-0">
                                    <div className="text-[13px] font-semibold text-foreground">{ins.area}</div>
                                    <p className="text-[13px] text-muted-foreground">{ins.text}</p>
                                </div>
                            </div>
                        );
                    })}
                </div>

                <p className="border-t border-divider pt-2.5 text-[11px] text-muted-foreground/80">
                    These are observations from your sensor data, not medical advice. Always check changes to insulin or
                    treatment with your care team.
                </p>
            </CardContent>
        </Card>
    );
}
