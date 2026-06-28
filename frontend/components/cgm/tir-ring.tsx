import {Card, CardContent} from "@/components/ui/card";
import {cn, GLUCOSE_ZONE_COLOR_VAR} from "@/lib/utils";

type TIRRingProps = {
    /** Time in range, % (70–180). */
    tir: number;
    /** Time below range, % (< 70, hypo). */
    tbr: number;
    /** Time above range, % (> 180). */
    tar: number;
    /** Label, e.g. "Time in range · 14 d". */
    label?: string;
    className?: string;
};

const R = 15.915; // circumference ≈ 100, so dash values read as percentages

/**
 * Time-in-range donut + legend. Segments are ordered low → in-range → high around
 * the ring; the in-range percentage is centered as the headline figure.
 */
export const TIRRing = ({tir, tbr, tar, label = "Time in range · 14 d", className}: TIRRingProps) => {
    const segments = [
        {value: tbr, color: GLUCOSE_ZONE_COLOR_VAR.low, offset: 25},
        {value: tir, color: GLUCOSE_ZONE_COLOR_VAR.inRange, offset: 25 - tbr},
        {value: tar, color: GLUCOSE_ZONE_COLOR_VAR.high, offset: 25 - tbr - tir},
    ];

    const legend = [
        {color: GLUCOSE_ZONE_COLOR_VAR.high, label: "Above 180", value: tar},
        {color: GLUCOSE_ZONE_COLOR_VAR.inRange, label: "70–180 in range", value: tir},
        {color: GLUCOSE_ZONE_COLOR_VAR.low, label: "Below 70", value: tbr},
    ];

    return (
        <Card className={cn("rounded-lg", className)}>
            <CardContent className="flex items-center gap-5">
                <svg width={110} height={110} viewBox="0 0 42 42" className="shrink-0" role="img"
                     aria-label={`Time in range ${tir} percent`}>
                    <circle cx="21" cy="21" r={R} fill="none" stroke="var(--muted)" strokeWidth="6"/>
                    {segments.map((s, i) => (
                        <circle
                            key={i}
                            cx="21"
                            cy="21"
                            r={R}
                            fill="none"
                            stroke={s.color}
                            strokeWidth="6"
                            strokeDasharray={`${s.value} ${100 - s.value}`}
                            strokeDashoffset={s.offset}
                            transform="rotate(-90 21 21)"
                        />
                    ))}
                    <text x="21" y="20" textAnchor="middle" fontSize="8" fontWeight="700"
                          fill="var(--foreground)" className="tabular-nums">
                        {tir}%
                    </text>
                    <text x="21" y="25" textAnchor="middle" fontSize="2.6" fill="var(--muted-foreground)"
                          letterSpacing="0.4">
                        IN RANGE
                    </text>
                </svg>

                <div className="flex-1">
                    <p className="mb-2.5 text-[11px] font-bold tracking-[0.08em] text-muted-foreground uppercase">
                        {label}
                    </p>
                    {legend.map((row) => (
                        <div key={row.label}
                             className="mb-1.5 flex items-center justify-between text-[13px] text-muted-foreground">
                            <span className="flex items-center gap-2">
                                <span className="size-2.5 shrink-0 rounded-[3px]" style={{background: row.color}}/>
                                {row.label}
                            </span>
                            <span className="font-bold text-foreground tabular-nums">{row.value}%</span>
                        </div>
                    ))}
                </div>
            </CardContent>
        </Card>
    );
};
