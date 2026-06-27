-- Query 1: Total volume and value by transaction type and channel
-- This helps us see which channels handle the highest exposure.

SELECT 
    transaction_type,
    channel,
    COUNT(transaction_id) AS total_transaction_count,
    ROUND(SUM(amount_ngn), 2) AS total_value_ngn,
    ROUND(AVG(amount_ngn), 2) AS average_amount_ngn
FROM 
    transactions
GROUP BY 
    transaction_type, 
    channel
ORDER BY 
    total_value_ngn DESC;