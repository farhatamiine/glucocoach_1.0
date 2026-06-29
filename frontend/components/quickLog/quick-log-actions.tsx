"use client";

import {useRouter} from "next/navigation";
import {Droplet, Syringe, Utensils} from "lucide-react";
import {ActionCard} from "@/components/quickLog/action-card";

/** Entry points into the dedicated add page, with the right tab/type preselected. */
export function QuickLogActions() {
    const router = useRouter();
    const go = (query: string) => router.push(`/quick-log/add?${query}`);

    return (
        <div className="grid grid-cols-3 gap-3">
            <ActionCard label="Meal" icon={Utensils} color="var(--color-chart-1)" onClick={() => go("tab=meal")}/>
            <ActionCard
                label="Bolus"
                icon={Syringe}
                color="var(--color-glucose-high)"
                onClick={() => go("tab=insulin&type=bolus")}
            />
            <ActionCard
                label="Basal"
                icon={Droplet}
                color="var(--color-chart-5)"
                onClick={() => go("tab=insulin&type=basal")}
            />
        </div>
    );
}
