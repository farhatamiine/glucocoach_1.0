import {z} from "zod";

/** Diabetes profile. Only type + unit are required by the backend; the rest are optional. */
export const profileSchema = z.object({
    diabetesType: z.enum(["TYPE_1", "TYPE_2"]),
    glucoseUnit: z.enum(["MG", "MMOL"]),
    height: z.number({message: "Enter a number"}).int().positive("Must be positive").optional(),
    diabetesSince: z.string().optional(),
    basalInsulinName: z.string().optional(),
    bolusInsulinName: z.string().optional(),
    prescribedBasalDose: z.number({message: "Enter a number"}).int().nonnegative("Can't be negative").optional(),
});

export type ProfileFormValues = z.infer<typeof profileSchema>;
