WITH Salmonella_by_Country AS
(
    SELECT s.Country,MIN(w.Region) AS Region,AVG(w.Population) AS Population_,COUNT(*) AS Total_Outbreaks,
    COUNT(*)/AVG(w.Population) AS Outbreaks_Per_Million
    FROM Salmonella s
    JOIN world_population w
    ON s.Country=w.Country
    GROUP BY s.Country
)
SELECT Region,
SUM(Total_Outbreaks) AS Total_Outbreaks,
MIN(Outbreaks_Per_Million) AS Min_Outbreaks_Per_Million,
ROUND(1.0*AVG(Outbreaks_Per_Million),5) AS Avg_Total_Outbreaks_Per_Million,
MAX(Outbreaks_Per_Million) AS Max_Outbreaks_Per_Million,
SUM(Population_) AS Population_,
ROUND(1.0*SUM(Total_Outbreaks)/SUM(Population_),5) AS Sum_Total_Outbreaks_Per_Million
FROM Salmonella_by_Country s
GROUP BY s.Region;