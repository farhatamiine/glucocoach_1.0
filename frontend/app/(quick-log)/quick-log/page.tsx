"use client"
import {NotebookPen, Syringe, Utensils} from "lucide-react";
import {ActionCard} from "@/components/quickLog/action-card";
import {GlucoseTrendCard} from "@/components/cgm/glucose-trend-card";
import {useState} from "react";
import {TrendDirection} from "@/lib/utils";

export default function QuickLogPage() {

    const [glucoseTrend] = useState({
        "sgv": 362,
        "direction": "FortyFiveUp",
        "delta": 9.3
    },);

    const direction = glucoseTrend.direction as TrendDirection;


    return (
        <div className="border">
            <div className={"flex items-center gap-2 mb-2 border-b p-6"}>
                <NotebookPen/>
                <h2 className={"font-semibold"}>Quick Log</h2>
            </div>
            <div className={"p-4"}>
                <GlucoseTrendCard value={glucoseTrend.sgv} delta={glucoseTrend.delta} unit={"mg/dL"}
                                  direction={direction} updatedAt={new Date().getMinutes()}
                />
            </div>
            <div className={"grid grid-cols-3 gap-6 p-4"}>
                <ActionCard label={"Meal"} icon={Utensils}/>
                <ActionCard label={"Bolus"} icon={Syringe} color={"#0A5D61"}/>
                <ActionCard label={"Basal"} icon={Syringe} color={"#f59e0b"}/>
            </div>
        </div>
    );
}
