"use client";

interface Course {
    course: string;
    description: string;
    lecturer: string;
}
interface Lecturer {
    name: string;
    phone: string;
    assistant: string;
}
interface Student {
    name: string;
    phone: string;
    paid: string;
}
interface Enrollment {
    name: string;
    course: string;
}

interface Category {
    courses: Course[];
    lecturers: Lecturer[];
    students: Student[];
    enrollments: Enrollment[];
}

export default function DashboardClient({ data, amount }: { data: Category, amount: number }) {

    return (
            <div className="max-w-6xl mx-auto">
                <TableSection
                    title="Courses"
                    headers={["Course", "Course Name", "Lecturer"]}
                    rows={data.courses.map((c) => [c.course, c.description, c.lecturer])}
                />
                <TableSection
                    title="Lecturers"
                    headers={["Name", "Phone", "Assistant"]}
                    rows={data.lecturers.map((l) => [l.name, l.phone, l.assistant])}
                />
                <TableSection
                    title="Students"
                    headers={["Name", "Phone", "Amount Paid", "Amount Left"]}
                    rows={data.students.map((s) => [s.name, s.phone, s.paid, String(amount - Number(s.paid)) ])}
                />
                <TableSection
                    title="Enrollments"
                    headers={["Name", "Course"]}
                    rows={data.enrollments.map(e => [e.name, e.course])}/>
            </div>
    );
}

function TableSection({
                          title,
                          headers,
                          rows,
                      }: {
    title: string;
    headers: string[];
    rows: string[][];
}) {
    return (
        <section className="mb-12">
            <h2 className="text-xl font-semibold mb-4">{title}</h2>
            <div className="overflow-x-auto rounded-lg border border-gray-200 shadow-sm">
                <table className="min-w-full divide-y divide-gray-200">
                    <thead className="bg-gray-100">
                    <tr>
                        {headers.map((header, idx) => (
                            <th
                                key={idx}
                                className="px-6 py-3 text-left text-sm font-medium text-gray-600 uppercase tracking-wider"
                            >
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
                                    <td
                                        key={index}
                                        className="px-6 py-4 whitespace-nowrap text-sm text-gray-700"
                                    >
                                        {cell}
                                    </td>
                                ))}
                            </tr>
                        ))
                    ) : (
                        <tr>
                            <td
                                colSpan={headers.length}
                                className="px-6 py-4 text-center text-gray-400"
                            >
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
