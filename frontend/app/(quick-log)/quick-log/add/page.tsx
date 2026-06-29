"use client";

import {Suspense, useMemo, useState} from "react";
import Link from "next/link";
import {useRouter, useSearchParams} from "next/navigation";
import {ChevronLeft} from "lucide-react";
import {
    Dialog,
    DialogContent,
    DialogDescription,
    DialogFooter,
    DialogHeader,
    DialogTitle,
} from "@/components/ui/dialog";
import {Button} from "@/components/ui/button";
import {Segmented} from "@/components/quickLog/segmented";
import {BolusForm} from "@/components/quickLog/bolus-form";
import {BasalForm} from "@/components/quickLog/basal-form";
import {MealForm} from "@/components/quickLog/meal-form";
import {useInsulinLogs} from "@/features/logging/hooks/useInsulinLogs";
import {useMeals} from "@/features/logging/hooks/useMealLogs";
import type {MealResponse} from "@/features/logging/types/logging.types";

type Tab = "meal" | "insulin";
type InsulinType = "bolus" | "basal";

function AddEntry() {
    const router = useRouter();
    const params = useSearchParams();

    const idParam = params.get("id");
    const id = idParam ? Number(idParam) : undefined;
    const isEdit = id !== undefined && !Number.isNaN(id);

    const mealIdParam = params.get("mealId");
    const queryMealId = mealIdParam ? Number(mealIdParam) : undefined;

    const [tab, setTab] = useState<Tab>(params.get("tab") === "insulin" ? "insulin" : "meal");
    const [type, setType] = useState<InsulinType>(params.get("type") === "basal" ? "basal" : "bolus");

    const {data: insulin} = useInsulinLogs();
    const {data: meals} = useMeals();

    // Meal we should pre-link a new bolus to: the one just created, else the ?mealId= one.
    const [createdMeal, setCreatedMeal] = useState<MealResponse | undefined>();
    const [showMealPrompt, setShowMealPrompt] = useState(false);
    const linkedMeal = useMemo(
        () => createdMeal ?? (queryMealId ? meals?.find((m) => m.id === queryMealId) : undefined),
        [createdMeal, queryMealId, meals],
    );

    const back = () => router.push("/quick-log");

    // Entries being edited, resolved from the warm query caches.
    const mealEntry = isEdit && tab === "meal" ? meals?.find((m) => m.id === id) : undefined;
    const bolusEntry =
        isEdit && tab === "insulin" && type === "bolus"
            ? insulin.find((e) => e.kind === "BOLUS" && e.id === id)
            : undefined;
    const basalEntry =
        isEdit && tab === "insulin" && type === "basal"
            ? insulin.find((e) => e.kind === "BASAL" && e.id === id)
            : undefined;

    const handleMealCreated = (meal: MealResponse) => {
        setCreatedMeal(meal);
        setShowMealPrompt(true);
    };

    const startBolusForMeal = () => {
        // Programmatic close — does not fire the dialog's onOpenChange.
        setShowMealPrompt(false);
        setTab("insulin");
        setType("bolus");
        // createdMeal stays set → BolusForm receives the link.
    };

    const title = isEdit
        ? `Edit ${tab === "meal" ? "meal" : type}`
        : `Add ${tab === "meal" ? "meal" : "insulin"}`;

    return (
        <div className="mx-auto flex min-h-dvh max-w-md flex-col">
            <header
                className="sticky top-0 z-10 flex items-center gap-2 border-b bg-background/90 p-4 backdrop-blur supports-backdrop-filter:bg-background/70">
                <Link
                    href="/quick-log"
                    aria-label="Back"
                    className="-ml-1 flex size-9 items-center justify-center rounded-full text-muted-foreground transition-colors hover:bg-muted hover:text-foreground"
                >
                    <ChevronLeft className="size-5"/>
                </Link>
                <h1 className="font-semibold capitalize">{title}</h1>
            </header>

            <main className="flex flex-col gap-4 p-4">
                {!isEdit && (
                    <Segmented<Tab>
                        className="w-full"
                        value={tab}
                        onChange={setTab}
                        options={[
                            {value: "meal", label: "Meal"},
                            {value: "insulin", label: "Insulin"},
                        ]}
                    />
                )}

                {tab === "insulin" && !isEdit && (
                    <Segmented<InsulinType>
                        value={type}
                        onChange={setType}
                        options={[
                            {value: "bolus", label: "Bolus"},
                            {value: "basal", label: "Basal"},
                        ]}
                    />
                )}

                {tab === "meal" ? (
                    <MealForm
                        entry={mealEntry}
                        onCreated={isEdit ? undefined : handleMealCreated}
                        onDone={back}
                    />
                ) : type === "bolus" ? (
                    <BolusForm
                        entry={bolusEntry}
                        mealId={isEdit ? undefined : linkedMeal?.id}
                        linkedMealName={isEdit ? undefined : linkedMeal?.name}
                        onDone={back}
                    />
                ) : (
                    <BasalForm entry={basalEntry} onDone={back}/>
                )}
            </main>

            {/* Post-meal prompt: offer to log the bolus that covers the meal just saved. */}
            <Dialog open={showMealPrompt} onOpenChange={(open) => !open && back()}>
                <DialogContent className="max-w-xs rounded-lg">
                    <DialogHeader>
                        <DialogTitle>Meal logged</DialogTitle>
                        <DialogDescription>
                            Add a bolus for {createdMeal?.name}? It&apos;ll be linked to this meal.
                        </DialogDescription>
                    </DialogHeader>
                    <DialogFooter className="gap-2">
                        <Button variant="outline" className="h-9" onClick={back}>
                            Not now
                        </Button>
                        <Button className="h-9" onClick={startBolusForMeal}>
                            Add bolus
                        </Button>
                    </DialogFooter>
                </DialogContent>
            </Dialog>
        </div>
    );
}

export default function AddPage() {
    return (
        <Suspense fallback={<div className="p-4 text-sm text-muted-foreground">Loading…</div>}>
            <AddEntry/>
        </Suspense>
    );
}
