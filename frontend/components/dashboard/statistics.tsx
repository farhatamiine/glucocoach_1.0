import { Badge } from '@/components/ui/badge';
import { Card, CardContent } from '@/components/ui/card';
import { cn } from '@/lib/utils';
import { ActivityIcon, FlaskConical, LucideIcon, Syringe, Target } from 'lucide-react';
type StatItem = {
    title: string;
    value: string;
    percentage: string;
    icon: LucideIcon;
    isPositive?: boolean;
};

type StatisticsBlockProps = {
    secondaryStats?: StatItem[];
};

const secondaryStatsData: StatItem[] = [
    {
        title: 'GMI',
        value: '6.8%',
        percentage: 'Estimated HbA1c',
        icon: FlaskConical,
        isPositive: true,
    },
    {
        title: 'Current Glucose',
        value: '145 mg/dL',
        percentage: 'RISING',
        icon: ActivityIcon,
        isPositive: true,
    },
    {
        title: 'Time In Range',
        value: '78%',
        percentage: 'Target >70%',
        icon: Target,
        isPositive: true,
    },
    {
        title: "Today's Insulin",
        value: '32 Units',
        percentage: 'Basal + Bolus',
        icon: Syringe,
        isPositive: true,
    },
];

const StatisticsBlock = ({ secondaryStats = secondaryStatsData }: StatisticsBlockProps) => {
    return (
        <div className="grid grid-cols-12 gap-6 h-full">
            {secondaryStats.map((stat, index) => (
                <div key={index} className="col-span-12 sm:col-span-6 xl:col-span-3">
                    <Card className="py-6 ring-0 border rounded-2xl hover:bg-gray-100 hover:cursor-pointer transition-all ease-in-out">
                        <CardContent className="px-6 flex items-start justify-between">
                            <div className="flex flex-col gap-5 justify-between">
                                <div className="flex flex-col gap-1">
                                    <p className="text-lg font-medium text-card-foreground">{stat.title}</p>
                                    <div className="flex items-center gap-2">
                                        <p className="text-2xl font-medium text-card-foreground">{stat.value}</p>
                                        <Badge
                                            className={cn('font-normal text-muted-foreground', stat.isPositive !== false ? 'bg-teal-400/10' : 'bg-red-500/10')}
                                        >
                                            {stat.percentage}
                                        </Badge>
                                    </div>
                                </div>
                            </div>
                            <div className="p-3 rounded-full outline">
                                <stat.icon size={16} />
                            </div>
                        </CardContent>
                    </Card>
                </div>
            ))}
        </div>
    );
};

export default StatisticsBlock;
