USE sakila;

WITH city_expenses AS (
	SELECT 
		city,
		exp_type,
		SUM(amount) AS total_spent
	FROM credit_card_transactions
	GROUP BY city, exp_type
)

SELECT 
		city,
        (
			SELECT exp_type
            FROM city_expenses
            WHERE total_spent = MAX(c.total_spent)
            LIMIT 1
        ) AS highest_lowest_type,
		(
			SELECT exp_type
            FROM city_expenses
            WHERE total_spent = MIN(c.total_spent)
            LIMIT 1
        ) AS lowest_expense_type
FROM city_expenses c
GROUP BY city