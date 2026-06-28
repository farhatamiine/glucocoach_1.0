import type {LucideIcon} from "lucide-react";
import {Activity, Droplet, NotebookPen, Syringe, Utensils} from "lucide-react";
import {Card, CardContent} from "@/components/ui/card";
import {Button} from "@/components/ui/button";
import {cn} from "@/lib/utils";

export type LogKind = "meal" | "bolus" | "basal" | "glucose" | "note";

export type LogEntry = {
    kind: LogKind;
    title: string;
    /** Tabular value, e.g. "45 g", "4.5 u", "142 mg/dL". */
    value?: string;
    /** Time string, e.g. "7:42 AM". */
    time?: string;
};

const kindConfig: Record<LogKind, { Icon: LucideIcon; chip: string }> = {
    meal: {Icon: Utensils, chip: "bg-accent text-accent-foreground"},
    bolus: {Icon: Syringe, chip: "bg-glucose-high/10 text-glucose-high"},
    basal: {Icon: Droplet, chip: "bg-chart-5/10 text-chart-5"},
    glucose: {Icon: Activity, chip: "bg-glucose-in-range/10 text-glucose-in-range"},
    note: {Icon: NotebookPen, chip: "bg-muted text-muted-foreground"},
};

type LogListProps = {
    entries: LogEntry[];
    title?: string;
    onOpen?: () => void;
    className?: string;
};

/** Compact event log (meals, boluses, basal, readings, notes). */
export const LogList = ({entries, title = "Today's log", onOpen, className}: LogListProps) => {
    return (
        <Card className={cn("gap-0 rounded-lg py-0", className)}>
            <CardContent className="flex items-center justify-between px-4 pt-3.5 pb-2.5">
                <p className="text-[11px] font-bold tracking-[0.08em] text-muted-foreground uppercase">{title}</p>
                {onOpen && (
                    <Button variant="ghost" size="sm" className="h-7 px-2 text-primary" onClick={onOpen}>
                        Open logbook
                    </Button>
                )}
            </CardContent>
            {entries.length === 0 ? (
                <div className="border-t border-divider px-4 py-6 text-center text-[13px] text-muted-foreground">
                    Nothing logged yet.
                </div>
            ) : (
                entries.map((e, i) => {
                    const {Icon, chip} = kindConfig[e.kind];
                    return (
                        <div key={i} className="flex items-center gap-3 border-t border-divider px-4 py-2.5">
                            <span className={cn("flex size-8 shrink-0 items-center justify-center rounded-lg", chip)}>
                                <Icon className="size-4"/>
                            </span>
                            <div className="flex-1 truncate text-[13px] text-foreground">{e.title}</div>
                            {e.value && (
                                <div className="text-[13px] font-semibold text-foreground tabular-nums">{e.value}</div>
                            )}
                            {e.time && (
                                <div
                                    className="w-16 text-right font-mono text-[11px] text-muted-foreground">{e.time}</div>
                            )}
                        </div>
                    );
                })
            )}
        </Card>
    );
};
