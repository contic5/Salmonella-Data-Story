SELECT s.Country,AVG(w.Population) AS Population
FROM Salmonella s
LEFT JOIN world_population w
ON s.Country=w.Country
GROUP BY s.Country
HAVING AVG(w.Population) IS NOT NULL
ORDER BY s.country;