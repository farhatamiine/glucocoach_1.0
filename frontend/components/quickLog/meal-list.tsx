"use client";

import {Utensils} from "lucide-react";
import {Card, CardContent} from "@/components/ui/card";
import {Skeleton} from "@/components/ui/skeleton";
import {LogRow} from "@/components/quickLog/log-row";
import {useMeals} from "@/features/logging/hooks/useMealLogs";
import type {MealResponse} from "@/features/logging/types/logging.types";

type MealListProps = {
    onEdit: (meal: MealResponse) => void;
    onDelete: (meal: MealResponse) => void;
};

export function MealList({onEdit, onDelete}: MealListProps) {
    const {data, isLoading, isError} = useMeals();
    const meals = [...(data ?? [])].sort(
        (a, b) => new Date(b.timestamp).getTime() - new Date(a.timestamp).getTime(),
    );

    return (
        <Card className="rounded-lg">
            <CardContent>
                <h2 className="text-[11px] font-bold tracking-[0.08em] text-muted-foreground uppercase">Meals</h2>
            </CardContent>
            <CardContent>
                {isLoading ? (
                    <div className="flex flex-col gap-2">
                        {[0, 1].map((i) => (
                            <Skeleton key={i} className="h-12 w-full rounded-lg"/>
                        ))}
                    </div>
                ) : isError ? (
                    <p className="py-6 text-center text-[13px] text-muted-foreground">Couldn&apos;t load meals.</p>
                ) : meals.length === 0 ? (
                    <p className="py-6 text-center text-[13px] text-muted-foreground">No meals logged yet.</p>
                ) : (
                    meals.map((meal) => (
                        <LogRow
                            key={meal.id}
                            icon={Utensils}
                            chipClassName="bg-accent text-accent-foreground"
                            title={meal.name}
                            value={`${meal.carbs} g`}
                            at={meal.timestamp}
                            onEdit={() => onEdit(meal)}
                            onDelete={() => onDelete(meal)}
                        />
                    ))
                )}
            </CardContent>
        </Card>
    );
}
