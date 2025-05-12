/* ddl.sql */
CREATE DATABASE IF NOT EXISTS university;
USE university;

-- -------- Department ----------
CREATE TABLE Department (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    name      VARCHAR(40) NOT NULL,
    phone     CHAR(12),
    office_loc VARCHAR(30),
    chair_ssn CHAR(9),
    CONSTRAINT fk_dept_chair
        FOREIGN KEY (chair_ssn) REFERENCES Professor(ssn)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- -------- Professor ----------
CREATE TABLE Professor (
    ssn        CHAR(9)  PRIMARY KEY,
    first_name VARCHAR(20),
    last_name  VARCHAR(20),
    street     VARCHAR(50),
    city       VARCHAR(30),
    state      CHAR(2),
    zip        CHAR(5),
    phone      CHAR(12),
    sex        CHAR(1),
    title      VARCHAR(20),
    salary     DECIMAL(9,2),
    degrees    VARCHAR(100)
);

-- -------- Course ----------
CREATE TABLE Course (
    course_id  INT AUTO_INCREMENT PRIMARY KEY,
    title      VARCHAR(60),
    textbook   VARCHAR(60),
    units      TINYINT,
    dept_id    INT,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- -------- Prerequisite ----------
CREATE TABLE Prerequisite (
    course_id  INT,
    prereq_id  INT,
    PRIMARY KEY (course_id, prereq_id),
    FOREIGN KEY (course_id)  REFERENCES Course(course_id)
        ON DELETE CASCADE,
    FOREIGN KEY (prereq_id) REFERENCES Course(course_id)
        ON DELETE CASCADE
);

-- -------- Section ----------
CREATE TABLE Section (
    sec_id     INT AUTO_INCREMENT PRIMARY KEY,
    course_id  INT,
    section_no INT,
    classroom  VARCHAR(15),
    seats      INT,
    days       VARCHAR(7),      -- e.g. MWF or TR
    start_time TIME,
    end_time   TIME,
    prof_ssn   CHAR(9),
    UNIQUE (course_id, section_no),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
        ON DELETE CASCADE,
    FOREIGN KEY (prof_ssn) REFERENCES Professor(ssn)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- -------- Student ----------
CREATE TABLE Student (
    cwid       CHAR(9) PRIMARY KEY,
    first_name VARCHAR(20),
    last_name  VARCHAR(20),
    street     VARCHAR(50),
    city       VARCHAR(30),
    state      CHAR(2),
    zip        CHAR(5),
    phone      CHAR(12),
    major_dept_id INT,
    FOREIGN KEY (major_dept_id) REFERENCES Department(dept_id)
        ON UPDATE CASCADE ON DELETE SET NULL
);

-- -------- StudentMinor ----------
CREATE TABLE StudentMinor (
    cwid    CHAR(9),
    dept_id INT,
    PRIMARY KEY (cwid, dept_id),
    FOREIGN KEY (cwid)    REFERENCES Student(cwid)    ON DELETE CASCADE,
    FOREIGN KEY (dept_id) REFERENCES Department(dept_id) ON DELETE CASCADE
);

-- -------- Enrollment ----------
CREATE TABLE Enrollment (
    enroll_id INT AUTO_INCREMENT PRIMARY KEY,
    cwid      CHAR(9),
    sec_id    INT,
    grade     CHAR(2),
    FOREIGN KEY (cwid)  REFERENCES Student(cwid)  ON DELETE CASCADE,
    FOREIGN KEY (sec_id) REFERENCES Section(sec_id) ON DELETE CASCADE
);
