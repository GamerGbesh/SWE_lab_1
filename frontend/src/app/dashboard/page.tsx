// app/dashboard/page.tsx
import DashboardClient from "./DashboardClient";

async function fetchDashboardData() {
    const res = await fetch("http://127.0.0.1:5000/dash", { cache: "no-store" });

    if (!res.ok) throw new Error("Failed to fetch dashboard data");

    return res.json();
}

export default async function DashboardPage() {
    const data = await fetchDashboardData();


    return <DashboardClient data={data} />;
}
