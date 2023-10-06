--5
SELECT Name,Age,PhoneNumber,Nationality
FROM Tourists
ORDER BY Nationality,Age DESC, Name

--6
SELECT s.Name, l.Name, s.Establishment, c.Name
FROM Sites AS s
JOIN Locations AS l
ON s.LocationId = l.Id
JOIN Categories AS c
ON c.Id = s.CategoryId
ORDER BY c.Name DESC, l.Name, s.Name

--7
SELECT l.Province, l.Municipality, l.Name, COUNT(s.Name) AS CountOfSites
FROM Locations AS l
JOIN Sites AS s
ON s.LocationId = l.Id
WHERE l.Province = 'Sofia'
GROUP BY l.Province, l.Municipality,l.Name
ORDER BY COUNT(s.Name) DESC, l.Name

--8
SELECT s.Name AS Site,l.Name AS Location,l.Municipality,l.Province,s.Establishment
FROM Sites AS s
JOIN Locations AS l
ON s.LocationId = l.Id
WHERE l.Name NOT LIKE ('[BMD]%') AND s.Establishment LIKE ('%BC')
ORDER BY s.Name

--9
SELECT t.Name,t.Age,t.PhoneNumber,t.Nationality,ISNULL(bp.Name, '(no bonus prize)') AS Reward
FROM Tourists AS t
LEFT JOIN TouristsBonusPrizes AS tbp
ON tbp.TouristId = t.Id
LEFT JOIN BonusPrizes AS bp
ON bp.Id = tbp.BonusPrizeId
ORDER BY t.Name

--10
SELECT DISTINCT SUBSTRING(t.Name,CHARINDEX(' ', t.Name) + 1,LEN(t.Name)) AS 'LastName',
t.Nationality, t.Age, t.PhoneNumber
FROM Tourists AS t
JOIN SitesTourists AS st
ON t.Id = st.TouristId
JOIN Sites AS s
ON s.Id = st.SiteId
JOIN Categories AS c
ON c.Id = s.CategoryId
WHERE c.Name = 'History and archaeology'
ORDER BY LastName





