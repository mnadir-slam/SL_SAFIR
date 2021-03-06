﻿CREATE PROCEDURE [dbo].[UPDATE_PARAMETRAGE]
AS
BEGIN

--P_USAGE: TABLE DE PARAMETRAGE DES USAGES DE LOTS
INSERT INTO P_USAGE (CD_USAGE, LB_USAGE)
SELECT E.CUSALOC AS CD_USAGE, E.LUSALOC AS LB_USAGE
FROM ESTIA_USALOC AS E
     LEFT JOIN P_USAGE AS P
          ON P.CD_USAGE = E.CUSALOC
WHERE P.CD_USAGE IS NULL
AND E.CUSALOC IS NOT NULL

UPDATE P_USAGE
SET LB_USAGE = E.LUSALOC
FROM ESTIA_USALOC AS E
     INNER JOIN P_USAGE AS P
           ON P.CD_USAGE = E.CUSALOC


--P_NATURE_BAIL: TABLE DE PARAMETRAGE DES NATURES DE BAIL
INSERT INTO P_NATURE_BAIL (CD_NATURE_BAIL, LB_NATURE_BAIL)
SELECT E.CBAIL AS CD_NATURE_BAIL, E.LBAIL AS LB_NATURE_BAIL
FROM ESTIA_BAIL AS E
     LEFT JOIN P_NATURE_BAIL AS P
          ON P.CD_NATURE_BAIL = E.CBAIL
WHERE P.CD_NATURE_BAIL IS NULL
AND E.CBAIL IS NOT NULL

UPDATE P_NATURE_BAIL
SET LB_NATURE_BAIL = E.LBAIL
FROM ESTIA_BAIL AS E
     INNER JOIN P_NATURE_BAIL AS P
           ON P.CD_NATURE_BAIL = E.CBAIL



--P_TYPE_LOT: TABLE DE PARAMETRAGE DES TYPES DE LOT
INSERT INTO P_TYPE_LOT (CD_TYPE_LOT, LB_TYPE_LOT)
SELECT E.CTYPLOG AS CD_TYPE_LOT, E.LTYPLOG AS LB_TYPE_LOT
FROM ESTIA_TYPLOG AS E
     LEFT JOIN P_TYPE_LOT AS P
          ON P.CD_TYPE_LOT = E.CTYPLOG
WHERE P.CD_TYPE_LOT IS NULL
AND E.CTYPLOG IS NOT NULL

UPDATE P_TYPE_LOT
SET LB_TYPE_LOT = E.LTYPLOG
FROM ESTIA_TYPLOG AS E
     INNER JOIN P_TYPE_LOT AS P
           ON P.CD_TYPE_LOT = E.CTYPLOG


--P_RUBRIQUE: TABLE DE PARAMETRAGE DES RUBRIQUES DE QUITTANCEMENT
INSERT INTO P_RUBRIQUE (CD_RUBRIQUE, LB_RUBRIQUE)
SELECT E.CRUB AS CD_RUBRIQUE, RTRIM(LEFT(E.LRUB, 30)) AS LB_RUBRIQUE
FROM ESTIA_RUB AS E
     LEFT JOIN P_RUBRIQUE AS P
          ON P.CD_RUBRIQUE = E.CRUB
WHERE P.CD_RUBRIQUE IS NULL
AND E.CRUB IS NOT NULL

UPDATE P_RUBRIQUE
SET LB_RUBRIQUE = RTRIM(LEFT(E.LRUB, 30))
FROM ESTIA_RUB AS E
     INNER JOIN P_RUBRIQUE AS P
           ON P.CD_RUBRIQUE = E.CRUB


--P_TYPE_CAUTION: TABLE DE PARAMETRAGE DES TYPES DE CAUTION
INSERT INTO P_TYPE_CAUTION (CD_TYPE_CAUTION, LB_TYPE_CAUTION)
SELECT E.CMOTIF AS CD_TYPE_CAUTION, E.LMOTIF AS LB_TYPE_CAUTION
FROM ESTIA_MOTIF AS E
     LEFT JOIN P_TYPE_CAUTION AS P
          ON P.CD_TYPE_CAUTION = E.CMOTIF
WHERE E.CSTE = 'TG'
AND E.CMOTIF IS NOT NULL
AND P.CD_TYPE_CAUTION IS NULL


UPDATE P_TYPE_CAUTION
SET LB_TYPE_CAUTION = E.LMOTIF
FROM ESTIA_MOTIF AS E
     INNER JOIN P_TYPE_CAUTION AS P
           ON P.CD_TYPE_CAUTION = E.CMOTIF
