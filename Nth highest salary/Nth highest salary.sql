--> Q) Nth highest salary
CREATE TABLE employees_salary (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT
);

INSERT INTO employees_salary (emp_id, emp_name, salary) VALUES
(1, 'Rahul', 50000),
(2, 'Sneha', 60000),
(3, 'Arjun', 75000),
(4, 'Priya', 55000),
(5, 'Neha', 90000),
(6, 'Karan', 60000),
(7, 'Meera', 80000),
(8, 'Rohan', 50000),
(9, 'Isha', 95000),
(10, 'Ankit', 70000);

EXPLAIN ANALYZE 					--Planning Time: 0.199ms	Execution Time: 0.120ms
SELECT emp_name, salary 
FROM (SELECT emp_name, salary, DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk FROM employees_salary)
WHERE rnk = 3;

EXPLAIN ANALYZE						--Planning Time: 0.212ms	Execution Time: 0.126ms
WITH highest AS (
SELECT emp_name, salary, DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk FROM employees_salary
)
SELECT * FROM highest WHERE rnk = 3;

