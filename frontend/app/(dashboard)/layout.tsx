import AppSidebar from '@/components/dashboard/app-sidebar';
import React from "react";

export default function DashboardLayout({
                                            children,
                                        }: {
    children: React.ReactNode;
}) {
    return (
        <AppSidebar>
            {children}
        </AppSidebar>
    );
}
