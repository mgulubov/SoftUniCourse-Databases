USE Gringotts
GO

SELECT
	SUM(wd1.DepositAmount - wd2.DepositAmount) AS SumDifference
FROM
	WizzardDeposits wd1,
	WizzardDeposits wd2
WHERE
	wd2.Id = wd1.Id + 1