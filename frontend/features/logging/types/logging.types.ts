import type {TrendDirection} from "@/lib/utils";

/* ---- Backend response shapes (from OpenAPI: Bolus/Basal/Meal controllers) ---- */

export type BolusType = "MEAL" | "CORRECTION";

export interface BolusResponse {
    id: number;
    amount: number;
    bolusType: BolusType;
    timestamp: string; // ISO date-time
    mealId?: number | null;
    userId: number;
}

export interface BasalResponse {
    id: number;
    amount: number;
    injectedAt: string; // ISO date-time
    userId: number;
}

export interface MealResponse {
    id: number;
    name: string;
    carbs: number;
    timestamp: string; // ISO date-time
    userId: number;
    estimatedCarbs?: number | null;
}

/* ---- Unified view model for the merged insulin list ---- */

export type InsulinKind = "BOLUS" | "BASAL";

export interface InsulinLog {
    id: number;
    kind: InsulinKind;
    amount: number;
    /** timestamp (bolus) or injectedAt (basal), ISO. */
    at: string;
    bolusType?: BolusType;
    mealId?: number | null;
}

/* ---- Current glucose (from /glucose/trend — Nightscout-shaped) ---- */

export interface CurrentGlucose {
    sgv: number;
    direction: TrendDirection;
    delta: number;
    at?: string;
}
