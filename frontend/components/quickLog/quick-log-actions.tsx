"use client";

import {Droplet, Syringe, Utensils} from "lucide-react";
import {ActionCard} from "@/components/quickLog/action-card";

type QuickLogActionsProps = {
    onSelect: (kind: "meal" | "bolus" | "basal") => void;
};

export function QuickLogActions({onSelect}: QuickLogActionsProps) {
    return (
        <div className="grid grid-cols-3 gap-3">
            <ActionCard label="Meal" icon={Utensils} color="var(--color-chart-1)" onClick={() => onSelect("meal")}/>
            <ActionCard
                label="Bolus"
                icon={Syringe}
                color="var(--color-glucose-high)"
                onClick={() => onSelect("bolus")}
            />
            <ActionCard label="Basal" icon={Droplet} color="var(--color-chart-5)" onClick={() => onSelect("basal")}/>
        </div>
    );
}
