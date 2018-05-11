--A trigger format used to prevent the deleting of more than one item

CREATE TRIGGER trigger_name --CREATE or ALTER depending if you need to CREATE OR ALTER it
ON dbo.example_table --TABLE 

FOR DELETE AS
IF(SELECT COUNT(*) FROM DELETED) >= 2 --if x or more are deleted then throw error
BEGIN
THROW 51000,'THIS IS A PRODUCTION TABLE, YOU MAY NOT DELETE MORE THAN X RECORDS!', 1 --only change message inside single quotes
END
