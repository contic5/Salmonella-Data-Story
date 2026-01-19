WITH Salmonella_by_Country AS
(
    SELECT s.Country,MIN(w.Region) AS Region,AVG(w.Population) AS Population_,COUNT(*) AS Total_Outbreaks,
    COUNT(*)/AVG(w.Population) AS Outbreaks_Per_Million
    FROM Salmonella s
    JOIN world_population w
    ON s.Country=w.Country
    GROUP BY s.Country
),
Salmonella_by_Country_Ranked AS
(
SELECT Country,Region,Outbreaks_Per_Million,
RANK() OVER (PARTITION BY Region ORDER BY Outbreaks_Per_Million ASC) AS Rank_ASC,
RANK() OVER (PARTITION BY Region ORDER BY Outbreaks_Per_Million DESC) AS Rank_DESC
FROM Salmonella_by_Country
)
SELECT Region,
MIN(Outbreaks_Per_Million) AS Min_Outbreaks_Per_Million,
(SELECT Country FROM Salmonella_by_Country_Ranked s2 WHERE s.Region=s2.Region AND s2.Rank_ASC=1) AS Min_Salmonella,
ROUND(AVG(Outbreaks_Per_Million),0) AS Avg_Outbreaks_Per_Million, 
MAX(Outbreaks_Per_Million) AS Max_Outbreaks_Per_Million,
(SELECT Country FROM Salmonella_by_Country_Ranked s2 WHERE s.Region=s2.Region AND s2.Rank_DESC=1) AS Max_Salmonella
FROM Salmonella_by_Country_Ranked s
GROUP BY s.Region;