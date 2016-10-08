USE Bank
GO
------------
------------
-- Drop functions if exist
DROP FUNCTION IF EXISTS
	ufn_CalculateFutureValue
GO
------------
------------
-- Drop procedures if exist
DROP PROCEDURE IF EXISTS
	usp_CalculateFutureValueForAccount
GO
------------
------------
-- Create function
CREATE FUNCTION
	ufn_CalculateFutureValue(
		@Sum MONEY,
		@InterestRate FLOAT,
		@NumberOfYears INT
	)
RETURNS MONEY
AS
BEGIN

RETURN
(
	SELECT
		(@Sum * POWER((1 + @InterestRate), @NumberOfYears))
)

END
GO
------------
------------
-- Create procedure
CREATE PROCEDURE
	usp_CalculateFutureValueForAccount
		@AccountId INT,
		@InterestRate FLOAT
AS
BEGIN
	SELECT
		a.Id AS 'Account Id',
		ah.FirstName AS 'First Name',
		ah.LastName AS 'Last Name',
		a.Balance AS 'Current Balance',
		dbo.ufn_CalculateFutureValue(a.Balance, @InterestRate, 5) AS 'Balance in 5 years'
	FROM
		AccountHolders ah
			INNER JOIN
				Accounts a ON
					a.AccountHolderId = ah.Id
	WHERE
		a.Id = @AccountId
END
GO
------------
------------
-- Drop functions if exist
DROP FUNCTION IF EXISTS
	ufn_CalculateFutureValue
GO
------------
------------
-- Drop procedures if exist
DROP PROCEDURE IF EXISTS
	usp_CalculateFutureValueForAccount
GO
------------
------------