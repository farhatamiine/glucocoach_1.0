"use client";

import {Controller, FormProvider, useForm} from "react-hook-form";
import {zodResolver} from "@hookform/resolvers/zod";
import {toast} from "sonner";
import {Utensils} from "lucide-react";
import {Field, FieldError, FieldLabel} from "@/components/ui/field";
import {Input} from "@/components/ui/input";
import {Button} from "@/components/ui/button";
import {type BolusFormValues, bolusSchema} from "@/features/logging/schemas/insulin.schema";
import {useInsulinMutations} from "@/features/logging/hooks/useInsulinLogs";
import type {InsulinLog} from "@/features/logging/types/logging.types";
import {isoToLocalInput} from "@/features/logging/datetime";
import {cn} from "@/lib/utils";

type BolusFormProps = {
    entry?: InsulinLog;
    /** Pre-link this bolus to a meal (e.g. from the post-meal prompt). */
    mealId?: number;
    /** Name of the linked meal, shown as a chip. */
    linkedMealName?: string;
    onDone: () => void;
};

export function BolusForm({entry, mealId, linkedMealName, onDone}: BolusFormProps) {
    const isEdit = Boolean(entry);
    const {createBolus, deleteBolus} = useInsulinMutations();

    const form = useForm<BolusFormValues>({
        resolver: zodResolver(bolusSchema),
        defaultValues: {
            amount: entry?.amount,
            bolusType: entry?.bolusType ?? "MEAL",
            timestamp: isoToLocalInput(entry?.at),
            mealId: entry?.mealId ?? mealId,
        },
    });

    const pending = createBolus.isPending || deleteBolus.isPending;

    const submit = async (values: BolusFormValues) => {
        try {
            // Create first so a failed edit never loses the original entry.
            await createBolus.mutateAsync(values);
            if (isEdit && entry) {
                try {
                    await deleteBolus.mutateAsync(entry.id);
                } catch {
                    toast.warning("Saved the change, but couldn't remove the old entry.");
                }
            }
            toast.success(isEdit ? "Bolus updated." : "Bolus logged.");
            onDone();
        } catch (e) {
            toast.error(e instanceof Error ? e.message : "Couldn't save bolus.");
        }
    };

    return (
        <FormProvider {...form}>
            <form onSubmit={form.handleSubmit(submit)} className="flex flex-col gap-4 px-4 pb-4">
                {linkedMealName && (
                    <div
                        className="flex items-center gap-2 rounded-lg bg-accent/60 px-3 py-2 text-xs text-accent-foreground">
                        <Utensils className="size-3.5 shrink-0"/>
                        <span className="truncate">Linked to <span
                            className="font-semibold">{linkedMealName}</span></span>
                    </div>
                )}
                <Controller
                    name="amount"
                    control={form.control}
                    render={({field, fieldState}) => (
                        <Field data-invalid={fieldState.invalid}>
                            <FieldLabel htmlFor="bolus-amount">Dose (units)</FieldLabel>
                            <Input
                                {...field}
                                id="bolus-amount"
                                type="number"
                                inputMode="decimal"
                                step="0.5"
                                placeholder="4.5"
                                value={field.value ?? ""}
                                onChange={(e) =>
                                    field.onChange(e.target.value === "" ? undefined : e.target.valueAsNumber)
                                }
                                aria-invalid={fieldState.invalid}
                            />
                            {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                        </Field>
                    )}
                />
                <Controller
                    name="bolusType"
                    control={form.control}
                    render={({field}) => (
                        <Field>
                            <FieldLabel>Type</FieldLabel>
                            <div className="inline-flex gap-0.5 rounded-lg bg-muted p-0.5">
                                {(["MEAL", "CORRECTION"] as const).map((t) => (
                                    <button
                                        key={t}
                                        type="button"
                                        onClick={() => field.onChange(t)}
                                        className={cn(
                                            "rounded-md px-3 py-1.5 text-xs font-semibold capitalize transition-all",
                                            field.value === t
                                                ? "bg-card text-foreground shadow-sm"
                                                : "text-muted-foreground",
                                        )}
                                    >
                                        {t.toLowerCase()}
                                    </button>
                                ))}
                            </div>
                        </Field>
                    )}
                />
                <Controller
                    name="timestamp"
                    control={form.control}
                    render={({field, fieldState}) => (
                        <Field data-invalid={fieldState.invalid}>
                            <FieldLabel htmlFor="bolus-time">Time</FieldLabel>
                            <Input {...field} id="bolus-time" type="datetime-local" aria-invalid={fieldState.invalid}/>
                            {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                        </Field>
                    )}
                />
                <Button type="submit" disabled={pending} className="mt-1 h-11">
                    {pending ? "Saving…" : isEdit ? "Save changes" : "Log bolus"}
                </Button>
            </form>
        </FormProvider>
    );
}
