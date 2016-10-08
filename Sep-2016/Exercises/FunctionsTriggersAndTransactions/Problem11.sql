USE master
---------------
---------------
-- Drop function if exists
DROP FUNCTION IF EXISTS
	ufn_CalculateFutureValue
GO
---------------
---------------
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
---------------
---------------
-- Call function
SELECT dbo.ufn_CalculateFutureValue(1000, 0.1, 5)
GO
---------------
---------------
-- Drop function if exists
DROP FUNCTION IF EXISTS
	ufn_CalculateFutureValue
GO