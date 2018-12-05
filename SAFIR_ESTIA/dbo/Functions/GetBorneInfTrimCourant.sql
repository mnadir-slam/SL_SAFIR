
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetBorneInfTrimCourant] 
(
	-- Add the parameters for the function here
	@DT_ANALYSE  DATETIME,
	@DT_COMP  DATETIME
)
RETURNS DATETIME
AS
BEGIN

	-- Return the result of the function
	RETURN	CASE WHEN @DT_COMP <= DATEADD(quarter, DATEDIFF(quarter, 0, @DT_ANALYSE), 0) THEN 
		CONVERT(VARCHAR(10), DATEADD(quarter, DATEDIFF(quarter, 0, @DT_ANALYSE), 0), 103) ELSE CONVERT(VARCHAR(10), @DT_COMP, 103) END 

END