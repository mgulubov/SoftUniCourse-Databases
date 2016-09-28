USE Gringotts
GO

SELECT
	UPPER(LEFT(wd.FirstName, 1)) AS 'first_letter'
FROM
	WizzardDeposits wd
WHERE
	wd.DepositGroup = 'Troll Chest'
GROUP BY
	LEFT(wd.FirstName, 1)
ORDER BY
	wd.FirstName ASC