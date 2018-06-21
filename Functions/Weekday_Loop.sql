/*
A function that takes two inputs - a date and the number of days it adds. The function will loop through and determine 
the business days added. Please note that the days added are exclusive, I.E. a Wednesday +3 days will be NEXT Monday, and not Friday.
*/

CREATE FUNCTION [dbo].FUNCTION_NAME (@addDate AS DATE, @numDays AS INT)
RETURNS DATETIME

AS

BEGIN

IF @numDays > 0

   WHILE @numDays>0

   BEGIN

      SET @addDate=DATEADD(d,1,@addDate)

      IF DATENAME(DW,@addDate)='saturday' SET @addDate=DATEADD(d,1,@addDate)

      IF DATENAME(DW,@addDate)='sunday' SET @addDate=DATEADD(d,1,@addDate)

      SET @numDays=@numDays-1

   END

ELSE IF @numDays < 0

WHILE @numDays < 0

   BEGIN

      SET @addDate=DATEADD(d,-1,@addDate)

      IF DATENAME(DW,@addDate)='saturday' SET @addDate=DATEADD(d,-1,@addDate)

      IF DATENAME(DW,@addDate)='sunday' SET @addDate=DATEADD(d,-1,@addDate)

      SET @numDays=@numDays+1

   END

   RETURN CAST(@addDate AS DATETIME)
END
