--> 3) Pivot table (sales and regions) 
CREATE TABLE sales(
	id SERIAL PRIMARY KEY,
	region VARCHAR(10) CHECK(region IN ('NORTH','SOUTH','EAST','WEST')),
	date DATE
);

INSERT INTO sales (region, date) VALUES
('NORTH', '2025-01-05'),
('NORTH', '2025-01-12'),
('NORTH', '2025-01-20'),
('NORTH', '2025-02-02'),
('NORTH', '2025-02-15'),
('NORTH', '2025-03-01'),
('SOUTH', '2025-01-07'),
('SOUTH', '2025-01-18'),
('SOUTH', '2025-01-25'),
('SOUTH', '2025-02-05'),
('SOUTH', '2025-02-20'),
('SOUTH', '2025-03-03'),
('EAST',  '2025-01-09'),
('EAST',  '2025-01-19'),
('EAST',  '2025-01-28'),
('EAST',  '2025-02-08'),
('EAST',  '2025-02-22'),
('EAST',  '2025-03-06'),
('WEST',  '2025-01-11'),
('WEST',  '2025-01-21'),
('WEST',  '2025-01-29'),
('WEST',  '2025-02-10'),
('WEST',  '2025-02-25'),
('WEST',  '2025-03-08'),
('NORTH', '2025-03-12'),
('SOUTH', '2025-03-15'),
('EAST',  '2025-03-18'),
('WEST',  '2025-03-20'),
('NORTH', '2025-03-25'),
('SOUTH', '2025-03-28');

EXPLAIN ANALYZE
SELECT region,
COUNT(*) FILTER(WHERE DATE_TRUNC('month', date) = DATE '2025-01-01') AS JAN,
COUNT(*) FILTER(WHERE DATE_TRUNC('month', date) = DATE '2025-02-01') AS FEB,
COUNT(*) FILTER(WHERE DATE_TRUNC('month', date) = DATE '2025-03-01') AS MAR
FROM sales
GROUP BY region
ORDER BY region;						--Planning Time: 0.175ms  Execution Time: 0.295ms


