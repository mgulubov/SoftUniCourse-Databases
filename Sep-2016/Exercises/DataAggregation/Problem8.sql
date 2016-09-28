USE Gringotts
GO

SELECT
	wd.DepositGroup,
	wd.MagicWandCreator,
	MIN(wd.DepositCharge)
FROM
	WizzardDeposits wd
GROUP BY
	wd.DepositGroup,
	wd.MagicWandCreator
ORDER BY
	wd.MagicWandCreator ASC,
	wd.DepositGroup ASC