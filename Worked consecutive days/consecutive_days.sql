--> 2) Detect employee who worked consecutive days

CREATE TABLE employees(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(50),
	department VARCHAR(50)
); 

CREATE TABLE employee_work_log(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	employee_id INT REFERENCES employees(id),
	work_date DATE
);

INSERT INTO employees (name, department) VALUES
('Alex Johnson', 'Marketing'),
('Maria Rodriguez', 'Engineering'),
('David Chen', 'Human Resources'),
('Sarah Miller', 'Sales'),
('Michael Brown', 'Finance'),
('Jessica Davis', 'IT'),
('Chris Wilson', 'Customer Service'),
('Laura Martinez', 'Legal');

INSERT INTO employee_work_log (employee_id, work_date) VALUES
(1,'2025-08-01'),(2,'2025-08-01'),(3,'2025-08-01'),(4,'2025-08-01'),(5,'2025-08-01'),(1,'2025-08-02'),(2,'2025-08-02'),(3,'2025-08-02'),
(6,'2025-08-02'),(7,'2025-08-02'),(5,'2025-08-03'),(1,'2025-08-03'),(2,'2025-08-03'),(3,'2025-08-03'),(4,'2025-08-03'),(6,'2025-08-03'),
(1,'2025-08-04'),(2,'2025-08-04'),(3,'2025-08-04'),(4,'2025-08-04'),(5,'2025-08-04'),(6,'2025-08-04'),(7,'2025-08-04'),(1,'2025-08-05'),
(2,'2025-08-05'),(5,'2025-08-05'),(7,'2025-08-05'),(8,'2025-08-05'),(5,'2025-08-06'),(1,'2025-08-07'),(2,'2025-08-07'),(7,'2025-08-07'),
(8,'2025-08-07'),(5,'2025-08-08'),(4,'2025-08-09'),(4,'2025-08-10');

--EXPLAIN ANALYZE --(To check the performance of query)
WITH PreviousWorkDate AS (
    SELECT
        employee_id,
        work_date,
        LEAD(work_date) OVER (
            PARTITION BY employee_id
            ORDER BY work_date
        ) AS next_work_date
    FROM
        employee_work_log
)
SELECT
    employee_id,
    work_date AS first_consecutive_day,
    next_work_date AS second_consecutive_day
FROM
    PreviousWorkDate
WHERE
    next_work_date - work_date = 1;			--Planning time: 0.179ms  Execution Time: 0.197ms