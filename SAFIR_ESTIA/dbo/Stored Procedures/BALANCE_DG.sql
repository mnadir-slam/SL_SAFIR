﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BALANCE_DG]
( 
	@DT_FIN DATETIME,
	@PK_PROPRIETAIRE NVARCHAR(MAX),
	@PK_IMMEUBLE NVARCHAR(MAX)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT FK_PROPRIETAIRE
     , FK_GROUPE
	 , 'DEP_GAR' AS SOUS_COMPTE
     , CORG
	 , CAGENCE
	 , CGROUPE
	 , NOM_PROPRIETAIRE
	 , CIMMEUB
	 , CLOCAL
	 , OCC
	 , CCOMPTE
	 , NOM_LOCATAIRE
	 , DT_ENTREE
	 , DT_SORTIE
	 , CUMUL_ANT_DEBIT
	 , CUMUL_ANT_CREDIT
	 , PERIODE_DEBIT
	 , PERIODE_CREDIT
	 , CASE WHEN PERIODE_DEBIT > PERIODE_CREDIT THEN PERIODE_DEBIT - PERIODE_CREDIT ELSE 0 END AS SOLDE_DEBIT
	 , CASE WHEN PERIODE_DEBIT < PERIODE_CREDIT THEN PERIODE_CREDIT -  PERIODE_DEBIT ELSE 0 END AS SOLDE_CREDIT
	 , CAST(NULL AS VARCHAR(50)) AS ORG_PAYEUR
FROM
(
	SELECT    PROPRIETAIRE.PK_TIERS AS FK_PROPRIETAIRE
	        , CPTGLOB.FK_GROUPE
			, CPTGLOB.CORG
			, LOCATION.CAGENCE
			, LOCATION.CGROUPE
			, PROPRIETAIRE.LTIERS AS NOM_PROPRIETAIRE
			, LOCATION.CIMMEUB
			, LOCATION.CLOCAL
			, LOCATION.OCC
			, LOCATION.CCOMPTE
			, LOCATAIRE.LTIERS AS NOM_LOCATAIRE
			, LOCATION.DATEFFET AS DT_ENTREE
			, LOCATION.DATSORQUIT AS DT_SORTIE
			, CAST(NULL AS NUMERIC(18,2)) AS CUMUL_ANT_DEBIT
			, CAST(NULL AS NUMERIC(18,2)) AS CUMUL_ANT_CREDIT
			, SUM(CASE CPTGLOB.SENS WHEN 'D' THEN CPTGLOB.MONTANT ELSE 0 END) AS PERIODE_DEBIT
			, SUM(CASE CPTGLOB.SENS WHEN 'C' THEN CPTGLOB.MONTANT ELSE 0 END) AS PERIODE_CREDIT
	FROM MASTER_ESTIA..ESTIA_CPTGLOB CPTGLOB
	LEFT JOIN MASTER_ESTIA..ESTIA_LOCATION LOCATION
	ON LOCATION.PK_LOCATION = CPTGLOB.FK_BAIL
	LEFT JOIN MASTER_ESTIA..ESTIA_GROUPE GROUPE 
	ON GROUPE.PK_GROUPE = CPTGLOB.FK_GROUPE
	LEFT JOIN MASTER_ESTIA..WRK_GROUPE_MANGES WGM
	ON WGM.CORG = GROUPE.CORG AND WGM.CAGENCE = GROUPE.CAGENCE AND WGM.CGROUPE = GROUPE.CGROUPE
	LEFT JOIN MASTER_ESTIA..ESTIA_TIERS PROPRIETAIRE
	on PROPRIETAIRE.PK_TIERS = WGM.FK_TIERS
	LEFT JOIN MASTER_ESTIA..ESTIA_TIERS LOCATAIRE
	on LOCATAIRE.PK_TIERS = CPTGLOB.FK_TIERS
	WHERE CPTGLOB.CORG = '11' 
	AND PROPRIETAIRE.PK_TIERS IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_PROPRIETAIRE,',')) 
	AND GROUPE.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	AND CPTGLOB.DATEC <= @DT_FIN
	AND CPTGLOB.TYPCPTA = 'LD'
	GROUP BY  PROPRIETAIRE.PK_TIERS
	        , CPTGLOB.FK_GROUPE
			, CPTGLOB.CORG
			, LOCATION.CAGENCE
			, LOCATION.CGROUPE
			, PROPRIETAIRE.LTIERS
			, LOCATION.CIMMEUB
			, LOCATION.CLOCAL
			, LOCATION.OCC
			, LOCATION.CCOMPTE
			, LOCATAIRE.LTIERS
			, LOCATION.DATEFFET
			, LOCATION.DATSORQUIT
) RES
ORDER BY CORG
	 , CAGENCE
	 , CGROUPE
	 , NOM_PROPRIETAIRE
	 , CIMMEUB
	 , CLOCAL
	 , OCC
	 , CCOMPTE


END