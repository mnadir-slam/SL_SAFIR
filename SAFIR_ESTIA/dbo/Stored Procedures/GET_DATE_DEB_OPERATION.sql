-- =============================================
-- Author:		Mario NADIR
-- Create date: 2017-08-25
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_DATE_DEB_OPERATION] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DISTINCT
		DATEPART(YEAR, TRANCHE.DDEXEC) AS ANNEE_DEB_OPERATION
	FROM MASTER_ESTIA..ESTIA_TRANCHE TRANCHE
	ORDER BY DATEPART(YEAR, TRANCHE.DDEXEC) DESC

END