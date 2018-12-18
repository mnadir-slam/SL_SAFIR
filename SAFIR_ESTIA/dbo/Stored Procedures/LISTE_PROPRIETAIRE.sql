﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LISTE_PROPRIETAIRE] 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT DISTINCT 
	  D_PROPRIETAIRE.PK_PROPRIETAIRE
	, D_PROPRIETAIRE.CD_PROPRIETAIRE
	, D_PROPRIETAIRE.NM_PROPRIETAIRE
	--, CAST(D_PROPRIETAIRE.NM_PROPRIETAIRE AS VARCHAR(14)) + ' - ' + D_PROPRIETAIRE.NOM_PROPRIETAIRE + ' ' + D_PROPRIETAIRE.PRENOM_PROPRIETAIRE AS NOM_PROPRIETAIRE
	, CONCAT(D_PROPRIETAIRE.CD_PROPRIETAIRE + ' - ' + D_PROPRIETAIRE.NOM_PROPRIETAIRE + ' ', D_PROPRIETAIRE.PRENOM_PROPRIETAIRE) AS NOM_PROPRIETAIRE
	FROM D_PROPRIETAIRE
	--WHERE D_PROPRIETAIRE.PK_PROPRIETAIRE IN (10853, 5879, 6318)
	ORDER BY D_PROPRIETAIRE.NM_PROPRIETAIRE

END