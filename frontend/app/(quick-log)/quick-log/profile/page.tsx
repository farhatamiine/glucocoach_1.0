import Link from "next/link";
import {ArrowLeft} from "lucide-react";
import {AccountForm} from "@/components/quickLog/profile/account-form";
import {DiabetesProfileForm} from "@/components/quickLog/profile/diabetes-profile-form";
import {PasswordForm} from "@/components/quickLog/profile/password-form";

export default function ProfilePage() {
    return (
        <div className="mx-auto flex min-h-dvh max-w-md flex-col">
            <header
                className="sticky top-0 z-10 flex items-center gap-2 border-b bg-background/90 p-4 backdrop-blur supports-backdrop-filter:bg-background/70">
                <Link
                    href="/quick-log"
                    aria-label="Back to quick log"
                    className="-ml-1 rounded-md p-1 text-muted-foreground transition-colors hover:text-foreground"
                >
                    <ArrowLeft className="size-5"/>
                </Link>
                <h1 className="font-semibold">Profile</h1>
            </header>

            <main className="flex flex-col gap-5 p-4">
                <AccountForm/>
                <DiabetesProfileForm/>
                <PasswordForm/>
            </main>
        </div>
    );
}
