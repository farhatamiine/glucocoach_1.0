import {z} from "zod";

/** Meal — name, carbs (grams), time. */
export const mealSchema = z.object({
    name: z.string().min(1, "Name the meal"),
    carbs: z.number({message: "Enter carbs"}).nonnegative("Carbs can't be negative"),
    timestamp: z.string().min(1, "Pick a time"),
});

export type MealFormValues = z.infer<typeof mealSchema>;
