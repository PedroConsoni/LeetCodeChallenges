WITH DailySales AS (
    SELECT 
        visited_on, 
        SUM(amount) AS day_amount
    FROM Customer
    GROUP BY visited_on
),
CalculatedStats AS (

    SELECT 
        visited_on,
        SUM(day_amount) OVER (
            ORDER BY visited_on 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS amount,
        AVG(CAST(day_amount AS FLOAT)) OVER (
            ORDER BY visited_on 
            ROWS BETWEEN 6 PRECEDING AND CURRENT ROW
        ) AS average_amount,
        ROW_NUMBER() OVER (ORDER BY visited_on) AS row_num
    FROM DailySales
)

SELECT 
    visited_on, 
    amount, 
    ROUND(average_amount, 2) AS average_amount
FROM CalculatedStats
WHERE row_num >= 7
ORDER BY visited_on;