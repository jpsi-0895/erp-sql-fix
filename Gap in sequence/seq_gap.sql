--> 5) Find gaps in sequence

CREATE TABLE order_history(
	id serial PRIMARY KEY,
	date DATE,
	region VARCHAR(10) CHECK(region IN ('EAST','WEST','NORTH','SOUTH')),
	customer_id INT
);

INSERT INTO order_history (date, region, customer_id) VALUES
('2025-01-02', 'EAST', 101),
('2025-01-05', 'WEST', 102),
('2025-01-07', 'NORTH', 103),
('2025-01-09', 'SOUTH', 104),
('2025-01-12', 'EAST', 105),
('2025-01-15', 'WEST', 106),
('2025-01-18', 'NORTH', 107),
('2025-01-20', 'SOUTH', 108),
('2025-01-22', 'EAST', 109),
('2025-01-25', 'WEST', 110),
('2025-01-27', 'NORTH', 111),
('2025-01-29', 'SOUTH', 112),
('2025-02-01', 'EAST', 113),
('2025-02-03', 'WEST', 114),
('2025-02-05', 'NORTH', 115),
('2025-02-07', 'SOUTH', 116),
('2025-02-10', 'EAST', 117),
('2025-02-12', 'WEST', 118),
('2025-02-14', 'NORTH', 119),
('2025-02-16', 'SOUTH', 120);



--EXPLAIN ANALYZE                                                  
WITH seq_gap AS(
		SELECT id, LEAD(id) OVER(ORDER BY id) AS next_id,
		(LEAD(id) OVER(ORDER BY id))-id AS gap
		FROM order_history
)
SELECT * FROM seq_gap
WHERE gap > 1;					--Planning Time: 0.207ms  Execution Time: 0.135ms
