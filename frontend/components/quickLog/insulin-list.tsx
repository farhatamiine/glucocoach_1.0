"use client";

import {useState} from "react";
import {Droplet, Syringe} from "lucide-react";
import {Card, CardContent} from "@/components/ui/card";
import {Skeleton} from "@/components/ui/skeleton";
import {PeriodPicker} from "@/components/cgm/period-picker";
import {LogRow} from "@/components/quickLog/log-row";
import {useInsulinLogs} from "@/features/logging/hooks/useInsulinLogs";
import type {InsulinLog} from "@/features/logging/types/logging.types";

type InsulinListProps = {
    onEdit: (entry: InsulinLog) => void;
    onDelete: (entry: InsulinLog) => void;
};

const FILTERS = ["All", "Bolus", "Basal"];

export function InsulinList({onEdit, onDelete}: InsulinListProps) {
    const [filter, setFilter] = useState("All");
    const {data, isLoading, isError} = useInsulinLogs();
    const rows = filter === "All" ? data : data.filter((d) => d.kind === filter.toUpperCase());

    return (
        <Card className="rounded-lg">
            <CardContent className="flex items-center justify-between gap-2">
                <h2 className="text-[11px] font-bold tracking-[0.08em] text-muted-foreground uppercase">Insulin</h2>
                <PeriodPicker value={filter} onChange={setFilter} options={FILTERS}/>
            </CardContent>
            <CardContent>
                {isLoading ? (
                    <div className="flex flex-col gap-2">
                        {[0, 1, 2].map((i) => (
                            <Skeleton key={i} className="h-12 w-full rounded-lg"/>
                        ))}
                    </div>
                ) : isError ? (
                    <p className="py-6 text-center text-[13px] text-muted-foreground">
                        Couldn&apos;t load insulin entries.
                    </p>
                ) : rows.length === 0 ? (
                    <p className="py-6 text-center text-[13px] text-muted-foreground">No insulin logged yet.</p>
                ) : (
                    rows.map((entry) => (
                        <LogRow
                            key={`${entry.kind}-${entry.id}`}
                            icon={entry.kind === "BOLUS" ? Syringe : Droplet}
                            chipClassName={
                                entry.kind === "BOLUS"
                                    ? "bg-glucose-high/10 text-glucose-high"
                                    : "bg-chart-5/10 text-chart-5"
                            }
                            title={entry.kind === "BOLUS" ? "Bolus" : "Basal"}
                            subtitle={
                                entry.kind === "BOLUS" && entry.bolusType
                                    ? entry.bolusType === "MEAL"
                                        ? "Meal dose"
                                        : "Correction"
                                    : undefined
                            }
                            value={`${entry.amount} u`}
                            at={entry.at}
                            onEdit={() => onEdit(entry)}
                            onDelete={() => onDelete(entry)}
                        />
                    ))
                )}
            </CardContent>
        </Card>
    );
}
