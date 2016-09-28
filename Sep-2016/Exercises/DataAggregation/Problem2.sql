USE Gringotts
GO

SELECT
	MAX(wd.MagicWandSize) AS LongestMagicWand
FROM
	WizzardDeposits wd