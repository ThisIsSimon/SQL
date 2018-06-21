/*
An example of a stored procedure that deletes duplicates (incase of multiple uploads or human error), then inserting the records
into the actual working table and then emptying the the staging table. Our team kept the staging tables open - you may alternatively
start the procedure with the creation of the table and then dumping it at the end
*/

create procedure STORED_PROCEDURE_NAME as

BEGIN

--Delete all duplicate items on the staging/temp table
BEGIN
with CTE_NAME as 
(
	SELECT ROW_NUMBER() OVER(PARTITION BY ssn, last_name, first_name, relationship ORDER BY upload_date) rn
	FROM STAGING_TEMP_TABLE
	WHERE ssn IS NOT NULL
)

DELETE from CTE_NAME
WHERE rn > 1
END

--Determine Target Date
BEGIN
;WITH cte1 AS
(
	SELECT DueDate = CASE WHEN LEFT(CONVERT(varchar(8), upload_date, 108), 2) >= 12 THEN dateadd(day, 3, upload_date)
						            WHEN LEFT(CONVERT(varchar(8), upload_date, 108), 2) < 12 THEN dateadd(day, 2, upload_date)
						            ELSE NULL
					         END
				 ,id
	FROM table1
)

UPDATE table1
SET Target_Date = CASE WHEN DATEPART(dw, DueDate) = 7 THEN dateadd(day, 2, DueDate)
		                   WHEN DATEPART(dw, DueDate) = 1 THEN dateadd(day, 1, DueDate)
		                   ELSE DueDate
		              END
FROM cte1
INNER JOIN table1 ON cte1.id = table1.id
END

--Insert records into main table
BEGIN
INSERT INTO ACTUAL_TABLE
(
	 [Employee_ID]
	,[COLUMN1]
  ,[COLUMN2]
)
SELECT
       [Employee_ID]
      ,[COLUMN1]
      ,[COLUMN2]
FROM StagingTable
END

--Delete from staging table
BEGIN
DELETE FROM StagingTable
END

END
