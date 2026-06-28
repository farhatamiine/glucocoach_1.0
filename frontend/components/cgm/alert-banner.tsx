"use client";

import {AlertOctagon, AlertTriangle, X} from "lucide-react";
import {Button} from "@/components/ui/button";
import {cn} from "@/lib/utils";

type AlertSeverity = "critical" | "warning";

type AlertBannerProps = {
    severity?: AlertSeverity;
    title: string;
    message?: string;
    /** Primary action, e.g. "Treat now". */
    actionLabel?: string;
    onAction?: () => void;
    onDismiss?: () => void;
    className?: string;
};

const config = {
    critical: {
        Icon: AlertOctagon,
        wrap: "border-glucose-low/30 bg-glucose-low/10 text-glucose-low shadow-[0_6px_20px_rgba(229,62,62,0.22)]",
        action: "bg-glucose-low text-white hover:bg-glucose-low/90",
    },
    warning: {
        Icon: AlertTriangle,
        wrap: "border-glucose-high/30 bg-glucose-high/10 text-glucose-high",
        action: "bg-glucose-high text-white hover:bg-glucose-high/90",
    },
} satisfies Record<AlertSeverity, { Icon: typeof AlertOctagon; wrap: string; action: string }>;

/**
 * Active, must-act alert. The design pins critical alerts to the top of the screen,
 * unscrollable — render this above scrollable content (e.g. sticky top-0). Red is
 * reserved for hypoglycemia; high readings use the warning severity.
 */
export const AlertBanner = ({
                                severity = "critical",
                                title,
                                message,
                                actionLabel,
                                onAction,
                                onDismiss,
                                className,
                            }: AlertBannerProps) => {
    const {Icon, wrap, action} = config[severity];
    return (
        <div
            role="alert"
            className={cn(
                "flex items-center gap-3 rounded-lg border px-4 py-3",
                wrap,
                className,
            )}
        >
            <Icon className="size-5 shrink-0" aria-hidden/>
            <div className="flex-1 min-w-0">
                <div className="text-sm font-bold tabular-nums">{title}</div>
                {message && <div className="text-xs font-medium opacity-90">{message}</div>}
            </div>
            {actionLabel && (
                <Button size="sm" className={cn("h-8 shrink-0", action)} onClick={onAction}>
                    {actionLabel}
                </Button>
            )}
            {onDismiss && (
                <button
                    type="button"
                    onClick={onDismiss}
                    aria-label="Dismiss alert"
                    className="shrink-0 rounded-md p-1 opacity-70 transition-opacity hover:opacity-100"
                >
                    <X className="size-4"/>
                </button>
            )}
        </div>
    );
};
