﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LISTE_IMMEUBLE] 
(
	@PK_PROPRIETAIRE NVARCHAR(MAX)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 SELECT
	    D_MANDAT_GERANCE.FK_PROPRIETAIRE AS PK_PROPRIETAIRE
	  , D_IMMEUBLE.PK_IMMEUBLE
	  , D_IMMEUBLE.CD_IMMEUBLE
	  , D_IMMEUBLE.NM_IMMEUBLE
	  , D_IMMEUBLE.ADRLGN1
	  , UPPER(CONCAT(CAST(D_IMMEUBLE.CD_IMMEUBLE AS VARCHAR(4)) + ' - ', D_IMMEUBLE.ADRLGN1)) as NOM_IMMEUBLE
	  , D_MANDAT_GERANCE.IND_MANDAT_ACTIF
	FROM
	  D_MANDAT_GERANCE
	  INNER JOIN D_IMMEUBLE
		ON D_MANDAT_GERANCE.FK_IMMEUBLE = D_IMMEUBLE.PK_IMMEUBLE
	  INNER JOIN D_PROPRIETAIRE
		ON D_MANDAT_GERANCE.FK_PROPRIETAIRE = D_PROPRIETAIRE.PK_PROPRIETAIRE
	WHERE D_MANDAT_GERANCE.FK_PROPRIETAIRE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_PROPRIETAIRE,',')) 
	  --AND D_MANDAT_GERANCE.IND_MANDAT_ACTIF LIKE N'O'	   
   	ORDER BY CD_IMMEUBLE

END