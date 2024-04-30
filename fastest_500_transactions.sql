USE sakila;

WITH ranked_transactions AS (
	SELECT 
		card_type,
		city,
		STR_TO_DATE(transaction_date, '%d-%b-%y') AS transaction_date,
		ROW_NUMBER() OVER (PARTITION BY city ORDER BY STR_TO_DATE(transaction_date, '%d-%b-%y')) AS ranking
	FROM credit_card_transactions
)

SELECT 
		city,
		DATEDIFF(MAX(transaction_date), MIN(transaction_date)) AS date_diff
FROM ranked_transactions r
 WHERE EXISTS (
	SELECT city
	FROM ranked_transactions
    WHERE city = r.city AND ranking = 500
) AND ranking IN (1, 500)
GROUP BY city
ORDER BY  date_diff
LIMIT 1