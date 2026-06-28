import {useQuery} from "@tanstack/react-query";
import {getCurrentGlucose} from "@/features/logging/services/glucoseService";

/** A CGM sensor reports a new value roughly every 5 minutes. */
const SENSOR_INTERVAL_MS = 5 * 60_000;
/** Small buffer so we fetch just after a reading should have propagated. */
const PROPAGATION_BUFFER_MS = 10_000;
/** While a new reading is due/overdue, re-check this often until it lands. */
const CHASE_INTERVAL_MS = 30_000;
/** Fallback when we don't know the last reading's timestamp. */
const FALLBACK_INTERVAL_MS = 60_000;

const clamp = (v: number, min: number, max: number) => Math.min(Math.max(v, min), max);

/**
 * Current glucose, polled in step with the sensor cadence.
 *
 * Rather than a flat 1-minute poll, the next refetch is scheduled for when the next
 * SGV is actually expected (last reading + ~5 min). Once a reading is due or overdue,
 * we chase at 30s until the new value arrives — responsive when it matters, quiet when
 * nothing has changed. Keeps polling while backgrounded and refetches on focus/reconnect.
 */
export function useCurrentGlucose() {
    return useQuery({
        queryKey: ["glucose", "trend"],
        queryFn: getCurrentGlucose,
        refetchInterval: (query) => {
            const at = query.state.data?.at;
            const atMs = at ? new Date(at).getTime() : NaN;
            if (Number.isNaN(atMs)) return FALLBACK_INTERVAL_MS;

            const dueIn = atMs + SENSOR_INTERVAL_MS + PROPAGATION_BUFFER_MS - Date.now();
            // Reading due/overdue → chase fast; otherwise wait until it's expected.
            return dueIn <= CHASE_INTERVAL_MS
                ? CHASE_INTERVAL_MS
                : clamp(dueIn, CHASE_INTERVAL_MS, SENSOR_INTERVAL_MS);
        },
        refetchIntervalInBackground: true,
        refetchOnWindowFocus: true,
        refetchOnReconnect: true,
        staleTime: 0,
    });
}
