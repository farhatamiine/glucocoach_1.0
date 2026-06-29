import {useMemo} from "react";
import {useMutation, useQuery, useQueryClient} from "@tanstack/react-query";
import {
    createBasal,
    createBolus,
    deleteBasal,
    deleteBolus,
    listBasals,
    listBoluses,
} from "@/features/logging/services/insulinService";
import type {BasalResponse, BolusResponse, InsulinLog,} from "@/features/logging/types/logging.types";
import {parseBackendDate} from "@/features/logging/datetime";

const BOLUS_KEY = ["bolus"] as const;
const BASAL_KEY = ["basal"] as const;

const fromBolus = (b: BolusResponse): InsulinLog => ({
    id: b.id,
    kind: "BOLUS",
    amount: b.amount,
    at: b.timestamp,
    bolusType: b.bolusType,
    mealId: b.mealId,
});

const fromBasal = (b: BasalResponse): InsulinLog => ({
    id: b.id,
    kind: "BASAL",
    amount: b.amount,
    at: b.injectedAt,
});

/** Merged, newest-first insulin log (bolus + basal come from separate endpoints). */
export function useInsulinLogs() {
    const bolus = useQuery({queryKey: BOLUS_KEY, queryFn: listBoluses});
    const basal = useQuery({queryKey: BASAL_KEY, queryFn: listBasals});

    const data = useMemo<InsulinLog[]>(() => {
        const merged = [
            ...(bolus.data ?? []).map(fromBolus),
            ...(basal.data ?? []).map(fromBasal),
        ];
        return merged.sort((a, b) => parseBackendDate(b.at).getTime() - parseBackendDate(a.at).getTime());
    }, [bolus.data, basal.data]);

    return {
        data,
        isLoading: bolus.isLoading || basal.isLoading,
        isError: bolus.isError || basal.isError,
    };
}

/** Create/delete mutations for both insulin kinds, each invalidating its list. */
export function useInsulinMutations() {
    const qc = useQueryClient();
    const invalidate = (key: readonly unknown[]) => qc.invalidateQueries({queryKey: key});

    return {
        createBolus: useMutation({
            mutationFn: createBolus,
            onSuccess: () => invalidate(BOLUS_KEY),
        }),
        deleteBolus: useMutation({
            mutationFn: deleteBolus,
            onSuccess: () => invalidate(BOLUS_KEY),
        }),
        createBasal: useMutation({
            mutationFn: createBasal,
            onSuccess: () => invalidate(BASAL_KEY),
        }),
        deleteBasal: useMutation({
            mutationFn: deleteBasal,
            onSuccess: () => invalidate(BASAL_KEY),
        }),
    };
}
