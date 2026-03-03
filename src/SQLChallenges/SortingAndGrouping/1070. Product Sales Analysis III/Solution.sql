WITH RankedSales AS (
    SELECT 
        product_id, 
        year AS first_year, 
        quantity, 
        price,
        RANK() OVER(PARTITION BY product_id ORDER BY year ASC) as rn
    FROM Sales
)
SELECT 
    product_id, 
    first_year, 
    quantity, 
    price
FROM RankedSales
WHERE rn = 1;