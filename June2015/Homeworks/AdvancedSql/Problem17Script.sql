USE SoftUni
GO

-- Delete table if it already exists
IF OBJECT_ID('Groups') IS NOT NULL
	DROP TABLE Groups
GO

-- Create table
CREATE TABLE Groups(
	GroupId int IDENTITY NOT NULL,
	Name nvarchar(50) NOT NULL

	CONSTRAINT PK_Groups
		PRIMARY KEY(GroupId),
	CONSTRAINT UN_Groups
		UNIQUE(Name)
)
GO