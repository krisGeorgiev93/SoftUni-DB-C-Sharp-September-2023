--11
CREATE FUNCTION udf_ClientWithCigars(@name NVARCHAR(30)) 
RETURNS INT --The function should return the total number of cigars that the client has.
 AS
 BEGIN
		RETURN (SELECT COUNT(c.Id)
		FROM Clients AS c
		JOIN ClientsCigars AS cc 
		ON cc.ClientId = c.Id
		JOIN Cigars AS cig
		ON cig.Id = cc.CigarId
		WHERE c.FirstName = @name)
 END


--12
CREATE PROC usp_SearchByTaste(@taste VARCHAR(20))
AS
BEGIN
		SELECT c.CigarName,
		'$'+CAST((c.PriceForSingleCigar) AS VARCHAR) AS Price,
		t.TasteType,
		b.BrandName,
		CONCAT(s.Length,' ', 'cm') AS CigarLength,
		CONCAT(s.RingRange,' ','cm') AS CigarRingRange		
		FROM Cigars AS c
		JOIN Tastes AS t
		ON c.TastId = t.Id
		JOIN Brands AS b
		ON b.Id = c.BrandId
		JOIN Sizes AS s
		ON s.Id = c.SizeId
	WHERE t.TasteType = @taste
	ORDER BY s.Length ASC, s.RingRange DESC
END