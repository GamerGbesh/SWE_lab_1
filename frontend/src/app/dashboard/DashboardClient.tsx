"use client";

import { useAuthContext } from "@/app/context/AuthContext";
import { useRouter } from "next/navigation";
import { useEffect } from "react";

interface Course {
    course: string;
    description: string;
}
interface Lecturer {
    name: string;
    phone: string;
}
interface Student {
    name: string;
    phone: string;
}
interface Category {
    courses: Course[];
    lecturers: Lecturer[];
    students: Student[];
}

export default function DashboardClient({ data }: { data: Category }) {
    const { user } = useAuthContext();
    const router = useRouter();

    // useEffect(() => {
    //     if (!user) router.push("/login");
    // }, [user, router]);

    // if (!user) return null;

    return (
        <div className="max-w-6xl mx-auto px-4 py-8">
            <h1 className="text-3xl font-bold mb-8 text-center">Dashboard</h1>

            <TableSection title="Courses" headers={["Course", "Description"]} rows={data.courses.map(c => [c.course, c.description])} />
            <TableSection title="Lecturers" headers={["Name", "Phone"]} rows={data.lecturers.map(l => [l.name, l.phone])} />
            <TableSection title="Students" headers={["Name", "Phone"]} rows={data.students.map(s => [s.name, s.phone])} />
        </div>
    );
}

function TableSection({ title, headers, rows }: { title: string; headers: string[]; rows: string[][] }) {
    return (
        <section className="mb-12">
            <h2 className="text-xl font-semibold mb-4">{title}</h2>
            <div className="overflow-x-auto rounded-lg border border-gray-200 shadow-sm">
                <table className="min-w-full divide-y divide-gray-200">
                    <thead className="bg-gray-100">
                    <tr>
                        {headers.map((header, idx) => (
                            <th key={idx} className="px-6 py-3 text-left text-sm font-medium text-gray-600 uppercase tracking-wider">
                                {header}
                            </th>
                        ))}
                    </tr>
                    </thead>
                    <tbody className="bg-white divide-y divide-gray-100">
                    {rows.length > 0 ? (
                        rows.map((row, idx) => (
                            <tr key={idx} className="hover:bg-gray-50 odd:bg-gray-50">
                                {row.map((cell, index) => (
                                    <td key={index} className="px-6 py-4 whitespace-nowrap text-sm text-gray-700">
                                        {cell}
                                    </td>
                                ))}
                            </tr>
                        ))
                    ) : (
                        <tr>
                            <td colSpan={headers.length} className="px-6 py-4 text-center text-gray-400">
                                No data available
                            </td>
                        </tr>
                    )}
                    </tbody>
                </table>
            </div>
        </section>
    );
}
