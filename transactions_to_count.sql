USE sakila;

WITH ratio_table AS (
	SELECT 
			city,
			SUM(amount) / count(*) AS amounts_to_count,
			CONCAT(WEEKOFYEAR(STR_TO_DATE(transaction_date, '%d-%b-%y')), '-', YEAR(STR_TO_DATE(transaction_date, '%d-%b-%y'))) AS weekend
	FROM credit_card_transactions
	WHERE 
		WEEKDAY(STR_TO_DATE(transaction_date, '%d-%b-%y')) IN (0, 6)
	GROUP BY weekend, city
)

SELECT 
	city,
	AVG(amounts_to_count) AS average_ratio
FROM ratio_table
GROUP BY city
ORDER BY average_ratio DESC
LIMIT 1