--5
SELECT m.FirstName + ' ' + m.LastName AS Mechanic,
	   j.Status, j.IssueDate
FROM Mechanics AS m
JOIN Jobs AS j
ON m.MechanicId = j.MechanicId
ORDER BY m.MechanicId,j.IssueDate,j.JobId

--6
SELECT 
c.FirstName + ' ' + c.LastName AS Client,
DATEDIFF(DAY,j.IssueDate,'2017-04-24') AS [Days Going],
j.Status
FROM Clients AS c
JOIN Jobs AS j
ON c.ClientId = j.ClientId
WHERE j.Status <> 'Finished'


--7
SELECT 
m.FirstName + ' ' + m.LastName AS Mechanic,
AVG(DATEDIFF(DAY,j.IssueDate,j.FinishDate)) AS [Average Days]
FROM Mechanics AS m
JOIN Jobs AS j
ON m.MechanicId = j.MechanicId
GROUP BY m.FirstName, m.LastName, m.MechanicId
ORDER BY m.MechanicId

--8
SELECT  CONCAT(m.FirstName, ' ', m.LastName) AS Available
	FROM Mechanics m
	WHERE
	m.MechanicId NOT IN (
	SELECT
		MechanicId
	FROM
		Jobs j
	WHERE
		MechanicId IS NOT NULL
		AND j.Status <> 'Finished'
	GROUP BY
		MechanicId
		, j.Status)
ORDER BY m.MechanicId ASC

--9
SELECT 
       j.JobId,
	   ISNULL(SUM(p.Price * op.Quantity),0) AS Total
FROM Jobs AS j
LEFT JOIN Orders AS o
ON j.JobId = o.JobId
LEFT JOIN OrderParts AS op
ON op.OrderId = o.OrderId
LEFT JOIN Parts AS p
ON p.PartId = op.PartId
	  WHERE j.Status = 'Finished'
	  GROUP BY j.JobId
	  ORDER BY Total DESC, j.JobId ASC


--	10. Missing Parts
SELECT
	p.PartId
	, p.Description
	, SUM(pn.Quantity) AS Required
	, SUM(p.StockQty) AS [In Stock]
	, ISNULL(SUM(g.Quantity), 0) AS Ordered
FROM
	Parts p
LEFT JOIN PartsNeeded pn ON
	pn.PartId = p.PartId
LEFT JOIN Jobs j ON
	pn.JobId = j.JobId
LEFT JOIN (
	SELECT 
		op.PartId
		, op.Quantity
	FROM
		Orders AS o
	JOIN OrderParts AS op ON
		op.OrderId = o.OrderId
	WHERE
		o.Delivered = 0) AS g ON
	g.PartId = p.PartId
WHERE
	j.Status <> 'Finished'
GROUP BY
	p.PartId
	, p.Description
HAVING
	SUM(pn.Quantity) > SUM(p.StockQty) + ISNULL(SUM(g.Quantity), 0)
ORDER BY
	p.PartId;

