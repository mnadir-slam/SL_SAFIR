﻿

CREATE VIEW [dbo].[V_F_COMPTABILITE_LOCATAIRE]
AS
SELECT GETDATE() AS DT_REF
	 , CPTGLOB.PK_CPTGLOB AS PK_ECRITURE
	 , CPTGLOB.DATEC AS FK_TEMPS
	 , WGM.FK_TIERS AS FK_PROPRIETAIRE
	 , WGM.FK_MANGES AS FK_MANDAT_GERANCE
	 , CPTGLOB.FK_GROUPE AS FK_IMMEUBLE
	 , CPTGLOB.FK_BAIL
	 , CPTGLOB.FK_TIERS AS FK_LOCATAIRE
	 , ISNULL(CPTGLOB.FK_RUB, 0) AS FK_RUBRIQUE
	 , CASE WHEN CPTGLOB.CTYPECRI IN ('QHF', 'QTA', 'QTM', 'QUI') THEN 'O' ELSE 'N' END AS IND_QUITTANCEMENT
	 , CASE WHEN CPTGLOB.CTYPECRI NOT IN ('QHF', 'QTA', 'QTM', 'QUI', 'ALC') THEN 'O' ELSE 'N' END AS IND_ENCAISSEMENT
	 , CASE WHEN WBR.CRUB > 0 THEN 'O' ELSE 'N' END AS IND_ELEMENT_PERMANENT
	 , CPTGLOB.DATEC AS DT_COMPTABLE
	 , CASE WHEN ISNUMERIC(CPTGLOB.LETTRAGE) <> 0 
		AND LEFT(CPTGLOB.LETTRAGE, 6) BETWEEN '190001' AND '999900' THEN 
		CONVERT(DATE, LEFT(CPTGLOB.LETTRAGE, 6) + '01', 112) END AS DT_TERME
	 , CPTGLOB.DATEC AS DT_SAISIE
	 , CPTGLOB.TRAIT AS CD_TYPE_SAISIE
	 , CPTGLOB.REF AS NUM_SAISIE
	 , CPTGLOB.NOPIECE AS PIECE_COMPTABLE
	 , CPTGLOB.NOCHEQUE AS NUM_FACTURE
	 , CPTGLOB.LIB AS LB_ECRITURE
	 , CASE WHEN CPTGLOB.SENS = 'D' THEN CONVERT(NUMERIC(17,2), REPLACE(CPTGLOB.MONTANT, ',','.')) ELSE 0 END AS MT_DEBIT
	 , CASE WHEN CPTGLOB.SENS = 'C' THEN CONVERT(NUMERIC(17,2), REPLACE(CPTGLOB.MONTANT, ',','.')) ELSE 0 END AS MT_CREDIT
	 , CASE WHEN CPTGLOB.CTYPECRI IN ('QHF', 'QTA', 'QTM', 'QUI') THEN 
		CASE WHEN CPTGLOB.SENS = 'D' THEN CONVERT(NUMERIC(17,2), REPLACE(CPTGLOB.MONTANT, ',','.')) 
			ELSE CONVERT(NUMERIC(17,2), REPLACE(CPTGLOB.MONTANT, ',','.')) *-1 END ELSE 0 END AS MT_QUITTANCE
	 , CASE WHEN CPTGLOB.CTYPECRI NOT IN ('QHF', 'QTA', 'QTM', 'QUI', 'ALC') THEN 
		CASE WHEN CPTGLOB.SENS = 'C' THEN CONVERT(NUMERIC(17,2), REPLACE(CPTGLOB.MONTANT, ',','.')) 
			ELSE CONVERT(NUMERIC(17,2), REPLACE(CPTGLOB.MONTANT, ',','.')) *-1 END ELSE 0 END AS MT_ENCAISSE
	, CASE WHEN CPTGLOB.SENS = 'D' THEN CONVERT(NUMERIC(17,2), REPLACE(CPTGLOB.MONTANT, ',','.')) 
		ELSE CONVERT(NUMERIC(17,2), REPLACE(CPTGLOB.MONTANT, ',','.')) *-1 END AS MT_SOLDE
FROM dbo.WRK_BAIL_RUB AS WBR 
	RIGHT OUTER JOIN dbo.ESTIA_CPTGLOB AS CPTGLOB 
		ON WBR.NOBAIL = CPTGLOB.NOBAIL 
		AND WBR.CRUB = CPTGLOB.CALC_CRUB 
		AND WBR.CORG = CPTGLOB.CORG 
		AND WBR.CCOMPTE = CPTGLOB.CCOMPTE 
	LEFT OUTER JOIN dbo.WRK_GROUPE_MANGES AS WGM 
		ON CPTGLOB.FK_GROUPE = WGM.PK_GROUPE
WHERE     (CPTGLOB.TYPCPTA = 'LG')