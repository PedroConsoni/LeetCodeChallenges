WITH WeightSum AS (
    SELECT 
        person_name, 
        SUM(weight) OVER (ORDER BY turn) AS cumulative_weight
    FROM Queue
)
SELECT TOP 1 person_name
FROM WeightSum
WHERE cumulative_weight <= 1000
ORDER BY cumulative_weight DESC;