"use client";

import {type ReactNode, useMemo, useState} from "react";
import Link from "next/link";
import {useRouter} from "next/navigation";
import {ChevronLeft, ChevronRight, Droplet, NotebookPen, Syringe, User, Utensils} from "lucide-react";
import {toast} from "sonner";
import {Button} from "@/components/ui/button";
import {Card, CardContent} from "@/components/ui/card";
import {Skeleton} from "@/components/ui/skeleton";
import {GlucoseSummary} from "@/components/quickLog/glucose-summary";
import {QuickLogActions} from "@/components/quickLog/quick-log-actions";
import {LogRow} from "@/components/quickLog/log-row";
import {ConfirmDialog} from "@/components/quickLog/confirm-dialog";
import {useInsulinLogs, useInsulinMutations} from "@/features/logging/hooks/useInsulinLogs";
import {useMealMutations, useMeals} from "@/features/logging/hooks/useMealLogs";
import {isSameLocalDay, parseBackendDate} from "@/features/logging/datetime";

type DeleteTarget = { kind: "bolus" | "basal" | "meal"; id: number; label: string };

const fmt = (u: number) => (Number.isInteger(u) ? String(u) : u.toFixed(1));

function isSameDay(a: Date, b: Date) {
    return (
        a.getFullYear() === b.getFullYear() &&
        a.getMonth() === b.getMonth() &&
        a.getDate() === b.getDate()
    );
}

