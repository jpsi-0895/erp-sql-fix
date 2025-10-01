CREATE TABLE students(
	id serial primary key,
	first_name varchar(20),
	last_name varchar(20),
	father_name varchar(20),
	age int,
	class varchar(20),
	city varchar(20)
);

INSERT INTO students (first_name, last_name, father_name, age, class, city) VALUES
('Aarav', 'Sharma', 'Rajesh Sharma', 14, '8th', 'Delhi'),
('Vivaan', 'Patel', 'Mahesh Patel', 13, '7th', 'Ahmedabad'),
('Diya', 'Verma', 'Suresh Verma', 15, '9th', 'Jaipur'),
('Arjun', 'Singh', 'Manoj Singh', 16, '10th', 'Lucknow'),
('Anaya', 'Gupta', 'Rakesh Gupta', 12, '6th', 'Mumbai'),
('Reyansh', 'Yadav', 'Pratap Yadav', 17, '11th', 'Kanpur'),
('Isha', 'Nair', 'Vijay Nair', 13, '7th', 'Kochi'),
('Kavya', 'Reddy', 'Srinivas Reddy', 15, '9th', 'Hyderabad'),
('Advait', 'Chopra', 'Amit Chopra', 16, '10th', 'Pune'),
('Meera', 'Bansal', 'Sunil Bansal', 14, '8th', 'Chandigarh');


--1) Procedure to Print a Student by ID
CREATE OR REPLACE PROCEDURE find_student_by_id(n int)
LANGUAGE plpgsql AS $$
DECLARE
	s RECORD;
BEGIN
	SELECT * INTO s FROM students WHERE id = n;
	IF FOUND THEN
		RAISE NOTICE 'id: %, first_name: %, last_name: %, father_name: %, age: %, class: %, city: %',
						s.id,s.first_name,s.last_name,s.father_name,s.age,s.class,s.city;
	ELSE
		RAISE NOTICE 'Not Found';
	END IF;
END;
$$;

CALL find_student_by_id(1);

--2) Procedure to Add New Student
CREATE OR REPLACE PROCEDURE insert_new_student(f_name VARCHAR(20),l_name VARCHAR(20),father_name VARCHAR(20),
							age INT,class VARCHAR(20),city VARCHAR(20))
LANGUAGE plpgsql AS $$
BEGIN
	INSERT INTO students(first_name,last_name,father_name,age,class,city)
	VALUES (f_name,l_name,father_name,age,class,city);
	RAISE NOTICE 'Student details Added SUCCESSFULL:';
END;
$$;

CALL insert_new_student('Kamal','Kumar','Kamlesh',15,'8th','Jaipur');


--3) Procedure to update Student grade.
ALTER TABLE students
ADD COLUMN grade CHAR(1);

CREATE OR REPLACE PROCEDURE grade_update(n INT,g CHAR(1))
LANGUAGE plpgsql AS $$
DECLARE
	s RECORD;
BEGIN
	SELECT * INTO s FROM students WHERE id = n;
	UPDATE students
	SET grade = g
	WHERE id = n;
	RAISE NOTICE 'Grade update SUCCESSFULLY %: Grade is %', s.first_name, s.grade;
END;
$$;

CALL grade_update(2,'B');


--4) Procedure to Delete a Student
CREATE OR REPLACE PROCEDURE delete_student(n INT)
LANGUAGE plpgsql AS $$
DECLARE
	s RECORD;
BEGIN
	SELECT * INTO s FROM students WHERE id = n;
	IF FOUND THEN
		DELETE FROM students
		WHERE id = n;
		RAISE NOTICE 'ID % Delete SUCCESSFULLY:', s.id;
	ELSE 
		RAISE NOTICE 'Student not exist.';
	END IF;
END;
$$;

CALL delete_student(11);


--5) Procedure to LIST all Students
CREATE OR REPLACE PROCEDURE list_all_students()
LANGUAGE plpgsql AS $$
DECLARE
	s RECORD;
BEGIN
	FOR s IN SELECT * FROM students ORDER BY id ASC LOOP
		RAISE NOTICE 'ID % Full Name: % % Fathers Name: % Age: % Class: % Grade: %',
					s.id,s.first_name,s.last_name,s.father_name,s.age,s.class,s.grade;
	END LOOP;
END;
$$;

CALL list_all_students();