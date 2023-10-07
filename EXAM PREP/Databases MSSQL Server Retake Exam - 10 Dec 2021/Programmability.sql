--11
CREATE FUNCTION udf_FlightDestinationsByEmail(@email VARCHAR(50))
RETURNS INT --returns the number of flight destinations that the passenger has.
	AS
	BEGIN
		RETURN(SELECT COUNT(p.Id) FROM Passengers AS p
		JOIN FlightDestinations AS fd 
		ON fd.PassengerId = p.Id
		WHERE p.Email = @email)
	END


--12
CREATE PROC usp_SearchByAirportName(@airportName VARCHAR(70))
AS
BEGIN
	SELECT 
	a.AirportName,
	p.FullName,
	CASE
	WHEN fd.TicketPrice <= 400 THEN 'Low'
	WHEN fd.TicketPrice >= 401 AND fd.TicketPrice <= 1500 THEN 'Medium'
	WHEN fd.TicketPrice >= 1501 THEN 'High'
	END AS Level,
	airc.Manufacturer,
	airc.Condition,
	airct.TypeName
		FROM FlightDestinations AS fd
		JOIN Passengers AS p ON p.Id = fd.PassengerId
		JOIN Airports AS a ON a.Id = fd.AirportId
		JOIN Aircraft AS airc ON airc.Id = fd.AircraftId
		JOIN AircraftTypes AS airct ON airct.Id = airc.TypeId
		WHERE a.AirportName = @airportName
		ORDER BY airc.Manufacturer ,p.FullName 
END