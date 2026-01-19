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
),
Salmonella_by_Country_And_GDP_Percentiled AS
(
SELECT Country,Total_Outbreaks,Population_,World_Bank_Esimate,
CAST(ROUND(1.0*Total_Outbreaks/World_Bank_Esimate,6) AS float) AS Outbreaks_Per_Dollar,
ROUND(1.0*Total_Outbreaks/Population_,2) AS Outbreaks_Per_Million,
100.0*PERCENT_RANK() OVER (ORDER BY World_Bank_Esimate) AS World_Bank_Esimate_Percent,
10*FLOOR(0.99*100*PERCENT_RANK() OVER (ORDER BY World_Bank_Esimate)/10)+10 AS World_Bank_Esimate_Percent_Group
FROM Salmonella_by_Country_And_GDP
)

SELECT World_Bank_Esimate_Percent_Group,
COUNT(*) AS Total_Nations,
AVG(Total_Outbreaks) AS Avg_Outbreaks,
AVG(Population_) AS Avg_Population,
AVG(World_Bank_Esimate) AS Avg_World_Bank,
AVG(Outbreaks_Per_Dollar) AS Avg_Outbreaks_Per_Dollar,
AVG(Outbreaks_Per_Million) AS Outbreaks_Per_Million
FROM Salmonella_by_Country_And_GDP_Percentiled
GROUP BY World_Bank_Esimate_Percent_Group;