WITH FirstLogins AS (
    SELECT 
        player_id, 
        MIN(event_date) AS first_login
    FROM 
        Activity
    GROUP BY 
        player_id
)
SELECT 
    CAST(
        COUNT(a.player_id) * 1.0 / (SELECT COUNT(DISTINCT player_id) FROM Activity) 
        AS DECIMAL(5,2)
    ) AS fraction
FROM 
    FirstLogins fl
LEFT JOIN 
    Activity a 
    ON fl.player_id = a.player_id 
    AND a.event_date = DATEADD(day, 1, fl.first_login);