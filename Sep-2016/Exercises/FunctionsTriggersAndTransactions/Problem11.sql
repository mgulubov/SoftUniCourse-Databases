USE master

DROP FUNCTION IF EXISTS
	ufn_CalculateFutureValue
GO

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

SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)
GO

DROP FUNCTION IF EXISTS
	ufn_CalculateFutureValue
GO