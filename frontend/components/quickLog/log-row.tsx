"use client";

import type {LucideIcon} from "lucide-react";
import {MoreVertical, Pencil, Trash2} from "lucide-react";
import {Button} from "@/components/ui/button";
import {DropdownMenu, DropdownMenuContent, DropdownMenuItem, DropdownMenuTrigger,} from "@/components/ui/dropdown-menu";
import {cn, formatRelativeTime} from "@/lib/utils";
import {parseBackendDate} from "@/features/logging/datetime";

type LogRowProps = {
    icon: LucideIcon;
    /** Tailwind classes for the icon chip, e.g. "bg-glucose-high/10 text-glucose-high". */
    chipClassName?: string;
    title: string;
    subtitle?: string;
    value?: string;
    at: string; // ISO
    onEdit?: () => void;
    onDelete?: () => void;
};

export function LogRow({
                           icon: Icon,
                           chipClassName = "bg-muted text-muted-foreground",
                           title,
                           subtitle,
                           value,
                           at,
                           onEdit,
                           onDelete,
                       }: LogRowProps) {
    return (
        <div className="flex items-center gap-3 border-t border-divider py-2.5 first:border-t-0">
            <span className={cn("flex size-9 shrink-0 items-center justify-center rounded-lg", chipClassName)}>
                <Icon className="size-4"/>
            </span>
            <div className="min-w-0 flex-1">
                <div className="truncate text-[13px] font-semibold text-foreground">{title}</div>
                {subtitle && <div className="truncate text-xs text-muted-foreground">{subtitle}</div>}
            </div>
            {value && <div className="text-[13px] font-semibold text-foreground tabular-nums">{value}</div>}
            <time className="w-16 shrink-0 text-right font-mono text-[11px] text-muted-foreground">
                {formatRelativeTime(parseBackendDate(at))}
            </time>
            {(onEdit || onDelete) && (
                <DropdownMenu>
                    <DropdownMenuTrigger asChild>
                        <Button variant="ghost" size="icon-sm" aria-label="Entry actions">
                            <MoreVertical/>
                        </Button>
                    </DropdownMenuTrigger>
                    <DropdownMenuContent align="end" className="min-w-32">
                        {onEdit && (
                            <DropdownMenuItem onClick={onEdit}>
                                <Pencil/> Edit
                            </DropdownMenuItem>
                        )}
                        {onDelete && (
                            <DropdownMenuItem variant="destructive" onClick={onDelete}>
                                <Trash2/> Delete
                            </DropdownMenuItem>
                        )}
                    </DropdownMenuContent>
                </DropdownMenu>
            )}
        </div>
    );
}
