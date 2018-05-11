/*
Here is a format showing an example of an update using a common table expression (CTE) with the help of a function LAG

BEGIN TRANSACTION and ROLLSBACK TRANSACTION are used so I can see the changes the update has on the table before 
committing the query

This query is used to update a column showing who was the previous owner of a specific item into the same row. I aggregate the table
and then up update it by referencing it back on itself with the CTE. Alternatively you may JOIN the aggregated table as a derived
table.
*/

BEGIN TRANSACTION

;WITH cte_old_owner as
(
	SELECT *
	FROM
	(
		SELECT ID
			     ,column1
			     ,column2
			     ,new_owner
			     ,older_owner = lag(new_owner,1) over(partition by column1 order by column1)
		FROM table1
		WHERE column = 'SOMETHING'
	) t
	where t.old_owner is not null
)

update table1
set previous_owner = old_owner
from cte_old_owner
where cte_old_owner.id = table1.id

select *
from table1


ROLLBACK TRANSACTION
