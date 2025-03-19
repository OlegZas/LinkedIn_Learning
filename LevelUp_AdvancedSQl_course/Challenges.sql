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

--7. Use CTE to show total sales per year 
-- '$' || ...: Concatenates the dollar sign to the formatted number.
-- printif - function is used to format numbers as floating-point values with a specific number of decimal places. 
-- %: This is the placeholder that tells printf to expect a value to be formatted.
-- .2: This specifies the number of decimal places you want to display (in this case, 2 decimal places).
-- f: This stands for floating-point number formatting. It ensures that the value is displayed as a floating-point number, which includes decimal points.
WITH YEARLYSALES AS (
  SELECT STRFTIME('%Y', soldDate) AS YEAR, '$' || printf('%.2f', SUM(S.salesAmount)) AS TOTALSALES 
  FROM SALES S 
  GROUP BY YEAR
)
SELECT YEAR, TOTALSALES
FROM YEARLYSALES

-- 8. Create a report that shows the amount of sale per employee for each month in 2021
WITH EMPLOYEES AS (
  SELECT employeeId, firstName, lastName
  FROM employee E 
), TOTALSALES AS (
  SELECT SUM(salesAmount) AS TOTALSALES, employeeId, STRFTIME('%m', soldDate) AS MONTH
  FROM sales
  GROUP BY employeeId, STRFTIME('%M', soldDate)
  HAVING STRFTIME('%Y', soldDate) = '2021'
)
SELECT firstName, lastName, T.*
FROM EMPLOYEES E
INNER JOIN TOTALSALES T ON E.employeeId = T.employeeId 


-- 9. Use subquery to find all sale was for an electric car 
-- A: 
SELECT S.SALESID, S.soldDate
FROM SALES S 
INNER JOIN INVENTORY I ON S.inventoryId = I.inventoryId 
  AND (SELECT UPPER(EngineType) FROM model E WHERE E.modelId = I.modelId) = 'ELECTRIC';
-- B:
  SELECT S.SALESID, S.soldDate, SUB.EngineType
FROM (SELECT EngineType, inventoryId
      FROM INVENTORY I 
      INNER JOIN MODEL M ON I.modelId = M.modelId
      WHERE UPPER(EngineType) = 'ELECTRIC') AS SUB
INNER JOIN SALES S ON SUB.inventoryId = S.inventoryId;
