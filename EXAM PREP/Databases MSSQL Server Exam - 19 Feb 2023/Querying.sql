--5
SELECT Name,Rating FROM Boardgames
ORDER BY YearPublished ASC, Name DESC

--6
SELECT b.Id, b.Name, b.YearPublished, c.Name
FROM Boardgames AS b
JOIN Categories AS c
ON b.CategoryId = c.Id
WHERE c.Name = 'Strategy Games' OR c.Name = 'Wargames'
ORDER BY YearPublished DESC 

--7
SELECT 
c.Id, CONCAT(c.FirstName,' ',c.LastName) AS CreatorName, c.Email
FROM Creators AS c
LEFT JOIN CreatorsBoardgames AS cb
ON c.Id = cb.CreatorId
WHERE cb.BoardgameId IS NULL
ORDER BY c.FirstName

--8
SELECT TOP(5)
b.Name, b.Rating, c.Name
FROM Boardgames AS b
JOIN PlayersRanges AS pr
ON b.PlayersRangeId = pr.Id
JOIN Categories AS c 
ON c.Id = b.CategoryId
WHERE b.Rating >= 7.00 AND b.Name LIKE '%a%' 
OR b.Rating >= 7.50 AND pr.PlayersMin = 2 AND pr.PlayersMax = 5
ORDER BY b.Name ASC, b.Rating DESC

--9
SELECT 
CONCAT(c.FirstName,' ',c.LastName) AS FullName,
c.Email AS Email,
MAX(b.Rating) AS Rating
FROM CreatorsBoardgames AS cb
JOIN Creators AS c 
ON cb.CreatorId = c.Id
JOIN Boardgames AS b
ON b.Id = cb.BoardgameId
WHERE c.Email LIKE '%.com%'
GROUP BY CONCAT(c.FirstName,' ',c.LastName), c.Email
ORDER BY CONCAT(c.FirstName,' ',c.LastName) ASC

--10
SELECT 
c.LastName,
CEILING(AVG(b.Rating)) AS AverageRating,
p.Name AS PublisherName
FROM Creators AS c
JOIN CreatorsBoardgames AS cb
ON c.Id = cb.CreatorId
JOIN Boardgames AS b
ON b.Id = cb.BoardgameId
JOIN Publishers AS p
ON p.Id = b.PublisherId
WHERE p.Name = 'Stonemaier Games'
GROUP BY p.Name, c.LastName
ORDER BY AVG(b.Rating) DESC