import EarningReportChart from '@/components/dashboard/earning-report-chart';
import SalesOverviewChart from '@/components/dashboard/sales-overview-chart';
import SalesByCountryWidget from '@/components/dashboard/salesbycountrywidget';
import StatisticsBlock from '@/components/dashboard/statistics';
import TopProductTable from '@/components/dashboard/top-product-table';

export default function DashboardPage() {
    return (
        <div className="grid grid-cols-12 gap-6 p-6 max-w-full mx-auto">
            <div className="col-span-12">
                <StatisticsBlock />
            </div>
            <div className="xl:col-span-8 col-span-12">
                <SalesOverviewChart />
            </div>
            <div className="xl:col-span-4 col-span-12">
                <EarningReportChart />
            </div>
            <div className="xl:col-span-8 col-span-12">
                <TopProductTable />
            </div>
            <div className="xl:col-span-4 col-span-12">
                <SalesByCountryWidget />
            </div>
        </div>
    );
}
