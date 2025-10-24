SELECT TOP (10) [Dress_ID]
      ,[Style]
      ,[Price]
      ,[Rating]
      ,[Size]
      ,[Season]
      ,[NeckLine]
      ,[NU]
      ,[waiseline]
      ,[Material]
      ,[FabricType]
      ,[Decoration]
      ,[Pattern Type]
      ,[Recommendation]
  FROM [Dress_Att_sales].[dbo].[Dim_Dress_Attributes]
    SELECT TOP 100 *
FROM 
    Fact_Dress_Sales AS s
INNER JOIN 
    Dim_Dress_Attributes AS a ON s.Dress_ID = a.Dress_ID;

-- Top 10 Dress Style by sales in Summer
SELECT TOP 10
    a.Dress_ID,
    a.Style,
    a.Season,
    SUM(s.Sales_Amount) AS Total_Sales
FROM 
    Fact_Dress_Sales AS s
INNER JOIN 
    Dim_Dress_Attributes AS a ON s.Dress_ID = a.Dress_ID
WHERE
    a.Season = 'Summer'
GROUP BY
    a.Dress_ID, a.Style, a.Season
ORDER BY
    Total_Sales DESC;