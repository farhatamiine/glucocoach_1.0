import {Card, CardContent} from "@/components/ui/card";
import {type LucideIcon} from 'lucide-react';


type ActionCardProps = {
    label: string,
    icon: LucideIcon,
    color?: string,
}

export const ActionCard = ({label, icon: Icon, color = "black"}: ActionCardProps) => {
    return (
        <Card>
            <CardContent className={"flex items-center flex-col space-y-1 justify-center"}>
                <Icon size={16} color={color}/>
                <p style={{color: color}}>{label}</p>
            </CardContent>
        </Card>
    );
};
