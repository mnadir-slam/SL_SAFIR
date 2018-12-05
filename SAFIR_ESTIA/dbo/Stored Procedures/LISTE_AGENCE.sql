-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LISTE_AGENCE] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DISTINCT 
	  AGENCE.PK_AGENCE
	, AGENCE.CAGENCE
	, AGENCE.LAGENCE
	, AGENCE.CAGENCE + ' - ' + AGENCE.LAGENCE AS NOM_AGENCE
	FROM MASTER_ESTIA..ESTIA_AGENCE AGENCE
	WHERE CORG = '11'
	ORDER BY AGENCE.CAGENCE

END