DECLARE @CurrentTime DATETIME = GETDATE()

SELECT
	p.Name,
	DATEDIFF(YEAR, p.Birthdate, @CurrentTime) AS 'Age in Years',
	DATEDIFF(MONTH, p.Birthdate, @CurrentTime) AS 'Age in Months',
	DATEDIFF(DAY, p.Birthdate, @CurrentTime) AS 'Age in Days',
	DATEDIFF(MINUTE, p.Birthdate, @CurrentTime) AS 'Age in Minutes'
FROM
	People p