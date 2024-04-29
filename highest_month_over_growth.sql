USE sakila;

SELECT 
		exp_type,
        card_type,
        count(*) AS usage_count
FROM credit_card_transactions
WHERE 
	MONTHNAME(STR_TO_DATE(transaction_date, '%d-%b-%y')) = "January" 
    AND YEAR(STR_TO_DATE(transaction_date, '%d-%b-%y')) = 2014
GROUP BY exp_type, card_type
ORDER BY usage_count DESC
LIMIT 1