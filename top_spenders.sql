USE sakila;

SELECT 
		city,
		SUM(amount) AS total_spendings,
        SUM(amount) / (
			SELECT SUM(amount)
            FROM credit_card_transactions
        ) * 100 AS total
FROM credit_card_transactions
GROUP BY city
ORDER BY total_spendings DESC
LIMIT 5