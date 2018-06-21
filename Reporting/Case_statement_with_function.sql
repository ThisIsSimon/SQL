/*
Case statement that helps assign a priority number according to a business logic based on dates. The function called that helps
determine business/working days can be found here: https://github.com/ThisIsSimon/SQL/blob/master/Functions/Weekday_Loop
*/

SELECT [Priority_Number] = CASE WHEN 
							                      Column_Date >= convert(date, getdate()) and Column_Date <= convert(date, Function_That_Determines_WorkingDays(getdate(), 2)) then 1
						                    WHEN
							                      convert(date, getdate()) >  convert(date, Function_That_Determines_WorkingDays(coalesce(ReceivedDate, loadeddate), 9)) then 2
						                    WHEN
							                      convert(date, getdate()) > convert(date, Function_That_Determines_WorkingDays(Column_Date, 2)) then 3
						                    WHEN
							                      Column_Date < convert(date, getdate()) then 4
					                      WHEN
						                        coalesce(receiveddate, loadeddate) <= convert(date, Function_That_Determines_WorkingDays(coalesce(receiveddate, loadeddate), 9)) then 5
                           END
       ,[BatchDate] = Column_Date
       ,[Received/Loaded] = coalesce(receiveddate, loadeddate)
from table1

/*
IMPORTANT NOTES:

ALL FUNCTION CALCULATED DATES ARE (DATETIMES) CURRENTLY EXCLUSIVE AND BUSINESS DATES
       I.E. Function_That_Determines_WorkingDays('2018/05/09', 2) GIVES YOU '2018-05-11 00:00:00.000' AND NOT '2018/05/10 00:00:00.000'
       I.E. Function_That_Determines_WorkingDays('2018/05/09', 3) GIVES YOU '2018/05/14 00:00:00.000' BECAUSE '2018/05/09 00:00:00.000' IS A WEDNESDAY AND THE 12TH WOULD BE THE SATURDAY

Priority 1 IS INCLUSIVE I.E. TODAY, TOMORROW AND DAY AFTER IS COUNTED

Priority 2 IS EXCLUSIVE I.E. GREATER THAN 9 OR (EQUAL TO OR GREATER THAN 10)

Priority 3 IS EXCLUSIVE I.E. GREATER THAN 2 OR (EQUAL TO OR GREATER THAN 3)

Priortiy 4 IS EXCLUSIVE

Priority 5 is INCLUSIVE I.E. EQUAL TO OR LESS THAN

CONVERT IS A SQL SERVER SPECIFIC FUNCTION, USE CAST FOR ANSI-STANDARD

*/
