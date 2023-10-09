--5
SELECT Description,FORMAT(OpenDate,'dd-MM-yyyy') AS OpenDate 
FROM Reports 
WHERE EmployeeId IS NULL
--first order by year/month/day
ORDER BY FORMAT(OpenDate,'yyyy-MM-dd') ASC, Description ASC

--6
SELECT r.Description, c.Name AS CategoryName
FROM Reports AS r
JOIN Categories AS c
ON r.CategoryId = c.Id
WHERE c.Id IS NOT NULL
ORDER BY Description, c.Name

--7
SELECT TOP(5)
       c.Name AS CategoryName,
       COUNT(r.Id) AS ReportsNumber
FROM Categories AS c
JOIN Reports AS r
ON c.Id = r.CategoryId
GROUP BY c.Name
ORDER BY ReportsNumber DESC, c.Name

--8
SELECT u.Username, c.Name AS CategoryName
FROM Users AS u
JOIN Reports AS r
ON u.Id = r.UserId
JOIN Categories AS c
ON c.Id = r.CategoryId
WHERE MONTH(r.OpenDate) = MONTH(u.Birthdate) AND DAY(r.OpenDate) = DAY(u.Birthdate)
ORDER BY u.Username, c.Name

--9
SELECT e.FirstName + ' ' + e.LastName AS FullName, COUNT(u.Id) AS UsersCount
FROM Employees AS e
LEFT JOIN Reports AS r
ON e.Id = r.EmployeeId
LEFT JOIN Users AS u
ON r.UserId = u.Id
GROUP BY e.FirstName, e.LastName
ORDER BY UsersCount DESC, FullName ASC

--10
SELECT ISNULL(e.FirstName + ' ' + e.LastName,'None') AS Employee,
	   ISNULL(de.Name,'None') AS Department,
	   ISNULL(c.Name,'None') AS Category,
	   ISNULL(r.Description,'None'),
	   FORMAT(r.OpenDate,'dd.MM.yyyy') AS OpenDate,
	   ISNULL(s.Label,'None') AS Status,
	   ISNULL(u.Name,'None') AS [User]
FROM Reports AS r
 LEFT JOIN Employees AS e
ON r.EmployeeId = e.Id
 LEFT JOIN Departments AS de
ON de.Id = e.DepartmentId
 LEFT JOIN Categories AS c
ON c.Id = r.CategoryId
 LEFT JOIN Users AS u
ON u.Id = r.UserId
 LEFT JOIN Status AS s
ON s.Id = r.StatusId
ORDER BY e.FirstName DESC, e.LastName DESC, de.Name, c.Name, r.Description, r.OpenDate, s.Label, u.Name
