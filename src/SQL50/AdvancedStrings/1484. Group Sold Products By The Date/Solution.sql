SELECT 
    sell_date,
    COUNT(DISTINCT product) AS num_sold,
    STRING_AGG(product, ',') WITHIN GROUP (ORDER BY product ASC) AS products
FROM (
    SELECT DISTINCT sell_date, product
    FROM Activities
) AS DistinctActivities
GROUP BY 
    sell_date
ORDER BY 
    sell_date;