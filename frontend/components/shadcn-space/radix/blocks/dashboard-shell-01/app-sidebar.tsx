'use client';
import Logo from '@/assets/logo/logo';
import { NavMain } from '@/components/shadcn-space/radix/blocks/dashboard-shell-01/nav-main';
import { SiteHeader } from '@/components/shadcn-space/radix/blocks/dashboard-shell-01/site-header';
import { Sidebar, SidebarContent, SidebarHeader, SidebarMenu, SidebarMenuItem, SidebarProvider } from '@/components/ui/sidebar';
import { AlignStartVertical, BarChart3, CircleUserRound, ClipboardList, LucideIcon, Notebook, NotepadText, Table, Ticket } from 'lucide-react';
import React from 'react';
import SimpleBar from 'simplebar-react';
import 'simplebar-react/dist/simplebar.min.css';

export type NavItem = {
    label?: string;
    isSection?: boolean;
    title?: string;
    icon?: LucideIcon;
    href?: string;
    children?: NavItem[];
    isActive?: boolean;
};

export const navData: NavItem[] = [
    // Dashboards Section

    { label: 'Dashboard', isSection: true },
    { title: 'Dashboards', icon: BarChart3, href: '#', isActive: true },

    // Pages Section
    { label: 'Diabetes', isSection: true },
    { title: 'Glucose Analytics', icon: Table, href: '#' },
    { title: 'Insulin', icon: ClipboardList, href: '#' },
    { title: 'Meals', icon: CircleUserRound, href: '#' },
    { title: 'Alerts', icon: CircleUserRound, href: '#' },
    { title: 'Lab Results', icon: CircleUserRound, href: '#' },

    // Health
    { label: 'Health', isSection: true },
    { title: 'Health Metrics', icon: Notebook, href: '#' },
    { title: 'Activity & Sleep', icon: Ticket, href: '#' },
    { title: 'Hydration', icon: Ticket, href: '#' },

    //AI
    { label: 'AI', isSection: true },
    {
        title: 'AI Coach',
        icon: NotepadText,
    },
    {
        title: 'Meal Scanner',
        icon: AlignStartVertical,
    },
    {
        title: 'Insights & Patterns',
        icon: AlignStartVertical,
    },
    { label: 'Reports', isSection: true },
    {
        title: 'Report',
        icon: AlignStartVertical,
    },
    {
        title: 'History ',
        icon: AlignStartVertical,
    },
];

/* -------------------------------------------------------------------------- */
/*                                   Page                                     */
/* -------------------------------------------------------------------------- */

const AppSidebar = ({ children }: { children: React.ReactNode }) => {
    return (
        <SidebarProvider>
            <Sidebar className="py-4 px-0 bg-background">
                <div className="flex flex-col gap-6 bg-background">
                    {/* ---------------- Header ---------------- */}
                    <SidebarHeader className="py-0 px-4">
                        <SidebarMenu>
                            <SidebarMenuItem>
                                <a href="#" className="w-full h-full">
                                    <Logo widj />
                                </a>
                            </SidebarMenuItem>
                        </SidebarMenu>
                    </SidebarHeader>

                    {/* ---------------- Content ---------------- */}
                    <SidebarContent className="overflow-hidden gap-0 px-0">
                        <SimpleBar autoHide={true} className="h-[calc(100vh-348px)] ">
                            <div className="px-4">
                                <NavMain items={navData} />
                            </div>
                        </SimpleBar>
                    </SidebarContent>
                </div>
            </Sidebar>

            {/* ---------------- Main ---------------- */}
            <div className="flex flex-1 flex-col">
                <header className="sticky top-0 z-50 flex items-center border-b px-6 py-3 bg-background">
                    <SiteHeader />
                </header>
                <main className="flex-1">{children}</main>
            </div>
        </SidebarProvider>
    );
};

export default AppSidebar;
