USE SoftUni
GO

-- Create backup file
BACKUP DATABASE
	SoftUni
TO DISK = 'C:\softuni-backup.bak'
WITH
	NAME = 'Full Back of SoftUni Database'
GO

USE master
GO

-- Drop connections
ALTER DATABASE
	SoftUni
SET 
	SINGLE_USER 
WITH ROLLBACK 
	IMMEDIATE
GO

-- Drop database
DROP DATABASE
	SoftUni
GO

-- Restore database
RESTORE DATABASE
	SoftUni
FROM DISK = 'C:\softuni-backup.bak'
GO

USE SoftUni
GO