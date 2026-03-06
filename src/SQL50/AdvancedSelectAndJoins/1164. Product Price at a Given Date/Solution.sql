WITH PrecosRecentes AS (
    SELECT 
        product_id, 
        new_price,
        RANK() OVER(PARTITION BY product_id ORDER BY change_date DESC) as rnk
    FROM Products
    WHERE change_date <= '2019-08-16'
)

SELECT product_id, new_price AS price
FROM PrecosRecentes
WHERE rnk = 1

UNION

SELECT product_id, 10 AS price
FROM Products
GROUP BY product_id
HAVING MIN(change_date) > '2019-08-16';