WITH CTE AS (
    SELECT *, 
           ROW_NUMBER() OVER (
               PARTITION BY Email 
               ORDER BY Id ASC
           ) AS NumeroLinha
    FROM Person
)
DELETE FROM CTE 
WHERE NumeroLinha > 1;