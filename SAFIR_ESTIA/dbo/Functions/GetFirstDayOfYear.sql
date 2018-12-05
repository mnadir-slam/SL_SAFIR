-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION GetFirstDayOfYear( @pDate date)
RETURNS date
AS
BEGIN

	RETURN DATEADD(YEAR , DATEDIFF(YEAR, 0, @pDate), 0)

END