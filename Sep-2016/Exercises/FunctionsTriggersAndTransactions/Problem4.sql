USE SoftUni
GO
-------------
-------------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_GetEmployeesFromTown
GO
-------------
-------------
-- Create procedure
CREATE PROCEDURE
	usp_GetEmployeesFromTown
		@EmployeeTownName NVARCHAR(MAX)
AS
BEGIN
	SELECT
		e.FirstName,
		e.LastName
	FROM
		Employees e
			INNER JOIN
				Addresses a ON
					a.AddressID = e.AddressID
			INNER JOIN
				Towns t ON
					t.TownID = a.TownID
	WHERE
		t.Name = @EmployeeTownName
END
GO
-------------
-------------
-- Execute procedure
EXECUTE usp_GetEmployeesFromTown @EmployeeTownName = 'Sofia'