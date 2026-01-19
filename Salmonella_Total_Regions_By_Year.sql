With Salmonella_Prepared AS
(
SELECT Country,Region,Subregion,Subsubregion,YEAR(Create_date) AS Year_
FROM Salmonella
GROUP BY Country,Region,Subregion,Subsubregion,YEAR(Create_date)
)
SELECT Year_,COUNT(*) AS total
FROM Salmonella_Prepared
GROUP BY Year_
ORDER BY Year_;