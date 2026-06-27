-- Query 3: Top 20 customers by total transaction value
-- Helps anti-money laundering (AML) teams track high-exposure accounts.

SELECT 
    customer_id,
    account_number,
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(amount_ngn), 2) AS total_value_ngn,
    ROUND(AVG(amount_ngn), 2) AS average_transaction_amount
FROM 
    transactions
GROUP BY 
    customer_id, 
    account_number
ORDER BY 
    total_value_ngn DESC
LIMIT 20;