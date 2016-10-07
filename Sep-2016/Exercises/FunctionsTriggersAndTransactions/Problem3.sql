USE SoftUni
GO
---------------
---------------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_GetTownsStartingWith 
GO
---------------
---------------
-- Create procedure
CREATE PROCEDURE
	usp_GetTownsStartingWith
		@StartingString NVARCHAR(MAX)
AS
BEGIN
	SELECT
		t.Name AS Town
	FROM
		Towns t
	WHERE
		t.Name LIKE (@StartingString + '%')
END
GO
---------------
---------------
-- Callc procedure
EXECUTE usp_GetTownsStartingWith @StartingString = 'b'