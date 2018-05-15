create trigger TRIGGER_NAME on TABLE_BEING_AUDITED
after update, insert --can also add in delete
as

begin

insert into AUDIT_TABLE (
COLUMN1
,COLUMN2
,COLUMN3
)

select i.COLUMN1
      ,i.COLUMN2
      ,i.COLUMN3
from TABLE_BEING_AUDITED T_B_A
inner join inserted i on T_B_A.ID = i.ID

end
