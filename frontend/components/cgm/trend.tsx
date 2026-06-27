import {ArrowRight} from "lucide-react";
import {TREND_CONFIG, TrendDirection} from "@/lib/utils";

type trendProps = {
    direction: TrendDirection
    delta: number,
    bgColor: string
}
export const Trend = ({direction, delta, bgColor}: trendProps) => {
    const config = TREND_CONFIG[direction];
    return (
        <div className={"flex items-end flex-col gap-2"}>
            <div className={"rounded-full w-12 h-12 items-center justify-center flex"}
                 style={{backgroundColor: `${bgColor}`}}>
                <ArrowRight style={{transform: `rotate(${config.rotation}deg)`}} color={"white"}/>
            </div>
            <p className={"text-white gap-3 font-semibold text-sm space-x-2"}>
                <span>{config.label}</span>
                <span>{delta > 0 ? '+' : ''}{delta}/min</span>
            </p>
        </div>
    );
};
