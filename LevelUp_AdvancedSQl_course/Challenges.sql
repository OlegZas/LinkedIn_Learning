-- 1. Create a list of employees and their immediate menagers: 
SELECT e.employeeId, e.firstName, e.lastName, e2.employeeId, e2.firstName || ' '|| e2.lastName as Manager
FROM employee e
INNER JOIN employee e2 ON e.employeeId = e2.managerId

-- 2. Get a list of salespeople with zero sales
SELECT e.firstName, e.lastName, s.salesAmount 
FROM employee e
LEFT JOIN sales s ON e.employeeId = s.employeeId 
WHERE s.employeeId IS NULL AND UPPER(e.title) LIKE '%SALES%' ;

-- 3. Get a list of all sales and all cusotmer even when some of the data has been removed. 
-- there can be sales data without customer or customer without sales -- they were removed 

SELECT C.firstName, C.lastName, C.customerId, S.salesId, S.salesAmount, S.soldDate 
FROM sales S
LEFT JOIN customer C ON S.customerId = C.customerId
UNION  
SELECT CU.firstName, CU.lastName, CU.customerId, S2.salesId, S2.salesAmount, S2.soldDate 
FROM CUSTOMER CU
LEFT JOIN SALES S2 ON S2.customerId = CU.customerId
WHERE S2.salesId IS NULL ;

-- 4. Number of cars sold by each employee 
SELECT E.employeeId, firstName, lastName, COUNT(S.salesId) AS CARSSOLD
FROM employee E
INNER JOIN sales S ON E.employeeId = S.employeeId 
GROUP BY E.employeeId, firstName, lastName
ORDER BY CARSSOLD DESC

--5. LEAST AND MOST EXPENSIVE SALE BY EACH EMPLOYEE THIS YEAR 
SELECT E.employeeId, firstName, lastName, MIN(S.salesAmount) AS LEASTEXPENSIVE, MAX(S.salesAmount) AS MOSTEXPENSIVE, COUNT(S.salesId) AS CARSSOLD
FROM EMPLOYEE E 
INNER JOIN SALES S ON E.employeeId = S.employeeId
WHERE STRFTIME('%Y', soldDate) = '2022'
GROUP BY E.employeeId, firstName, lastName
ORDER BY CARSSOLD DESC

-- 6. Get a list of employees who have made more than 5 sales this year 
SELECT E.employeeId, firstName, lastName, SUM(S.salesAmount) AS TOTALSALES, COUNT(S.salesId) AS CARSSOLD
FROM EMPLOYEE E  
INNER JOIN SALES S ON E.employeeId = S.employeeId
WHERE STRFTIME('%Y', soldDate) = '2022' 
GROUP BY E.employeeId, firstName, lastName
HAVING COUNT(S.salesId) > 5;
