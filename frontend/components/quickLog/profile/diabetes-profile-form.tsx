"use client";

import {useEffect} from "react";
import {Controller, FormProvider, useForm} from "react-hook-form";
import {zodResolver} from "@hookform/resolvers/zod";
import {toast} from "sonner";
import {Card, CardContent, CardHeader, CardTitle} from "@/components/ui/card";
import {Field, FieldError, FieldLabel} from "@/components/ui/field";
import {Input} from "@/components/ui/input";
import {Button} from "@/components/ui/button";
import {Skeleton} from "@/components/ui/skeleton";
import {Segmented} from "@/components/quickLog/segmented";
import {type ProfileFormValues, profileSchema} from "@/features/profile/schemas/profile.schema";
import {useDiabetesProfile, useSaveProfile} from "@/features/profile/hooks/useProfile";

const numberOrUndefined = (v: string) => (v === "" ? undefined : Number(v));

export function DiabetesProfileForm() {
    const {data, isLoading, isError} = useDiabetesProfile();
    const exists = Boolean(data);
    const save = useSaveProfile(exists);

    const form = useForm<ProfileFormValues>({
        resolver: zodResolver(profileSchema),
        defaultValues: {
            diabetesType: "TYPE_1",
            glucoseUnit: "MG",
            height: undefined,
            diabetesSince: "",
            basalInsulinName: "",
            bolusInsulinName: "",
            prescribedBasalDose: undefined,
        },
    });

    useEffect(() => {
        if (data) {
            form.reset({
                diabetesType: data.diabetesType ?? "TYPE_1",
                glucoseUnit: data.glucoseUnit ?? "MG",
                height: data.height ?? undefined,
                diabetesSince: data.diabetesSince ?? "",
                basalInsulinName: data.basalInsulinName ?? "",
                bolusInsulinName: data.bolusInsulinName ?? "",
                prescribedBasalDose: data.prescribedBasalDose ?? undefined,
            });
        }
    }, [data, form]);

    if (isLoading) return <Skeleton className="h-96 w-full rounded-lg"/>;

    const submit = (values: ProfileFormValues) => {
        save.mutate(values, {
            onSuccess: () => toast.success("Diabetes profile saved."),
            onError: (e) => toast.error(e instanceof Error ? e.message : "Couldn't save profile."),
        });
    };

    return (
        <Card className="rounded-lg">
            <CardHeader>
                <CardTitle>Diabetes profile</CardTitle>
            </CardHeader>
            <CardContent>
                {isError && (
                    <p className="mb-3 text-xs text-destructive">Couldn&apos;t load your profile.</p>
                )}
                <FormProvider {...form}>
                    <form onSubmit={form.handleSubmit(submit)} className="flex flex-col gap-4">
                        <Controller
                            name="diabetesType"
                            control={form.control}
                            render={({field}) => (
                                <Field>
                                    <FieldLabel>Diabetes type</FieldLabel>
                                    <Segmented
                                        value={field.value}
                                        onChange={field.onChange}
                                        options={[
                                            {value: "TYPE_1", label: "Type 1"},
                                            {value: "TYPE_2", label: "Type 2"},
                                        ]}
                                    />
                                </Field>
                            )}
                        />
                        <Controller
                            name="glucoseUnit"
                            control={form.control}
                            render={({field}) => (
                                <Field>
                                    <FieldLabel>Glucose unit</FieldLabel>
                                    <Segmented
                                        value={field.value}
                                        onChange={field.onChange}
                                        options={[
                                            {value: "MG", label: "mg/dL"},
                                            {value: "MMOL", label: "mmol/L"},
                                        ]}
                                    />
                                </Field>
                            )}
                        />
                        <Controller
                            name="diabetesSince"
                            control={form.control}
                            render={({field, fieldState}) => (
                                <Field data-invalid={fieldState.invalid}>
                                    <FieldLabel htmlFor="diabetesSince">Diagnosed since</FieldLabel>
                                    <Input {...field} id="diabetesSince" type="date"/>
                                    {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                                </Field>
                            )}
                        />
                        <Controller
                            name="height"
                            control={form.control}
                            render={({field, fieldState}) => (
                                <Field data-invalid={fieldState.invalid}>
                                    <FieldLabel htmlFor="height">Height (cm)</FieldLabel>
                                    <Input
                                        {...field}
                                        id="height"
                                        type="number"
                                        inputMode="numeric"
                                        placeholder="175"
                                        value={field.value ?? ""}
                                        onChange={(e) => field.onChange(numberOrUndefined(e.target.value))}
                                        aria-invalid={fieldState.invalid}
                                    />
                                    {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                                </Field>
                            )}
                        />
                        <Controller
                            name="basalInsulinName"
                            control={form.control}
                            render={({field}) => (
                                <Field>
                                    <FieldLabel htmlFor="basalInsulinName">Basal insulin</FieldLabel>
                                    <Input {...field} id="basalInsulinName" placeholder="e.g. Tresiba"/>
                                </Field>
                            )}
                        />
                        <Controller
                            name="bolusInsulinName"
                            control={form.control}
                            render={({field}) => (
                                <Field>
                                    <FieldLabel htmlFor="bolusInsulinName">Bolus insulin</FieldLabel>
                                    <Input {...field} id="bolusInsulinName" placeholder="e.g. NovoRapid"/>
                                </Field>
                            )}
                        />
                        <Controller
                            name="prescribedBasalDose"
                            control={form.control}
                            render={({field, fieldState}) => (
                                <Field data-invalid={fieldState.invalid}>
                                    <FieldLabel htmlFor="prescribedBasalDose">Prescribed basal dose
                                        (units/day)</FieldLabel>
                                    <Input
                                        {...field}
                                        id="prescribedBasalDose"
                                        type="number"
                                        inputMode="numeric"
                                        placeholder="20"
                                        value={field.value ?? ""}
                                        onChange={(e) => field.onChange(numberOrUndefined(e.target.value))}
                                        aria-invalid={fieldState.invalid}
                                    />
                                    {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                                </Field>
                            )}
                        />
                        <Button type="submit" disabled={save.isPending} className="mt-1 h-10 self-start px-4">
                            {save.isPending ? "Saving…" : "Save profile"}
                        </Button>
                    </form>
                </FormProvider>
            </CardContent>
        </Card>
    );
}
