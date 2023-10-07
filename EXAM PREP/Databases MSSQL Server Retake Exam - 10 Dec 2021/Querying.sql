USE Airport
Go
--5
SELECT Manufacturer,Model,FlightHours,Condition
FROM Aircraft
ORDER BY FlightHours DESC

--6
SELECT p.FirstName,p.LastName,a.Manufacturer,a.Model,a.FlightHours FROM Pilots AS p
JOIN PilotsAircraft AS pa
ON p.Id = pa.PilotId
JOIN Aircraft AS a
ON pa.AircraftId = a.Id
WHERE FlightHours <= 304
ORDER BY FlightHours DESC, p.FirstName

--7
SELECT TOP(20)
fd.Id,fd.Start,p.FullName,a.AirportName,fd.TicketPrice
FROM FlightDestinations AS fd
JOIN Airports AS a
ON fd.AirportId = a.Id
JOIN Passengers AS p
ON fd.PassengerId = p.Id
WHERE DAY(Start) % 2 = 0
ORDER BY TicketPrice DESC, a.AirportName

--8
SELECT a.Id AS AircraftId,
a.Manufacturer,
a.FlightHours,
COUNT(*) AS FlightDestinationsCount,
ROUND(AVG(fd.TicketPrice),2) AS AvgPrice
FROM Aircraft AS a
JOIN FlightDestinations AS fd
ON a.Id = fd.AircraftId
GROUP BY a.Id, a.Manufacturer, a.FlightHours
HAVING COUNT(fd.AircraftId) >= 2
ORDER BY COUNT(fd.AircraftId) DESC, a.Id

--9
SELECT p.FullName,
		COUNT(a.ID) AS CountOfAircrafts,
		SUM(fd.TicketPrice) AS TotalPayed
FROM Passengers AS p
JOIN FlightDestinations AS fd
ON p.Id = fd.PassengerId
JOIN Aircraft AS a
ON a.Id = fd.AircraftId
GROUP BY p.FullName, p.Id
HAVING COUNT(a.Id) > 1 AND p.FullName LIKE ('_a%')
ORDER BY p.FullName

--10
SELECT 
a.AirportName,fd.Start AS DayTime, 
fd.TicketPrice,
p.FullName,
airc.Manufacturer,
airc.Model
FROM FlightDestinations AS fd
JOIN Airports AS a
ON fd.AirportId = a.Id
JOIN Passengers AS p
ON p.Id = fd.PassengerId
JOIN Aircraft as airc
ON airc.Id = fd.AircraftId
WHERE DATEPART(HOUR, Start) BETWEEN 6 AND 20 AND fd.TicketPrice > 2500
ORDER BY airc.Model