use university_jjm_db;

# join ALL tables

SELECT s.name AS subject, concat(t.first_name, ' ', t.last_name) AS teacher, d.name AS dept, b.name AS building, room_number AS room, 
tte.time, tte.week_day, g.name AS group_name, concat(st.first_name, ' ', st.last_name) AS student, grades.value AS grade,
concat(ps.name, ' ', ps.address) as parking_spot, concat(pa.login, ' ', pa.password) as student_creds 
FROM subjects AS s
CROSS JOIN teachers AS t ON t.id = s.teacher_id 
CROSS JOIN departments AS d ON d.id = t.department_id
CROSS JOIN buildings AS b ON d.building_id = b.id
CROSS JOIN rooms AS r ON b.id = r.building_id
CROSS JOIN time_table_entries AS tte ON tte.room_id = r.id
JOIN groups_has_time_table_entries AS gh ON tte.id = gh.time_table_entry_id
JOIN student_groups AS g ON g.id = gh.student_group_id
CROSS JOIN students AS st ON g.id = st.student_group_id
CROSS JOIN grades ON student_id = st.id
CROSS JOIN parking_spots AS ps ON ps.teacher_id = t.id
CROSS JOIN portal_accounts AS pa ON pa.student_id = st.id;

#=================================================================================================================================
# JOINS

# 1) list grades for subjects for all students
SELECT st.first_name, st.last_name, g.value, sb.name FROM students AS st
LEFT JOIN grades AS g ON st.id = g.student_id
JOIN subjects AS sb ON g.subject_id = sb.id;

# 2) list subjects for each group of students
SELECT DISTINCT g.name AS group_name, s.name AS subject FROM student_groups AS g
JOIN groups_has_time_table_entries AS gh ON g.id = gh.student_group_id
JOIN time_table_entries AS tte ON gh.time_table_entry_id = tte.id
JOIN subjects AS s ON s.id = tte.subject_id;

# 3) list rooms that are occupied on Mondays
SELECT DISTINCT room_number, building_id AS building FROM time_table_entries AS tte
JOIN rooms AS r ON tte.room_id = r.id
WHERE tte.week_day = 'MONDAY'
ORDER BY room_number ASC;

# more JOINs in sections below

#=================================================================================================================================
# statements with aggregate functions and GROUP BY and without HAVING.

# 1) calculate average grade for each student
SELECT s.first_name, s.last_name, AVG(g.value) AS avg_grade FROM students AS s
LEFT JOIN  grades AS g ON s.id = g.student_id
GROUP BY s.id 
ORDER BY avg_grade DESC;

# 2) calculate average grade per subject
SELECT s.name, AVG(g.value) AS avg_grade  FROM subjects AS s
LEFT JOIN grades AS g ON s.id = g.subject_id
GROUP BY s.name 
ORDER BY avg_grade DESC;

# 3) count number of subjects per group of students
SELECT g.name AS group_name, COUNT(DISTINCT tte.subject_id) AS number_of_subjects FROM student_groups AS g
JOIN groups_has_time_table_entries AS gh ON g.id = gh.student_group_id
JOIN time_table_entries AS tte ON gh.time_table_entry_id = tte.id
GROUP BY g.name;

# 4) count number of studnets per group
SELECT g.name AS group_name, COUNT(s.id) FROM student_groups AS g
JOIN students AS s ON g.id = s.student_group_id
GROUP BY group_name;

# 5) number of lectures given per departmant per week
SELECT d.id AS dept_id, d.name AS dept_name, COUNT(tte.id) AS number_of_lectures FROM departments AS d
LEFT JOIN teachers AS t ON d.id = t.department_id 
JOIN subjects AS s ON t.id = s.teacher_id
JOIN time_table_entries AS tte ON s.id = tte.subject_id
GROUP BY d.id;

# 6) count number of rooms occupied ON each day of week
SELECT DISTINCT COUNT(r.id) AS number_of_rooms, week_day FROM time_table_entries AS tte
JOIN rooms AS r ON tte.room_id = r.id
GROUP BY week_day ;

# 7) count number of teachers in each department
SELECT department_id, COUNT(id) FROM TEACHERS
GROUP BY department_id;

#=================================================================================================================================
#statements with aggregate functions and GROUP BY and with HAVING

# 1) find groups of students that have at least 3 subjects a week
SELECT g.name AS group_name, COUNT(DISTINCT tte.subject_id) AS number_of_subjects FROM student_groups AS g
JOIN groups_has_time_table_entries AS gh ON g.id = gh.student_group_id
JOIN time_table_entries AS tte ON gh.time_table_entry_id = tte.id
GROUP BY g.name
HAVING number_of_subjects >= 3;

# 2) list subjects with average grade above 4.0
SELECT s.name, avg(g.value) AS avg_grade  FROM subjects AS s
LEFT JOIN grades AS g ON s.id = g.subject_id
GROUP BY s.name 
HAVING avg_grade > 4.0 
ORDER BY avg_grade DESC;
 
# 3) list departments that give more then 4 lectures per week
SELECT d.id AS dept_id, d.name AS dept_name, COUNT(tte.id) AS number_of_lectures FROM departments AS d
LEFT JOIN teachers AS t ON d.id = t.department_id 
JOIN subjects AS s ON t.id = s.teacher_id
JOIN time_table_entries AS tte ON s.id = tte.subject_id
GROUP BY d.id
HAVING COUNT(tte.id) > 4;

