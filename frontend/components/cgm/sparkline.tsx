import {cn} from "@/lib/utils";

type SparklineProps = {
    data: number[];
    /** Any CSS color; defaults to the brand teal (chart-1). */
    color?: string;
    /** Render a soft area fill below the line. */
    fill?: boolean;
    height?: number;
    strokeWidth?: number;
    className?: string;
};

/**
 * Minimal, dependency-free trend line for stat cards and dense lists.
 * Stretches to its container width; height is fixed.
 */
export const Sparkline = ({
                              data,
                              color = "var(--color-chart-1)",
                              fill = false,
                              height = 28,
                              strokeWidth = 1.8,
                              className,
                          }: SparklineProps) => {
    if (data.length < 2) return null;

    const w = 100;
    const h = height;
    const max = Math.max(...data);
    const min = Math.min(...data);
    const range = max - min || 1;

    const points = data.map((v, i) => {
        const x = (i / (data.length - 1)) * w;
        const y = h - ((v - min) / range) * (h - strokeWidth) - strokeWidth / 2;
        return [x, y] as const;
    });

    const line = points.map(([x, y]) => `${x},${y}`).join(" ");
    const area = `${line} ${w},${h} 0,${h}`;
    const gradId = `spark-${Math.round(min)}-${Math.round(max)}-${data.length}`;

    return (
        <svg
            viewBox={`0 0 ${w} ${h}`}
            preserveAspectRatio="none"
            className={cn("w-full", className)}
            style={{height}}
            aria-hidden
        >
            {fill && (
                <>
                    <defs>
                        <linearGradient id={gradId} x1="0" y1="0" x2="0" y2="1">
                            <stop offset="0%" stopColor={color} stopOpacity={0.18}/>
                            <stop offset="100%" stopColor={color} stopOpacity={0}/>
                        </linearGradient>
                    </defs>
                    <polygon points={area} fill={`url(#${gradId})`} stroke="none"/>
                </>
            )}
            <polyline
                points={line}
                fill="none"
                stroke={color}
                strokeWidth={strokeWidth}
                strokeLinecap="round"
                strokeLinejoin="round"
                vectorEffect="non-scaling-stroke"
            />
        </svg>
    );
};
