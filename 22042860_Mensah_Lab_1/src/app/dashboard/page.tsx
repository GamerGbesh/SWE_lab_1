import DashboardClient from "./DashboardClient";
import { pool } from "../db"
import { cookies } from 'next/headers';
import {redirect} from "next/navigation";


async function fetchDashboardData() {

    const coursesRes = await pool.query(
        `SELECT course_name AS Course, course_description AS Description,
       COALESCE(lecturer_first_name, '') || ' ' || COALESCE(lecturer_last_name, '') AS Lecturer FROM courses
       JOIN lecturers ON courses.lecturer_id = lecturers.lecturer_id`
    )

    const lecturersRes = await pool.query(
        `SELECT COALESCE(lecturer_first_name, '') || ' ' || COALESCE(lecturer_last_name, '') AS Name, 
         phone AS Phone,
        COALESCE(ta_first_name, '') || ' ' || COALESCE(ta_last_name, '') AS assistant 
        FROM lecturers
        LEFT JOIN tas ON tas.lecturer_id = lecturers.lecturer_id`
    )

    const studentsRes = await pool.query(
        `SELECT COALESCE(first_name, '') || ' ' || COALESCE(last_name,'') AS Name, phone AS Phone,
         amount_paid as paid FROM studentdeets
         LEFT JOIN feespayment ON feespayment.student_id = studentdeets.student_id`
    )

    const enrollmentsRes = await pool.query(
        `SELECT COALESCE(first_name, '') || ' ' || COALESCE(last_name,'') AS Name,
        course_name as Course
        FROM studentdeets
        INNER JOIN courseenrollments on courseenrollments.student_id = studentdeets.student_id
        INNER JOIN courses ON courses.course_id = courseenrollments.course_id`
    )

    return {
        courses: coursesRes.rows,
        lecturers: lecturersRes.rows,
        students: studentsRes.rows,
        enrollments: enrollmentsRes.rows,
    };
}

interface Data{
    courses: {course: string, description : string, lecturer: string}[];
    lecturers: {name: string, phone : string, assistant: string}[];
    students: {name: string, phone : string, paid : string}[];
    enrollments: {name: string, course: string}[];
}

export default async function DashboardPage() {
    const cookieStore = await cookies();

    const user = cookieStore.get("user")
    if (!user) {
        redirect("/login");
    }
    const data : Data = await fetchDashboardData();

    return <>
        <DashboardClient data={data} amount={2000}/>
    </>;
}
