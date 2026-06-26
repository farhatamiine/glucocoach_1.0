import {NotebookPen, Syringe, Utensils} from "lucide-react";
import {ActionCard} from "@/components/quickLog/action-card";

export default function QuickLogPage() {
    return (
        <div className="">
            <div className={"flex items-center gap-2 mb-2 border-b p-6"}>
                <NotebookPen/>
                <h2 className={"font-semibold"}>Quick Log</h2>
            </div>
            <div className={"grid grid-cols-3 gap-6 p-4"}>
                <ActionCard label={"Meal"} icon={Utensils}/>
                <ActionCard label={"Bolus"} icon={Syringe} color={"#0A5D61"}/>
                <ActionCard label={"Basal"} icon={Syringe} color={""}/>


            </div>
        </div>
    );
}
