-- Query 4: Velocity Check - 3+ transactions within a 10-minute window
-- Flags rapid repeated activity indicative of structuring or account takeover.

WITH transaction_velocity AS (
    SELECT 
        transaction_id,
        account_number,
        transaction_datetime,
        transaction_type,
        amount_ngn,
        -- Look back 2 transactions ago within the same account
        LAG(transaction_datetime, 2) OVER (
            PARTITION BY account_number 
            ORDER BY transaction_datetime
        ) AS txn_time_two_steps_ago
    FROM 
        transactions
)
SELECT 
    transaction_id,
    account_number,
    transaction_datetime,
    transaction_type,
    amount_ngn,
    txn_time_two_steps_ago,
    -- Calculate difference in minutes using Unix timestamps
    ROUND((strftime('%s', transaction_datetime) - strftime('%s', txn_time_two_steps_ago)) / 60.0, 2) AS minutes_for_three_txns
FROM 
    transaction_velocity
WHERE 
    txn_time_two_steps_ago IS NOT NULL
    AND (strftime('%s', transaction_datetime) - strftime('%s', txn_time_two_steps_ago)) <= 600 -- 600 seconds = 10 minutes
ORDER BY 
    minutes_for_three_txns ASC;