-- 1. Create a list of employees and their immediate menagers: 
SELECT e.employeeId, e.firstName, e.lastName, e2.employeeId, e2.firstName || ' '|| e2.lastName as Manager
FROM employee e
INNER JOIN employee e2 ON e.employeeId = e2.managerId
