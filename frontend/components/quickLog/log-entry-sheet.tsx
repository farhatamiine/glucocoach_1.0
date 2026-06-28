"use client";

import {Sheet, SheetContent, SheetDescription, SheetHeader, SheetTitle,} from "@/components/ui/sheet";
import {BolusForm} from "@/components/quickLog/bolus-form";
import {BasalForm} from "@/components/quickLog/basal-form";
import {MealForm} from "@/components/quickLog/meal-form";
import type {InsulinLog, MealResponse} from "@/features/logging/types/logging.types";

export type SheetTarget =
    | { kind: "bolus"; entry?: InsulinLog }
    | { kind: "basal"; entry?: InsulinLog }
    | { kind: "meal"; entry?: MealResponse };

const COPY: Record<SheetTarget["kind"], { noun: string; hint: string }> = {
    bolus: {noun: "bolus", hint: "Rapid insulin for a meal or correction."},
    basal: {noun: "basal", hint: "Your long-acting background insulin."},
    meal: {noun: "meal", hint: "What you ate and the carbs it contained."},
};

type LogEntrySheetProps = {
    target: SheetTarget | null;
    onOpenChange: (open: boolean) => void;
};

export function LogEntrySheet({target, onOpenChange}: LogEntrySheetProps) {
    const isEdit = Boolean(target?.entry);
    const close = () => onOpenChange(false);

    return (
        <Sheet open={Boolean(target)} onOpenChange={onOpenChange}>
            <SheetContent side="bottom" className="mx-auto max-w-md rounded-t-2xl pb-[env(safe-area-inset-bottom)]">
                {target && (
                    <>
                        <SheetHeader>
                            <SheetTitle className="capitalize">
                                {isEdit ? "Edit" : "Add"} {COPY[target.kind].noun}
                            </SheetTitle>
                            <SheetDescription>{COPY[target.kind].hint}</SheetDescription>
                        </SheetHeader>
                        {target.kind === "bolus" && <BolusForm entry={target.entry} onDone={close}/>}
                        {target.kind === "basal" && <BasalForm entry={target.entry} onDone={close}/>}
                        {target.kind === "meal" && <MealForm entry={target.entry} onDone={close}/>}
                    </>
                )}
            </SheetContent>
        </Sheet>
    );
}
