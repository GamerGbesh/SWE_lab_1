-- Insert into studentDeets (based on Excel data)
INSERT INTO studentDeets ( first_name, last_name, email, phone) VALUES
('Ama', 'Mensah', 'ama.mensah@example.com', 233237),
('Kwame', 'Boakye', 'kwame.boakye@example.com', 276543),
('Esi', 'Owusu', 'esi.owusu@example.com', 2332632),
('Yaw', 'Kwarteng', 'yaw.kwarteng@example.com', 254321);

-- Insert dummy lecturers
INSERT INTO lecturers (lecturer_first_name, lecturer_last_name, email, phone) VALUES
('John', 'Doe', 'john.doe@university.edu', 23322),
('Grace', 'Adjei', 'grace.adjei@university.edu', 23877);

-- Insert dummy courses
INSERT INTO courses (course_name, course_description, lecturer_id) VALUES
('CPEN 101', 'Introduction to Computer Engineering', 1),
('CPEN 102', 'Digital Systems', 1),
('CPEN 201', 'Microprocessors', 2);

-- Insert dummy courseEnrollments (mapping students to courses)
INSERT INTO courseEnrollments (student_id, course_id) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 2),
(4, 1),
(4, 3);

-- Insert dummy payments
INSERT INTO feesPayment (student_id, amount_paid) VALUES
(1, 1500.00),
(2, 1400.00),
(3, 1600.00),
(4, 1350.00);

-- Insert dummy TAs
INSERT INTO TAs (ta_first_name, ta_last_name, ta_email, ta_phone, lecturer_id) VALUES
('Kofi', 'Asare', 'kofi.asare@university.edu', 233230, 1),
('Akua', 'Mensimah', 'akua.mensimah@university.edu', 23320, 2);
