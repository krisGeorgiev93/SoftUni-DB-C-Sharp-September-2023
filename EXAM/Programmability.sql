CREATE FUNCTION udf_RoomsWithTourists
(
    @roomType NVARCHAR(40)
)
RETURNS INT
AS
BEGIN  
    RETURN(SELECT (SUM(b.AdultsCount) + SUM(b.ChildrenCount))
    FROM Bookings AS b
	JOIN Rooms AS r
	ON b.RoomId = r.Id	
    WHERE r.Type = @roomType
	)  
END;


--12
CREATE PROC usp_SearchByCountry(@country VARCHAR(50))
AS
BEGIN
	SELECT t.Name,t.PhoneNumber,t.Email,COUNT(b.Id) AS CountOfBookings
	FROM Tourists AS t
	JOIN Bookings AS b
	ON t.Id = b.TouristId
	JOIN Countries AS c
	ON c.Id = t.CountryId
	WHERE c.Name = @country
	GROUP BY t.Name, t.PhoneNumber, t.Email
	ORDER BY t.Name, CountOfBookings DESC 
END