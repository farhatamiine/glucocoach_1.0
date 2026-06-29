import {useQuery} from "@tanstack/react-query";
import {getGlucoseSummary} from "@/features/analytics/services/analyticsService";

/** Aggregate glucose analytics for the given window (days). */
export function useGlucoseSummary(days: number) {
    return useQuery({
        queryKey: ["glucose", "summary", days],
        queryFn: () => getGlucoseSummary(days),
        staleTime: 5 * 60_000,
    });
}
