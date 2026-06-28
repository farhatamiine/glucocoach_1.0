export type DiabetesType = "TYPE_1" | "TYPE_2";
export type GlucoseUnit = "MG" | "MMOL";

export interface UserResponse {
    id: number;
    firstName: string;
    lastName: string;
    birthDate: string; // YYYY-MM-DD
    email: string;
}

export interface ProfileResponse {
    id: number;
    diabetesType: DiabetesType;
    height?: number | null;
    diabetesSince?: string | null; // YYYY-MM-DD
    basalInsulinName?: string | null;
    bolusInsulinName?: string | null;
    glucoseUnit: GlucoseUnit;
    prescribedBasalDose?: number | null;
    userId: number;
}
