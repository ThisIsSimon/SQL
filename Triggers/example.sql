alter trigger TriggerName on table1
after update, insert
as

begin

insert into audit_table (
column1
,column2
)

select i.column1
      ,i.column2
from table1 t1
inner join inserted i on .ID = i.ID

end
