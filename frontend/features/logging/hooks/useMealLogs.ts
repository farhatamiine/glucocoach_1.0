import {useMutation, useQuery, useQueryClient} from "@tanstack/react-query";
import {createMeal, deleteMeal, listMeals, updateMeal,} from "@/features/logging/services/mealService";
import type {MealFormValues} from "@/features/logging/schemas/meal.schema";

const MEALS_KEY = ["meals"] as const;

export function useMeals() {
    return useQuery({queryKey: MEALS_KEY, queryFn: listMeals});
}

/** Full CRUD mutations for meals (the backend supports PUT here). */
export function useMealMutations() {
    const qc = useQueryClient();
    const invalidate = () => qc.invalidateQueries({queryKey: MEALS_KEY});

    return {
        createMeal: useMutation({
            mutationFn: createMeal,
            onSuccess: invalidate,
        }),
        updateMeal: useMutation({
            mutationFn: ({id, values}: { id: number; values: MealFormValues }) =>
                updateMeal(id, values),
            onSuccess: invalidate,
        }),
        deleteMeal: useMutation({
            mutationFn: deleteMeal,
            onSuccess: invalidate,
        }),
    };
}
