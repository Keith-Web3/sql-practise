USE sakila;

WITH 
	total_city_transactions AS (
		SELECT 
				city, 
				SUM(amount) AS total
		FROM credit_card_transactions
		GROUP BY city
	),
	 total_gold_transactions AS (
		SELECT 
			city,
			SUM(amount) AS amount
		FROM credit_card_transactions
		WHERE card_type = "Gold"
		GROUP BY city
	)
SELECT 
		city,
		MIN(amount / total * 100) AS percentage_transactions
FROM total_city_transactions c
JOIN total_gold_transactions ch USING(city)
GROUP BY city
ORDER BY percentage_transactions
LIMIT 1
