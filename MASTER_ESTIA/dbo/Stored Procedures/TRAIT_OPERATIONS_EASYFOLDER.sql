﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TRAIT_OPERATIONS_EASYFOLDER]
AS
BEGIN

SET ANSI_WARNINGS OFF

DECLARE @DT DATETIME
SET @DT = CONVERT(DATETIME, CONVERT(VARCHAR(10),GETDATE(),103), 103)

DELETE FROM WRK_INTERFACE_EASYFOLDER_OPERATIONS WHERE PK_TEMPS = @DT AND IFC_STATUT_TRAITEMENT IS NOT NULL;

-- AJOUT DES NOUVELLES OPERATIONS DANS LA TABLE WRK_INTERFACE_EASYFOLDER_OPERATIONS
INSERT INTO WRK_INTERFACE_EASYFOLDER_OPERATIONS(PK_TEMPS, ACTION, CD_OPERATION, CD_TRANCHE, LB_OPERATION, CD_IMMEUBLE, NOM_IMMEUBLE_ESTIA, DT_DEB_OPERATION)
SELECT @DT AS PK_TEMPS
	 , 'ADD' AS ACTION
	 , CD_OPERATION
	 , CD_TRANCHE
	 , LB_OPERATION
	 , CD_IMMEUBLE
	 , NOM_IMMEUBLE_ESTIA
	 , DT_DEB_OPERATION
FROM
(
	SELECT POPE.COPE AS CD_OPERATION
		 , TRANCHE.CTRANCHE AS CD_TRANCHE
		 , CASE WHEN CAST(TRANCHE.CTRANCHE AS varchar(10)) <> '1' THEN 
			CONCAT(CONCAT(CAST(POPE.LOPE AS VARCHAR(100)) + ' - ', CAST(POPE.NOMTECH AS VARCHAR(100))), ' - TRANCHE_' + CAST(TRANCHE.CTRANCHE AS varchar(10))) ELSE CONCAT(CAST(POPE.LOPE AS VARCHAR(100)) + ' - ', CAST(POPE.NOMTECH AS VARCHAR(100))) END as LB_OPERATION
		 , POPE.CGROUPE as CD_IMMEUBLE
		 , GROUPE.LGROUPE as NOM_IMMEUBLE_ESTIA
		 , TRANCHE.DDEXEC as DT_DEB_OPERATION
	FROM ESTIA_POPE POPE
	LEFT OUTER JOIN ESTIA_TRANCHE TRANCHE
	ON TRANCHE.COPE = POPE.COPE
	LEFT OUTER JOIN ESTIA_GROUPE GROUPE
	ON GROUPE.CORG = POPE.CORG AND GROUPE.CGROUPE = POPE.CGROUPE
	INNER JOIN V_D_MANDAT_GERANCE MANDAT
	ON FK_IMMEUBLE = PK_GROUPE
	WHERE POPE.CORG = '11'
	AND LEFT(POPE.COPE, 4) >= 2016
	AND MANDAT.IND_MANDAT_ACTIF = 'O'
	--UNION
	--SELECT POPE.COPE AS CD_OPERATION
	--	 , TRANCHE.CTRANCHE AS CD_TRANCHE
	--	 , CASE WHEN CAST(TRANCHE.CTRANCHE AS varchar(10)) <> '1' THEN 
	--		CONCAT(CONCAT(CAST(POPE.LOPE AS VARCHAR(100)) + ' - ', CAST(POPE.NOMTECH AS VARCHAR(100))), ' - TRANCHE_' + CAST(TRANCHE.CTRANCHE AS varchar(10))) ELSE CONCAT(CAST(POPE.LOPE AS VARCHAR(100)) + ' - ', CAST(POPE.NOMTECH AS VARCHAR(100))) END as LB_OPERATION
	--	 , POPE.CGROUPE as CD_IMMEUBLE
	--	 , GROUPE.LGROUPE as NOM_IMMEUBLE_ESTIA
	--	 , TRANCHE.DDEXEC as DT_DEB_OPERATION
	--FROM ESTIA_POPE POPE
	--LEFT OUTER JOIN ESTIA_TRANCHE TRANCHE
	--ON TRANCHE.COPE = POPE.COPE
	--LEFT OUTER JOIN ESTIA_GROUPE GROUPE
	--ON GROUPE.CORG = POPE.CORG AND GROUPE.CGROUPE = POPE.CGROUPE
	--INNER JOIN V_D_MANDAT_GERANCE MANDAT
	--ON FK_IMMEUBLE = PK_GROUPE
	--WHERE POPE.CORG = '11'
	--AND POPE.CGROUPE IN (1740, 1741)
	--AND LEFT(POPE.COPE, 4) < 2016
	--AND MANDAT.IND_MANDAT_ACTIF = 'O'
) REQ
WHERE NOT EXISTS
(
	SELECT * FROM L_INTERFACE_EASYFOLDER_OPERATIONS L
	WHERE L.CD_OPERATION = REQ.CD_OPERATION AND L.CD_TRANCHE = REQ.CD_TRANCHE
)


-- AJOUT DES NOUVELLES OPERATIONS DANS LA TABLE L_INTERFACE_EASYFOLDER_OPERATIONS
INSERT INTO L_INTERFACE_EASYFOLDER_OPERATIONS(CD_OPERATION, CD_TRANCHE, LB_OPERATION, CD_IMMEUBLE, NOM_IMMEUBLE_ESTIA, DT_DEB_OPERATION)
SELECT CD_OPERATION
	 , CD_TRANCHE
	 , LB_OPERATION
	 , CD_IMMEUBLE
	 , NOM_IMMEUBLE_ESTIA
	 , DT_DEB_OPERATION
FROM WRK_INTERFACE_EASYFOLDER_OPERATIONS
WHERE PK_TEMPS = @DT
AND ACTION = 'ADD'

END