-- 1. Create a list of employees and their immediate menagers: 
SELECT e.employeeId, e.firstName, e.lastName, e2.employeeId, e2.firstName || ' '|| e2.lastName as Manager
FROM employee e
INNER JOIN employee e2 ON e.employeeId = e2.managerId

-- 2. Get a list of salespeople with zero sales
SELECT e.firstName, e.lastName, s.salesAmount 
FROM employee e
LEFT JOIN sales s ON e.employeeId = s.employeeId 
WHERE s.employeeId IS NULL ;
