USE SoftUni
GO

-- Drop function if exists
IF OBJECT_ID(N'FuncSelectTownsAndNamesComprisedOf', N'FN') IS NOT NULL
	DROP FUNCTION FuncSelectTownsAndNamesComprisedOf
GO

CREATE FUNCTION 
	FuncSelectTownsAndNamesComprisedOf
(
	@ComprisedOfString nvarchar(100)
)
RETURNS
	@TownsAndNamesComprisedOf TABLE(
		Name nvarchar(150)
	)
AS
BEGIN
	DECLARE @TownsAndNamesTable TABLE (
		Name nvarchar(150)
	)
	INSERT @TownsAndNamesTable
		SELECT
			e.FirstName
				AS 'Name'
		FROM
			Employees e
		UNION ALL
		SELECT
			e.MiddleName
		FROM
			Employees e
		UNION ALL
		SELECT
			e.LastName
		FROM
			Employees e
		UNION ALL
		SELECT
			t.Name
		FROM
			Towns t

	INSERT @TownsAndNamesComprisedOf
		SELECT
			Name
		FROM 
			@TownsAndNamesTable
		WHERE
			Name NOT LIKE CONCAT('%[^', @ComprisedOfString, ']%')

	RETURN
END
GO

-- Test function
SELECT
	*
FROM
	FuncSelectTownsAndNamesComprisedOf('oistmiahf')

	