CREATE TABLE famous(
	user_id INT,
	follower_id INT
);

INSERT INTO famous VALUES
(1,2),(1,3),(2,4),(5,1),(5,3),(11,7),(12,8),(13,5),(13,10),(14,12),(14,3),(15,14),(15,13);

WITH distinct_users AS (
	SELECT user_id FROM famous
	UNION
	SELECT follower_id FROM famous
),
followers_count AS (
	SELECT user_id, COUNT(follower_id) AS followers
	FROM famous
	GROUP BY user_id
)
SELECT f.user_id, (f.followers*100.0)/(SELECT COUNT(*) FROM distinct_users)
FROM followers_count f
ORDER BY user_id;