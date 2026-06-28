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
import {type AccountFormValues, accountSchema} from "@/features/profile/schemas/account.schema";
import {useUpdateUser, useUser} from "@/features/profile/hooks/useProfile";

export function AccountForm() {
    const {data, isLoading, isError} = useUser();
    const update = useUpdateUser();

    const form = useForm<AccountFormValues>({
        resolver: zodResolver(accountSchema),
        defaultValues: {firstName: "", lastName: "", birthDate: ""},
    });

    useEffect(() => {
        if (data) {
            form.reset({
                firstName: data.firstName ?? "",
                lastName: data.lastName ?? "",
                birthDate: data.birthDate ?? "",
            });
        }
    }, [data, form]);

    if (isLoading) return <Skeleton className="h-56 w-full rounded-lg"/>;

    const submit = (values: AccountFormValues) => {
        update.mutate(values, {
            onSuccess: () => toast.success("Account updated."),
            onError: (e) => toast.error(e instanceof Error ? e.message : "Couldn't update account."),
        });
    };

    return (
        <Card className="rounded-lg">
            <CardHeader>
                <CardTitle>Account</CardTitle>
            </CardHeader>
            <CardContent>
                {isError && (
                    <p className="mb-3 text-xs text-destructive">Couldn&apos;t load your account details.</p>
                )}
                <FormProvider {...form}>
                    <form onSubmit={form.handleSubmit(submit)} className="flex flex-col gap-4">
                        {data?.email && (
                            <Field>
                                <FieldLabel>Email</FieldLabel>
                                <Input value={data.email} readOnly disabled/>
                            </Field>
                        )}
                        <Controller
                            name="firstName"
                            control={form.control}
                            render={({field, fieldState}) => (
                                <Field data-invalid={fieldState.invalid}>
                                    <FieldLabel htmlFor="firstName">First name</FieldLabel>
                                    <Input {...field} id="firstName" aria-invalid={fieldState.invalid}/>
                                    {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                                </Field>
                            )}
                        />
                        <Controller
                            name="lastName"
                            control={form.control}
                            render={({field, fieldState}) => (
                                <Field data-invalid={fieldState.invalid}>
                                    <FieldLabel htmlFor="lastName">Last name</FieldLabel>
                                    <Input {...field} id="lastName" aria-invalid={fieldState.invalid}/>
                                    {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                                </Field>
                            )}
                        />
                        <Controller
                            name="birthDate"
                            control={form.control}
                            render={({field, fieldState}) => (
                                <Field data-invalid={fieldState.invalid}>
                                    <FieldLabel htmlFor="birthDate">Birth date</FieldLabel>
                                    <Input {...field} id="birthDate" type="date" aria-invalid={fieldState.invalid}/>
                                    {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                                </Field>
                            )}
                        />
                        <Button type="submit" disabled={update.isPending} className="mt-1 h-10 self-start px-4">
                            {update.isPending ? "Saving…" : "Save account"}
                        </Button>
                    </form>
                </FormProvider>
            </CardContent>
        </Card>
    );
}
