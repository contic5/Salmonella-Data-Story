WITH Salmonella_Prepared AS
(
    SELECT YEAR(Create_date) AS Year_,
    /*Multiply 2023 by 3/2 since only 8 months of 2023 are included*/
    CASE WHEN YEAR(Create_Date)=2023 THEN ROUND(12*COUNT(*)/8,0) 
    ELSE COUNT(*)
    END AS Total_Outbreaks
    FROM Salmonella
    GROUP BY YEAR(Create_date)
)
SELECT Year_,
Total_Outbreaks,
CAST(ROUND(100.0*Total_Outbreaks/(SELECT SUM(Total_Outbreaks) FROM Salmonella_Prepared),2) AS FLOAT) AS Percent_
FROM Salmonella_Prepared
ORDER BY Year_