USE Geography
GO
--------------------------
--------------------------
-- This problem assumes that the previous problem is completed successfully without errors.
--------------------------
--------------------------
-- 1. Write and execute a SQL command that changes the country named "Myanmar" to its other name "Burma".
UPDATE
	Countries
SET
	CountryName = 'Burma'
WHERE
	CountryName = 'Myanmar'
GO
--------------------------
--------------------------
-- 2. Add a new monastery holding the following information: Name="Hanga Abbey", Country="Tanzania".
-- 3. Add a new monastery holding the following information: Name="Myin-Tin-Daik", Country="Myanmar".
DECLARE @TanzaniaCountryCode CHAR(2) = (
	SELECT
		CountryCode
	FROM
		Countries
	WHERE
		CountryName = 'Tanzania'
)

DECLARE @MyanmarCountryCode CHAR(2) = (
	SELECT
		CountryCode
	FROM
		Countries
	WHERE
		CountryName = 'Myanmar'
)

INSERT INTO
	Monasteries(
		Name,
		CountryCode
	)
VALUES
	(
		'Hanga Abbey',
		@TanzaniaCountryCode
	),
	(
		'Myin-Tin-Daik',
		@MyanmarCountryCode
	)
GO
--------------------------
--------------------------
-- 4. Find the count of monasteries for each continent and not deleted country. 
-- Display the continent name, the country name and the count of monasteries. 
-- Include also the countries with 0 monasteries. 
-- Sort the results by monasteries count (from largest to lowest), then by country name alphabetically. 
-- Name the columns exactly like in the table below. Submit for evaluation the result grid with headers.
SELECT
	cn.ContinentName,
	c.CountryName,
	COUNT(m.Id) AS MonasteriesCount
FROM
	Continents cn
		LEFT JOIN
			Countries c ON
				c.ContinentCode = cn.ContinentCode
				AND
				c.IsDeleted != 1
		LEFT JOIN
			Monasteries m ON
				m.CountryCode = c.CountryCode
GROUP BY
	cn.ContinentName,
	c.CountryName
ORDER BY
	MonasteriesCount DESC,
	c.CountryName ASC
GO
--------------------------
--------------------------