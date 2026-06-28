import {request} from "@/features/logging/services/client";
import type {MealResponse} from "@/features/logging/types/logging.types";
import type {MealFormValues} from "@/features/logging/schemas/meal.schema";
import {localInputToIso} from "@/features/logging/datetime";

function toPayload(values: MealFormValues) {
    return JSON.stringify({
        name: values.name,
        carbs: values.carbs,
        timestamp: localInputToIso(values.timestamp),
    });
}

export function listMeals() {
    return request<MealResponse[]>("/api/meals");
}

export function createMeal(values: MealFormValues) {
    return request<MealResponse>("/api/meals", {method: "POST", body: toPayload(values)});
}

export function updateMeal(id: number, values: MealFormValues) {
    return request<MealResponse>(`/api/meals/${id}`, {method: "PUT", body: toPayload(values)});
}

export function deleteMeal(id: number) {
    return request<void>(`/api/meals/${id}`, {method: "DELETE"});
}
