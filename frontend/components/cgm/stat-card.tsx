import type {ReactNode} from "react";
import {Card, CardContent} from "@/components/ui/card";
import {Sparkline} from "@/components/cgm/sparkline";
import {InfoHint} from "@/components/cgm/info-hint";
import {cn} from "@/lib/utils";

type DeltaDirection = "good" | "bad" | "neutral";

type StatCardProps = {
    label: string;
    value: string | number;
    unit?: string;
    /** Magnitude of change vs the prior period, e.g. "0.2". */
    delta?: string;
    deltaDir?: DeltaDirection;
    /** Caption under the value, e.g. "Est. A1C equivalent". */
    sub?: string;
    /** Optional override color for the value (e.g. hypo red). Any CSS color. */
    valueColor?: string;
    sparkData?: number[];
    sparkColor?: string;
    /** Optional plain-language explanation shown via an info tooltip on the label. */
    hint?: ReactNode;
    className?: string;
};

const deltaClasses: Record<DeltaDirection, string> = {
    good: "text-glucose-in-range",
    bad: "text-glucose-low",
    neutral: "text-muted-foreground",
};

const deltaArrow: Record<DeltaDirection, string> = {
    good: "↘",
    bad: "↗",
    neutral: "→",
};

/**
 * Clinical metric card (GMI, avg glucose, CV, hypos…). Values use tabular figures
 * so they don't jitter as readings update.
 */
export const StatCard = ({
                             label,
                             value,
                             unit,
                             delta,
                             deltaDir = "neutral",
                             sub,
                             valueColor,
                             sparkData,
                             sparkColor,
                             hint,
                             className,
                         }: StatCardProps) => {
    return (
        <Card className={cn("gap-0 rounded-lg", className)}>
            <CardContent className="flex flex-col gap-1">
                <div className="flex items-center gap-1">
                    <p className="text-[11px] font-bold tracking-[0.08em] text-muted-foreground uppercase">
                        {label}
                    </p>
                    {hint && <InfoHint label={label}>{hint}</InfoHint>}
                </div>
                <div className="flex items-baseline gap-1.5">
                    <span
                        className="text-2xl font-bold tracking-tight tabular-nums"
                        style={valueColor ? {color: valueColor} : undefined}
                    >
                        {value}
                    </span>
                    {unit && <span className="text-[11px] font-medium text-muted-foreground">{unit}</span>}
                    {delta && (
                        <span className={cn("ml-1 text-[11px] font-semibold", deltaClasses[deltaDir])}>
                            {deltaArrow[deltaDir]} {delta}
                        </span>
                    )}
                </div>
                {sub && <p className="text-[11px] text-muted-foreground">{sub}</p>}
                {sparkData && sparkData.length > 1 && (
                    <Sparkline data={sparkData} color={sparkColor} className="mt-1.5"/>
                )}
            </CardContent>
        </Card>
    );
};
