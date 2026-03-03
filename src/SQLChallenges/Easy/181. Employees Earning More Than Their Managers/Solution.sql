SELECT e.name AS Employee
FROM employee e
JOIN employee m
ON e.managerid = m.id
WHERE e.salary > m.salary