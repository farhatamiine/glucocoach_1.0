import AppSidebar from '@/components/dashboard/app-sidebar';

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
