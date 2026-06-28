import {z} from "zod";

export const passwordSchema = z
    .object({
        oldPassword: z.string().min(1, "Enter your current password"),
        newPassword: z.string().min(6, "At least 6 characters"),
        confirmPassword: z.string().min(1, "Confirm your new password"),
    })
    .refine((d) => d.newPassword === d.confirmPassword, {
        message: "Passwords don't match",
        path: ["confirmPassword"],
    });

export type PasswordFormValues = z.infer<typeof passwordSchema>;
