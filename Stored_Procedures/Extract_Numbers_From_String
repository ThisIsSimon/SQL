/*
This query extracts numbers from a string by looking for an indication of ID#, and in the scenario that it fails, it will look for
the first set of number.

Keep in mind this will only work in the scenario that the id number is indicated by predecessing "word" (in this case, ID#)
OR the number being extracted has no random numbers before itself.

I.E. This is 500 a random ID#654654 
Will result in "654654" being extracted

I.E. This again is a random 546 statement 77
Will result in "546"

Take out begin transaction in the beginning and rollback in the end to run the actual query. Note I kept them in to test the update statement
before I fully commit it.
*/

--create procedure STORED_PROCEDURE_NAME as

begin transaction

begin try
update table1
set RelatedItemID =

left(substring(substring([EmailSubject], patindex('ID#', [EmailSubject]), len([EmailSubject])), patindex('%[0-9]%', substring([EmailSubject], patindex('ID#', [EmailSubject]), len([EmailSubject]))), len(substring([EmailSubject], patindex('ID#', [EmailSubject]), len([EmailSubject])))), charindex(' ', substring(substring([EmailSubject], patindex('ID#', [EmailSubject]), len([EmailSubject])), patindex('%[0-9]%', substring([EmailSubject], patindex('ID#', [EmailSubject]), len([EmailSubject]))), len(substring([EmailSubject], patindex('ID#', [EmailSubject]), len([EmailSubject]))))))
where [EmailSubject] like '%Missing Information%' 
and [EmailSubject] like '%id#%'
and relateditemid is  null
and assignedtorid is null
and assignedtoname is null
and currentstatus = 1
end try

--if the first method fails, try this method before blowing up
begin catch
update table1
set RelatedItemID = 

left(subsrt, patindex('%[^0-9]%', subsrt + 't') - 1) 
from (
    select subsrt = substring(emailsubject, pos, len(emailsubject))
	      --,EmailSubject
		  ,id
    from (
        select id, emailsubject, pos = patindex('%[0-9]%', emailsubject)
        from [LifeMap].[dbo].[LifeMap_Work_Items]
		where [EmailSubject] like '%Missing Information%' 
		and [EmailSubject] like '%id#%'
		and relateditemid is  null
		and assignedtorid is null
		and assignedtoname is null
		 ) d
     ) t
inner join LifeMap_Work_Items t1 on t1.id = t.id
end catch
select id, EmailSubject,RelatedItemID from LifeMap_Work_Items
where [EmailSubject] like '%Missing Information%' 
	and [EmailSubject] like '%id#%'

rollback
