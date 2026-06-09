'use client';
import Logo from '@/assets/logo/logo';
import { NavMain } from '@/components/shadcn-space/radix/blocks/dashboard-shell-01/nav-main';
import { SiteHeader } from '@/components/shadcn-space/radix/blocks/dashboard-shell-01/site-header';
import { Sidebar, SidebarContent, SidebarHeader, SidebarMenu, SidebarMenuItem, SidebarProvider } from '@/components/ui/sidebar';
import {
    Activity,
    Bell,
    Brain,
    Droplets,
    FileText,
    FlaskConical,
    HeartPulse,
    History,
    LayoutDashboard,
    Lightbulb,
    LucideIcon,
    ScanLine,
    Syringe,
    Utensils,
} from 'lucide-react';
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
    { title: 'Dashboards', icon: LayoutDashboard, href: '#', isActive: true },

    // Pages Section
    { label: 'Diabetes', isSection: true },
    { title: 'Glucose Analytics', icon: Activity, href: '#' },
    { title: 'Insulin', icon: Syringe, href: '#' },
    { title: 'Meals', icon: Utensils, href: '#' },
    { title: 'Alerts', icon: Bell, href: '#' },
    { title: 'Lab Results', icon: FlaskConical, href: '#' },

    // Health
    { label: 'Health', isSection: true },
    { title: 'Health Metrics', icon: HeartPulse, href: '#' },
    { title: 'Activity & Sleep', icon: Activity, href: '#' },
    { title: 'Hydration', icon: Droplets, href: '#' },

    //AI
    { label: 'AI', isSection: true },
    {
        title: 'AI Coach',
        icon: Brain,
    },
    {
        title: 'Meal Scanner',
        icon: ScanLine,
    },
    {
        title: 'Insights & Patterns',
        icon: Lightbulb,
    },
    { label: 'Reports', isSection: true },
    {
        title: 'Report',
        icon: FileText,
    },
    {
        title: 'History ',
        icon: History,
    },
];

/* -------------------------------------------------------------------------- */
/*                                   Page                                     */
/* -------------------------------------------------------------------------- */

const AppSidebar = ({ children }: { children: React.ReactNode }) => {
    return (
        <SidebarProvider>
            <Sidebar className="py-4 px-0 bg-background ">
                <div className="flex flex-col gap-6 bg-background ">
                    {/* ---------------- Header ---------------- */}
                    <SidebarHeader className="py-0 px-4">
                        <SidebarMenu>
                            <SidebarMenuItem>
                                <a href="#" className="w-full h-full ">
                                    <Logo />
                                </a>
                            </SidebarMenuItem>
                        </SidebarMenu>
                    </SidebarHeader>

                    {/* ---------------- Content ---------------- */}
                    <SidebarContent className="overflow-hidden gap-0 px-0">
                        <SimpleBar autoHide={true}>
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
