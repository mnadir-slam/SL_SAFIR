-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LISTE_SOCIETE] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT ORG.PK_ORG AS PK_SOC
	 , ORG.CORG AS CD_SOCIETE
	 , CAST(ORG.CORG AS VARCHAR(14)) + ' - ' + ORG.LORG AS NOM_SOCIETE
FROM
	MASTER_ESTIA..ESTIA_ORG ORG

END