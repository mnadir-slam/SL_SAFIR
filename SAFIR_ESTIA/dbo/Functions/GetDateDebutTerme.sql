
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetDateDebutTerme] 
(
	-- Add the parameters for the function here
	@DT_COMPTABLE  DATETIME,
	@CD_FREQ_QUIT  VARCHAR(2)
)
RETURNS DATETIME
AS
BEGIN

	-- Return the result of the function
	RETURN CASE @CD_FREQ_QUIT
		WHEN '01' THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, @DT_COMPTABLE), 0)
		WHEN '03' THEN DATEADD(QUARTER, DATEDIFF(QUARTER, 0, @DT_COMPTABLE), 0)
		WHEN '06' THEN DATEADD(MONTH, (DATEDIFF(QUARTER, 0, @DT_COMPTABLE) / 2) * 6, 0)
		WHEN '12' THEN DATEADD(YEAR , DATEDIFF(YEAR, 0, @DT_COMPTABLE), 0)
	END 

END