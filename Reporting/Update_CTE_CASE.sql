/*
This query utilizes a common table expression to use a CASE statement to figure out the due date.

The business logic is as follows:

if the item is uploaded before 12:00pm (exclusive), the due date is in 2 days

if the item is uploaded after 12:00pm (inclusive), the due date is in 3 days

In the update we account for weekends:

if the due date is saturday, add 2 days and make the due date monday
if the due date is sunday, add 1
else keep its' original due date
*/

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
