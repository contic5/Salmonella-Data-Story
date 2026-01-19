WITH Salmonella_by_Country_And_GDP AS
(
SELECT s.Country,
AVG(w.Population) AS Population_,
MIN(World_Bank_Estimate) AS World_Bank_Esimate,
COUNT(*) AS Total_Outbreaks
FROM Salmonella s
JOIN world_population w ON s.Country=w.Country
JOIN GDP_By_Nation g ON s.Country=g.Country
GROUP BY s.Country
)
SELECT Country,Total_Outbreaks,Population_,World_Bank_Esimate,
CAST(ROUND(1.0*Total_Outbreaks/World_Bank_Esimate,6) AS float) AS Outbreaks_Per_Dollar,
ROUND(1.0*Total_Outbreaks/Population_,2) AS Outbreaks_Per_Million
FROM Salmonella_by_Country_And_GDP
ORDER BY Outbreaks_Per_Dollar DESC;