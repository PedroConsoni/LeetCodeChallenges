WITH CTE AS (
    SELECT 
        tiv_2016,
        COUNT(*) OVER(PARTITION BY tiv_2015) as cnt_tiv_2015,
        COUNT(*) OVER(PARTITION BY lat, lon) as cnt_lat_lon
    FROM Insurance
)
SELECT 
    CAST(SUM(tiv_2016) AS DECIMAL(18, 2)) AS tiv_2016
FROM CTE
WHERE 
    cnt_tiv_2015 > 1
    AND cnt_lat_lon = 1;