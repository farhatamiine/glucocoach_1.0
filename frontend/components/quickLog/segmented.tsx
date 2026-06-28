"use client";

import {cn} from "@/lib/utils";

type SegmentedProps<T extends string> = {
    value: T;
    onChange: (value: T) => void;
    options: { value: T; label: string }[];
    className?: string;
};

/** Compact segmented control for small, mutually-exclusive choices (enums, filters). */
export function Segmented<T extends string>({value, onChange, options, className}: SegmentedProps<T>) {
    return (
        <div className={cn("inline-flex gap-0.5 rounded-lg bg-muted p-0.5", className)}>
            {options.map((o) => (
                <button
                    key={o.value}
                    type="button"
                    onClick={() => onChange(o.value)}
                    aria-pressed={value === o.value}
                    className={cn(
                        "rounded-md px-3 py-1.5 text-xs font-semibold transition-all",
                        value === o.value
                            ? "bg-card text-foreground shadow-sm"
                            : "text-muted-foreground hover:text-foreground",
                    )}
                >
                    {o.label}
                </button>
            ))}
        </div>
    );
}
