CREATE TABLE customers(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	name VARCHAR(20),
	email VARCHAR(50),
	region VARCHAR(10) CHECK(region IN ('NORTH','SOUTH','EAST','WEST'))
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

--> 1) Query without JOIN
EXPLAIN ANALYZE             --> Planning Time: 0.180ms  Execution Time: 0.105ms
SELECT 
	CASE
		WHEN id % 2 = 1 AND id + 1 <= (SELECT MAX(id) FROM customers) THEN id + 1
		WHEN id % 2 = 0 THEN id -1
		ELSE id
	END AS id, name, email, region
FROM customers
ORDER BY id;


--> 2) Query using JOIN
EXPLAIN ANALYZE            --> Planning Time: 0.317ms  Execution Time: 0.187ms
SELECT
	CASE 
		WHEN c1.id % 2 = 1 AND c2.id IS NOT NULL THEN c2.id
		WHEN c1.id % 2 = 0 THEN c1.id - 1
		ELSE c1.id
	END AS swap_id, c1.name, c1.email, c1.region
FROM customers c1 LEFT JOIN customers c2 ON c1.id + 1 = c2.id
ORDER BY swap_id;

--> Query 1 is best performance because it take less Execution Time than Query 2.