/* sample_data.sql */
USE university;

-- Departments
INSERT INTO Department(name, phone, office_loc) VALUES
('Computer Science','657-000-0000','CS‑401'),
('Mathematics','657-000-0001','MH‑166');

-- Professors
INSERT INTO Professor VALUES
('100000000','Dalen','Ha','100 Apple Fruit St','Fullerton','CA','92831',
 '657-000-0002','M','Professor',120000,'PhD Computer Science'),
('100000001','Darren','Wei','101 Banana Fruit St','Fullerton','CA','92831',
 '657-000-0003','M','Associate Prof',105000,'PhD Mathematics'),
('100000002','Solavi','Seng','102 Cherry Fruit St','Fullerton','CA','92831',
 '657-000-0004','F','Professor',130000,'PhD CS, PhD Math');

-- set chairs
UPDATE Department SET chair_ssn='100000000' WHERE name='Computer Science';
UPDATE Department SET chair_ssn='100000001' WHERE name='Mathematics';

-- Courses
INSERT INTO Course(title,textbook,units,dept_id) VALUES
('Intro to Programming','Think Python',3,1),
('Data Structures','Algorithms in C++',3,1),
('Discrete Math','Discrete Mathematics',3,2),
('Linear Algebra','Linear Algebra Done Right',3,2);

-- Prereqs
INSERT INTO Prerequisite VALUES
(2,1), -- Data Structures prereq Intro to Programming
(3,1); -- Discrete Math prereq Intro to Programming

-- Sections (6)
INSERT INTO Section(course_id,section_no,classroom,seats,days,start_time,end_time,prof_ssn) VALUES
(1,1,'CS‑100',30,'MWF','09:00','09:50','100000000'),
(1,2,'CS‑101',25,'TR' ,'10:30','11:45','100000001'),
(2,1,'CS‑200',35,'MWF','13:00','13:50','100000000'),
(3,1,'MH‑150',40,'TR' ,'09:00','10:15','100000001'),
(4,1,'MH‑151',40,'MWF','10:00','10:50','100000002'),
(2,2,'CS‑201',30,'TR' ,'14:00','15:15','100000002');

-- Students (CWIDs start at 800000000)
INSERT INTO Student VALUES
('800000000','Martin','Nguyen','103 Date Fruit St','Fullerton','CA','92831','657-000-0005',1),
('800000001','Dan','Pham','104 Elderberry Fruit St','Fullerton','CA','92831','657-000-0006',2),
('800000002','Kandice','Nguyen','105 Fig Fruit St','Fullerton','CA','92831','657-000-0007',1),
('800000003','Matthew','Braatmadja','106 Grape Fruit St','Fullerton','CA','92831','657-000-0008',1),
('800000004','Jessica','Phan','107 Honeydew Fruit St','Fullerton','CA','92831','657-000-0009',1),
('800000005','Abigail','Chang','108 Ita Palm Fruit St','Fullerton','CA','92831','657-000-0010',1),
('800000006','Jacob','Wynn','109 Jackfruit Fruit St','Fullerton','CA','92831','657-000-0011',2),
('800000007','AJ','Saechao','110 Kiwi Fruit St','Fullerton','CA','92831','657-000-0012',2);

-- Minors
INSERT INTO StudentMinor VALUES
('800000001',1),('800000002',2);

-- Enrollments (20)
INSERT INTO Enrollment(cwid,sec_id,grade) VALUES
('800000000',1,'A'),('800000001',1,'B+'),('800000002',1,'A‑'),
('800000003',1,'B'),('800000004',1,'A'),('800000005',1,'C+'),
('800000006',2,'A'),('800000007',2,'B'),
('800000000',3,'A'),('800000002',3,'B+'),('800000004',3,'A‑'),
('800000005',3,'B'),('800000003',4,'A'),('800000001',4,'A‑'),
('800000006',4,'B+'),('800000007',4,'A'),
('800000000',5,'A'),('800000002',5,'A‑'),
('800000001',6,'B'),('800000003',6,'A');