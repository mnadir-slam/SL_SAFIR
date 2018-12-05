-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LISTE_SIREN_FOURNISSEUR] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 SELECT SIRET
 FROM
 (
	 SELECT DISTINCT LEFT(TIERS.SIRET, 10) AS SIRET
	 FROM MASTER_ESTIA..ESTIA_TIERS TIERS
	 LEFT JOIN MASTER_ESTIA..ESTIA_FINDIV FINDIV
	 ON FINDIV.CTIERS = TIERS.CTIERS
	 WHERE TIERS.SIRET IS NOT NULL
	 --AND LEFT(TIERS.SIRET, 10) = @PK_SIREN
	 AND ISNULL(FINDIV.FINGEST, '29990101') > GETDATE()
 ) REQ
 ORDER BY SIRET 

END