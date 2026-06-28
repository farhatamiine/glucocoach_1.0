import {Card, CardContent} from "@/components/ui/card";
import {Button} from "@/components/ui/button";
import {cn} from "@/lib/utils";

export type AlertTone = "low" | "high" | "info";

export type AlertItem = {
    tone: AlertTone;
    title: string;
    /** Status line, e.g. "Resolved · 3:12 AM" or "Correction given". */
    sub?: string;
    /** Right-aligned timestamp, e.g. "Today", "Yesterday". */
    time?: string;
};

const toneDot: Record<AlertTone, string> = {
    low: "bg-glucose-low",
    high: "bg-glucose-high",
    info: "bg-chart-5",
};

type AlertFeedProps = {
    items: AlertItem[];
    title?: string;
    onSeeAll?: () => void;
    className?: string;
};

/** Recent alerts list. For an active, must-act alert use {@link AlertBanner} instead. */
export const AlertFeed = ({items, title = "Recent alerts", onSeeAll, className}: AlertFeedProps) => {
    return (
        <Card className={cn("gap-0 rounded-lg py-0", className)}>
            <CardContent className="flex items-center justify-between px-4 pt-3.5 pb-2.5">
                <p className="text-[11px] font-bold tracking-[0.08em] text-muted-foreground uppercase">{title}</p>
                {onSeeAll && (
                    <Button variant="ghost" size="sm" className="h-7 px-2 text-primary" onClick={onSeeAll}>
                        See all
                    </Button>
                )}
            </CardContent>
            {items.length === 0 ? (
                <div className="border-t border-divider px-4 py-6 text-center text-[13px] text-muted-foreground">
                    No alerts. You&apos;re all clear.
                </div>
            ) : (
                items.map((item, i) => (
                    <div key={i} className="flex items-center gap-3 border-t border-divider px-4 py-2.5">
                        <span className={cn("size-2 shrink-0 rounded-full", toneDot[item.tone])} aria-hidden/>
                        <div className="flex-1 min-w-0">
                            <div className="truncate text-[13px] font-semibold text-foreground">{item.title}</div>
                            {item.sub && <div className="truncate text-xs text-muted-foreground">{item.sub}</div>}
                        </div>
                        {item.time && (
                            <div className="font-mono text-[11px] text-muted-foreground">{item.time}</div>
                        )}
                    </div>
                ))
            )}
        </Card>
    );
};
