import {Card, CardContent} from "@/components/ui/card";
import {Trend} from "@/components/cgm/trend";
import {getGlucoseTrendArrowBg, getGlucoseTrendCardColor, TrendDirection} from "@/lib/utils";

type GlucoseTrendCardProps = {
    unit?: string,
    value: number,
    updatedAt: number,
    delta: number,
    status?: string,
    direction: TrendDirection,
};

export const GlucoseTrendCard = ({value, delta, direction, unit, updatedAt}: GlucoseTrendCardProps) => {
    const bgColor = getGlucoseTrendCardColor(value);
    const bgArrowColor = getGlucoseTrendArrowBg(value);
    return (
        <Card className={"rounded-sm"} style={{backgroundColor: `${bgColor}`}}>
            <CardContent>
                <div className={"flex justify-between gap-2 items-center"}>
                    <div>
                        <h2 className={"uppercase text-secondary font-bold"}>Current Glucose</h2>
                        <div className={"flex items-end gap-2"}>
                            <h2 className={"uppercase text-4xl md:text-6xl text-secondary font-semibold md:font-bold"}>{value}</h2>
                            <span className={"pb-0 font-semibold text-secondary"}>{unit}</span>
                        </div>
                        <div>
                            <p className={"text-secondary"}>Updated {updatedAt} min ago</p>
                        </div>
                    </div>
                    <div>
                        <Trend delta={delta} direction={direction} bgColor={bgArrowColor || ""}/>
                    </div>
                </div>
            </CardContent>
        </Card>
    );
};
