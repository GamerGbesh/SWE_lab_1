import DashboardClient from "./DashboardClient";
import { pool } from "../db"
import { cookies } from 'next/headers';
import {redirect} from "next/navigation";
import logoutUser from "@/app/dashboard/actions";


async function fetchDashboardData() {

    const coursesRes = await pool.query(
        "SELECT course_name AS Course, course_description AS Description FROM courses"
    );

    const lecturersRes = await pool.query(
        "SELECT COALESCE(lecturer_first_name, '') || ' ' || COALESCE(lecturer_last_name, '') AS Name, phone AS Phone FROM lecturers"
    );

    const studentsRes = await pool.query(
        "SELECT COALESCE(first_name, '') || ' ' || COALESCE(last_name,'') AS Name, phone AS Phone FROM studentdeets"
    );

    return {
        courses: coursesRes.rows,
        lecturers: lecturersRes.rows,
        students: studentsRes.rows,
    };
}

interface Data{
    courses: {course: string, description : string}[];
    lecturers: {name: string, phone : string}[];
    students: {name: string, phone : string}[];
}

export default async function DashboardPage() {
    const cookieStore = await cookies();

    const user = cookieStore.get("user")
    if (!user) {
        redirect("/login");
    }
    const data : Data = await fetchDashboardData();

    return <>
        <form action={logoutUser}>
            <button type={"submit"} className={"bg-blue-600 my-2 p-2 rounded-4xl shadow-2xl hover:bg-blue-800 cursor-pointer"}>Logout</button>
        </form>

        <DashboardClient data={data} />
    </>;
}