# 4) list buildings that have more than 3 rooms
SELECT b.id AS building_id, b.name AS building , COUNT(r.id) number_of_rooms FROM buildings AS b
JOIN rooms AS r ON r.building_id= b.id
GROUP BY b.id
HAVING number_of_rooms > 3;

# 5) list students that have at least 3 grades
SELECT s.id, s.first_name, s.last_name , COUNT(g.id) AS number_of_grades FROM students AS s
JOIN grades AS g ON s.id = g.student_id
GROUP BY s.id, s.first_name, s.last_name
HAVING COUNT(g.id) >= 3
ORDER BY s.last_name;

# 6) list students whose lowest grade is 4
SELECT s.id, s.first_name, s.last_name , min(g.value) AS lowest_grades FROM students AS s
JOIN grades AS g ON s.id = g.student_id
GROUP BY s.id, s.first_name, s.last_name
HAVING lowest_grades >= 4
ORDER BY lowest_grades DESC;

# 7) list subjects that have at least 2 teachers
SELECT id, name, COUNT(teacher_id) FROM subjects 
GROUP BY id, name
having COUNT(teacher_id) >= 2;

#=================================================================================================================================
# statements for UPDATE

# 1)
UPDATE students SET first_name = 'Robin' WHERE last_name = 'Smith'; 

# 2)
UPDATE time_table_entries SET time = '11:00:00' WHERE week_day = 'MONDAY' AND subject_id = 1 AND room_id = 1;
SELECT time FROM time_table_entries WHERE week_day = 'MONDAY' AND subject_id = 1 AND room_id = 1;

# 3)
UPDATE time_table_entries SET room_id = 11 WHERE subject_id = 6;

# 4)
UPDATE buildings SET address = '123 Sesame Street' WHERE name ='A1';

# 5 
UPDATE grades SET value = (SELECT value FROM (SELECT * FROM grades) AS sth WHERE student_id = 7 and subject_id = 4) + 1 WHERE student_id = 7 and subject_id = 4;

# 6)
UPDATE grades SET value = (SELECT value FROM (SELECT * FROM grades) AS sth WHERE id = 19) + 1 WHERE id = 19;

# 7)
UPDATE teachers SET department_id = 3 WHERE department_id = 4;

# 8)
UPDATE time_table_entries SET room_id = 2 WHERE subject_id = (SELECT id FROM subjects WHERE name = 'Jewellery & Metal');

# 9)
UPDATE time_table_entries SET time = '19:00:00' WHERE subject_id IN (SELECT id FROM subjects WHERE name in ('Java','Java Script'));

# 10)
UPDATE teachers SET first_name = 'Anna Maria' WHERE department_id = (SELECT id FROM departments AS d WHERE d.name = 'Art');

#=================================================================================================================================
# statements for DELETE

# 1)
DELETE FROM students WHERE last_name = 'Yellow';

# 2)
DELETE FROM students WHERE date_of_birth IS NULL;

# 3)  delete students that have grade <= 2 for AT LEAST one subject
DELETE FROM students WHERE id IN (SELECT student_id FROM grades WHERE value <= 2);
SELECT * FROM students AS s
LEFT JOIN grades AS g ON s.id = g.student_id 
WHERE s.id IN (SELECT student_id FROM grades WHERE value <= 2);

# 4) delete all departments FROM building B1
DELETE FROM departments WHERE building_id IN (SELECT id FROM buildings WHERE name = 'B1');
SELECT * FROM departments 
CROSS JOIN buildings AS b ON building_id = b.id;

# 5) delete time table entries located in building B1
DELETE FROM time_table_entries 
WHERE room_id IN 
(SELECT r.id FROM rooms AS r JOIN buildings AS b ON building_id = b.id WHERE b.name = 'B1');
SELECT * FROM time_table_entries WHERE room_id IN 
(SELECT r.id FROM rooms AS r JOIN buildings AS b ON building_id = b.id WHERE b.name = 'B1');

# 6) delete all grades for student with id = 1
DELETE FROM grades WHERE student_id = 1;

# 7) delete student called Mark Lee
DELETE FROM students WHERE first_name = 'Julia' AND last_name = 'Johnson';

# 8) delete all students FROM group Y1C
DELETE FROM students WHERE student_group_id = (SELECT g.id FROM student_groups AS g WHERE g.name = 'Y1C');
SELECT * FROM students WHERE student_group_id = (SELECT g.id FROM student_groups AS g WHERE g.name = 'Y1C');

# 9) delete all grades for subject Jewellery & Metal
DELETE FROM grades WHERE subject_id = (SELECT id FROM subjects WHERE name = 'Jewellery & Metal');
SELECT * FROM grades WHERE subject_id = (SELECT id FROM subjects WHERE name = 'Jewellery & Metal');

# 10) delete subject called Jewellery & Metal (required to run delete statement #9 firstly)
DELETE FROM subjects WHERE name = 'Jewellery & Metal';
SELECT * FROM subjects WHERE name = 'Jewellery & Metal';

#=================================================================================================================================
# Statements for ALTER

# 1) 
ALTER TABLE students ADD email varchar(255);

# 2)
ALTER TABLE students ADD CHECK (YEAR(date_of_birth)> 1985);

# 3)
ALTER TABLE student_groups ADD UNIQUE (name);

# 4)
ALTER TABLE rooms ADD capacity INT;

# 5)
ALTER TABLE students DROP COLUMN date_of_birth;