USE Bank
GO

-- Drop stored procedure if exists
IF OBJECT_ID('PrintAllPersonsWithAccountsLessThan', 'P') IS NOT NULL
	DROP PROCEDURE PrintAllPersonsWithAccountsLessThan
GO

-- Create stored procedure
CREATE PROCEDURE 
	PrintAllPersonsWithAccountsLessThan(
		@CompareNum money
	)
AS
BEGIN
	SELECT
		p.Id,
		p.FirstName,
		p.LastName,
		p.SSN
	FROM
		Persons p
			INNER JOIN
				Accounts a
			ON
				p.Id = a.PersonId
	WHERE
		a.Balance > @CompareNum
END
GO

-- Call stored procedure
EXECUTE PrintAllPersonsWithAccountsLessThan @CompareNum = 5 