--5
SELECT CigarName, PriceForSingleCigar, ImageURL
FROM Cigars
ORDER BY PriceForSingleCigar ASC, CigarName DESC

--6
SELECT c.Id, c.CigarName, c.PriceForSingleCigar, t.TasteType, t.TasteStrength
FROM Cigars AS c
JOIN Tastes AS t
ON c.TastId = t.Id
WHERE t.TasteType = 'Earthy' OR t.TasteType = 'Woody'
ORDER BY c.PriceForSingleCigar DESC

--7
SELECT c.Id, CONCAT(c.FirstName,' ',c.LastName) AS ClientName, c.Email
FROM Clients AS c
LEFT JOIN ClientsCigars AS cc
ON c.Id = cc.ClientId
WHERE cc.CigarId IS NULL
ORDER BY CONCAT(c.FirstName,' ',c.LastName)

--8
SELECT TOP(5) 
c.CigarName,c.PriceForSingleCigar, c.ImageURL
FROM Cigars AS c
JOIN Sizes AS s
ON c.SizeId = s.Id
--first 5 cigars that are at least 12cm long and contain "ci" in the cigar name or price 
--for a single cigar is bigger than $50 and ring range is bigger than 2.55
WHERE s.Length >= 12 
	  AND (c.CigarName LIKE '%ci%'
	  OR c.PriceForSingleCigar > 50)
	  AND s.RingRange > 2.55
ORDER BY c.CigarName ASC, c.PriceForSingleCigar DESC

--9
SELECT CONCAT(c.FirstName,' ',c.LastName) AS FullName,
	   a.Country, a.ZIP, '$' + CAST(MAX(cig.PriceForSingleCigar)AS VARCHAR) AS CigarPrice
FROM Clients AS c
JOIN Addresses AS a
ON c.AddressId = a.Id
JOIN ClientsCigars AS cc
ON cc.ClientId = c.Id
JOIN Cigars AS cig
ON cig.Id = cc.CigarId
WHERE ISNUMERIC(a.ZIP) = 1 --OR a.ZIP NOT LIKE ('%[^0-9]%')
GROUP BY c.Id, c.FirstName, c.LastName, a.Country, a.ZIP
ORDER BY FullName


--10
SELECT c.LastName, -- awlays group by the first select value
AVG(s.Length) AS AvgCigarLength,
CEILING(AVG(s.RingRange)) AS CigarRingRange
FROM Clients AS c
JOIN ClientsCigars AS cc
ON cc.ClientId = c.Id
JOIN Cigars AS cig
ON cig.Id = cc.CigarId
JOIN Sizes AS s
ON s.Id = cig.SizeId
GROUP BY c.LastName
ORDER BY AvgCigarLength DESC