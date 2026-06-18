'use client'
import React from 'react';
import {Button} from "@/components/ui/button";
import {Card, CardContent, CardDescription, CardFooter, CardHeader, CardTitle} from "@/components/ui/card";
import {Input} from "@/components/ui/input";
import Link from "next/link";
import {Controller, FormProvider, useForm} from "react-hook-form";
import {LoginFormValues, loginSchema} from "@/features/auth/schemas/login.schema";
import useLoginForm from "@/features/auth/hooks/useLoginForm";
import {zodResolver} from "@hookform/resolvers/zod";
import {Field, FieldError, FieldLabel} from "@/components/ui/field";

const LoginForm = () => {
    const form = useForm<LoginFormValues>({
        resolver: zodResolver(loginSchema),
        defaultValues: {
            email: '',
            password: '',
        },
    });
    const {loginMutation} = useLoginForm()

    const submitLogin = async (data: LoginFormValues) => {
        loginMutation({
            email: data.email,
            password: data.password,
        }, {
            onSuccess: () => {
                console.log('Login successful')
            },
            onError: (error) => {
                form.setError('email', {
                    type: 'manual',
                    message: error.message,
                });
            }
        })
    }

    return (
        <FormProvider {...form}>
            <form onSubmit={form.handleSubmit(submitLogin)} className="space-y-4">
                <Card className="w-full">
                    <CardHeader className="space-y-1">
                        <CardTitle className="text-2xl font-bold">Login</CardTitle>
                        <CardDescription>
                            Enter your email and password to login to your account
                        </CardDescription>
                    </CardHeader>
                    <CardContent className="space-y-4">
                        <div className="space-y-2">
                            <Controller
                                name="email"
                                control={form.control}
                                render={({field, fieldState}) => (
                                    <Field data-invalid={fieldState.invalid}>
                                        <FieldLabel htmlFor={field.name}>Email</FieldLabel>
                                        <Input
                                            {...field}
                                            id={field.name}
                                            aria-invalid={fieldState.invalid}
                                            placeholder="example@email.com"
                                            autoComplete="off"
                                            required
                                        />
                                        {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                                    </Field>
                                )}
                            />
                        </div>
                        <div className="space-y-2">

                            <Controller
                                name="password"
                                control={form.control}
                                render={({field, fieldState}) => (
                                    <Field data-invalid={fieldState.invalid}>
                                        <FieldLabel htmlFor={field.name}>Password</FieldLabel>
                                        <Input
                                            {...field}
                                            id={field.name}
                                            aria-invalid={fieldState.invalid}
                                            placeholder="your password"
                                            autoComplete="off"
                                            required
                                        />
                                        {fieldState.invalid && <FieldError errors={[fieldState.error]}/>}
                                    </Field>
                                )}
                            />
                        </div>
                    </CardContent>
                    <CardFooter className="flex flex-col space-y-4">
                        <Button className="w-full">Login</Button>
                        <div className="text-center text-sm">
                            Don&apos;t have an account?{" "}
                            <Link href="/register" className="text-primary hover:underline">
                                Sign up
                            </Link>
                        </div>
                    </CardFooter>
                </Card>
            </form>
        </FormProvider>
    );
};

export default LoginForm;