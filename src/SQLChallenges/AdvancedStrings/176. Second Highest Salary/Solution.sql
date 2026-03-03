SELECT MAX(salary) as secondhighestsalary
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee);