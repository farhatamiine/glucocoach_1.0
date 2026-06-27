import {type ClassValue, clsx} from "clsx"
import {twMerge} from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
    return twMerge(clsx(inputs))
}


export enum TrendDirection {
    None = "None",
    DoubleUp = "DoubleUp",
    SingleUp = "SingleUp",
    FortyFiveUp = "FortyFiveUp",
    Flat = "Flat",
    FortyFiveDown = "FortyFiveDown",
    SingleDown = "SingleDown",
    DoubleDown = "DoubleDown",
    NotComputable = "NOT COMPUTABLE",
    RateOutOfRange = "RATE OUT OF RANGE",
}

export const TREND_CONFIG: Record<TrendDirection, { rotation: number; label: string }> = {
    [TrendDirection.DoubleUp]: {rotation: -90, label: "Rising fast"},
    [TrendDirection.SingleUp]: {rotation: -67.5, label: "Rising"},
    [TrendDirection.FortyFiveUp]: {rotation: -45, label: "Rising"},
    [TrendDirection.Flat]: {rotation: 0, label: "Steady"},
    [TrendDirection.FortyFiveDown]: {rotation: 45, label: "Falling"},
    [TrendDirection.SingleDown]: {rotation: 67.5, label: "Falling"},
    [TrendDirection.DoubleDown]: {rotation: 90, label: "Falling fast"},
    [TrendDirection.NotComputable]: {rotation: 0, label: "Unknown"},
    [TrendDirection.RateOutOfRange]: {rotation: 0, label: "Unknown"},
    [TrendDirection.None]: {rotation: 0, label: "—"},
};


export const getGlucoseTrendCardColor = (value: number) => {
    switch (true) {
        case value < 70:
            return "#e53e3e";
        case value > 70 && value < 180 :
            return "#10b981";
        case value > 180 && value < 250 :
            return "#f59e0b";
        case value > 250 :
            return "#d97706";
    }
}

export const getGlucoseTrendArrowBg = (value: number) => {
    switch (true) {
        case value <= 70:
            return "#fca5a5"; // light red
        case value > 70 && value < 180:
            return "#6ee7b7"; // light green
        case value >= 180 && value <= 250:
            return "#fcd34d"; // light amber
        case value > 250:
            return "#fdba74"; // light orange
    }
};