-- Query 5 (SQLite Variant): Finding High-Value Outliers using a Business Heuristic
-- Since SQLite doesn't support standard deviation natively, we flag transactions 
-- that are greater than 3 times the average for that specific transaction type.

WITH type_averages AS (
    SELECT 
        transaction_type,
        AVG(amount_ngn) AS avg_amount
    FROM 
        transactions
    GROUP BY 
        transaction_type
)
SELECT 
    t.transaction_id,
    t.account_number,
    t.transaction_type,
    t.amount_ngn,
    ROUND(a.avg_amount, 2) AS type_average,
    ROUND(t.amount_ngn / a.avg_amount, 2) AS times_higher_than_average
FROM 
    transactions t
JOIN 
    type_averages a ON t.transaction_type = a.transaction_type
WHERE 
    t.amount_ngn > (a.avg_amount * 3) 
ORDER BY 
    times_higher_than_average DESC;