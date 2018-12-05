-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE GET_ANNEE_EXERCICE_ENG 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DISTINCT TOP 5 CEXO 
	FROM MASTER_ESTIA..ESTIA_ECRIB
	ORDER BY CEXO DESC

END