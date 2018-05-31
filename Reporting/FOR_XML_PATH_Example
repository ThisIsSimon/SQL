/*
Main Table sample:
+----+
| ID |
+----+
|  1 |
|  2 |
|  3 |
|  4 |
+----+

CommentTable sample:
+----+-------------+-----------+
| ID | ReferenceID | Comments  |
+----+-------------+-----------+
|  1 |           1 | comment1  |
|  2 |           1 | comment20 |
|  3 |           2 | comment33 |
|  4 |           3 | comment4  |
+----+-------------+-----------+

The query combines all of the comments into one column, separated by semicolons. STUFF is just used to remove the first leading semicolon
+-------------+---------------------+
| ReferenceID |      Comments       |
+-------------+---------------------+
|           1 | comment1; comment20 |
|           2 | comment33           |
|           3 | comment4            |
+-------------+---------------------+
*/


select ID
	   ,stuff((select '; ' + Comment
	           from CommentTable ct
		       where mt.ID = ct.AuditID
		       for XML PATH('')), 1, 1, '') Comments
from MainTable mt
group by ID, AuditID
order by 1
