--5
SELECT Number,Currency FROM Invoices
ORDER BY Amount DESC , DueDate ASC

--6
SELECT [p].Id, [p].Name, [p].Price, [c].Name
FROM Products AS [p]
INNER JOIN Categories AS [c] ON [p].CategoryId = [c].Id
WHERE [c].Id IN (3,5) 
ORDER BY [p].Price DESC

--7
SELECT c.Id,c.Name AS Client, CONCAT(a.StreetName,' ',a.StreetNumber,',',' ',a.City,',',' ',a.PostCode,',',' ',co.Name) AS Address
FROM Clients AS c
LEFT JOIN ProductsClients AS pc
ON c.Id = pc.ClientId
 JOIN Addresses AS a
ON a.Id = c.AddressId
 JOIN Countries AS co
ON co.Id = a.CountryId

WHERE pc.ProductId IS NULL
ORDER BY c.Name

--8
SELECT TOP(7) i.Number, i.Amount, c.Name AS CLient
FROM Invoices AS i
JOIN Clients AS c
ON i.ClientId = c.Id
WHERE IssueDate < '2023-01-01' AND i.Currency = 'EUR' OR i.Amount > 500.00
AND c.NumberVAT LIKE ('DE%')
ORDER BY i.Number ASC , i.Amount DESC

--9
SELECT c.Name AS Client,
MAX(p.Price) AS Price,
c.NumberVAT AS [VAT Number]
	FROM Clients AS c
JOIN ProductsClients AS pc
ON c.Id = pc.ClientId
JOIN Products AS p
ON pc.ProductId = p.Id
	WHERE c.Name NOT LIKE '%KG%' --not ending in KG
	GROUP BY c.Name, c.NumberVAT
	ORDER BY MAX(p.Price) DESC

--10
SELECT c.Name, FLOOR(AVG(p.Price)) AS [Average Price]
FROM Clients AS c
JOIN ProductsClients AS pc
ON c.Id = pc.ClientId
JOIN Products AS p
ON pc.ProductId = p.Id
JOIN Vendors AS v
ON v.Id = p.VendorId
WHERE v.NumberVAT LIKE '%FR%'
GROUP BY c.Name
ORDER BY AVG(p.Price) ASC, c.Name DESC

