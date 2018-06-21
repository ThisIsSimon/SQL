CREATE PROCEDURE procedure_name AS
(
IF OBJECT_ID('dbo.table1_backup', 'U') IS NOT NULL --Make sure the table exists with content
DROP TABLE dbo.table1_backup --Drop the table
SELECT * INTO table1_backup -- select new information into backup table
FROM table1

IF OBJECT_ID('dbo.table2_backup', 'U') IS NOT NULL
DROP TABLE dbo.table2_backup
SELECT * INTO dbo.table2_backup
FROM table2
)
