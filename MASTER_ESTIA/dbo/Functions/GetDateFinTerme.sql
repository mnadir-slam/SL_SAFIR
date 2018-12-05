
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetDateFinTerme] 
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
		when '01' then DATEADD(DAY, -1, DATEADD(MONTH, DATEDIFF(MONTH, 0, @DT_COMPTABLE) + 1, 0))
		when '03' then DATEADD(DAY, -1, DATEADD(quarter, DATEDIFF(quarter, 0, @DT_COMPTABLE) + 1, 0))
		when '06' then DATEADD(DAY, -1, DATEADD(MONTH, ((DATEDIFF(quarter, 0, @DT_COMPTABLE) / 2) * 6) + 6, 0))
		when '12' then DATEADD(DAY, -1, DATEADD(YEAR , DATEDIFF(YEAR, 0, @DT_COMPTABLE) + 1, 0))
	END 

END