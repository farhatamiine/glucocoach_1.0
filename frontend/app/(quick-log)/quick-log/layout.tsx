import React from "react";

export default function QuickLogLayout({
                                           children,
                                       }: {
    children: React.ReactNode;
}) {
    return (
        <div>
            {children}
        </div>
    );
}
