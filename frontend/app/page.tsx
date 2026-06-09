import AppSidebar from '@/components/shadcn-space/radix/blocks/dashboard-shell-01/app-sidebar';
import SalesOverviewChart from '@/components/shadcn-space/radix/blocks/dashboard-shell-01/sales-overview-chart';
import StatisticsBlock from '@/components/shadcn-space/radix/blocks/dashboard-shell-01/statistics';

export default function Home() {
    return (
        <AppSidebar>
            <div className="grid grid-cols-12 gap-6 p-6 max-w-7xl mx-auto">
                <div className="col-span-12">
                    <StatisticsBlock />
                </div>
                <div className="xl:col-span-8 col-span-12">
                    <SalesOverviewChart />
                </div>
            </div>
        </AppSidebar>
    );
}
