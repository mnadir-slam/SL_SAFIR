﻿CREATE FUNCTION [dbo].[f_GET_LEASE_FINANCIAL_DATA] 
(
	@DT_ANALYSE DATETIME
)
RETURNS @retLEASE_FINANCIAL_DATA TABLE   
(  
	PK_ORG						int,
	PK_GROUPE					int,
	PK_BAIL						int,
	PK_TIERS					int,
	CORG						varchar(4),
	CD_IMMEUBLE_ESTIA			int,
	CD_IMMEUBLE_DREAM			varchar(20),
	NOM_IMMEUBLE				varchar(64),
	CD_BAIL						varchar(20),
	--DT_ENTREE					date,
	--DT_SORTIE					date,
	FREQUENCE_QUITTANCEMENT		int,
	CD_LOCATAIRE				varchar(14),
	NOM_LOCATAIRE				varchar(76),
	MT_LOYER_ACTUEL				numeric(17,2), 
	MT_LOYER_ACTUEL_FACTURABLE	numeric(17,2),
	MT_CHARGES					numeric(17,2),
	MT_DG						numeric(17,2),
	MT_LOYER_FRANCHISE			numeric(17,2),
	MT_PALIER					numeric(17,2)
)  
AS  
BEGIN  
WITH LEASE_FINANCIAL_DATA_cte(PK_ORG, PK_GROUPE, PK_BAIL, FK_TIERS, CORG, CD_IMMEUBLE_ESTIA, CD_IMMEUBLE_DREAM, NOM_IMMEUBLE, CD_BAIL, /*DT_ENTREE, DT_SORTIE,*/ FREQUENCE_QUITTANCEMENT, CD_LOCATAIRE, NOM_LOCATAIRE, MT_LOYER_ACTUEL, MT_LOYER_ACTUEL_FACTURABLE, MT_CHARGES, MT_DG, MT_LOYER_FRANCHISE, MT_PALIER)
AS
(
	select LOCATION.FK_ORG AS PK_ORG
		 , LOCATION.FK_GROUPE AS PK_GROUPE
		 , LOCATION.FK_BAIL AS PK_BAIL
		 , LOCATION.FK_TIERS AS PK_LOCATAIRE
		 , LOCATION.CORG
		 , LOCATION.CGROUPE CD_IMMEUBLE_ESTIA
		 , IMMEUBLE_EASYFOLDER.CD_IMMEUBLE_DREAM
		 , upper(IMMEUBLE.ADRLGN1) NOM_IMMEUBLE
		 , LOCATION.CCOMPTE + '/' + REPLACE(STR(LOCATION.NOBAIL, 2, 0), ' ', '0') AS CD_BAIL
		 --, convert(VARCHAR(10), LOCATION.DATENTQUIT, 103) AS DT_ENTREE
		 --, convert(VARCHAR(10), LOCATION.DATSORQUIT, 103) AS DT_SORTIE
		 , LOCATION.PERIOD AS FREQUENCE_QUITTANCEMENT
		 , LOCATAIRE.NM_LOCATAIRE AS CD_LOCATAIRE
		 , LOCATAIRE.NOM_LOCATAIRE
		 , SUM(CASE WHEN PSRE.IND_CALCUL_LOYER = 'O' AND (PSRE.IND_CALCUL_FRANCHISE = 'N' AND PSRE.IND_CALCUL_PALIER = 'N') THEN HQLOCAT.NB 
					WHEN PSRE.IND_CALCUL_LOYER = 'O' AND (PSRE.IND_CALCUL_FRANCHISE = 'O' OR PSRE.IND_CALCUL_PALIER = 'O') THEN 0 ELSE 0 END) AS MT_LOYER_ACTUEL
		 , SUM(CASE WHEN PSRE.IND_CALCUL_LOYER = 'O' AND PSRE.IND_CALCUL_FRANCHISE = 'N' AND PSRE.IND_CALCUL_PALIER = 'N' AND PSRE.CD_SOUS_REG_ELTFAC <> 'LOR' THEN HQLOCAT.NB ELSE 0 END) AS MT_LOYER_ACTUEL_FACTURABLE
		 , SUM(CASE WHEN PSRE.IND_CALCUL_CHARGES = 'O' THEN HQLOCAT.NB ELSE 0 END) AS MT_CHARGES
		 , SUM(CALCUL_DG.MT_DG) AS MT
		 , SUM(CASE WHEN PSRE.IND_CALCUL_FRANCHISE = 'O' THEN HQLOCAT.NB ELSE 0 END) AS MT_LOYER_FRANCHISE
		 , SUM(CASE WHEN PSRE.IND_CALCUL_PALIER = 'O' THEN HQLOCAT.NB ELSE 0 END) AS MT_PALIER
	from MASTER_ESTIA..ESTIA_LOCATION AS LOCATION
		inner join MASTER_ESTIA..ESTIA_HQLOCAT AS HQLOCAT
			on HQLOCAT.CORG = LOCATION.CORG
			and HQLOCAT.CAGENCE = LOCATION.CAGENCE
			and HQLOCAT.CGROUPE = LOCATION.CGROUPE
			and HQLOCAT.CIMMEUB = LOCATION.CIMMEUB
			and HQLOCAT.CLOCAL = LOCATION.CLOCAL
			and HQLOCAT.OCC = LOCATION.OCC
		left join MASTER_ESTIA..P_RUBRIQUE AS P
			on P.CD_RUBRIQUE = HQLOCAT.CRUB
		left join MASTER_ESTIA..P_SOUS_REG_ELTFAC AS PSRE
			on PSRE.CD_SOUS_REG_ELTFAC = P.CD_SOUS_REG_ELTFAC
		left join SAFIR_ESTIA..D_IMMEUBLE IMMEUBLE
		on IMMEUBLE.PK_IMMEUBLE = LOCATION.FK_GROUPE
		inner join SAFIR_ESTIA..D_MANDAT_GERANCE MANDAT
		on MANDAT.FK_IMMEUBLE = IMMEUBLE.PK_IMMEUBLE
		left join SAFIR_ESTIA..D_LOCATAIRE LOCATAIRE
		on LOCATAIRE.PK_LOCATAIRE = LOCATION.FK_TIERS
		left join MASTER_ESTIA..P_TRANSCO_IMMEUBLE_EASYFOLDER IMMEUBLE_EASYFOLDER
		on IMMEUBLE_EASYFOLDER.NM_IMMEUBLE_ESTIA = LOCATION.CGROUPE
		left join
		(
			SELECT PK_BAIL
				 , CCOMPTE
				 , NOBAIL
				 , SUM(MT_DG) AS MT_DG
			FROM
			(
				SELECT CPTGLOB.FK_BAIL AS PK_BAIL
					 , CPTGLOB.CCOMPTE
					 , CPTGLOB.NOBAIL
					 , SUM(CASE WHEN CPTGLOB.SENS = 'C' THEN CAST(REPLACE(CPTGLOB.MONTANT, ',','.') AS NUMERIC(18,2)) ELSE CAST(REPLACE(CPTGLOB.MONTANT, ',','.') AS NUMERIC(18,2))*-1 END) AS MT_DG
				FROM MASTER_ESTIA..ESTIA_CPTGLOB AS CPTGLOB
					 INNER JOIN MASTER_ESTIA..P_RUBRIQUE AS PR
						   ON PR.CD_RUBRIQUE = CPTGLOB.CRUB
					 INNER JOIN MASTER_ESTIA..ESTIA_LOCATION LOCATION
					 ON LOCATION.PK_LOCATION = CPTGLOB.FK_BAIL
				WHERE CPTGLOB.TYPCPTA = 'LD'
				AND (PR.IND_DG_PRINCIPAL = 'O' OR PR.IND_DG_ANNEXE = 'O')
				AND CPTGLOB.DATEC <= @DT_ANALYSE
				AND LOCATION.CORG = '11'
				GROUP BY CPTGLOB.FK_BAIL, CPTGLOB.CCOMPTE, CPTGLOB.NOBAIL
				UNION
				SELECT CPTGLOB.FK_BAIL AS PK_BAIL
					 , CPTGLOB.CCOMPTE, CPTGLOB.NOBAIL,
					   SUM(CASE WHEN CPTGLOB.SENS = 'C' THEN CAST(REPLACE(CPTGLOB.MONTANT, ',','.') AS NUMERIC(18,2)) ELSE CAST(REPLACE(CPTGLOB.MONTANT, ',','.') AS NUMERIC(18,2))*-1 END) AS MT_DG
				FROM MASTER_ESTIA..ESTIA_CPTGLOB AS CPTGLOB
					 INNER JOIN MASTER_ESTIA..ESTIA_LOCATION LOCATION
					 ON LOCATION.PK_LOCATION = CPTGLOB.FK_BAIL
				WHERE CPTGLOB.TYPCPTA = 'LD'
				AND CPTGLOB.DATEC <= @DT_ANALYSE
				AND LOCATION.CORG = '11'
				AND UPPER(CJOURNAL) = 'ANO'
				AND FK_RUB IS NULL
				AND UPPER(LIB) LIKE '%REPRISE DG%'
				GROUP BY CPTGLOB.FK_BAIL, CPTGLOB.CCOMPTE, CPTGLOB.NOBAIL
				UNION
				SELECT CPTGLOB.FK_BAIL AS PK_BAIL
					 , CPTGLOB.CCOMPTE
					 , CPTGLOB.NOBAIL
					 , SUM(CASE WHEN CPTGLOB.SENS = 'C' THEN CAST(REPLACE(CPTGLOB.MONTANT, ',','.') AS NUMERIC(18,2)) ELSE CAST(REPLACE(CPTGLOB.MONTANT, ',','.') AS NUMERIC(18,2))*-1 END) AS MT_DG
				FROM MASTER_ESTIA..ESTIA_CPTGLOB AS CPTGLOB
					 INNER JOIN MASTER_ESTIA..ESTIA_LOCATION LOCATION
					 ON LOCATION.PK_LOCATION = CPTGLOB.FK_BAIL
				WHERE CPTGLOB.TYPCPTA = 'LD'
				AND CPTGLOB.DATEC <= @DT_ANALYSE
				AND LOCATION.CORG = '11'
				AND UPPER(CJOURNAL) IN ('QUI')
				and CPTGLOB.CTYPECRI = 'ANV'
				AND FK_RUB IS NULL
				AND UPPER(LIB) LIKE '%REPRISE DG%' 
				GROUP BY CPTGLOB.FK_BAIL, CPTGLOB.CCOMPTE, CPTGLOB.NOBAIL
			) REQ
			GROUP BY PK_BAIL, CCOMPTE, NOBAIL
	) CALCUL_DG
	on CALCUL_DG.PK_BAIL = LOCATION.FK_BAIL
	where LOCATION.CORG = '11' 
	and LOCATION.FK_BAIL IS NOT NULL
	and P.CD_SOUS_REG_ELTFAC not in ('LOR')
	and @DT_ANALYSE BETWEEN HQLOCAT.DDEB AND ISNULL(HQLOCAT.DFIN, '2999/01/01')
	and LOCATION.FK_BAIL IS NOT NULL
	and (LOCATION.DATSORQUIT IS NULL OR LOCATION.DATSORQUIT >= @DT_ANALYSE)
	and MANDAT.IND_MANDAT_ACTIF = 'O'
	group by LOCATION.FK_ORG
		   , LOCATION.FK_GROUPE
		   , LOCATION.FK_BAIL 
		   , LOCATION.FK_TIERS
		   , LOCATION.CORG
		   , LOCATION.CGROUPE
		   , IMMEUBLE_EASYFOLDER.CD_IMMEUBLE_DREAM
		   , IMMEUBLE.ADRLGN1 
		   , LOCATION.CCOMPTE
		   , LOCATION.NOBAIL
		   --, LOCATION.DATENTQUIT
		   --, LOCATION.DATSORQUIT
		   , LOCATION.PERIOD
		   , LOCATAIRE.NM_LOCATAIRE 
		   , LOCATAIRE.NOM_LOCATAIRE
)

-- copy the required columns to the result of the function   
   INSERT @retLEASE_FINANCIAL_DATA  
   SELECT PK_ORG, PK_GROUPE, PK_BAIL, FK_TIERS, CORG, CD_IMMEUBLE_ESTIA, CD_IMMEUBLE_DREAM, NOM_IMMEUBLE, CD_BAIL, /*DT_ENTREE, DT_SORTIE,*/ FREQUENCE_QUITTANCEMENT, CD_LOCATAIRE, NOM_LOCATAIRE, MT_LOYER_ACTUEL, MT_LOYER_ACTUEL_FACTURABLE, MT_CHARGES, MT_DG, MT_LOYER_FRANCHISE, MT_PALIER
   FROM LEASE_FINANCIAL_DATA_cte   
   RETURN  
END;