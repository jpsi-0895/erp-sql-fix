--> Q) Find Employees with more than one manager

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT
);

INSERT INTO employees (emp_id, emp_name, manager_id) VALUES
(1, 'Rahul', 101),
(2, 'Sneha', 102),
(3, 'Aaryan', 101),
(4, 'Priya', 103),
(5, 'Neha', 102),
(6, 'Anshul', 104),
(7, 'Karan', 103),
(8, 'Deepak', 105),
(9, 'kiran', 106),
(10, 'Meera', 102);

--EXPLAIN ANALYZE						--Planning Time: 0.257ms  Execution Time: 0.181ms
SELECT emp_name, manager_id FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees
	GROUP BY manager_id
	HAVING COUNT(emp_name) < 2);