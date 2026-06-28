"use client";

import {useState} from "react";
import Link from "next/link";
import {NotebookPen, User} from "lucide-react";
import {toast} from "sonner";
import {GlucoseSummary} from "@/components/quickLog/glucose-summary";
import {QuickLogActions} from "@/components/quickLog/quick-log-actions";
import {InsulinList} from "@/components/quickLog/insulin-list";
import {MealList} from "@/components/quickLog/meal-list";
import {LogEntrySheet, type SheetTarget} from "@/components/quickLog/log-entry-sheet";
import {ConfirmDialog} from "@/components/quickLog/confirm-dialog";
import {useInsulinMutations} from "@/features/logging/hooks/useInsulinLogs";
import {useMealMutations} from "@/features/logging/hooks/useMealLogs";

type DeleteTarget = { kind: "bolus" | "basal" | "meal"; id: number; label: string };

export default function QuickLogPage() {
    const [sheet, setSheet] = useState<SheetTarget | null>(null);
    const [pendingDelete, setPendingDelete] = useState<DeleteTarget | null>(null);

    const {deleteBolus, deleteBasal} = useInsulinMutations();
    const {deleteMeal} = useMealMutations();
    const deleting = deleteBolus.isPending || deleteBasal.isPending || deleteMeal.isPending;

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

                <QuickLogActions onSelect={(kind) => setSheet({kind})}/>

                <InsulinList
                    onEdit={(entry) =>
                        setSheet({kind: entry.kind === "BOLUS" ? "bolus" : "basal", entry})
                    }
                    onDelete={(entry) =>
                        setPendingDelete({
                            kind: entry.kind === "BOLUS" ? "bolus" : "basal",
                            id: entry.id,
                            label: `${entry.kind === "BOLUS" ? "Bolus" : "Basal"} ${entry.amount} u`,
                        })
                    }
                />

                <MealList
                    onEdit={(meal) => setSheet({kind: "meal", entry: meal})}
                    onDelete={(meal) =>
                        setPendingDelete({kind: "meal", id: meal.id, label: meal.name})
                    }
                />
            </main>

            <LogEntrySheet
                target={sheet}
                onOpenChange={(open) => {
                    if (!open) setSheet(null);
                }}
            />

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
