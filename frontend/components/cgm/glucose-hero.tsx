import {ArrowRight} from "lucide-react";
import {Sparkline} from "@/components/cgm/sparkline";
import {cn, formatRelativeTime, TREND_CONFIG, TrendDirection} from "@/lib/utils";

type GlucoseHeroProps = {
    value: number;
    unit?: string;
    direction: TrendDirection;
    /** Rate of change per minute, e.g. 1.2. */
    delta?: number;
    /** When the reading was taken — accepts a Date, epoch ms, or a prebuilt string. */
    updatedAt?: Date | number | string;
    /** Sensor / source line, e.g. "Dexcom G7 via Nightscout". */
    source?: string;
    /** Recent readings for the inline trace. */
    sparkData?: number[];
    className?: string;
};

/**
 * The dashboard hero. Per the brand principle, the current glucose reading is the
 * single largest, most legible element — set against the only gradient the system
 * permits (teal-700 → teal-500). Never scrolls off the dashboard.
 */
export const GlucoseHero = ({
                                value,
                                unit = "mg/dL",
                                direction,
                                delta,
                                updatedAt,
                                source,
                                sparkData,
                                className,
                            }: GlucoseHeroProps) => {
    const trend = TREND_CONFIG[direction];
    const updatedLabel =
        typeof updatedAt === "string" || updatedAt === undefined
            ? updatedAt
            : formatRelativeTime(updatedAt);

    const rateLabel =
        delta !== undefined ? `${delta > 0 ? "+" : ""}${delta}/min` : undefined;

    return (
        <div
            className={cn(
                "flex items-center justify-between gap-4 rounded-lg px-6 py-5 text-white",
                "shadow-[0_4px_16px_rgba(13,115,119,0.18)]",
                className,
            )}
            style={{background: "linear-gradient(160deg,#084A4D 0%,#0D7377 100%)"}}
        >
            <div className="min-w-0">
                <p className="text-[11px] font-bold tracking-[0.08em] text-white/60 uppercase">
                    Current glucose
                </p>
                <div className="mt-1.5 flex items-baseline gap-2">
                    <span className="text-5xl leading-none font-extrabold tracking-tight tabular-nums md:text-6xl">
                        {value}
                    </span>
                    <span className="text-base font-medium text-white/60">{unit}</span>
                    <span className="ml-2 inline-flex items-center gap-1.5 rounded-full bg-white/15 px-3 py-1">
                        <ArrowRight
                            className="size-4"
                            style={{transform: `rotate(${trend.rotation}deg)`}}
                            aria-hidden
                        />
                        <span className="text-xs font-semibold">
                            {trend.label}
                            {rateLabel ? ` · ${rateLabel}` : ""}
                        </span>
                    </span>
                </div>
                {(updatedLabel || source) && (
                    <p className="mt-2 truncate text-xs text-white/50">
                        {[updatedLabel && `Updated ${updatedLabel}`, source].filter(Boolean).join(" · ")}
                    </p>
                )}
            </div>

            {sparkData && sparkData.length > 1 && (
                <div className="hidden w-56 shrink-0 sm:block">
                    <Sparkline data={sparkData} color="rgba(255,255,255,0.75)" height={60} strokeWidth={2}/>
                </div>
            )}
        </div>
    );
};
