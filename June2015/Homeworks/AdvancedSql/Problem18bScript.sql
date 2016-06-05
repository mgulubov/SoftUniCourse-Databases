USE SoftUni
GO

ALTER TABLE
	Users
ADD
	CONSTRAINT 
		FK_Users_Groups
	FOREIGN KEY
		(GroupId)
	REFERENCES
		Groups(GroupId)