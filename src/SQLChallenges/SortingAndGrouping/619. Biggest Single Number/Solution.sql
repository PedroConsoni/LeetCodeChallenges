SELECT MAX(num) as num
FROM (
    SELECT num
    FROM mynumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) AS singlenumber