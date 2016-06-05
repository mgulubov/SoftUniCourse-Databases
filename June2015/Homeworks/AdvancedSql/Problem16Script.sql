use SoftUni
GO

CREATE VIEW
	TodayUsers
AS
	SELECT
		*
	FROM
		Users u
	WHERE
		u.LastLoginDate = GETDATE()