# Lab Report: PostgreSQL Database Development and Next.js 14 Application

## Overview

This lab consisted of two main tasks:

1. Designing and implementing a PostgreSQL relational database to manage various operations for a software system in the Computer Engineering Department.
2. Developing a Next.js 14 application with user authentication (login, register) and a protected dashboard.

---

## Task 1: PostgreSQL Database Development

### Objective

Design and implement a relational database to support the following functionalities:

1. Student Personal Information
2. Student Fees Payments
3. Course Enrollment
4. Lectures to Course Assignment
5. Lectures to TA Assignment

### Steps Undertaken

- **Database Creation**: A PostgreSQL database was created to house all the required entities.
- **Schema and Tables**: Appropriate schemas and tables were defined to reflect the data relationships and functional requirements.
- **Table Definitions**:
  - `students`
  - `fees`
  - `courses`
  - `lectures`
  - `teaching_assistants`
  - `enrollments`
  - `lecture_course_assignments`
  - `lecture_ta_assignments`
- **Sample Data Insertion**:
  - SQL insert scripts were written to populate all tables with sample data representing actual members of our class.
- **User Table**:
  - An additional `users` table was created to manage authentication data for the web application.
- **Database Function**:
  - A PostgreSQL function was implemented to compute outstanding fees for each student and return the result as a JSON array.

### Technologies Used

- PostgreSQL (latest version)
- SQL scripts for schema and data creation
- PL/pgSQL for stored procedures

---

## Task 2: Next.js 14 Web Application

### Objective

Create a Next.js 14 web application with the following features:

- User Registration
- User Login
- Protected Dashboard accessible only to logged-in users

### Steps Undertaken

- **Backend Development**:
  - A Flask-based backend was created to interact with the PostgreSQL database.
  - RESTful endpoints were defined for registration, login, and fetching dashboard data.
  - Flask was also used to handle authentication.
- **Frontend Development**:
  - A Next.js 14 application was built using the new `app/` directory structure.
  - Pages created:
    - `/register`
    - `/login`
    - `/dashboard`
  - Authentication:
    - The login and registration pages communicate with the Flask backend via API calls.
    - Upon successful login, access to the dashboard is granted.
    - Password hashing was used to ensure better security when creating an account.
  - Authorization:
    - The dashboard page is protected and only accessible if the user is authenticated.
    - The dashboard displays data retrieved from the PostgreSQL database.

### Technologies Used

- **Backend**: Python, Flask, SQLAlchemy, PostgreSQL
- **Frontend**: Next.js 14 (App Router), Tailwind CSS, React
- **Communication**: RESTful API using `axios`
- **Authentication**: Simple boolean check (Will upscale if needed)

---

## Conclusion

This lab provided hands-on experience in full-stack development, covering relational database design, backend API integration, and frontend development using Next.js. The end result is a functional system that supports user authentication and secure data display via a modern web interface.

---

## Assumptions Made

- The user model is separate from the student/lecture models for security and flexibility.
- Dummy data used reflects actual members of the class.
- Only essential features were implemented due to time constraints.

---

## Possible Improvements

- Add role-based access control (admin, student, lecturer).
- Implement unit and integration tests.
- Add pagination and filtering to the dashboard data.