SELECT 
    project_id, 
    ROUND(AVG(CAST(experience_years AS DECIMAL(10,2))), 2) average_years
FROM Project p
JOIN Employee e ON p.employee_id = e.employee_id
GROUP BY project_id;