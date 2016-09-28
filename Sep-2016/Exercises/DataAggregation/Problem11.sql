USE Gringotts
GO

SELECT
	DISTINCT(wd.DepositGroup),
	wd.IsDepositExpired,
	AVG(wd.DepositInterest) OVER(PARTITION BY wd.DepositGroup, wd.IsDepositExpired)
FROM
	WizzardDeposits wd
WHERE
	wd.DepositStartDate > '01/01/1985'
ORDER BY
	wd.DepositGroup DESC,
	wd.IsDepositExpired ASC