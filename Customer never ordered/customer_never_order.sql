CREATE TABLE customers(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(20),
	email VARCHAR(50),
	region VARCHAR(10) CHECK(region IN ('NORTH','SOUTH','EAST','WEST'))
);

CREATE TABLE orders(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	customer_id BIGINT REFERENCES customers(id),
	order_date DATE,
	amount NUMERIC(10,2)
);

INSERT INTO customers (name, email, region) VALUES
('Amit Sharma', 'amit.sharma@example.com', 'NORTH'),
('Priya Verma', 'priya.verma@example.com', 'SOUTH'),
('Rohit Singh', 'rohit.singh@example.com', 'EAST'),
('Neha Gupta', 'neha.gupta@example.com', 'WEST'),
('Vikram Mehta', 'vikram.mehta@example.com', 'NORTH'),
('Ananya Das', 'ananya.das@example.com', 'SOUTH'),
('Karan Malhotra', 'karan.malhotra@example.com', 'EAST'),
('Simran Kaur', 'simran.kaur@example.com', 'WEST'),
('Manish Joshi', 'manish.joshi@example.com', 'NORTH'),
('Divya Rao', 'divya.rao@example.com', 'SOUTH'),
('Sandeep Yadav', 'sandeep.yadav@example.com', 'EAST'),
('Pooja Nair', 'pooja.nair@example.com', 'WEST'),
('Arjun Patel', 'arjun.patel@example.com', 'NORTH'),
('Meera Iyer', 'meera.iyer@example.com', 'SOUTH'),
('Rahul Khanna', 'rahul.khanna@example.com', 'EAST'),
('Shreya Kulkarni', 'shreya.kulkarni@example.com', 'WEST'),
('Nitin Bansal', 'nitin.bansal@example.com', 'NORTH'),
('Kavita Menon', 'kavita.menon@example.com', 'SOUTH'),
('Aditya Reddy', 'aditya.reddy@example.com', 'EAST'),
('Sneha Pillai', 'sneha.pillai@example.com', 'WEST');

INSERT INTO orders (customer_id, order_date, amount) VALUES
(1, '2025-01-05', 2500.00),
(3, '2025-01-12', 1800.50),
(5, '2025-02-01', 3200.75),
(7, '2025-02-14', 450.00),
(9, '2025-03-03', 999.99),
(12, '2025-03-10', 1500.00),
(14, '2025-04-01', 2700.25),
(16, '2025-04-15', 300.00),
(18, '2025-05-05', 1200.00),
(20, '2025-05-20', 5000.00);

--Query using NOT IN
EXPLAIN ANALYZE
SELECT * FROM customers
WHERE id NOT IN (SELECT customer_id FROM orders);	--Planning time: 0.081ms  Execution Time: 0.060ms

--Query using LEFT JOIN + IS NULL
EXPLAIN ANALYZE
SELECT c.* FROM customers c LEFT JOIN orders o ON o.customer_id = c.id 
WHERE o.id IS NULL
ORDER BY c.id;  					--Planning time: 0.167ms  Execution Time: 0.129ms

--Query using NOT EXISTS
EXPLAIN ANALYZE
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1 
    FROM orders o 
    WHERE o.customer_id = c.id);			--Planning time: 0.187ms  Execution Time: 0.087ms
