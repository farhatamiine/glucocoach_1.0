'use client';

import NotificationDropdown from "@/components/shadcn-space/radix/blocks/dashboard-shell-01/notification-dropdown";
import UserDropdown from "@/components/shadcn-space/radix/blocks/dashboard-shell-01/user-dropdown";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { SidebarTrigger } from "@/components/ui/sidebar";
import { BellRing } from "lucide-react";
import { usePathname } from 'next/navigation';
import { navData } from './app-sidebar';

export function SiteHeader() {
  const pathname = usePathname();

  const getTitle = () => {
    if (pathname === '/') return 'Dashboards';
    const item = navData.find(item => item.href === pathname);
    return item?.title || 'Dashboard';
  };

  return (
    <div className="flex w-full items-center justify-between">
      <div className="flex items-center gap-2">
        <SidebarTrigger className="-ml-1 h-8 w-8 cursor-pointer" />
        <div className="ml-2">
          <h1 className="text-lg font-semibold">{getTitle()}</h1>
        </div>
      </div>
      <div className="flex items-center gap-3">
        <NotificationDropdown
          defaultOpen={false}
          align="center"
          trigger={
            <div className="rounded-full p-2 hover:bg-accent relative before:absolute before:bottom-0 before:left-1/2 before:z-10 before:w-2 before:h-2 before:rounded-full before:bg-red-500 before:top-1 cursor-pointer">
              <BellRing className="size-4" />
            </div>
          }
        />
        <UserDropdown
          defaultOpen={false}
          align="center"
          trigger={
            <div className="rounded-full">
              <Avatar className="size-8 cursor-pointer">
                <AvatarImage
                  src="https://images.shadcnspace.com/assets/profiles/user-11.jpg"
                  alt="David McMichael"
                />
                <AvatarFallback>DM</AvatarFallback>
              </Avatar>
            </div>
          }
        />
      </div>
    </div>
  );
}
