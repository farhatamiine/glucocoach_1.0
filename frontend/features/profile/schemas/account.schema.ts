import {z} from "zod";

/** Editable account fields (email is read-only — not part of UserRequest). */
export const accountSchema = z.object({
    firstName: z.string().min(1, "Enter your first name"),
    lastName: z.string().min(1, "Enter your last name"),
    birthDate: z.string().min(1, "Pick your birth date"),
});

export type AccountFormValues = z.infer<typeof accountSchema>;
