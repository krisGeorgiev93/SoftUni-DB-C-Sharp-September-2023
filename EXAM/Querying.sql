--5
SELECT FORMAT(ArrivalDate, 'yyyy-MM-dd') AS ArrivalDate,
AdultsCount, ChildrenCount
FROM Bookings AS b
JOIN Rooms AS r
ON b.RoomId = r.Id
ORDER BY Price DESC,ArrivalDate ASC

--6
SELECT h.Id,h.Name
FROM Hotels AS h
JOIN HotelsRooms AS hr
ON h.Id = hr.HotelId
JOIN Rooms AS r
ON r.Id = hr.RoomId
JOIN Bookings AS b
ON b.HotelId = h.Id
WHERE r.Type = 'VIP Apartment'
GROUP BY h.Id,h.Name,h.DestinationId,hr.HotelId
ORDER BY COUNT(*) DESC

--7
SELECT t.Id,t.Name,t.PhoneNumber
FROM Tourists AS t
LEFT JOIN Bookings AS b
ON t.Id = b.TouristId
WHERE b.TouristId IS NULL
ORDER BY t.Name

--8
SELECT TOP(10)
h.Name,d.Name,c.Name
FROM Bookings AS b
JOIN Hotels AS h
ON b.HotelId = h.Id
JOIN Destinations AS d
ON d.Id = h.DestinationId
JOIN Countries AS c
ON c.Id = d.CountryId
WHERE b.ArrivalDate < '2023-12-31' AND h.Id % 2 = 1
ORDER BY c.Name, b.ArrivalDate

--9
SELECT 
h.Name, r.Price
FROM Tourists AS t
JOIN Bookings AS b
ON t.Id = b.TouristId
JOIN Hotels AS h
ON b.HotelId = h.Id
JOIN Rooms AS r
ON b.RoomId = r.Id
WHERE t.Name NOT LIKE '%EZ'
ORDER BY r.Price DESC

--10
SELECT h.Name, 
SUM(r.Price * DATEDIFF(day, B.ArrivalDate, B.DepartureDate)) AS TotalRevenue
FROM Hotels AS h
JOIN Bookings AS b
ON h.Id = b.HotelId
JOIN Rooms AS r
ON r.Id = b.RoomId
GROUP BY h.Name
ORDER BY TotalRevenue DESC