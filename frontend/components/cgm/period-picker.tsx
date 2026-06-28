"use client";

import {cn} from "@/lib/utils";

export type Period = string;

type PeriodPickerProps = {
    value: Period;
    onChange: (value: Period) => void;
    options?: Period[];
    className?: string;
};

/** Segmented control for the analytics time window. */
export const PeriodPicker = ({
                                 value,
                                 onChange,
                                 options = ["24h", "7d", "14d", "30d", "90d"],
                                 className,
                             }: PeriodPickerProps) => {
    return (
        <div
            role="tablist"
            className={cn("inline-flex gap-0.5 rounded-lg bg-muted p-0.5", className)}
        >
            {options.map((o) => {
                const active = o === value;
                return (
                    <button
                        key={o}
                        role="tab"
                        aria-selected={active}
                        onClick={() => onChange(o)}
                        className={cn(
                            "rounded-md px-3 py-1 text-xs font-semibold transition-all",
                            active
                                ? "bg-card text-foreground shadow-sm"
                                : "text-muted-foreground hover:text-foreground",
                        )}
                    >
                        {o}
                    </button>
                );
            })}
        </div>
    );
};
