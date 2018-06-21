/*
For a specific business unit, this query finds the LATEST work that is not completed per lineofbusiness
*/

/*CREATE VIEW view_name
AS*/
SELECT ID
       ,[Line Of Business] = LineOfBusiness
	     ,[Unit ID] = UnitID
	     ,[Billing Entity Name] = Billing_entity_name
	     ,[Group Identification Number] = Billing_Entity_ID
	     ,[Current Status] = CurrentStatus
	     ,[Date Added To Tool] = DateAddedToTool
	     ,[Date Last Reported On] = DateLastOnReport
	     ,[Responsible] = AssignedToName
FROM (SELECT ID 
             ,LineOfBusiness
             ,UnitID
             ,CASE WHEN Billing_entity_name IS NULL THEN GroupName ELSE Billing_entity_name END AS Billing_entity_name
             ,CASE WHEN Billing_Entity_ID IS NULL THEN GroupID ELSE Billing_entity_id END AS Billing_Entity_id
             ,CurrentStatus
             ,DateAddedToTool
             ,DateLastOnReport
             ,CASE WHEN AssignedToName IS NULL THEN 'Not Assigned' ELSE AssignedToName END AS AssignedToName
             ,ROW_NUMBER() OVER(PARTITION BY LineOfBusiness, UnitID ORDER BY DateAddedToTool ASC) rn
       FROM table1 t1
       WHERE DateCompletedByProcessor IS NULL
       AND
	     Work_Source IN ('MEM103','REC108')
     ) t1
WHERE t1.rn = 1


