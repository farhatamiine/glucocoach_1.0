"use client";

import type {ReactNode} from "react";
import {Info} from "lucide-react";
import {Tooltip, TooltipContent, TooltipProvider, TooltipTrigger} from "@/components/ui/tooltip";

type InfoHintProps = {
    /** Accessible label for the trigger (defaults to "What is this?"). */
    label?: string;
    children: ReactNode;
};

/** Small "?" info icon that reveals a plain-language explanation on hover/tap. */
export function InfoHint({label, children}: InfoHintProps) {
    return (
        <TooltipProvider delayDuration={100}>
            <Tooltip>
                <TooltipTrigger asChild>
                    <button
                        type="button"
                        aria-label={label ?? "What is this?"}
                        className="inline-flex text-muted-foreground/70 transition-colors hover:text-foreground focus-visible:text-foreground focus-visible:outline-none"
                    >
                        <Info className="size-3.5"/>
                    </button>
                </TooltipTrigger>
                <TooltipContent sideOffset={6} className="max-w-xs text-xs leading-relaxed">
                    {children}
                </TooltipContent>
            </Tooltip>
        </TooltipProvider>
    );
}
