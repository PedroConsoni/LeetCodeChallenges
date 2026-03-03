SELECT 
    m.employee_id, 
    m.name, 
    COUNT(e.employee_id) AS reports_count, 
    CAST(ROUND(AVG(CAST(e.age AS FLOAT)), 0) AS INT) AS average_age
FROM Employees e
INNER JOIN Employees m ON e.reports_to = m.employee_id
GROUP BY m.employee_id, m.name
ORDER BY m.employee_id;