export default function QuickLogPage() {
    const router = useRouter();
    const [day, setDay] = useState(() => new Date());
    const [pendingDelete, setPendingDelete] = useState<DeleteTarget | null>(null);

    const {data: insulin, isLoading: insulinLoading} = useInsulinLogs();
    const {data: meals, isLoading: mealsLoading} = useMeals();
    const {deleteBolus, deleteBasal} = useInsulinMutations();
    const {deleteMeal} = useMealMutations();
    const deleting = deleteBolus.isPending || deleteBasal.isPending || deleteMeal.isPending;

    const isToday = isSameDay(day, new Date());

    const insulinForDay = useMemo(
        () => insulin.filter((e) => isSameLocalDay(e.at, day)),
        [insulin, day],
    );
    const mealsForDay = useMemo(
        () =>
            [...(meals ?? [])]
                .filter((m) => isSameLocalDay(m.timestamp, day))
                .sort((a, b) => parseBackendDate(b.timestamp).getTime() - parseBackendDate(a.timestamp).getTime()),
        [meals, day],
    );

    const bolusUnits = insulinForDay.filter((e) => e.kind === "BOLUS").reduce((s, e) => s + e.amount, 0);
    const basalUnits = insulinForDay.filter((e) => e.kind === "BASAL").reduce((s, e) => s + e.amount, 0);
    const totalUnits = bolusUnits + basalUnits;
    const totalCarbs = mealsForDay.reduce((s, m) => s + m.carbs, 0);

    const loading = insulinLoading || mealsLoading;

    const shiftDay = (delta: number) =>
        setDay((d) => {
            const n = new Date(d);
            n.setDate(n.getDate() + delta);
            return n;
        });

    const confirmDelete = async () => {
        if (!pendingDelete) return;
        try {
            if (pendingDelete.kind === "bolus") await deleteBolus.mutateAsync(pendingDelete.id);
            else if (pendingDelete.kind === "basal") await deleteBasal.mutateAsync(pendingDelete.id);
            else await deleteMeal.mutateAsync(pendingDelete.id);
            toast.success("Entry deleted.");
            setPendingDelete(null);
        } catch (e) {
            toast.error(e instanceof Error ? e.message : "Couldn't delete entry.");
        }
    };

    return (
        <div className="mx-auto flex min-h-dvh max-w-md flex-col">
            <header
                className="sticky top-0 z-10 flex items-center gap-2 border-b bg-background/90 p-4 backdrop-blur supports-backdrop-filter:bg-background/70">
                <NotebookPen className="size-5 text-primary"/>
                <h1 className="font-semibold">Quick log</h1>
                <Link
                    href="/quick-log/profile"
                    aria-label="Open profile"
                    className="ml-auto flex size-9 items-center justify-center rounded-full text-muted-foreground transition-colors hover:bg-muted hover:text-foreground"
                >
                    <User className="size-5"/>
                </Link>
            </header>

            <main className="flex flex-col gap-5 p-4">
                <GlucoseSummary/>

                <QuickLogActions/>

                {/* Day navigator */}
                <div className="flex items-center justify-between">
                    <Button variant="ghost" size="icon-sm" aria-label="Previous day" onClick={() => shiftDay(-1)}>
                        <ChevronLeft/>
                    </Button>
                    <span className="text-sm font-semibold">
                        {isToday
                            ? "Today"
                            : day.toLocaleDateString([], {weekday: "short", day: "numeric", month: "short"})}
                    </span>
                    <Button
                        variant="ghost"
                        size="icon-sm"
                        aria-label="Next day"
                        onClick={() => shiftDay(1)}
                        disabled={isToday}
                    >
                        <ChevronRight/>
                    </Button>
                </div>

                {/* Daily totals */}
                <Card className="rounded-lg">
                    <CardContent className="grid grid-cols-4 gap-2 py-1 text-center">
                        <Stat label="Bolus" value={`${fmt(bolusUnits)}u`} loading={loading}/>
                        <Stat label="Basal" value={`${fmt(basalUnits)}u`} loading={loading}/>
                        <Stat label="Total" value={`${fmt(totalUnits)}u`} loading={loading}/>
                        <Stat label="Carbs" value={`${fmt(totalCarbs)}g`} loading={loading}/>
                    </CardContent>
                </Card>

                {/* Insulin group */}
                <Card className="rounded-lg">
                    <CardContent>
                        <h2 className="text-[11px] font-bold tracking-[0.08em] text-muted-foreground uppercase">
                            Insulin
                        </h2>
                    </CardContent>
                    <CardContent>
                        {loading ? (
                            <Skeletons n={2}/>
                        ) : insulinForDay.length === 0 ? (
                            <Empty>No insulin {isToday ? "logged today" : "this day"}.</Empty>
                        ) : (
                            insulinForDay.map((entry) => (
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
                                                ? entry.mealId
                                                    ? `Meal dose · ${meals?.find((m) => m.id === entry.mealId)?.name ?? "linked meal"}`
                                                    : "Meal dose"
                                                : "Correction"
                                            : undefined
                                    }
                                    value={`${fmt(entry.amount)} u`}
                                    at={entry.at}
                                    onEdit={() =>
                                        router.push(
                                            `/quick-log/add?tab=insulin&type=${entry.kind === "BOLUS" ? "bolus" : "basal"}&id=${entry.id}`,
                                        )
                                    }
                                    onDelete={() =>
                                        setPendingDelete({
                                            kind: entry.kind === "BOLUS" ? "bolus" : "basal",
                                            id: entry.id,
                                            label: `${entry.kind === "BOLUS" ? "Bolus" : "Basal"} ${fmt(entry.amount)} u`,
                                        })
                                    }
                                />
                            ))
                        )}
                    </CardContent>
                </Card>

                {/* Meals group */}
                <Card className="rounded-lg">
                    <CardContent>
                        <h2 className="text-[11px] font-bold tracking-[0.08em] text-muted-foreground uppercase">
                            Meals
                        </h2>
                    </CardContent>
                    <CardContent>
                        {loading ? (
                            <Skeletons n={2}/>
                        ) : mealsForDay.length === 0 ? (
                            <Empty>No meals {isToday ? "logged today" : "this day"}.</Empty>
                        ) : (
                            mealsForDay.map((meal) => (
                                <LogRow
                                    key={meal.id}
                                    icon={Utensils}
                                    chipClassName="bg-accent text-accent-foreground"
                                    title={meal.name}
                                    value={`${fmt(meal.carbs)} g`}
                                    at={meal.timestamp}
                                    onEdit={() => router.push(`/quick-log/add?tab=meal&id=${meal.id}`)}
                                    onDelete={() => setPendingDelete({kind: "meal", id: meal.id, label: meal.name})}
                                />
                            ))
                        )}
                    </CardContent>
                </Card>
            </main>

            <ConfirmDialog
                open={Boolean(pendingDelete)}
                onOpenChange={(open) => {
                    if (!open) setPendingDelete(null);
                }}
                title="Delete this entry?"
                description={pendingDelete ? `“${pendingDelete.label}” will be removed permanently.` : undefined}
                onConfirm={confirmDelete}
                isPending={deleting}
            />
        </div>
    );
}

function Stat({label, value, loading}: { label: string; value: string; loading?: boolean }) {
    return (
        <div className="flex flex-col items-center gap-0.5 py-1">
            {loading ? (
                <Skeleton className="h-5 w-10 rounded"/>
            ) : (
                <span className="text-base font-bold tabular-nums text-foreground">{value}</span>
            )}
            <span className="text-[10px] font-semibold tracking-[0.06em] text-muted-foreground uppercase">{label}</span>
        </div>
    );
}

function Skeletons({n}: { n: number }) {
    return (
        <div className="flex flex-col gap-2">
            {Array.from({length: n}).map((_, i) => (
                <Skeleton key={i} className="h-12 w-full rounded-lg"/>
            ))}
        </div>
    );
}

function Empty({children}: { children: ReactNode }) {
    return <p className="py-6 text-center text-[13px] text-muted-foreground">{children}</p>;
}