WHERE E.CSTE = 'TG'


--P_IMMEUBLE: TABLE DE PARAMETRAGE DES IMMEUBLES
INSERT INTO P_IMMEUBLE (CD_SOCIETE, CD_AGENCE, NM_IMMEUBLE, LB_IMMEUBLE)
SELECT E.CORG AS CD_SOCIETE, E.CAGENCE AS CD_AGENCE, E.CGROUPE AS NM_IMMEUBLE, E.LGROUPE AS LB_IMMEUBLE
FROM ESTIA_GROUPE AS E
     LEFT JOIN P_IMMEUBLE AS P
          ON P.CD_SOCIETE = E.CORG
          AND P.CD_AGENCE = E.CAGENCE
          AND P.NM_IMMEUBLE = E.CGROUPE
WHERE P.NM_IMMEUBLE IS NULL
AND E.CORG = '11'

UPDATE P_IMMEUBLE
SET LB_IMMEUBLE = E.LGROUPE,
	LB_IMMEUBLE_GED = CAST(E.CGROUPE AS VARCHAR(5)) + '_' + REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(E.RUE), ' ', ''), 'É','E'),'À','A'),'Â','A'),'''', ''),'°',''),'/',''),'-',''),'È','E'),'Ê','E')
  FROM P_IMMEUBLE AS P
     LEFT JOIN ESTIA_GROUPE AS E
           ON P.CD_SOCIETE = E.CORG
           AND P.CD_AGENCE = E.CAGENCE
           AND P.NM_IMMEUBLE = E.CGROUPE
WHERE P.LB_IMMEUBLE_GED IS NULL
AND CD_SOCIETE = '11'

UPDATE P_IMMEUBLE
SET CHEMIN_PLAN = '\\viveris.local\VIVERIS-DFS\IMMO\DOCS IMMEUBLES\GED\' + LB_IMMEUBLE_GED + '\2 Actif\2.2 Plans',
    CHEMIN_ETAT_SURFACES = '\\viveris.local\VIVERIS-DFS\IMMO\DOCS IMMEUBLES\GED\' + LB_IMMEUBLE_GED + '\2 Actif\2.1 Mesurage',
	CHEMIN_TB = '\\viveris.local\VIVERIS-DFS\IMMO\DOCS IMMEUBLES\GED\' + LB_IMMEUBLE_GED + '\12 Fiscalite\12.2 Taxe sur les bureaux',
	CHEMIN_TF = '\\viveris.local\VIVERIS-DFS\IMMO\DOCS IMMEUBLES\GED\' + LB_IMMEUBLE_GED + '\12 Fiscalite\12.1 Taxe Fonciere'
  FROM P_IMMEUBLE AS P
     LEFT JOIN ESTIA_GROUPE AS E
           ON P.CD_SOCIETE = E.CORG
           AND P.CD_AGENCE = E.CAGENCE
           AND P.NM_IMMEUBLE = E.CGROUPE
WHERE P.CHEMIN_PLAN IS NULL
AND P.CD_SOCIETE = '11'

--P_TIERS: TABLE DE PARAMETRAGE DES TIERS
INSERT INTO P_TIERS (CD_TYPE_TIERS, CD_TIERS, NOM_TIERS)
SELECT E.CTYPTIERS AS CD_TYPE_TIERS, E.CTIERS AS CD_TIERS, E.LTIERS AS NOM_TIERS
FROM ESTIA_TIERS AS E
     LEFT JOIN P_TIERS AS P
          ON P.CD_TYPE_TIERS = E.CTYPTIERS
          AND P.CD_TIERS = E.CTIERS
WHERE P.CD_TIERS IS NULL

UPDATE P_TIERS
SET NOM_TIERS = E.LTIERS,
VILLE = E.BDIS
FROM ESTIA_TIERS AS E
     INNER JOIN P_TIERS AS P
           ON P.CD_TYPE_TIERS = E.CTYPTIERS
           AND P.CD_TIERS = E.CTIERS

	update P_ETAT_LOC_INIT
	set PK_LOT = V_D_LOT.PK_LOT
	from P_ETAT_LOC_INIT
	left join V_D_LOT
	on V_D_LOT.CD_SOCIETE = P_ETAT_LOC_INIT.CODE_SOCIETE
	and V_D_LOT.NM_IMMEUBLE = P_ETAT_LOC_INIT.CODE_IMMEUBLE
	and V_D_LOT.NM_LOT = P_ETAT_LOC_INIT.NM_LOT;

	update P_ETAT_LOC_INIT
	set PK_BAIL = V_D_BAIL.PK_BAIL,
		NM_LOCATAIRE = V_D_BAIL.NM_LOCATAIRE,
		PK_LOCATAIRE = V_D_BAIL.FK_LOCATAIRE
	from P_ETAT_LOC_INIT
	left join V_D_BAIL
	on V_D_BAIL.CD_SOCIETE = P_ETAT_LOC_INIT.CODE_SOCIETE
	and V_D_BAIL.NM_IMMEUBLE = P_ETAT_LOC_INIT.CODE_IMMEUBLE
	and V_D_BAIL.NM_BAIL = P_ETAT_LOC_INIT.NM_BAIL;

-- P_VLM: TABLE DE PARAMETRAGE DES VLM
INSERT INTO P_VLM (PK_PROPRIETAIRE, PK_IMMEUBLE, CD_SOCIETE, CD_AGENCE, NM_PROPRIETAIRE, NOM_PROPRIETAIRE, NM_IMMEUBLE, ADRESSE, VLM_ARC, VLM_PKG_SIMPLE, VLM_PKG_DOUBLE)
SELECT WGM.FK_TIERS, GROUPE.PK_GROUPE, GROUPE.CORG, GROUPE.CAGENCE, PROPRIETAIRE.NM_PROPRIETAIRE, PROPRIETAIRE.NOM_PROPRIETAIRE, GROUPE.CGROUPE AS NM_IMMEUBLE, GROUPE.LGROUPE, 0 AS VLM_ARC, 0 AS VLM_PKG_SIMPLE, 0 AS VLM_PKG_DOUBLE
FROM ESTIA_GROUPE AS GROUPE
     LEFT JOIN P_VLM AS P
          ON P.PK_IMMEUBLE = GROUPE.PK_GROUPE
	 LEFT JOIN WRK_GROUPE_MANGES WGM
		  ON WGM.PK_GROUPE = GROUPE.PK_GROUPE
	 LEFT JOIN V_D_PROPRIETAIRE PROPRIETAIRE
	      ON PROPRIETAIRE.PK_PROPRIETAIRE = WGM.FK_TIERS
WHERE P.NM_IMMEUBLE IS NULL
AND GROUPE.CORG = '11'
AND GROUPE.CGROUPE NOT IN ('2222', '8888', '4027', '9999', '8510', '1024', '4444', '1111')

-- P_TRANSCO_IMMEUBLE_EASYFOLDER
insert into P_TRANSCO_IMMEUBLE_EASYFOLDER
select T.NM_IMMEUBLE_ESTIA, T.CD_IMMEUBLE_DREAM, T.NOM_IMMEUBLE_DREAM
from TMP_TRANSCO_IMMEUBLE_EASYFOLDER as T
left join P_TRANSCO_IMMEUBLE_EASYFOLDER as P
on P.CD_IMMEUBLE_DREAM = T.CD_IMMEUBLE_DREAM
where P.CD_IMMEUBLE_DREAM IS NULL
and T.CD_IMMEUBLE_DREAM IS NOT NULL

insert into P_TRANSCO_IMMEUBLE_EASYFOLDER(NM_IMMEUBLE_ESTIA, NOM_IMMEUBLE_DREAM)
SELECT V_D_IMMEUBLE.NM_IMMEUBLE NM_IMMEUBLE_ESTIA, V_D_IMMEUBLE.ADRLGN1 NOM_IMMEUBLE_DREAM
FROM V_D_IMMEUBLE
INNER JOIN V_D_MANDAT_GERANCE
ON V_D_MANDAT_GERANCE.FK_IMMEUBLE = V_D_IMMEUBLE.PK_IMMEUBLE
WHERE V_D_IMMEUBLE.CD_SOCIETE = '11'
AND V_D_MANDAT_GERANCE.IND_MANDAT_ACTIF = 'O'
AND V_D_IMMEUBLE.NM_IMMEUBLE NOT IN (3057, 3333, 7777, 9021, 9022, 9023, 9024, 9025, 1, 899)
AND NOT EXISTS
(
	SELECT * FROM P_TRANSCO_IMMEUBLE_EASYFOLDER
	WHERE P_TRANSCO_IMMEUBLE_EASYFOLDER.NM_IMMEUBLE_ESTIA IS NOT NULL
	AND V_D_IMMEUBLE.NM_IMMEUBLE = P_TRANSCO_IMMEUBLE_EASYFOLDER.NM_IMMEUBLE_ESTIA
)

END