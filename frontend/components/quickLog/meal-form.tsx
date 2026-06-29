"use client";

import {Controller, FormProvider, useForm} from "react-hook-form";
import {zodResolver} from "@hookform/resolvers/zod";
import {toast} from "sonner";
import {Field, FieldError, FieldLabel} from "@/components/ui/field";
import {Input} from "@/components/ui/input";
import {Button} from "@/components/ui/button";
import {type MealFormValues, mealSchema} from "@/features/logging/schemas/meal.schema";
import {useMealMutations} from "@/features/logging/hooks/useMealLogs";
import type {MealResponse} from "@/features/logging/types/logging.types";
import {isoToLocalInput} from "@/features/logging/datetime";

type MealFormProps = {
    entry?: MealResponse;
    /** Called with the new meal after a successful create (not edit). */
    onCreated?: (meal: MealResponse) => void;
    onDone: () => void;
};

export function MealForm({entry, onCreated, onDone}: MealFormProps) {
    const isEdit = Boolean(entry);
    const {createMeal, updateMeal} = useMealMutations();

    const form = useForm<MealFormValues>({
        resolver: zodResolver(mealSchema),
        defaultValues: {
            name: entry?.name ?? "",
            carbs: entry?.carbs,
            timestamp: isoToLocalInput(entry?.timestamp),
        },
    });

    const pending = createMeal.isPending || updateMeal.isPending;

    const submit = async (values: MealFormValues) => {
        try {
            if (isEdit && entry) {
                await updateMeal.mutateAsync({id: entry.id, values});
                toast.success("Meal updated.");
                onDone();
            } else {
                const created = await createMeal.mutateAsync(values);
                toast.success("Meal logged.");
                if (onCreated) onCreated(created);
                else onDone();
            }
        } catch (e) {
            toast.error(e instanceof Error ? e.message : "Couldn't save meal.");
        }
    };

    return (
        <FormProvider {...form}>
            <form onSubmit={form.handleSubmit(submit)} className="flex flex-col gap-4 px-4 pb-4">
                <Controller
                    name="name"
                    control={form.control}
                    render={({field, fieldState}) => (
                        <Field data-invalid={fieldState.invalid}>
                            <FieldLabel htmlFor="meal-name">Meal</FieldLabel>
                            <Input
                                {...field}
                                id="meal-name"
                                placeholder="Oatmeal + berries"
                                aria-invalid={fieldState.invalid}
                            />
                            {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                        </Field>
                    )}
                />
                <Controller
                    name="carbs"
                    control={form.control}
                    render={({field, fieldState}) => (
                        <Field data-invalid={fieldState.invalid}>
                            <FieldLabel htmlFor="meal-carbs">Carbs (grams)</FieldLabel>
                            <Input
                                {...field}
                                id="meal-carbs"
                                type="number"
                                inputMode="numeric"
                                step="1"
                                placeholder="45"
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
                    name="timestamp"
                    control={form.control}
                    render={({field, fieldState}) => (
                        <Field data-invalid={fieldState.invalid}>
                            <FieldLabel htmlFor="meal-time">Time</FieldLabel>
                            <Input {...field} id="meal-time" type="datetime-local" aria-invalid={fieldState.invalid}/>
                            {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                        </Field>
                    )}
                />
                <Button type="submit" disabled={pending} className="mt-1 h-11">
                    {pending ? "Saving…" : isEdit ? "Save changes" : "Log meal"}
                </Button>
            </form>
        </FormProvider>
    );
}
