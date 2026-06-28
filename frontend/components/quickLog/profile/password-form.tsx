"use client";

import {Controller, FormProvider, useForm} from "react-hook-form";
import {zodResolver} from "@hookform/resolvers/zod";
import {toast} from "sonner";
import {Card, CardContent, CardHeader, CardTitle} from "@/components/ui/card";
import {Field, FieldError, FieldLabel} from "@/components/ui/field";
import {Input} from "@/components/ui/input";
import {Button} from "@/components/ui/button";
import {type PasswordFormValues, passwordSchema} from "@/features/profile/schemas/password.schema";
import {useChangePassword} from "@/features/profile/hooks/useProfile";

export function PasswordForm() {
    const change = useChangePassword();

    const form = useForm<PasswordFormValues>({
        resolver: zodResolver(passwordSchema),
        defaultValues: {oldPassword: "", newPassword: "", confirmPassword: ""},
    });

    const submit = (values: PasswordFormValues) => {
        change.mutate(values, {
            onSuccess: () => {
                toast.success("Password changed.");
                form.reset({oldPassword: "", newPassword: "", confirmPassword: ""});
            },
            onError: (e) => toast.error(e instanceof Error ? e.message : "Couldn't change password."),
        });
    };

    return (
        <Card className="rounded-lg">
            <CardHeader>
                <CardTitle>Change password</CardTitle>
            </CardHeader>
            <CardContent>
                <FormProvider {...form}>
                    <form onSubmit={form.handleSubmit(submit)} className="flex flex-col gap-4">
                        <Controller
                            name="oldPassword"
                            control={form.control}
                            render={({field, fieldState}) => (
                                <Field data-invalid={fieldState.invalid}>
                                    <FieldLabel htmlFor="oldPassword">Current password</FieldLabel>
                                    <Input
                                        {...field}
                                        id="oldPassword"
                                        type="password"
                                        autoComplete="current-password"
                                        aria-invalid={fieldState.invalid}
                                    />
                                    {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                                </Field>
                            )}
                        />
                        <Controller
                            name="newPassword"
                            control={form.control}
                            render={({field, fieldState}) => (
                                <Field data-invalid={fieldState.invalid}>
                                    <FieldLabel htmlFor="newPassword">New password</FieldLabel>
                                    <Input
                                        {...field}
                                        id="newPassword"
                                        type="password"
                                        autoComplete="new-password"
                                        aria-invalid={fieldState.invalid}
                                    />
                                    {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                                </Field>
                            )}
                        />
                        <Controller
                            name="confirmPassword"
                            control={form.control}
                            render={({field, fieldState}) => (
                                <Field data-invalid={fieldState.invalid}>
                                    <FieldLabel htmlFor="confirmPassword">Confirm new password</FieldLabel>
                                    <Input
                                        {...field}
                                        id="confirmPassword"
                                        type="password"
                                        autoComplete="new-password"
                                        aria-invalid={fieldState.invalid}
                                    />
                                    {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                                </Field>
                            )}
                        />
                        <Button type="submit" disabled={change.isPending} className="mt-1 h-10 self-start px-4">
                            {change.isPending ? "Saving…" : "Update password"}
                        </Button>
                    </form>
                </FormProvider>
            </CardContent>
        </Card>
    );
}
