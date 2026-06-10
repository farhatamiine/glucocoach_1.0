import AppSidebar from '@/components/shadcn-space/radix/blocks/dashboard-shell-01/app-sidebar';

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
