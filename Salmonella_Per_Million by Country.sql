WITH Salmonella_by_Country AS
(
SELECT s.Country,AVG(w.Population) AS Population_,COUNT(*) AS Total_Outbreaks
FROM Salmonella s
JOIN world_population w
ON s.Country=w.Country
GROUP BY s.Country
)
SELECT Country,Population_,Total_Outbreaks,
Total_Outbreaks/(Population_) AS Outbreaks_Per_Million
FROM Salmonella_by_Country
ORDER BY Outbreaks_Per_Million DESC;