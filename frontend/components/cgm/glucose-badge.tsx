import {cn, getGlucoseZone, GLUCOSE_ZONE_CLASSES, GLUCOSE_ZONE_LABEL, type GlucoseZone} from "@/lib/utils";

type GlucoseBadgeProps = {
    /** Pass a raw glucose value and the zone is derived, or pass an explicit zone. */
    value?: number;
    zone?: GlucoseZone;
    /** Override the label text (defaults to the zone label). */
    label?: string;
    className?: string;
};

/**
 * Zone pill — colored dot + label. Never relies on color alone (text always present),
 * per the design system's accessibility rule.
 */
export const GlucoseBadge = ({value, zone, label, className}: GlucoseBadgeProps) => {
    const resolved: GlucoseZone = zone ?? (value !== undefined ? getGlucoseZone(value) : "inRange");
    const c = GLUCOSE_ZONE_CLASSES[resolved];
    return (
        <span
            className={cn(
                "inline-flex items-center gap-1.5 rounded-full px-2 py-0.5 text-xs font-semibold",
                c.bgSubtle,
                c.text,
                className,
            )}
        >
            <span className={cn("size-1.5 shrink-0 rounded-full", c.dot)} aria-hidden/>
            {label ?? GLUCOSE_ZONE_LABEL[resolved]}
        </span>
    );
};
