/* queries.sql */
/* Professor a */
SELECT c.title, s.classroom, s.days, s.start_time, s.end_time
FROM Section s JOIN Course c ON c.course_id=s.course_id
WHERE s.prof_ssn = '111223333';

/* Professor b */
SELECT grade, COUNT(*) FROM Enrollment e
JOIN Section s ON s.sec_id = e.sec_id
WHERE s.course_id = 1 AND s.section_no = 1
GROUP BY grade;

/* Student a */
SELECT s.section_no, s.classroom, s.days, s.start_time, s.end_time,
       COUNT(e.enroll_id) AS enrolled, s.seats
FROM Section s LEFT JOIN Enrollment e ON e.sec_id = s.sec_id
WHERE s.course_id = 1
GROUP BY s.sec_id;

/* Student b */
SELECT c.title, s.section_no, e.grade
FROM Enrollment e
JOIN Section s ON s.sec_id = e.sec_id
JOIN Course  c ON c.course_id = s.course_id
WHERE e.cwid = 'C001';
