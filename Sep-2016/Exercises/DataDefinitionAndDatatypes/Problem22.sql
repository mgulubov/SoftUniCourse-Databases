USE SoftUni
GO
-------------------
-------------------
DECLARE employee_ids_cursor CURSOR
FOR
SELECT
	Id
FROM
	Employees

DECLARE @EmployeeId INT

OPEN employee_ids_cursor
FETCH NEXT FROM
	employee_ids_cursor
INTO
	@EmployeeId

WHILE @@FETCH_STATUS = 0
BEGIN
	DECLARE @IncreasedSalary FLOAT(2) = (
		SELECT
			e.Salary + (e.Salary * 0.1)
		FROM
			Employees e
		WHERE
			e.Id = @EmployeeId
	)

	UPDATE
		Employees
	SET
		Salary = @IncreasedSalary
	WHERE
		Id = @EmployeeId

	FETCH NEXT FROM
		employee_ids_cursor
	INTO
		@EmployeeId
END

CLOSE employee_ids_cursor
DEALLOCATE employee_ids_cursor
-------------------
-------------------
SELECT
	Salary
FROM
	Employees