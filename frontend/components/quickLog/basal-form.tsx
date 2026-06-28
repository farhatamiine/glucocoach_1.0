"use client";

import {Controller, FormProvider, useForm} from "react-hook-form";
import {zodResolver} from "@hookform/resolvers/zod";
import {toast} from "sonner";
import {Field, FieldError, FieldLabel} from "@/components/ui/field";
import {Input} from "@/components/ui/input";
import {Button} from "@/components/ui/button";
import {type BasalFormValues, basalSchema} from "@/features/logging/schemas/insulin.schema";
import {useInsulinMutations} from "@/features/logging/hooks/useInsulinLogs";
import type {InsulinLog} from "@/features/logging/types/logging.types";
import {isoToLocalInput} from "@/features/logging/datetime";

type BasalFormProps = {
    entry?: InsulinLog;
    onDone: () => void;
};

export function BasalForm({entry, onDone}: BasalFormProps) {
    const isEdit = Boolean(entry);
    const {createBasal, deleteBasal} = useInsulinMutations();

    const form = useForm<BasalFormValues>({
        resolver: zodResolver(basalSchema),
        defaultValues: {
            amount: entry?.amount,
            injectedAt: isoToLocalInput(entry?.at),
        },
    });

    const pending = createBasal.isPending || deleteBasal.isPending;

    const submit = async (values: BasalFormValues) => {
        try {
            await createBasal.mutateAsync(values);
            if (isEdit && entry) {
                try {
                    await deleteBasal.mutateAsync(entry.id);
                } catch {
                    toast.warning("Saved the change, but couldn't remove the old entry.");
                }
            }
            toast.success(isEdit ? "Basal updated." : "Basal logged.");
            onDone();
        } catch (e) {
            toast.error(e instanceof Error ? e.message : "Couldn't save basal.");
        }
    };

    return (
        <FormProvider {...form}>
            <form onSubmit={form.handleSubmit(submit)} className="flex flex-col gap-4 px-4 pb-4">
                <Controller
                    name="amount"
                    control={form.control}
                    render={({field, fieldState}) => (
                        <Field data-invalid={fieldState.invalid}>
                            <FieldLabel htmlFor="basal-amount">Dose (units)</FieldLabel>
                            <Input
                                {...field}
                                id="basal-amount"
                                type="number"
                                inputMode="decimal"
                                step="0.5"
                                placeholder="12"
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
                    name="injectedAt"
                    control={form.control}
                    render={({field, fieldState}) => (
                        <Field data-invalid={fieldState.invalid}>
                            <FieldLabel htmlFor="basal-time">Time</FieldLabel>
                            <Input {...field} id="basal-time" type="datetime-local" aria-invalid={fieldState.invalid}/>
                            {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                        </Field>
                    )}
                />
                <Button type="submit" disabled={pending} className="mt-1 h-11">
                    {pending ? "Saving…" : isEdit ? "Save changes" : "Log basal"}
                </Button>
            </form>
        </FormProvider>
    );
}
