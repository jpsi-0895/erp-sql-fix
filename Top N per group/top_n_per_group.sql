--> 4) Top N per group

CREATE TABLE employee_sales (
    id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL,
    department VARCHAR(50) NOT NULL,
    sale_date DATE NOT NULL,
    amount NUMERIC(10,2) NOT NULL
);

INSERT INTO employee_sales (employee_id, department, sale_date, amount) VALUES
(101, 'Electronics', '2025-01-05', 1200.00), (101, 'Electronics', '2025-01-15', 800.00), (101, 'Electronics', '2025-02-01', 1500.00),
(102, 'Clothing',    '2025-01-07', 700.00), (102, 'Clothing',    '2025-01-18', 900.00), (102, 'Clothing',    '2025-02-05', 1100.00),
(103, 'Furniture',   '2025-01-09', 500.00), (103, 'Furniture',   '2025-01-25', 1300.00), (103, 'Furniture',   '2025-02-10', 600.00),
(104, 'Electronics', '2025-01-20', 2000.00), (104, 'Electronics', '2025-02-02', 1800.00), (105, 'Clothing',    '2025-02-08', 950.00),
(105, 'Clothing',    '2025-02-18', 1200.00), (106, 'Furniture',   '2025-01-11', 400.00), (106, 'Furniture',   '2025-02-14', 1400.00),
(107, 'Electronics', '2025-01-30', 1750.00), (107, 'Electronics', '2025-02-12', 2200.00), (108, 'Clothing',    '2025-01-29', 1050.00),
(108, 'Clothing',    '2025-02-20', 1250.00), (109, 'Furniture',   '2025-02-25', 1600.00);

-- Find top 2 sales amount per employee
EXPLAIN ANALYZE
WITH top AS (
SELECT employee_id, department, sale_date, amount, 
ROW_NUMBER() OVER(PARTITION BY employee_id ORDER BY amount DESC) AS r
FROM employee_sales
)
SELECT employee_id, department, sale_date, amount
FROM top 
WHERE r <=2;						-- Planning Time: 0.149ms  Execution Time: 0.146ms




