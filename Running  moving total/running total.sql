-- Q) Running/moving totals

--Running total means Cumulative total
CREATE TABLE sales (
    id SERIAL PRIMARY KEY,
    order_date DATE,
    sales INT
);

INSERT INTO sales (order_date, sales) VALUES
('2025-09-01', 100),
('2025-09-02', 200),
('2025-09-03', 150),
('2025-09-04', 300),
('2025-09-05', 250),
('2025-09-06', 400),
('2025-09-07', 100);

--EXPLAIN ANALYZE 				--Planning Time: 0.083ms  Execution Time: 0.086ms
SELECT order_date, sales, SUM(sales) OVER (ORDER BY order_date) AS running_total
FROM sales;

--Moving total means Rolling total / Sliding window

--EXPLAIN ANALYZE 				--Planning Time: 0.108ms  Execution Time: 0.125ms
SELECT order_date, sales, 
	SUM(sales) OVER (ORDER BY order_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
	AS moving_total_3days
FROM sales;