WITH Salmonella_Prepared AS
(
    SELECT YEAR(Create_date) AS Year_,
    CASE WHEN Isolation_Type IS NULL THEN 'Unknown'
    ELSE Isolation_Type
    END AS Isolation_Type
    FROM Salmonella
)
SELECT Year_,[environmental/other],[Unknown],[Clinical]
FROM 
(
SELECT Year_,Isolation_type
FROM
Salmonella_Prepared
) AS SourceTable
PIVOT (
    COUNT (Isolation_Type)
    FOR Isolation_type IN ([environmental/other], [Unknown], [Clinical])
) AS PivotTable
ORDER BY Year_;