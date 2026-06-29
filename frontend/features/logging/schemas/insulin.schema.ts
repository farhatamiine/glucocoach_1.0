import {z} from "zod";

/** Bolus — amount (units), type (meal/correction), time. */
export const bolusSchema = z.object({
    amount: z.number({message: "Enter a dose"}).positive("Dose must be greater than 0"),
    bolusType: z.enum(["MEAL", "CORRECTION"]),
    timestamp: z.string().min(1, "Pick a time"),
    /** Optional link to the meal this bolus covers. */
    mealId: z.number().int().positive().optional(),
});

export type BolusFormValues = z.infer<typeof bolusSchema>;

/** Basal — amount (units), time injected. */
export const basalSchema = z.object({
    amount: z.number({message: "Enter a dose"}).positive("Dose must be greater than 0"),
    injectedAt: z.string().min(1, "Pick a time"),
});

export type BasalFormValues = z.infer<typeof basalSchema>;
