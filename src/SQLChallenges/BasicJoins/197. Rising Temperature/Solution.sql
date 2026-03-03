SELECT id
FROM (
    SELECT
        id,
        temperature,
        recordDate,
        LAG(temperature) OVER(ORDER BY recordDate) as prev_temp,
        LAG(recordDate) OVER(ORDER BY recordDate) as prev_date
    FROM weather
) as temp_comparison
WHERE temperature > prev_temp
    AND DATEDIFF(day, prev_date, recordDate) = 1;