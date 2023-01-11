USE university_jjm_db;

INSERT INTO buildings (name, address) VALUES
('A1','South Parks St, Oxford'),
('B1','128 Bullingdon Road, Oxford'),
('C1','74 High Street, Oxford');

INSERT INTO departments (name, building_id) VALUES
('Art', 1),
('English Language and Literature', 2),
('Computer Science', 3),
('Engineering Science', 1);

INSERT INTO teachers (first_name, last_name, department_id) VALUES
('Anna', 'Smith', 1),
('John', 'Williams', 2),
('Sue', 'Sandler', 3),
('Kate', 'Taylor', 4),
('Tom', 'Brown', 1),
('Jack', 'Black', 3),
('Josh', 'White', 4);

INSERT INTO rooms (room_number, building_id) VALUES
('A101', 1), ('A102', 1), ('A103', 1), ('A104', 1),
('B101', 2), ('B102', 2), ('B103', 2), ('B104', 2),
('C101', 3), ('C102', 3), ('C103', 3);

INSERT INTO subjects (name, teacher_id) VALUES
('Jewellery & Metal', 1), ('History of Design', 5),
('Modern English', 2),
('Maths', 3), ('Databases', 6), ('Java', 3), ('Java Script', 6),
('Optical Physics', 4),('PCB design', 7);

INSERT INTO time_table_entries (time, week_day, subject_id, room_id) VALUES
('08:00:00', 'MONDAY', 1, 1), ('08:00:00', 'TUESDAY', 2, 2), ('08:00:00', 'WEDNESDAY', 1, 1), ('08:00:00', 'THURSDAY' , 2, 2), ('08:00:00', 'FRIDAY', 3, 5), 
('08:00:00', 'MONDAY', 5, 11), ('11:00:00', 'TUESDAY', 6, 10), ('08:00:00', 'WEDNESDAY', 5, 11), ('10:00:00', 'THURSDAY' , 2, 10), ('08:00:00', 'FRIDAY', 4, 9),
('09:00:00', 'MONDAY', 8, 3), ('11:00:00', 'TUESDAY', 8, 3), ('17:00:00', 'WEDNESDAY', 9, 2), ('15:00:00', 'THURSDAY' , 9, 2),
('08:00:00', 'MONDAY', 3, 5), ('10:00:00', 'TUESDAY', 3, 6), ('15:00:00', 'WEDNESDAY', 2, 2), ('12:00:00', 'THURSDAY' , 2, 1), 
('14:00:00', 'MONDAY', 2, 2), ('15:00:00', 'TUESDAY', 2, 1), ('16:00:00', 'WEDNESDAY', 7, 9), ('16:00:00', 'THURSDAY', 7, 10),
('13:00:00', 'MONDAY', 5, 11), ('14:00:00', 'TUESDAY', 6, 10), ('15:00:00', 'WEDNESDAY', 5, 11), ('12:00:00', 'THURSDAY' , 6, 10), ('13:00:00', 'FRIDAY', 4, 9),
('17:00:00', 'MONDAY', NULL, 11), ('18:00:00', 'TUESDAY', NULL, 10), ('09:00:00', 'WEDNESDAY', NULL, 11), ('13:00:00', 'THURSDAY' , NULL, 10), ('15:00:00', 'FRIDAY', NULL, 9);

INSERT INTO student_groups (name) VALUES
('Y1A'), ('Y1B'), ('Y1C'), ('Y2A'), ('Y2B'), ('Y2C');

INSERT INTO students (first_name, last_name, student_group_id, date_of_birth) VALUES
('Eric','Smith', 1, DATE '1990-12-12'), ('Jane','Fox', 1, DATE '1990-11-11'), ('John','Grey', 1, DATE '1990-10-10'), ('Jack','Yellow', 1, DATE '1990-09-12'),
('Jake','Edwards', 2, DATE '1990-01-12'), ('Trevor','Kubat', 2, DATE '1990-02-12'), ('Norma','Violet', 2, DATE '1990-03-12'), ('Dona','White', 2, NULL),
('Mark','Lee', 3, DATE '1990-10-12'), ('Tom','Smith', 3, DATE '1990-11-02'), ('Kate','Wilson', 3, NULL), ('Jim','Jones', 3, DATE '1991-12-10'),
('Anna','Martin', 4, DATE '1991-11-11'), ('Dora','Wang', 4, NULL), ('Wendy','Anders', 4, DATE '1991-01-12'), ('Kara','Anderson', 4, DATE '1990-04-12'),
('Alex','Roy', 5, DATE '1990-10-12'), ('Robert','Wolf', 5, DATE '1990-04-10'), ('Ben','Martin', 5, DATE '1990-06-12'), ('Kevin','Miller', 5, DATE '1990-12-12'),
('Leo','Evans', 6, DATE '1992-07-12'), ('Adam','Davies', 6, NULL), ('Julia','Johnson', 6, DATE '1992-11-16'), ('Hanna','Murphy', 6, DATE '1992-12-09');

INSERT INTO grades (value, student_id, subject_id) VALUES 
(4, 1, 1), (5, 1, 2), (4, 1, 3), 
(5, 2, 1), (4, 2, 2), (3, 2, 3), 
(4, 3, 1), (4, 3, 2), (3, 3, 3), 
(5, 4, 1), (4, 4, 2), (4, 4, 3), 
(4, 5, 4), (3, 5, 5), (3, 5, 6), 
(5, 6, 4), (4, 6, 5), (4, 6, 6), 
(2, 7, 4), (5, 7, 5), (5, 7, 6), 
(4, 8, 4), (4, 8, 5), (4, 8, 6), 
(2, 9, 8), (2, 9, 9),
(4, 10, 8), (4, 10, 9),
(3, 11, 8), (3, 11, 9),
(4, 12, 8), (3, 12, 9),
(5, 13, 2), (5, 13, 3),
(5, 14, 2), (5, 14, 3),
(4, 15, 2), (4, 15, 3),
(4, 16, 2), (5, 16, 3),
(3, 17, 2), (3, 17, 7),
(5, 18, 2), (2, 18, 7),
(4, 19, 2), (3, 19, 7),
(4, 20, 2), (3, 20, 7),
(3, 21, 4), (3, 21, 5), (3, 21, 6), 
(4, 22, 4), (4, 22, 5), (4, 22, 6), 
(5, 23, 4), (5, 23, 5), (5, 23, 6), 
(3, 24, 4), (3, 24, 5), (4, 24, 6);

INSERT INTO groups_has_time_table_entries (student_group_id, time_table_entry_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), (1, 5),
(2, 6), (2, 7), (2, 8), (2, 9), (2, 10),
(3, 11), (3, 12), (3, 13), (3, 14),
(4, 15), (4, 16), (4, 17), (4, 18),
(5, 19), (5, 20), (5, 21), (5, 22),
(6, 23), (6, 24), (6, 25), (6, 26), (6, 27);