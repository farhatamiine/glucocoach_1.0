'use client';
import Logo from '@/assets/logo/logo';
import { NavMain } from '@/components/dashboard/nav-main';
import { SiteHeader } from '@/components/dashboard/site-header';
import {
    Sidebar,
    SidebarContent,
    SidebarHeader,
    SidebarMenu,
    SidebarMenuButton,
    SidebarMenuItem,
    SidebarProvider,
} from '@/components/ui/sidebar';
import Link from 'next/link';
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
    { title: 'Dashboards', icon: LayoutDashboard, href: '/' },

    // Pages Section
    { label: 'Diabetes', isSection: true },
    { title: 'Glucose Analytics', icon: Activity, href: '/glucose-analytics' },
    { title: 'Insulin', icon: Syringe, href: '/insulin' },
    { title: 'Meals', icon: Utensils, href: '/meals' },
    { title: 'Alerts', icon: Bell, href: '/alerts' },
    { title: 'Lab Results', icon: FlaskConical, href: '/lab-results' },

    // Health
    { label: 'Health', isSection: true },
    { title: 'Health Metrics', icon: HeartPulse, href: '/health-metrics' },
    { title: 'Activity & Sleep', icon: Activity, href: '/activity-sleep' },
    { title: 'Hydration', icon: Droplets, href: '/hydration' },

    //AI
    { label: 'AI', isSection: true },
    {
        title: 'AI Coach',
        icon: Brain,
        href: '/ai-coach',
    },
    {
        title: 'Meal Scanner',
        icon: ScanLine,
        href: '/meal-scanner',
    },
    {
        title: 'Insights & Patterns',
        icon: Lightbulb,
        href: '/insights-patterns',
    },
    { label: 'Reports', isSection: true },
    {
        title: 'Report',
        icon: FileText,
        href: '/report',
    },
    {
        title: 'History',
        icon: History,
        href: '/history',
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
                                <SidebarMenuButton asChild className="h-auto p-0 hover:bg-transparent">
                                    <Link href="/public" className="w-full h-full ">
                                        <Logo />
                                    </Link>
                                </SidebarMenuButton>
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
