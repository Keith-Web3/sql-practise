USE sakila;

WITH summed_up_transactions AS 
(
	SELECT 
			MONTHNAME(STR_TO_DATE(transaction_date, '%d-%b-%y')) AS month,
			card_type,
			SUM(amount) as total_spendings
	FROM credit_card_transactions
	GROUP BY month, card_type
)

SELECT *
FROM summed_up_transactions o
WHERE total_spendings = (
	SELECT 
		MAX(total_spendings) AS max_spent
    FROM summed_up_transactions i
	GROUP BY card_type
	HAVING o.total_spendings = max_spent AND o.card_type = i.card_type
);