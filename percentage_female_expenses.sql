USE sakila;

WITH gender_division AS (
	SELECT 
			exp_type,
			gender,
			SUM(amount) AS amount_spent
	FROM credit_card_transactions c
	GROUP BY exp_type, gender
)

SELECT
		exp_type,
        amount_spent / (amount_spent + (
			SELECT amount_spent
            FROM gender_division i
            WHERE exp_type = o.exp_type AND gender = "M"
        )) * 100 AS percentage_female_expenses
FROM gender_division o
WHERE gender = "F"