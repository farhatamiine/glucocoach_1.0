import {Card, CardContent} from "@/components/ui/card";
import {cn} from "@/lib/utils";
import {type LucideIcon} from "lucide-react";

type ActionCardProps = {
    label: string;
    icon: LucideIcon;
    color?: string;
    onClick?: () => void;
    className?: string;
};

export const ActionCard = ({label, icon: Icon, color = "currentColor", onClick, className}: ActionCardProps) => {
    const interactive = Boolean(onClick);
    return (
        <Card
            role={interactive ? "button" : undefined}
            tabIndex={interactive ? 0 : undefined}
            onClick={onClick}
            onKeyDown={
                interactive
                    ? (e) => {
                        if (e.key === "Enter" || e.key === " ") {
                            e.preventDefault();
                            onClick?.();
                        }
                    }
                    : undefined
            }
            className={cn(
                "rounded-lg",
                interactive &&
                "cursor-pointer transition-all hover:bg-muted focus-visible:ring-2 focus-visible:ring-ring focus-visible:outline-none active:translate-y-px",
                className,
            )}
        >
            {/* min-h keeps a ≥44pt touch target per the design system */}
            <CardContent className="flex min-h-11 flex-col items-center justify-center gap-1.5 py-2">
                <Icon size={20} color={color}/>
                <p className="text-sm font-medium" style={{color}}>
                    {label}
                </p>
            </CardContent>
        </Card>
    );
};
