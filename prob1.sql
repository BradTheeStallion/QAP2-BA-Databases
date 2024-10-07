--Brad Ayers
--QAP2 Problem 1: University Course Enrollment System
--October 7, 2024

--Create Tables
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    enrollment_date DATE
);

CREATE TABLE professors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(100)
);

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100),
    course_description TEXT,
    professor_id INT,
    FOREIGN KEY (professor_id) REFERENCES professors(id)
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

--Insert Data
-- Insert students
INSERT INTO students (first_name, last_name, email, enrollment_date) VALUES
('Brad', 'Ayers', 'bradley.ayer@keyin.com', '2024-01-02'),
('Adam', 'Stevenson', 'adam.stevenson@keyin.com', '2024-01-02'),
('Brandon', 'Shea', 'brandon.shea@keyin.com', '2024-01-02'),
('Kyle', 'Hollett', 'kyle.hollett@keyin.com', '2024-01-02'),
('Brian', 'Janes', 'brian.janes@keyin.com', '2024-01-02');

-- Insert professors
INSERT INTO professors (first_name, last_name, department) VALUES
('Matthew', 'English', 'Full Stack Development'),
('Ainee', 'Q', 'Java'),
('Suresh', 'P', 'AWS'),
('Mo', 'B', 'Python'),
('Noman', 'A', 'JS');

-- Insert courses
INSERT INTO courses (course_name, course_description, professor_id) VALUES
('Databases', 'Introduction to Databases', 1),
('Advanced Java', 'Fundamentals of Java', 2),
('AWS', 'Introduction to AWS Development', 3);

-- Insert enrollments
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-09-02'),
(2, 1, '2024-09-02'),
(3, 2, '2024-09-02'),
(4, 3, '2024-09-02'),
(5, 1, '2024-09-02');

--Query to get all students enrolled in a specific course
SELECT CONCAT(students.first_name, ' ', students.last_name) AS full_name
FROM students
JOIN enrollments ON students.id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.id
WHERE courses.course_name = 'Databases';

--Query to get all courses and the professors who teach them
SELECT courses.course_name, CONCAT(professors.first_name, ' ', professors.last_name) AS professor_name
FROM courses
JOIN professors ON courses.professor_id = professors.id;

--Query to get all courses that have at least one student enrolled
SELECT DISTINCT courses.course_name
FROM courses
JOIN enrollments ON courses.id = enrollments.course_id;

--Update student email
UPDATE students
SET email = 'brad.ayers@keyin.com'
WHERE id = 1;

--Delete student enrollment
DELETE FROM enrollments
WHERE student_id = 1 AND course_id = 1;