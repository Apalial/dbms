CREATE TABLE Courses (--
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(100)
);

CREATE TABLE Subjects (--
    subject_id NUMBER PRIMARY KEY,
    subject_name VARCHAR2(100),
    course_id NUMBER,
    CONSTRAINT fk_subject_course FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Student (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    course_id NUMBER,
    CONSTRAINT fk_course FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

CREATE TABLE student_phone(
    student_id NUMBER,
    phone_number NUMBER,
    CONSTRAINT stu_p FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Admin (--
    admin_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100)
);


CREATE TABLE Notice ( --
    notice_id NUMBER PRIMARY KEY,
    title VARCHAR2(100),
    content VARCHAR2(4000),
    date_posted DATE
);

CREATE TABLE Student_Leave (--
    leave_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    start_date DATE,
    end_date DATE,
    reason VARCHAR2(400),
    CONSTRAINT fk_student_leave FOREIGN KEY (student_id) REFERENCES Student(student_id)
);


CREATE TABLE Student_Feedback (--
    feedback_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    feedback_content VARCHAR2(4000),
    date_submitted DATE,
    CONSTRAINT fk_student_feedback FOREIGN KEY (student_id) REFERENCES Student(student_id)
);


CREATE TABLE sessions (--
    session_id NUMBER PRIMARY KEY,
    course_id NUMBER,
    start_date DATE,
    end_date DATE,
    CONSTRAINT fk_session_course FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);


-- PROCEDURE , TRIGGER , FUNCTION
----------------------------------------------------------

-- function for current date

CREATE OR REPLACE FUNCTION get_current_date RETURN DATE IS
    submited_date DATE;
BEGIN
    SELECT SYSDATE INTO submited_date FROM DUAL;
    RETURN submited_date;
END;
/

-- Sequence for generating course_id values
CREATE SEQUENCE courses_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create a course with automatically generated course_id
CREATE OR REPLACE PROCEDURE create_course (
    p_name IN VARCHAR2
)
IS 
BEGIN
    INSERT INTO Courses (course_id, course_name) 
    VALUES (courses_seq.NEXTVAL, p_name);
END;
/


-- Sequence for generating notice_id values
CREATE SEQUENCE notice_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create a notice with automatically generated notice_id
CREATE OR REPLACE PROCEDURE create_notice (
    title IN VARCHAR2,
    content IN VARCHAR2
)
IS
    submited_date DATE;
BEGIN 
    submited_date := get_current_date();
    INSERT INTO Notice (notice_id, title, content, date_posted) 
    VALUES (notice_seq.NEXTVAL, title, content, submited_date);
END;
/

-- DROP PROCEDURE create_notice;
-- DROP PROCEDURE create_feedback;
    
-- Sequence for generating subject_id values
CREATE SEQUENCE subjects_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create a subject with automatically generated subject_id
CREATE OR REPLACE PROCEDURE create_subject (
    subject_name IN VARCHAR2,
    course_id IN NUMBER
)
IS
BEGIN 
    INSERT INTO Subjects (subject_id, subject_name, course_id) 
    VALUES (subjects_seq.NEXTVAL, subject_name, course_id);
END;
/

-- Sequence for generating session_id values
CREATE SEQUENCE sessions_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create a session with automatically generated session_id
CREATE OR REPLACE PROCEDURE create_session (
    course_id IN NUMBER,
    start_date IN DATE,
    end_date IN DATE
)
IS
BEGIN 
    INSERT INTO sessions (session_id, course_id, start_date, end_date) 
    VALUES (sessions_seq.NEXTVAL, course_id, start_date, end_date);
END;
/



CREATE SEQUENCE admin_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;
    
-- Procedure to create admin without admin_id parameter

CREATE OR REPLACE PROCEDURE create_admin (
    name VARCHAR2,
    email VARCHAR2
)
IS
BEGIN 
    INSERT INTO Admin (admin_id, name, email) VALUES (NULL, name, email);
END;
/

-- Trigger to ensure that the admin_id is automatically generated
CREATE OR REPLACE TRIGGER trg_admin_id_auto_generate
BEFORE INSERT ON Admin
FOR EACH ROW
BEGIN
    IF :NEW.admin_id IS NULL THEN
        SELECT admin_seq.NEXTVAL INTO :NEW.admin_id FROM DUAL;
    END IF;
END;
/

----------------------------------------------------------------------    

    
-- Sequence for generating student_id values
CREATE SEQUENCE student_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create student without student_id parameter
CREATE OR REPLACE PROCEDURE create_student (
    name VARCHAR2,
    email VARCHAR2,
    course_id NUMBER,
    phone VARCHAR2
)
IS
BEGIN 
    INSERT INTO Student (student_id, name, email, course_id) 
    VALUES (student_seq.NEXTVAL, name, email, course_id);
    
    INSERT INTO student_phone (student_id, phone_number) 
    VALUES (student_seq.CURRVAL, phone);
END;
/

-- Trigger to ensure that the student_id is automatically generated
CREATE OR REPLACE TRIGGER trg_student_id_auto_generate
BEFORE INSERT ON Student
FOR EACH ROW
BEGIN
    IF :NEW.student_id IS NULL THEN
        SELECT student_seq.NEXTVAL INTO :NEW.student_id FROM DUAL;
    END IF;
END;
/


-- Sequence for generating leave_id values
CREATE SEQUENCE student_leave_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

-- Procedure to create student leave without leave_id parameter
CREATE OR REPLACE PROCEDURE create_leave (
    student_id NUMBER,
    start_date DATE,
    end_date DATE,
    reason VARCHAR2
)
IS
BEGIN 
    INSERT INTO Student_Leave (leave_id, student_id, start_date, end_date, reason) 
    VALUES (student_leave_seq.NEXTVAL, student_id, start_date, end_date, reason);
END;
/

-- Trigger to ensure that the leave_id is automatically generated
CREATE OR REPLACE TRIGGER trg_leave_id_auto_generate
BEFORE INSERT ON Student_Leave
FOR EACH ROW
BEGIN
    IF :NEW.leave_id IS NULL THEN
        SELECT student_leave_seq.NEXTVAL INTO :NEW.leave_id FROM DUAL;
    END IF;
END;
/


-- Sequence for generating feedback_id values
CREATE SEQUENCE student_feedback_seq
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;


-- Procedure to create student feedback without feedback_id parameter
CREATE OR REPLACE PROCEDURE create_feedback (
    student_id NUMBER,
    feedback_content VARCHAR2
)
IS
    submited_date DATE;
BEGIN 
    submited_date := get_current_date();
    INSERT INTO Student_Feedback (feedback_id, student_id, feedback_content, date_submitted) 
    VALUES (student_feedback_seq.NEXTVAL, student_id, feedback_content, submited_date);
END;
/

-- Trigger to ensure that the feedback_id is automatically generated
CREATE OR REPLACE TRIGGER trg_feedback_id_auto_generate
BEFORE INSERT ON Student_Feedback
FOR EACH ROW
BEGIN
    IF :NEW.feedback_id IS NULL THEN
        SELECT student_feedback_seq.NEXTVAL INTO :NEW.feedback_id FROM DUAL;
    END IF;
END;
/
    
EXEC create_course('computer science');
EXEC create_course('Robotics');
EXEC create_course('Mechanical');

EXEC create_subject('physics',1);
EXEC create_subject('maths',1);
EXEC create_subject('physics',2);
EXEC create_subject('maths',2);

EXEC create_session(1,TO_DATE('2 JUL 2022', 'DD MON YYYY'),TO_DATE('2 JUN 2026', 'DD MON YYYY'));

EXEC create_admin('Arshdeep','arshdeep@palial');
EXEC create_admin('Arsh','palial@arshdeep');

EXEC create_student('A','A@gmail.com',1,'1234567890');
EXEC create_student('B','B@gmail.com',2,'197131730');
EXEC create_student('C','C@gmail.com',1,'2911287131');
EXEC create_student('D','D@gmail.com',2,'2911357131');
EXEC create_student('E','E@gmail.com',2,'2971511131');
EXEC create_student('F','F@gmail.com',1,'2971387131');


EXEC create_feedback(1,'good project');
EXEC create_feedback(2,'vvvgood project');
EXEC create_feedback(2,'vvgood project');
EXEC create_feedback(5,'vgood project');


EXEC create_leave(1,TO_DATE('23 APRIL 2024','DD MON YYYY'),TO_DATE('1 MAY 2024' , 'DD MON YYYY'),'SOMETHING IMPORTANT');
EXEC create_leave(2,TO_DATE('20 APRIL 2024','DD MON YYYY'),TO_DATE('1 MAY 2024' , 'DD MON YYYY'),'SOMETHING IMPORTANT');
EXEC create_leave(2,TO_DATE('12 APRIL 2024','DD MON YYYY'),TO_DATE('1 MAY 2024' , 'DD MON YYYY'),'SOMETHING IMPORTANT');
EXEC create_leave(3,TO_DATE('9 APRIL 2024','DD MON YYYY'),TO_DATE('1 MAY 2024' , 'DD MON YYYY'),'SOMETHING IMPORTANT');
EXEC create_leave(5,TO_DATE('13 APRIL 2024','DD MON YYYY'),TO_DATE('1 MAY 2024' , 'DD MON YYYY'),'SOMETHING IMPORTANT');


EXEC create_notice('NOTICE','CONTENT');
EXEC create_notice('NOTICE','CONTENT');
EXEC create_notice('NOTICE','CONTENT');
EXEC create_notice('NOTICE','CONTENT');


SELECT * FROM Student;
SELECT * FROM student_phone;
SELECT * FROM Student_Leave;
SELECT * FROM Student_Feedback;
SELECT * FROM Notice;
SELECT * FROM sessions;
SELECT * FROM Subjects;
SELECT * FROM Courses;
SELECT * FROM Admin;
