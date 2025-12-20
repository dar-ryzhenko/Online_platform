CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    full_name  TEXT NOT NULL,
    city       TEXT,
    reg_date   DATE
);

CREATE TABLE instructors (
    instructor_id SERIAL PRIMARY KEY,
    full_name     TEXT NOT NULL,
    specialization TEXT
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name TEXT NOT NULL,
    category    TEXT,
    instructor_id INT REFERENCES instructors(instructor_id)
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id  INT REFERENCES courses(course_id),
    enroll_date DATE
);

CREATE TABLE progress (
    progress_id SERIAL PRIMARY KEY,
    enrollment_id INT REFERENCES enrollments(enrollment_id),
    lesson_number INT,
    score NUMERIC(5,2),     -- оцінка за урок
    completed BOOLEAN
);

INSERT INTO students (full_name, city, reg_date) VALUES
('Anna Kovalenko', 'Kyiv', '2024-01-12'),
('Dmytro Shevchenko', 'Lviv', '2024-02-05'),
('Olena Bondar', 'Kharkiv', '2024-03-18'),
('Serhii Melnyk', 'Odesa', '2024-01-25'),
('Iryna Tkachenko', 'Dnipro', '2024-04-02'),
('Maksym Horbunov', 'Kyiv', '2024-02-20'),
('Kateryna Polishchuk', 'Lviv', '2024-03-01'),
('Yurii Kravets', 'Kharkiv', '2024-03-22'),
('Sofiia Levchenko', 'Odesa', '2024-04-10'),
('Vladyslav Chernenko', 'Kyiv', '2024-01-30');

INSERT INTO instructors (full_name, specialization) VALUES
('Oleh Marchenko', 'Data Science'),
('Tetiana Ivanova', 'Web Development'),
('Roman Sydorenko', 'Machine Learning'),
('Natalia Hlushko', 'UI/UX Design'),
('Andrii Petrenko', 'Databases');

INSERT INTO courses (course_name, category, instructor_id) VALUES
('Python for Beginners', 'Programming', 1),
('Data Analysis with SQL', 'Data Science', 5),
('Machine Learning Basics', 'Machine Learning', 3),
('Frontend Development with React', 'Web Development', 2),
('UI/UX Fundamentals', 'Design', 4),
('Advanced SQL Analytics', 'Data Science', 5),
('Deep Learning Intro', 'Machine Learning', 3),
('JavaScript Essentials', 'Programming', 2);

INSERT INTO enrollments (student_id, course_id, enroll_date) VALUES
(1, 1, '2024-02-01'),
(1, 2, '2024-02-10'),
(2, 2, '2024-02-15'),
(2, 4, '2024-03-01'),
(3, 3, '2024-03-20'),
(3, 6, '2024-03-25'),
(4, 1, '2024-02-05'),
(4, 5, '2024-04-01'),
(5, 2, '2024-04-05'),
(5, 7, '2024-04-12'),
(6, 4, '2024-03-10'),
(7, 5, '2024-03-15'),
(8, 6, '2024-04-02'),
(9, 3, '2024-04-15'),
(10, 1, '2024-02-20');

INSERT INTO progress (enrollment_id, lesson_number, score, completed) VALUES
-- Enrollment 1 (Anna, Python)
(1, 1, 85, TRUE),
(1, 2, 90, TRUE),
(1, 3, 88, TRUE),

-- Enrollment 2 (Anna, SQL)
(2, 1, 92, TRUE),
(2, 2, 87, TRUE),
(2, 3, 95, TRUE),

-- Enrollment 3 (Dmytro, SQL)
(3, 1, 78, TRUE),
(3, 2, 82, TRUE),
(3, 3, 80, FALSE),

-- Enrollment 4 (Dmytro, React)
(4, 1, 88, TRUE),
(4, 2, 90, TRUE),

-- Enrollment 5 (Olena, ML)
(5, 1, 91, TRUE),
(5, 2, 89, TRUE),
(5, 3, 93, TRUE),

-- Enrollment 6 (Olena, Advanced SQL)
(6, 1, 85, TRUE),
(6, 2, 87, TRUE),

-- Enrollment 7 (Serhii, Python)
(7, 1, 70, TRUE),
(7, 2, 75, FALSE),

-- Enrollment 8 (Serhii, UI/UX)
(8, 1, 95, TRUE),
(8, 2, 97, TRUE),

-- Enrollment 9 (Iryna, SQL)
(9, 1, 88, TRUE),
(9, 2, 92, TRUE),
(9, 3, 90, TRUE),

-- Enrollment 10 (Iryna, Deep Learning)
(10, 1, 84, TRUE),
(10, 2, 86, TRUE),

-- Enrollment 11 (Maksym, React)
(11, 1, 80, TRUE),
(11, 2, 82, TRUE),

-- Enrollment 12 (Kateryna, UI/UX)
(12, 1, 98, TRUE),
(12, 2, 96, TRUE),

-- Enrollment 13 (Yurii, Advanced SQL)
(13, 1, 75, TRUE),
(13, 2, 78, TRUE),

