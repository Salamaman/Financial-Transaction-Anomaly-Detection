-- Query 2: Average transaction amount and count by hour of day
-- This defines what "normal" chronological behavior looks like.

SELECT 
    strftime('%H', transaction_datetime) AS hour_of_day,
    COUNT(transaction_id) AS transaction_count,
    ROUND(SUM(amount_ngn), 2) AS total_value_ngn,
    ROUND(AVG(amount_ngn), 2) AS average_amount_ngn    
FROM 
    transactions
GROUP BY 
    hour_of_day
ORDER BY 
    hour_of_day ASC;