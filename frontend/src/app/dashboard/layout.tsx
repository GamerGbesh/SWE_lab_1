"use client";
import { ReactNode } from "react";
import logoutUser from "@/app/dashboard/actions";

export default function DashboardLayout({ children }: { children: ReactNode }) {
    return (
        <div className="flex min-h-screen bg-gray-100">
            <div className="flex flex-col flex-1">
                <header className="bg-white shadow px-6 py-4 flex justify-between items-center">
                    <h1 className="text-xl font-semibold text-gray-800">Dashboard Overview</h1>
                    <form action={logoutUser}>
                        <button type={"submit"} className={"bg-blue-600 my-2 p-2 rounded-4xl shadow-2xl hover:bg-blue-800 cursor-pointer"}>Logout</button>
                    </form>
                </header>

                <main className="p-6">{children}</main>
            </div>
        </div>
    );
}
