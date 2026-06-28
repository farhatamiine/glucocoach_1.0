"use client";

import {useEffect, useState} from "react";
import {GlucoseTrendCard} from "@/components/cgm/glucose-trend-card";
import {Skeleton} from "@/components/ui/skeleton";
import {useCurrentGlucose} from "@/features/logging/hooks/useCurrentGlucose";

export function GlucoseSummary() {
    const {data, isLoading, isError} = useCurrentGlucose();

    // Seed "now" once (lazy init), then tick each minute so "X min ago" stays live.
    const [now, setNow] = useState(() => Date.now());
    useEffect(() => {
        const id = setInterval(() => setNow(Date.now()), 60_000);
        return () => clearInterval(id);
    }, []);

    if (isLoading) {
        return <Skeleton className="h-28 w-full rounded-lg"/>;
    }

    if (isError || !data) {
        return (
            <div className="rounded-lg border border-border p-4 text-sm text-muted-foreground">
                Couldn&apos;t load your latest reading. Pull to refresh in a moment.
            </div>
        );
    }

    const minutesAgo =
        data.at && now ? Math.max(0, Math.round((now - new Date(data.at).getTime()) / 60_000)) : 0;

    return (
        <GlucoseTrendCard
            value={data.sgv}
            delta={data.delta}
            direction={data.direction}
            unit="mg/dL"
            updatedAt={minutesAgo}
        />
    );
}
