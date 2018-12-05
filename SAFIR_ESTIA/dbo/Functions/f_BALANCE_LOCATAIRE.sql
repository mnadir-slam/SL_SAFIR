﻿CREATE FUNCTION [dbo].[f_BALANCE_LOCATAIRE] 
(
	@DT_FIN DATETIME--,
	--@PK_PROPRIETAIRE INT--,
	--@PK_IMMEUBLE NVARCHAR(MAX)
)
RETURNS @retBALANCE_LOCATAIRE TABLE   
(  
	FK_PROPRIETAIRE int,
	FK_GROUPE int,
	SOUS_COMPTE varchar(10) NULL,
	CORG varchar(4) NULL,
	CAGENCE varchar(4) NULL,
	CGROUPE int NULL,
	LGROUPE varchar(64) NULL,
	NOM_PROPRIETAIRE varchar(76),
	CIMMEUB int NULL,
	CLOCAL int NULL,
	OCC int NULL,
	CCOMPTE varchar(22) NULL,
	NOM_LOCATAIRE varchar(76) NULL,
	DT_ENTREE date,
	DT_SORTIE date,
	CUMUL_ANT_DEBIT numeric(17, 2) NULL,
	CUMUL_ANT_CREDIT numeric(17, 2) NULL,
	PERIODE_DEBIT  numeric(17, 2) NULL,
	PERIODE_CREDIT  numeric(17, 2) NULL,
	SOLDE_DEBIT  numeric(17, 2) NULL,
	SOLDE_CREDIT  numeric(17, 2) NULL,
	ORG_PAYEUR varchar(50) NULL

)  
--Returns a result set that lists all the employees who report to the   
--specific employee directly or indirectly.*/  
AS  
BEGIN  
WITH BALANCE_LOCATAIRE_cte(FK_PROPRIETAIRE, FK_GROUPE, SOUS_COMPTE, CORG, CAGENCE, CGROUPE, LGROUPE, NOM_PROPRIETAIRE, CIMMEUB, CLOCAL, OCC, CCOMPTE, NOM_LOCATAIRE, DT_ENTREE, DT_SORTIE, CUMUL_ANT_DEBIT, CUMUL_ANT_CREDIT, PERIODE_DEBIT, PERIODE_CREDIT, SOLDE_DEBIT, SOLDE_CREDIT, ORG_PAYEUR)
AS
(
	SELECT FK_PROPRIETAIRE
		 , FK_GROUPE
		 , 'GENERAL' AS SOUS_COMPTE
		 , CORG
		 , CAGENCE
		 , CGROUPE
		 , LGROUPE
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
				, GROUPE.LGROUPE
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
		--AND PROPRIETAIRE.PK_TIERS = @PK_PROPRIETAIRE
		--AND GROUPE.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
		AND CPTGLOB.DATEC <= @DT_FIN
		--AND CPTGLOB.DATEC BETWEEN @DT_DEBUT AND @DT_FIN
		AND CPTGLOB.TYPCPTA = 'LG'
		GROUP BY  PROPRIETAIRE.PK_TIERS
				, CPTGLOB.FK_GROUPE
				, CPTGLOB.CORG
				, LOCATION.CAGENCE
				, LOCATION.CGROUPE
				, GROUPE.LGROUPE
				, PROPRIETAIRE.LTIERS
				, LOCATION.CIMMEUB
				, LOCATION.CLOCAL
				, LOCATION.OCC
				, LOCATION.CCOMPTE
				, LOCATAIRE.LTIERS
				, LOCATION.DATEFFET
				, LOCATION.DATSORQUIT
	) RES
)

-- copy the required columns to the result of the function   
   INSERT @retBALANCE_LOCATAIRE 
   SELECT FK_PROPRIETAIRE, FK_GROUPE, SOUS_COMPTE, CORG, CAGENCE, CGROUPE, LGROUPE, NOM_PROPRIETAIRE, CIMMEUB, CLOCAL, OCC, CCOMPTE, NOM_LOCATAIRE, DT_ENTREE, DT_SORTIE, CUMUL_ANT_DEBIT, CUMUL_ANT_CREDIT, PERIODE_DEBIT, PERIODE_CREDIT, SOLDE_DEBIT, SOLDE_CREDIT, ORG_PAYEUR
   FROM BALANCE_LOCATAIRE_cte   
   RETURN  
END;