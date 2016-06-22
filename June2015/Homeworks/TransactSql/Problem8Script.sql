USE SoftUni
GO

IF CURSOR_STATUS('global','emp_pairs_per_town')>=-1
BEGIN
	CLOSE emp_pairs_per_town
	DEALLOCATE emp_pairs_per_town
END

DECLARE emp_pairs_per_town CURSOR FOR
	SELECT
		fe.FirstName,
		fe.LastName,
		t.Name,
		se.FirstName,
		se.LastName
	FROM
		Employees fe
			JOIN
				Addresses a
			ON
				fe.AddressID = a.AddressID,
		Employees se
			JOIN
				Addresses sa
			ON
				se.AddressID = sa.AddressID, 
		Towns t
	WHERE
		t.TownID = a.TownID
	AND
		(SELECT Name FROM Towns WHERE Towns.TownID = a.TownID)
			=
		(SELECT Name FROM Towns WHERE Towns.TownID = sa.TownID)

DECLARE @FeFirstName nvarchar(100)
DECLARE @FeLastName nvarchar(100)
DECLARE @TownName nvarchar(100)
DECLARE @SeFirstName nvarchar(100)
DECLARE @SeLastName nvarchar(100)

OPEN 
	emp_pairs_per_town
FETCH NEXT FROM
	emp_pairs_per_town
INTO
	@FeFirstName,
	@FeLastName,
	@TownName,
	@SeFirstName,
	@SeLastName

WHILE
	@@FETCH_STATUS = 0
BEGIN
	PRINT @SeLastName + ': ' + @FeFirstName + ' ' + @FeLastName + ' ' + @TownName + ' ' + @SeFirstName

	FETCH NEXT FROM
		emp_pairs_per_town
	INTO
		@FeFirstName,
		@FeLastName,
		@TownName,
		@SeFirstName,
		@SeLastName
END

CLOSE 
	emp_pairs_per_town
DEALLOCATE
	emp_pairs_per_town
				