-- Enrollment 14 (Sofiia, ML)
(14, 1, 89, TRUE),
(14, 2, 91, TRUE),
(14, 3, 94, TRUE),

-- Enrollment 15 (Vladyslav, Python)
(15, 1, 82, TRUE),
(15, 2, 85, TRUE),
(15, 3, 88, TRUE);


-- Задача 1. Базові SELECT
-- Вивести всіх студентів, які зареєструвалися після 
SELECT *
FROM students
WHERE reg_date > '2024-01-01'
ORDER BY reg_date;

-- Вивести всі курси категорії "Data Science".
SELECT *
FROM courses
WHERE category = 'Data Science';

-------------------------------------------------------
-- Задача 2. Групування та агрегація
-- Порахувати кількість студентів у кожному місті.
SELECT COUNT(*) AS student_count, city
FROM students
GROUP BY city;

-- Порахувати кількість курсів у кожній категорії.
SELECT COUNT(*) AS course_count, category    
FROM courses
GROUP BY category;

-- Порахувати середню оцінку по кожному курсу.
SELECT c.course_id, c.course_name, ROUND(AVG(p.score), 1) AS avg_score
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN progress p ON e.enrollment_id = p.enrollment_id
GROUP BY c.course_id, c.course_name;


-------------------------------------------------------
-- Задача 3. JOIN‑аналіз
-- Вивести список курсів разом з іменами викладачів.
SELECT c.course_id, c.course_name, c.category, i.full_name AS instructor_name
FROM courses c
JOIN instructors i ON c.instructor_id = i.instructor_id
ORDER BY c.course_name;

-- Вивести студентів та назви курсів, на які вони записані.
SELECT s.student_id, s.full_name AS student_name,
    c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON c.course_id = e.course_id
ORDER BY s.student_id, c.course_name

-- Порахувати, скільки студентів у кожного викладача.
SELECT i.instructor_id, i.full_name AS instuctor_name,
    COUNT(e.student_id) AS student_count
FROM instructors i 
JOIN courses c ON c.instructor_id = i.instructor_id
JOIN enrollments e ON e.course_id = c.course_id
GROUP BY i.instructor_id,  i.full_name
ORDER BY student_count


-------------------------------------------------------
-- Задача 4. Аналітика прогресу
-- Порахувати середню оцінку кожного студента.
SELECT s.student_id, s.full_name AS student_name,
    ROUND(AVG(p.score), 1) AS avg_score
FROM students s 
JOIN enrollments e ON e.student_id = s.student_id
JOIN progress p ON e.enrollment_id = p.enrollment_id
GROUP BY s.student_id, s.full_name
ORDER BY avg_score;

-- Порахувати відсоток завершених уроків для кожного курсу.
SELECT c.course_id, c.course_name,
    ROUND(100.0 * SUM(CASE 
                    WHEN p.completed = TRUE 
                    THEN 1 
                    ELSE 0 
                    END)/ COUNT(*), 2) AS completed_percent
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN progress p ON e.enrollment_id = p.enrollment_id
GROUP BY c.course_id, c.course_name
ORDER BY completed_percent;

-- Знайти студентів, які завершили всі уроки у своїх курсах.
SELECT s.student_id, s.full_name AS student_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN progress p ON e.enrollment_id = p.enrollment_id
GROUP BY s.student_id, s.full_name
HAVING COUNT(*) = SUM(CASE
                     WHEN p.completed = TRUE
                     THEN 1 
                     ELSE 0 
                     END)
ORDER BY s.student_id;

-------------------------------------------------------
-- Задача 5. Віконні функції
-- Для кожного курсу визначити рейтинг студентів за середнім балом.
SELECT c.course_id, c.course_name, s.student_id,
s.full_name AS student_name,
    ROUND(AVG(p.score), 2) AS avg_score,
    RANK() OVER (PARTITION BY c.course_id
    ORDER BY AVG(p.score) DESC) AS course_rank
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id
JOIN progress p ON e.enrollment_id = p.enrollment_id
GROUP BY c.course_id, c.course_name, s.student_id, s.full_name
ORDER BY c.course_name, course_rank;

-- Порахувати кумулятивну кількість уроків, завершених студентом у хронологічному порядку.
SELECT s.full_name, e.enroll_date,
    SUM(CASE WHEN p.completed THEN 1 ELSE 0 END)
        OVER (PARTITION BY s.student_id ORDER BY p.lesson_number) 
        AS cumulative_completed
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN progress p ON e.enrollment_id = p.enrollment_id
ORDER BY s.student_id, e.enroll_date, p.lesson_number;

-- Для кожної категорії курсів знайти топ‑1 курс за кількістю студентів.
SELECT c.course_id, c.course_name, s.student_id, s.full_name AS student_name,
    ROUND(AVG(p.score), 2) AS avg_score,
    RANK() OVER (PARTITION BY c.course_id
        ORDER BY AVG(p.score) DESC) AS course_rank
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
JOIN students s ON e.student_id = s.student_id
JOIN progress p ON e.enrollment_id = p.enrollment_id
GROUP BY c.course_id, c.course_name, s.student_id, s.full_name
ORDER BY c.course_name, course_rank;