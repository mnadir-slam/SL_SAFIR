-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GET_BAUX_SALEFORCE_2]
(
	@DT_ANALYSE DATETIME
)
AS
BEGIN

	SET NOCOUNT ON;

-- calcul des valeurs financières
--CREATE TABLE #VAL_FINANCIERES
--(
--	PK_GROUPE				INT NOT NULL,
--	PK_BAIL                 INT NOT NULL,
--	MT_LOYER_ACTUEL         NUMERIC(18, 2) NULL,
--	MT_LOYER_FRANCHISE      NUMERIC(18, 2) NULL,
--	MT_PALIER				NUMERIC(18, 2) NULL
--)

--insert into #VAL_FINANCIERES(PK_GROUPE, PK_BAIL, MT_LOYER_ACTUEL, MT_LOYER_FRANCHISE, MT_PALIER)
--SELECT PK_GROUPE, PK_BAIL, MT_LOYER_ACTUEL, MT_LOYER_FRANCHISE, MT_PALIER
--FROM
--(
--SELECT LOCATION.FK_GROUPE AS PK_GROUPE, LOCATION.PK_LOCATION AS PK_BAIL,
--		SUM(CASE WHEN PSRE.IND_CALCUL_LOYER = 'O' AND PSRE.IND_CALCUL_FRANCHISE = 'N' AND PSRE.IND_CALCUL_PALIER = 'N' THEN HQLOCAT.NB ELSE 0 END) AS MT_LOYER_ACTUEL,
--		SUM(CASE WHEN PSRE.IND_CALCUL_FRANCHISE = 'O' THEN HQLOCAT.NB ELSE 0 END) AS MT_LOYER_FRANCHISE,
--		SUM(CASE WHEN PSRE.IND_CALCUL_PALIER = 'O' THEN HQLOCAT.NB ELSE 0 END) AS MT_PALIER

--FROM MASTER_ESTIA..ESTIA_LOCATION AS LOCATION
--		INNER JOIN MASTER_ESTIA..ESTIA_HQLOCAT AS HQLOCAT
--			ON HQLOCAT.CORG = LOCATION.CORG
--			AND HQLOCAT.CAGENCE = LOCATION.CAGENCE
--			AND HQLOCAT.CGROUPE = LOCATION.CGROUPE
--			AND HQLOCAT.CIMMEUB = LOCATION.CIMMEUB
--			AND HQLOCAT.CLOCAL = LOCATION.CLOCAL
--			AND HQLOCAT.OCC = LOCATION.OCC
--		INNER JOIN MASTER_ESTIA..P_RUBRIQUE AS P
--			ON P.CD_RUBRIQUE = HQLOCAT.CRUB
--		INNER JOIN MASTER_ESTIA..P_SOUS_REG_ELTFAC AS PSRE
--			ON PSRE.CD_SOUS_REG_ELTFAC = P.CD_SOUS_REG_ELTFAC
--		INNER JOIN MASTER_ESTIA..ESTIA_GROUPE GROUPE
--		ON GROUPE.PK_GROUPE = LOCATION.FK_GROUPE
--		INNER JOIN MASTER_ESTIA..V_D_MANDAT_GERANCE MANDAT
--		ON MANDAT.FK_IMMEUBLE = GROUPE.PK_GROUPE
--WHERE @DT_ANALYSE BETWEEN HQLOCAT.DDEB AND ISNULL(HQLOCAT.DFIN, '2999/01/01')
--AND LOCATION.FK_BAIL IS NOT NULL
--AND LOCATION.CORG = '11'
--AND (LOCATION.DATSORQUIT IS NULL OR LOCATION.DATSORQUIT > @DT_ANALYSE)
--AND IND_MANDAT_ACTIF = 'O'
--GROUP BY LOCATION.FK_GROUPE, LOCATION.PK_LOCATION
--) REQ
--WHERE MT_LOYER_ACTUEL > 0

--CREATE TABLE #TRAIT_BAUX
--(
--	IDENTIFIANT_BAIL_DREAM		VARCHAR(255),
--	IDENTIFIANT_DREAM_IMMEUBLE	VARCHAR(255),
--	NM_IMMEUBLE					INT,
--	ACTIF						VARCHAR(3),
--	LOCATAIRE_PRINCIPAL			VARCHAR(255),
--	SIREN						VARCHAR(100),
--	RCS							VARCHAR(100),
--	DT_EFFET					DATE,
--	DT_FIN						DATE,
--	LOYER_ANNUEL_FACIAL			NUMERIC(18,2),
--	DERNIER_TERME_ANNUALISE		NUMERIC(18,2),
--	VAL_SURF_BAIL				NUMERIC(18,2),
--	VAL_SURF_BUR				NUMERIC(18,2),
--	VAL_SURF_COM				NUMERIC(18,2),
--	VAL_SURF_ARC				NUMERIC(18,2),
--	VAL_SURF_HAB				NUMERIC(18,2),
--	VAL_SURF_HOT				NUMERIC(18,2),
--	VAL_SURF_ACT				NUMERIC(18,2),
--	CD_STATUT					VARCHAR(1)
--)

--INSERT INTO #TRAIT_BAUX
--SELECT IDENTIFIANT_BAIL_DREAM
--     , IDENTIFIANT_DREAM_IMMEUBLE
--	 , SRC.NM_IMMEUBLE
--	 , ACTIF
--	 , LOCATAIRE_PRINCIPAL
--	 , SIREN
--	 , RCS
--	 , DT_EFFET
--	 , DT_FIN
--	 , SUM(LOYER_ANNUEL_FACIAL) LOYER_ANNUEL_FACIAL
--	 , SUM(DERNIER_TERME_ANNUALISE) DERNIER_TERME_ANNUALISE
--	 , SUM(W.VAL_SURF_BUR + W.VAL_SURF_COM + W.VAL_SURF_ARC + W.VAL_SURF_HAB + W.VAL_SURF_HOT + W.VAL_SURF_ACT) VAL_SURF_BAIL
--	 , SUM(VAL_SURF_BUR) VAL_SURF_BUR
--	 , SUM(VAL_SURF_COM) VAL_SURF_COM
--	 , SUM(VAL_SURF_ARC) VAL_SURF_ARC
--	 , SUM(VAL_SURF_HAB) VAL_SURF_HAB
--	 , SUM(VAL_SURF_HOT) VAL_SURF_HOT
--	 , SUM(VAL_SURF_ACT) VAL_SURF_ACT
--     , CD_STATUT
--FROM
--(
--	SELECT F_ETAT_LOCATIF.FK_IMMEUBLE
--	 , ISNULL(F_ETAT_LOCATIF.FK_BAIL, 99999) FK_BAIL
--	 , F_ETAT_LOCATIF.FK_LOCATAIRE
--     --, D_LOCATAIRE.PK_LOCATAIRE PK_TIERS
--	 , CASE WHEN F_ETAT_LOCATIF.CD_STATUT = 'L' THEN
--		CASE WHEN ABS(F_ETAT_LOCATIF.FK_LOCATAIRE) = 88888
--		THEN 'BAIL999997' ELSE 'BAIL999999' END
--		ELSE 'BAIL999998'  
--		END AS IDENTIFIANT_BAIL_DREAM
--	 , ISNULL(EASYFOLDER_BAUX.IDENTIFIANT_DREAM_IMMEUBLE, P.CD_IMMEUBLE_DREAM) as IDENTIFIANT_DREAM_IMMEUBLE
--	 , D_IMMEUBLE.NM_IMMEUBLE
--	 , 'Oui' ACTIF
--	 , CASE WHEN F_ETAT_LOCATIF.CD_STATUT = 'L' THEN
--	   CASE WHEN ABS(F_ETAT_LOCATIF.FK_LOCATAIRE) = 88888
--	   THEN 'Gardien' ELSE 'Total '+P.CD_IMMEUBLE_DREAM END
--	   ELSE 'Vacant '+P.CD_IMMEUBLE_DREAM  
--	   END AS  LOCATAIRE_PRINCIPAL
--	 , NULL AS SIREN
--	 , NULL AS RCS
--	 , NULL AS DT_EFFET
--	 , NULL AS DT_FIN
--     , SUM(ISNULL(CASE WHEN F_ETAT_LOCATIF.IND_LOT_PRINCIPAL = 'O ' THEN  VAL_FIN.MT_LOYER_ACTUEL ELSE 0 END, 0)) AS LOYER_ANNUEL_FACIAL
--     --, SUM(ISNULL(CASE WHEN F_ETAT_LOCATIF.IND_LOT_PRINCIPAL = 'O ' THEN  VAL_FIN.MT_LOYER_ACTUEL_FACTURABLE - ABS(VAL_FIN.MT_LOYER_FRANCHISE) - ABS(VAL_FIN.MT_PALIER) ELSE 0 END, 0)) AS DERNIER_TERME_ANNUALISE
--	 , SUM(ISNULL(CASE WHEN F_ETAT_LOCATIF.IND_LOT_PRINCIPAL = 'O ' THEN  VAL_FIN.MT_LOYER_ACTUEL - ABS(VAL_FIN.MT_LOYER_FRANCHISE) - ABS(VAL_FIN.MT_PALIER) ELSE 0 END, 0)) AS DERNIER_TERME_ANNUALISE
--	 , CASE WHEN F_ETAT_LOCATIF.CD_STATUT = 'L' THEN
--	 CASE WHEN ABS(F_ETAT_LOCATIF.FK_LOCATAIRE) = 88888
--	 THEN 1 ELSE 3 END
--	 ELSE 2  
--	 END AS ORDRE_TRI
--	 , F_ETAT_LOCATIF.CD_STATUT
--FROM
--  F_ETAT_LOCATIF
--  LEFT OUTER JOIN D_IMMEUBLE
--    ON F_ETAT_LOCATIF.FK_IMMEUBLE = D_IMMEUBLE.PK_IMMEUBLE
--  LEFT OUTER JOIN D_LOT
--    ON F_ETAT_LOCATIF.PK_LOT = D_LOT.PK_LOT
--  LEFT OUTER JOIN D_BAIL
--    ON F_ETAT_LOCATIF.FK_BAIL = D_BAIL.PK_BAIL
--  LEFT OUTER JOIN D_LOCATAIRE
--    ON F_ETAT_LOCATIF.FK_LOCATAIRE = D_LOCATAIRE.PK_LOCATAIRE
--  LEFT OUTER JOIN D_PROPRIETAIRE
--    ON F_ETAT_LOCATIF.FK_PROPRIETAIRE = D_PROPRIETAIRE.PK_PROPRIETAIRE
--  LEFT OUTER JOIN D_MANDAT_GERANCE
--    ON F_ETAT_LOCATIF.FK_MANDAT_GERANCE = D_MANDAT_GERANCE.PK_MANDAT_GERANCE
--  INNER JOIN MASTER_ESTIA..P_TRANSCO_IMMEUBLE_EASYFOLDER P
--    ON D_IMMEUBLE.NM_IMMEUBLE = P.NM_IMMEUBLE_ESTIA
--  LEFT JOIN #VAL_FINANCIERES VAL_FIN
--  ON VAL_FIN.PK_BAIL = D_BAIL.PK_BAIL
--  LEFT JOIN MASTER_ESTIA..L_INTERFACE_EASYFOLDER_BAUX EASYFOLDER_BAUX 
--	ON EASYFOLDER_BAUX.IDENTIFIANT_ESTIA_IMMEUBLE = D_BAIL.NM_IMMEUBLE AND CAST(EASYFOLDER_BAUX.IDENTIFIANT_ESTIA_COMPTE as varchar(30)) + dbo.LPAD(EASYFOLDER_BAUX.NOBAIL_ESTIA, 2, '0') = D_BAIL.NM_BAIL
--  INNER JOIN
--	(
--		SELECT DISTINCT IMMEUBLE.PK_IMMEUBLE
--		FROM MASTER_ESTIA..L_INTERFACE_EASYFOLDER_BAUX AS EASYFOLDER_BAUX 
--		LEFT JOIN SAFIR_ESTIA..D_BAIL BAIL
--		ON BAIL.NM_IMMEUBLE = EASYFOLDER_BAUX.IDENTIFIANT_ESTIA_IMMEUBLE AND BAIL.NM_BAIL = CAST(EASYFOLDER_BAUX.IDENTIFIANT_ESTIA_COMPTE AS VARCHAR(30)) + DBO.LPAD(EASYFOLDER_BAUX.NOBAIL_ESTIA, 2, '0')
--		LEFT JOIN SAFIR_ESTIA..D_IMMEUBLE IMMEUBLE
--		ON IMMEUBLE.PK_IMMEUBLE = BAIL.FK_IMMEUBLE
--		LEFT JOIN SAFIR_ESTIA..D_MANDAT_GERANCE DMG
--		ON DMG.FK_IMMEUBLE = IMMEUBLE.PK_IMMEUBLE
--		LEFT JOIN MASTER_ESTIA..P_TRANSCO_IMMEUBLE_EASYFOLDER P
--		ON IMMEUBLE.NM_IMMEUBLE = P.NM_IMMEUBLE_ESTIA
--		WHERE  (BAIL.CD_SOCIETE IS NULL OR BAIL.CD_SOCIETE = '11')
--		AND DMG.IND_MANDAT_ACTIF = 'O'
--	) SRC
--	ON SRC.PK_IMMEUBLE = D_IMMEUBLE.PK_IMMEUBLE
--WHERE
--  F_ETAT_LOCATIF.PK_TEMPS = @DT_ANALYSE
--  AND D_MANDAT_GERANCE.IND_MANDAT_ACTIF = 'O'
--  AND CONVERT(DATETIME, CONVERT(VARCHAR(10),GETDATE(),103), 103) BETWEEN D_LOT.DT_DEBUT_EN_SERVICE AND ISNULL(D_LOT.DT_FIN_EN_SERVICE,'2999/01/01')
--GROUP BY F_ETAT_LOCATIF.FK_IMMEUBLE
--	 , F_ETAT_LOCATIF.FK_BAIL
--	 , F_ETAT_LOCATIF.FK_LOCATAIRE
--	 , EASYFOLDER_BAUX.IDENTIFIANT_DREAM_IMMEUBLE
--	 , P.CD_IMMEUBLE_DREAM
--	 , D_IMMEUBLE.NM_IMMEUBLE
--     , D_IMMEUBLE.SURFACE_TOTALE
--	 , F_ETAT_LOCATIF.CD_STATUT
--) SRC
--LEFT JOIN
--(
--		SELECT FEL.PK_TEMPS, FEL.FK_IMMEUBLE, ISNULL(FEL.FK_BAIL, 99999) AS FK_BAIL
--			, SUM(CASE WHEN CD_REG_USAGE = 'BUR' THEN ISNULL(VAL_SURFACE_REELLE, 0) ELSE 0 END) VAL_SURF_BUR
--			, SUM(CASE WHEN CD_REG_USAGE = 'COM' THEN ISNULL(VAL_SURFACE_REELLE, 0) ELSE 0 END) VAL_SURF_COM
--			, SUM(CASE WHEN CD_REG_USAGE = 'ARC' THEN ISNULL(VAL_SURFACE_REELLE, 0) ELSE 0 END) VAL_SURF_ARC
--			, SUM(CASE WHEN CD_REG_USAGE = 'HAB' THEN ISNULL(VAL_SURFACE_REELLE, 0) ELSE 0 END) VAL_SURF_HAB
--			, SUM(CASE WHEN CD_REG_USAGE = 'HOT' THEN ISNULL(VAL_SURFACE_REELLE, 0) ELSE 0 END) VAL_SURF_HOT
--			, SUM(CASE WHEN CD_REG_USAGE NOT IN ('BUR', 'COM', 'ARC', 'HAB', 'HOT') THEN ISNULL(VAL_SURFACE_REELLE, 0) ELSE 0 END) VAL_SURF_ACT
--		FROM F_ETAT_LOCATIF FEL INNER JOIN
--		(
--			SELECT L.PK_LOT, L.NM_LOT, L.CD_USAGE, L.CD_REG_USAGE, L.LB_REG_USAGE, L.LB_USAGE, VAL_SURFACE_REELLE  
--			FROM D_LOT L
--			WHERE VAL_SURFACE_REELLE > 0
--		) LOT
--		ON LOT.PK_LOT = FEL.PK_LOT
--		WHERE FEL.PK_TEMPS = @DT_ANALYSE
--		GROUP BY FEL.PK_TEMPS, FEL.FK_IMMEUBLE, FEL.FK_BAIL
--) W
--ON W.FK_IMMEUBLE = SRC.FK_IMMEUBLE AND ABS(W.FK_BAIL) = ABS(SRC.FK_BAIL)
--GROUP BY SRC.NM_IMMEUBLE
--	 , IDENTIFIANT_BAIL_DREAM
--     , IDENTIFIANT_DREAM_IMMEUBLE
--	 , ACTIF
--	 , LOCATAIRE_PRINCIPAL
--	 , SIREN
--	 , RCS
--	 , DT_EFFET
--	 , DT_FIN
--     , CD_STATUT
--  , ORDRE_TRI


--UPDATE #TRAIT_BAUX
--SET VAL_SURF_BAIL = I.SURFACE_TOTALE, 
--	VAL_SURF_BUR = T2.VAL_SURF_BUR,
--	VAL_SURF_COM = T2.VAL_SURF_COM,
--	VAL_SURF_ARC = T2.VAL_SURF_ARC,
--	VAL_SURF_HAB = T2.VAL_SURF_HAB,
--	VAL_SURF_HOT = T2.VAL_SURF_HOT,
--	VAL_SURF_ACT = T2.VAL_SURF_ACT
--FROM #TRAIT_BAUX T
--LEFT JOIN (SELECT PK_IMMEUBLE, NM_IMMEUBLE, SURFACE_TOTALE FROM D_IMMEUBLE WHERE CD_SOCIETE = '11') I 
--ON I.NM_IMMEUBLE = T.NM_IMMEUBLE
--LEFT JOIN 
--(
--	SELECT NM_IMMEUBLE
--		  , SUM(VAL_SURF_BUR) VAL_SURF_BUR
--		  , SUM(VAL_SURF_COM) VAL_SURF_COM
--		  , SUM(VAL_SURF_ARC) VAL_SURF_ARC
--		  , SUM(VAL_SURF_HAB) VAL_SURF_HAB
--		  , SUM(VAL_SURF_HOT) VAL_SURF_HOT
--		  , SUM(VAL_SURF_ACT) VAL_SURF_ACT 
--	FROM #TRAIT_BAUX
--	GROUP BY NM_IMMEUBLE
--) T2
--ON T2.NM_IMMEUBLE = T.NM_IMMEUBLE
--WHERE T.LOCATAIRE_PRINCIPAL like 'Total%'

--INSERT INTO #TRAIT_BAUX (IDENTIFIANT_BAIL_DREAM, IDENTIFIANT_DREAM_IMMEUBLE, NM_IMMEUBLE, ACTIF, LOCATAIRE_PRINCIPAL)
--SELECT DISTINCT 'BAIL999998', B.IDENTIFIANT_DREAM_IMMEUBLE, B.NM_IMMEUBLE, B.ACTIF, 'Vacant '+B.IDENTIFIANT_DREAM_IMMEUBLE 
--FROM #TRAIT_BAUX B
--WHERE NOT EXISTS
--(
--  SELECT * FROM #TRAIT_BAUX
--  WHERE #TRAIT_BAUX.IDENTIFIANT_DREAM_IMMEUBLE = B.IDENTIFIANT_DREAM_IMMEUBLE AND #TRAIT_BAUX.LOCATAIRE_PRINCIPAL = 'Vacant '+B.IDENTIFIANT_DREAM_IMMEUBLE
--)

--select IDENTIFIANT_BAIL_DREAM
--	 , IDENTIFIANT_DREAM_IMMEUBLE
--	 , NM_IMMEUBLE
--	 , ACTIF
--	 , LOCATAIRE_PRINCIPAL
--	 , SIREN
--	 , RCS
--	 , DT_EFFET
--	 , DT_FIN
--	 , LOYER_ANNUEL_FACIAL
--	 , DERNIER_TERME_ANNUALISE
--	 , VAL_SURF_BAIL
--	 , VAL_SURF_BUR
--	 , VAL_SURF_COM
--	 , VAL_SURF_ARC
--	 , VAL_SURF_HAB
--	 , VAL_SURF_HOT
--	 , VAL_SURF_ACT
--from
--(
--	select EASYFOLDER_BAUX.IDENTIFIANT_BAIL_DREAM
--		 , ISNULL(EASYFOLDER_BAUX.IDENTIFIANT_DREAM_IMMEUBLE, P.CD_IMMEUBLE_DREAM) as IDENTIFIANT_DREAM_IMMEUBLE
--		 , IMMEUBLE.NM_IMMEUBLE
--		 , case when ISNULL(BAIL.DT_SORTIE, '29990101') >=  @DT_ANALYSE then 'Oui' else 'Non' end as ACTIF
--		 , TIERS.LTIERS AS LOCATAIRE_PRINCIPAL
--		 , ISNULL(case when len(RCS_COMPLETE.SIREN) = 8 then dbo.LPAD(RCS_COMPLETE.SIREN, 10, '0') else RCS_COMPLETE.SIREN end, case when TIERS.POUM = 'P' then 'Personne physique' else LEFT(TIERS.SIRET, 9) end) as SIREN
--		 , TIERS.RCS
--		 , convert(varchar(10), EASYFOLDER_BAUX.DT_EFFET, 103) as DT_EFFET
--		 , convert(VARCHAR(10), EASYFOLDER_BAUX.DT_FIN, 103) as DT_FIN
--		 , VAL_FIN.MT_LOYER_ACTUEL AS LOYER_ANNUEL_FACIAL
--		 --, VAL_FIN.MT_LOYER_ACTUEL_FACTURABLE - ABS(VAL_FIN.MT_LOYER_FRANCHISE) - ABS(VAL_FIN.MT_PALIER) as DERNIER_TERME_ANNUALISE
--		 , VAL_FIN.MT_LOYER_ACTUEL - ABS(VAL_FIN.MT_LOYER_FRANCHISE) - ABS(VAL_FIN.MT_PALIER) as DERNIER_TERME_ANNUALISE
--		 , CALCUL_SURFACE.VAL_SURF_BUR + CALCUL_SURFACE.VAL_SURF_COM + CALCUL_SURFACE.VAL_SURF_ACT + CALCUL_SURFACE.VAL_SURF_ARC + CALCUL_SURFACE.VAL_SURF_HAB + CALCUL_SURFACE.VAL_SURF_HOT AS VAL_SURF_BAIL
--		 , CALCUL_SURFACE.VAL_SURF_BUR
--		 , CALCUL_SURFACE.VAL_SURF_COM
--		 , CALCUL_SURFACE.VAL_SURF_ARC
--		 , CALCUL_SURFACE.VAL_SURF_HAB
--		 , CALCUL_SURFACE.VAL_SURF_HOT
--		 , CALCUL_SURFACE.VAL_SURF_ACT
--	from MASTER_ESTIA..L_INTERFACE_EASYFOLDER_BAUX as EASYFOLDER_BAUX 
--	left join SAFIR_ESTIA..D_BAIL BAIL
--	on BAIL.NM_IMMEUBLE = EASYFOLDER_BAUX.IDENTIFIANT_ESTIA_IMMEUBLE and BAIL.NM_BAIL = cast(EASYFOLDER_BAUX.IDENTIFIANT_ESTIA_COMPTE as varchar(30)) + dbo.LPAD(EASYFOLDER_BAUX.NOBAIL_ESTIA, 2, '0')
--	-- Debut modif MNA 20190213
--	inner join (select FK_BAIL from SAFIR_ESTIA..F_ETAT_LOCATIF where CORG = '11' and CD_STATUT = 'L' and IND_LOT_PRINCIPAL = 'O' and PK_TEMPS = @DT_ANALYSE) FEL
--	-- Fin modif MNA 20190213
--	on FEL.FK_BAIL = BAIL.PK_BAIL
--	--on FEL.CGROUPE = BAIL.NM_IMMEUBLE  and CAST(CAST(FEL.CCOMPTE as NUMERIC(10,0)) as VARCHAR(30)) + dbo.LPAD(FEL.NOBAIL, 2, '0') = BAIL.NM_BAIL
--	left join MASTER_ESTIA..ESTIA_TIERS TIERS
--	on TIERS.PK_TIERS = BAIL.FK_LOCATAIRE
--	left join
--	(
--		select * from f_GET_LEASE_VALUES(@DT_ANALYSE)
--	) CALCUL_SURFACE
--	on CALCUL_SURFACE.FK_BAIL = BAIL.PK_BAIL
--	left join SAFIR_ESTIA..D_IMMEUBLE IMMEUBLE
--	on IMMEUBLE.PK_IMMEUBLE = BAIL.FK_IMMEUBLE
--	left join SAFIR_ESTIA..D_MANDAT_GERANCE DMG
--	on DMG.FK_IMMEUBLE = IMMEUBLE.PK_IMMEUBLE
--	left join #VAL_FINANCIERES VAL_FIN
--	on VAL_FIN.PK_BAIL = BAIL.PK_BAIL
--	left join MASTER_ESTIA..P_TRANSCO_IMMEUBLE_EASYFOLDER P
--	on IMMEUBLE.NM_IMMEUBLE = P.NM_IMMEUBLE_ESTIA
--	left join RCS_COMPLETE
--	on RCS_COMPLETE.IDENTIFIANT_BAIL_DREAM = EASYFOLDER_BAUX.IDENTIFIANT_BAIL_DREAM
--	where  (BAIL.CD_SOCIETE IS NULL OR BAIL.CD_SOCIETE = '11')
--	and DMG.IND_MANDAT_ACTIF = 'O'
--	union
--	select IDENTIFIANT_BAIL_DREAM
--		 , IDENTIFIANT_DREAM_IMMEUBLE
--		 , NM_IMMEUBLE
--		 , ACTIF
--		 , LOCATAIRE_PRINCIPAL
--		 , SIREN
--		 , RCS
--		 , DT_EFFET
--		 , DT_FIN
--		 , LOYER_ANNUEL_FACIAL
--		 , DERNIER_TERME_ANNUALISE
--		 , VAL_SURF_BAIL
--		 , VAL_SURF_BUR
--		 , VAL_SURF_COM
--		 , VAL_SURF_ARC
--		 , VAL_SURF_HAB
--		 , VAL_SURF_HOT
--		 , VAL_SURF_ACT
--	from #TRAIT_BAUX
--) SRC
--order by IDENTIFIANT_DREAM_IMMEUBLE, IDENTIFIANT_BAIL_DREAM

--DROP TABLE #TRAIT_BAUX


CREATE TABLE #TRAIT_BAUX
(
	IDENTIFIANT_BAIL_DREAM		VARCHAR(255),
	IDENTIFIANT_DREAM_IMMEUBLE	VARCHAR(255),
	NM_IMMEUBLE					INT,
	ACTIF						VARCHAR(3),
	LOCATAIRE_PRINCIPAL			VARCHAR(255),
	SIREN						VARCHAR(100),
	RCS							VARCHAR(100),
	DT_EFFET					DATE,
	DT_FIN						DATE,
	LOYER_ANNUEL_FACIAL			NUMERIC(18,2),
	DERNIER_TERME_ANNUALISE		NUMERIC(18,2),
	VAL_SURF_BAIL				NUMERIC(18,2),
	VAL_SURF_BUR				NUMERIC(18,2),
	VAL_SURF_COM				NUMERIC(18,2),
	VAL_SURF_ARC				NUMERIC(18,2),
	VAL_SURF_HAB				NUMERIC(18,2),
	VAL_SURF_HOT				NUMERIC(18,2),
	VAL_SURF_ACT				NUMERIC(18,2),
	CD_STATUT					VARCHAR(1)
)

insert into #TRAIT_BAUX
select src.identifiant_bail_dream
	 , src.identifiant_dream_immeuble
	 , src.nm_immeuble
	 , src.actif
	 , src.locataire_principal
	 , src.siren
	 , src.rcs
	 , src.dt_effet
	 , src.dt_fin
	 , src.loyer_annuel_facial
	 , src.dernier_terme_annualise
	 , isnull(surface.val_surf_bur + surface.val_surf_com + surface.val_surf_arc + surface.val_surf_hab + surface.val_surf_hot + surface.val_surf_act, 0) val_surf_bail
	 , isnull(surface.val_surf_bur, 0) val_surf_bur
	 , isnull(surface.val_surf_com, 0) val_surf_com
	 , isnull(surface.val_surf_arc, 0) val_surf_arc
	 , isnull(surface.val_surf_hab, 0) val_surf_hab
	 , isnull(surface.val_surf_hot, 0) val_surf_hot
	 , isnull(surface.val_surf_act, 0) val_surf_act
	 , cd_statut
from
(
	select identifiant_dream_immeuble
		 , identifiant_bail_dream
		 , locataire_principal
		 , nm_immeuble
		 , actif
		 , siren
		 , rcs
		 , dt_effet
		 , dt_fin
		 , sum(loyer_annuel_facial) loyer_annuel_facial
		 , sum(dernier_terme_annualise) dernier_terme_annualise
		 , cd_statut
		 , sum(val_surf_bail) val_surf_bail
	from
	(
		select p.cd_immeuble_dream identifiant_dream_immeuble
			 , case when f.cd_statut = 'L' then
				case when abs(f.fk_locataire) = 88888
				then 'BAIL999997' else 'BAIL999999' end
				else 'BAIL999998'  
			   end identifiant_bail_dream
			 , case when f.cd_statut = 'L' then
				case when abs(f.fk_locataire) = 88888
				then 'Gardien' else 'Total '+p.cd_immeuble_dream end
				else 'Vacant '+p.cd_immeuble_dream  
			   end as locataire_principal
			 , f.cgroupe nm_immeuble
			 , 'Oui' actif
			 , null siren
			 , null rcs
			 , null dt_effet
			 , null dt_fin
			 , f.mt_loyer_actuel loyer_annuel_facial
			 , (f.mt_loyer_actuel - abs(f.mt_loyer_franchise) - abs(f.mt_palier)) dernier_terme_annualise
			 , f.cd_statut
			 , f.val_surface_totale val_surf_bail
		from f_etat_locatif f
		left join master_estia..p_transco_immeuble_easyfolder p
		on f.cgroupe = p.nm_immeuble_estia
		left join d_immeuble
		on f.fk_immeuble = d_immeuble.pk_immeuble
		inner join
		(
			select distinct immeuble.pk_immeuble
			from master_estia..l_interface_easyfolder_baux as easyfolder_baux 
			left join safir_estia..d_bail bail
			on bail.nm_immeuble = easyfolder_baux.identifiant_estia_immeuble and bail.nm_bail = cast(easyfolder_baux.identifiant_estia_compte as varchar(30)) + dbo.lpad(easyfolder_baux.nobail_estia, 2, '0')
			left join safir_estia..d_immeuble immeuble
			on immeuble.pk_immeuble = bail.fk_immeuble
			left join safir_estia..d_mandat_gerance dmg
			on dmg.fk_immeuble = immeuble.pk_immeuble
			left join master_estia..p_transco_immeuble_easyfolder p
			on immeuble.nm_immeuble = p.nm_immeuble_estia
			where  (bail.cd_societe is null or bail.cd_societe = '11')
			and dmg.ind_mandat_actif = 'o'
		) src
		on src.pk_immeuble = d_immeuble.pk_immeuble
		where f.pk_temps = @DT_ANALYSE and corg = '11'
	) w
	group by  identifiant_dream_immeuble
			, identifiant_bail_dream
			, locataire_principal
			, nm_immeuble
			, actif
			, siren
			, rcs
			, dt_effet
			, dt_fin
		    , cd_statut
) src
left join
(
	select identifiant_immeuble
		 , identifiant_bail
		 , sum(val_surf_bur) val_surf_bur
		 , sum(val_surf_com) val_surf_com
		 , sum(val_surf_arc) val_surf_arc
		 , sum(val_surf_hab) val_surf_hab
		 , sum(val_surf_hot) val_surf_hot
		 , sum(val_surf_act) val_surf_act
	from
	(
		select p.cd_immeuble_dream identifiant_immeuble
			, case when fel.cd_statut = 'L' then
			  case when abs(fel.fk_bail) = 88888
			  then 'BAIL999997' else 'BAIL999999' end
			  else 'BAIL999998'  
			  end identifiant_bail
			, (case when cd_reg_usage = 'BUR' then isnull(val_surface_reelle, 0) else 0 end) val_surf_bur
			, (case when cd_reg_usage = 'COM' then isnull(val_surface_reelle, 0) else 0 end) val_surf_com
			, (case when cd_reg_usage = 'ARC' then isnull(val_surface_reelle, 0) else 0 end) val_surf_arc
			, (case when cd_reg_usage = 'HAB' then isnull(val_surface_reelle, 0) else 0 end) val_surf_hab
			, (case when cd_reg_usage = 'HOT' then isnull(val_surface_reelle, 0) else 0 end) val_surf_hot
			, (case when cd_reg_usage not in ('BUR', 'COM', 'ARC', 'HAB', 'HOT') then isnull(val_surface_reelle, 0) else 0 end) val_surf_act
		from f_etat_locatif fel inner join
		(
			select l.pk_lot, l.nm_lot, l.cd_usage, l.cd_reg_usage, l.lb_reg_usage, l.lb_usage, val_surface_reelle  
			from d_lot l
			where val_surface_reelle > 0
		) lot
		on lot.pk_lot = fel.pk_lot
		left join master_estia..p_transco_immeuble_easyfolder p
		on fel.cgroupe = p.nm_immeuble_estia
		where fel.pk_temps = @DT_ANALYSE and corg = '11'
	) v
	group by identifiant_immeuble, identifiant_bail
) surface
on surface.identifiant_immeuble = src.identifiant_dream_immeuble and surface.identifiant_bail = src.identifiant_bail_dream

update #TRAIT_BAUX
set val_surf_bail = i.surface_totale, 
	val_surf_bur = t2.val_surf_bur,
	val_surf_com = t2.val_surf_com,
	val_surf_arc = t2.val_surf_arc,
	val_surf_hab = t2.val_surf_hab,
	val_surf_hot = t2.val_surf_hot,
	val_surf_act = t2.val_surf_act
from #TRAIT_BAUX T
left join (select pk_immeuble, nm_immeuble, surface_totale from d_immeuble where cd_societe = '11') i 
on i.nm_immeuble = t.nm_immeuble
left join 
(
	select nm_immeuble
		  , sum(val_surf_bur) val_surf_bur
		  , sum(val_surf_com) val_surf_com
		  , sum(val_surf_arc) val_surf_arc
		  , sum(val_surf_hab) val_surf_hab
		  , sum(val_surf_hot) val_surf_hot
		  , sum(val_surf_act) val_surf_act 
	from #TRAIT_BAUX
	group by nm_immeuble
) t2
on t2.nm_immeuble = t.nm_immeuble
where t.locataire_principal like 'Total%'

insert into #TRAIT_BAUX (identifiant_bail_dream, identifiant_dream_immeuble, nm_immeuble, actif, locataire_principal, loyer_annuel_facial, dernier_terme_annualise, val_surf_bail, val_surf_bur, val_surf_com, val_surf_arc, val_surf_hab, val_surf_hot, val_surf_act)
select distinct 'BAIL999998', b.identifiant_dream_immeuble, b.nm_immeuble, b.actif, 'Vacant '+b.identifiant_dream_immeuble, 0, 0, 0, 0, 0, 0, 0, 0, 0 
from #TRAIT_BAUX B
where not exists
(
  select * from #TRAIT_BAUX
  where #TRAIT_BAUX.identifiant_dream_immeuble = b.identifiant_dream_immeuble and #TRAIT_BAUX.locataire_principal = 'Vacant '+b.identifiant_dream_immeuble
)

select IDENTIFIANT_BAIL_DREAM
	 , IDENTIFIANT_DREAM_IMMEUBLE
	 , NM_IMMEUBLE
	 , ACTIF
	 , LOCATAIRE_PRINCIPAL
	 , SIREN
	 , RCS
	 , DT_EFFET
	 , DT_FIN
	 , LOYER_ANNUEL_FACIAL
	 , DERNIER_TERME_ANNUALISE
	 , VAL_SURF_BAIL
	 , VAL_SURF_BUR
	 , VAL_SURF_COM
	 , VAL_SURF_ARC
	 , VAL_SURF_HAB
	 , VAL_SURF_HOT
	 , VAL_SURF_ACT
from
(
	select IDENTIFIANT_BAIL_DREAM
		 , IDENTIFIANT_DREAM_IMMEUBLE
		 , NM_IMMEUBLE
		 , ACTIF
		 , LOCATAIRE_PRINCIPAL
		 , SIREN
		 , RCS
		 , DT_EFFET
		 , DT_FIN
		 , SUM(ISNULL(LOYER_ANNUEL_FACIAL, 0)) LOYER_ANNUEL_FACIAL
		 , SUM(ISNULL(DERNIER_TERME_ANNUALISE, 0)) DERNIER_TERME_ANNUALISE
		 , SUM(ISNULL(VAL_SURF_BAIL, 0)) VAL_SURF_BAIL
		 , SUM(ISNULL(VAL_SURF_BUR, 0)) VAL_SURF_BUR
		 , SUM(ISNULL(VAL_SURF_COM, 0)) VAL_SURF_COM
		 , SUM(ISNULL(VAL_SURF_ARC, 0)) VAL_SURF_ARC
		 , SUM(ISNULL(VAL_SURF_HAB, 0)) VAL_SURF_HAB
		 , SUM(ISNULL(VAL_SURF_HOT, 0)) VAL_SURF_HOT
		 , SUM(ISNULL(VAL_SURF_ACT, 0)) VAL_SURF_ACT
	from
	(
		select EASYFOLDER_BAUX.IDENTIFIANT_BAIL_DREAM
			 , ISNULL(EASYFOLDER_BAUX.IDENTIFIANT_DREAM_IMMEUBLE, P.CD_IMMEUBLE_DREAM) as IDENTIFIANT_DREAM_IMMEUBLE
			 , IMMEUBLE.NM_IMMEUBLE
			 , case when ISNULL(BAIL.DT_SORTIE, '29990101') >=  @DT_ANALYSE then 'Oui' else 'Non' end as ACTIF
			 , TIERS.LTIERS AS LOCATAIRE_PRINCIPAL
			 , ISNULL(case when len(RCS_COMPLETE.SIREN) = 8 then dbo.LPAD(RCS_COMPLETE.SIREN, 10, '0') else RCS_COMPLETE.SIREN end, case when TIERS.POUM = 'P' then 'Personne physique' else LEFT(TIERS.SIRET, 9) end) as SIREN
			 , TIERS.RCS
			 , convert(varchar(10), EASYFOLDER_BAUX.DT_EFFET, 103) as DT_EFFET
			 , convert(VARCHAR(10), EASYFOLDER_BAUX.DT_FIN, 103) as DT_FIN
			 , FEL.MT_LOYER_ACTUEL AS LOYER_ANNUEL_FACIAL
			 , FEL.MT_LOYER_ACTUEL - ABS(FEL.MT_LOYER_FRANCHISE) - ABS(FEL.MT_PALIER) as DERNIER_TERME_ANNUALISE
			 , CALCUL_SURFACE.VAL_SURF_BUR + CALCUL_SURFACE.VAL_SURF_COM + CALCUL_SURFACE.VAL_SURF_ACT + CALCUL_SURFACE.VAL_SURF_ARC + CALCUL_SURFACE.VAL_SURF_HAB + CALCUL_SURFACE.VAL_SURF_HOT AS VAL_SURF_BAIL
			 , CALCUL_SURFACE.VAL_SURF_BUR
			 , CALCUL_SURFACE.VAL_SURF_COM
			 , CALCUL_SURFACE.VAL_SURF_ARC
			 , CALCUL_SURFACE.VAL_SURF_HAB
			 , CALCUL_SURFACE.VAL_SURF_HOT
			 , CALCUL_SURFACE.VAL_SURF_ACT
		from MASTER_ESTIA..L_INTERFACE_EASYFOLDER_BAUX as EASYFOLDER_BAUX 
		--left join SAFIR_ESTIA..D_BAIL BAIL
		--on BAIL.NM_IMMEUBLE = EASYFOLDER_BAUX.IDENTIFIANT_ESTIA_IMMEUBLE and BAIL.NM_BAIL = cast(EASYFOLDER_BAUX.IDENTIFIANT_ESTIA_COMPTE as varchar(30)) + dbo.LPAD(EASYFOLDER_BAUX.NOBAIL_ESTIA, 2, '0')
		--inner join (select FK_BAIL, MT_LOYER_ACTUEL, MT_LOYER_FRANCHISE, MT_PALIER from SAFIR_ESTIA..F_ETAT_LOCATIF where CORG = '11' and CD_STATUT = 'L' and PK_TEMPS = @DT_ANALYSE) FEL
		--on FEL.FK_BAIL = BAIL.PK_BAIL
		--left join MASTER_ESTIA..ESTIA_TIERS TIERS
		--on TIERS.PK_TIERS = BAIL.FK_LOCATAIRE
		left join (select distinct PK_BAIL, FK_IMMEUBLE, FK_LOCATAIRE, NM_IMMEUBLE, NM_BAIL, DT_SORTIE from SAFIR_ESTIA..D_BAIL where CD_SOCIETE IS NULL OR CD_SOCIETE = '11') BAIL
		on BAIL.NM_IMMEUBLE = EASYFOLDER_BAUX.IDENTIFIANT_ESTIA_IMMEUBLE and BAIL.NM_BAIL = cast(EASYFOLDER_BAUX.IDENTIFIANT_ESTIA_COMPTE as varchar(30)) + dbo.LPAD(EASYFOLDER_BAUX.NOBAIL_ESTIA, 2, '0')
		inner join 
		(
			select FK_BAIL
				 , SUM(MT_LOYER_ACTUEL) MT_LOYER_ACTUEL
				 , SUM(MT_LOYER_FRANCHISE) MT_LOYER_FRANCHISE
				 , SUM(MT_PALIER) MT_PALIER 
			from SAFIR_ESTIA..F_ETAT_LOCATIF 
			where CORG = '11' 
			and CD_STATUT = 'L' 
			and PK_TEMPS = @DT_ANALYSE
			--and IND_LOT_PRINCIPAL = 'O'
			group by FK_BAIL
		) FEL
		on FEL.FK_BAIL = BAIL.PK_BAIL
		left join MASTER_ESTIA..ESTIA_TIERS TIERS
		on TIERS.PK_TIERS = BAIL.FK_LOCATAIRE
		left join
		(
			select * from f_GET_LEASE_VALUES(@DT_ANALYSE)
		) CALCUL_SURFACE
		on CALCUL_SURFACE.FK_BAIL = BAIL.PK_BAIL
		left join SAFIR_ESTIA..D_IMMEUBLE IMMEUBLE
		on IMMEUBLE.PK_IMMEUBLE = BAIL.FK_IMMEUBLE
		left join SAFIR_ESTIA..D_MANDAT_GERANCE DMG
		on DMG.FK_IMMEUBLE = IMMEUBLE.PK_IMMEUBLE
		left join MASTER_ESTIA..P_TRANSCO_IMMEUBLE_EASYFOLDER P
		on IMMEUBLE.NM_IMMEUBLE = P.NM_IMMEUBLE_ESTIA
		left join RCS_COMPLETE
		on RCS_COMPLETE.IDENTIFIANT_BAIL_DREAM = EASYFOLDER_BAUX.IDENTIFIANT_BAIL_DREAM
		where EASYFOLDER_BAUX.IDENTIFIANT_ESTIA_IMMEUBLE is not null  and DMG.IND_MANDAT_ACTIF = 'O'
	) y
	group by IDENTIFIANT_BAIL_DREAM
		   , IDENTIFIANT_DREAM_IMMEUBLE
		   , NM_IMMEUBLE
		   , ACTIF
		   , LOCATAIRE_PRINCIPAL
		   , SIREN
		   , RCS
		   , DT_EFFET
		   , DT_FIN
 --Autre methode pour obtenir la lsite des baux loues 
		--select IDENTIFIANT_BAIL_DREAM
		--		, IDENTIFIANT_DREAM_IMMEUBLE
		--		, NM_IMMEUBLE
		--		, ACTIF
		--		, LOCATAIRE_PRINCIPAL
		--		, SIREN
		--		, RCS
		--		, DT_EFFET
		--		, DT_FIN
		--		, SUM(ISNULL(LOYER_ANNUEL_FACIAL, 0)) LOYER_ANNUEL_FACIAL
		--		, SUM(ISNULL(DERNIER_TERME_ANNUALISE, 0)) DERNIER_TERME_ANNUALISE
		--		, SUM(ISNULL(VAL_SURF_BAIL, 0)) VAL_SURF_BAIL
		--		, SUM(ISNULL(VAL_SURF_BUR, 0)) VAL_SURF_BUR
		--		, SUM(ISNULL(VAL_SURF_COM, 0)) VAL_SURF_COM
		--		, SUM(ISNULL(VAL_SURF_ARC, 0)) VAL_SURF_ARC
		--		, SUM(ISNULL(VAL_SURF_HAB, 0)) VAL_SURF_HAB
		--		, SUM(ISNULL(VAL_SURF_HOT, 0)) VAL_SURF_HOT
		--		, SUM(ISNULL(VAL_SURF_ACT, 0)) VAL_SURF_ACT
		--from
		--(
		--	select easyfolder_baux.identifiant_bail_dream
		--		 , ISNULL(easyfolder_baux.identifiant_dream_immeuble, p.cd_immeuble_dream) identifiant_dream_immeuble
		--		 , immeuble.nm_immeuble
		--		 , case when ISNULL(bail.dt_sortie, '29990101') >=  /*@DT_ANALYSE*/'20190131' then 'Oui' else 'Non' end ACTIF
		--		 , tiers.ltiers Locataire_principal
		--		 , ISNULL(case when len(rcs_complete.siren) = 8 then dbo.lpad(rcs_complete.siren, 10, '0') else rcs_complete.siren end, case when tiers.poum = 'P' then 'Personne physique' else LEFT(tiers.siret, 9) end) siren
		--		 , tiers.rcs
		--		 , convert(varchar(10), easyfolder_baux.dt_effet, 103) dt_effet
		--		 , convert(VARCHAR(10), easyfolder_baux.dt_fin, 103) dt_fin
		--		 , fel.mt_loyer_actuel AS loyer_annuel_facial
		--		 , fel.mt_loyer_actuel - ABS(fel.mt_loyer_franchise) - ABS(fel.mt_palier) as dernier_terme_annualise
		--		 , calcul_surface.val_surf_bur + calcul_surface.val_surf_com + calcul_surface.val_surf_act + calcul_surface.val_surf_arc + calcul_surface.val_surf_hab + calcul_surface.val_surf_hot as val_surf_bail
		--		 , calcul_surface.val_surf_bur
		--		 , calcul_surface.val_surf_com
		--		 , calcul_surface.val_surf_arc
		--		 , calcul_surface.val_surf_hab
		--		 , calcul_surface.val_surf_hot
		--		 , calcul_surface.val_surf_act
		--	from safir_estia..f_etat_locatif fel
		--	left join safir_estia..d_bail bail
		--	on bail.pk_bail = fel.fk_bail
		--	inner join master_estia..l_interface_easyfolder_baux easyfolder_baux
		--	on bail.nm_immeuble = easyfolder_baux.identifiant_estia_immeuble and bail.nm_bail = cast(easyfolder_baux.identifiant_estia_compte as varchar(30)) + dbo.LPAD(easyfolder_baux.nobail_estia, 2, '0')
		--	left join safir_estia..d_immeuble immeuble
		--	on immeuble.pk_immeuble = bail.fk_immeuble
		--	left join safir_estia..d_mandat_gerance dmg
		--	on dmg.fk_immeuble = immeuble.pk_immeuble
		--	left join master_estia..p_transco_immeuble_easyfolder p
		--	on immeuble.nm_immeuble = p.nm_immeuble_estia
		--	left join rcs_complete
		--	on rcs_complete.identifiant_bail_dream = easyfolder_baux.identifiant_bail_dream
		--	left join master_estia..estia_tiers tiers
		--	on tiers.pk_tiers = bail.fk_locataire
		--	left join
		--	(
		--		select * from f_get_lease_values(/*@DT_ANALYSE*/'20190131')
		--	) calcul_surface
		--	on calcul_surface.fk_bail = bail.pk_bail	
		--	where fel.corg = '11' --and fel.cgroupe = 4020
		--	and fel.cd_statut = 'L'
		--	and fel.pk_temps = '20190131'--@DT_ANALYSE
		--	and dmg.ind_mandat_actif = 'O'
		--) y
		--group by IDENTIFIANT_BAIL_DREAM
		--		, IDENTIFIANT_DREAM_IMMEUBLE
		--		, NM_IMMEUBLE
		--		, ACTIF
		--		, LOCATAIRE_PRINCIPAL
		--		, SIREN
		--		, RCS
		--		, DT_EFFET
		--		, DT_FIN
-------------------------------------------------------------------
	union
	select IDENTIFIANT_BAIL_DREAM
		 , IDENTIFIANT_DREAM_IMMEUBLE
		 , NM_IMMEUBLE
		 , ACTIF
		 , LOCATAIRE_PRINCIPAL
		 , SIREN
		 , RCS
		 , DT_EFFET
		 , DT_FIN
		 , LOYER_ANNUEL_FACIAL
		 , DERNIER_TERME_ANNUALISE
		 , VAL_SURF_BAIL
		 , VAL_SURF_BUR
		 , VAL_SURF_COM
		 , VAL_SURF_ARC
		 , VAL_SURF_HAB
		 , VAL_SURF_HOT
		 , VAL_SURF_ACT
	from #TRAIT_BAUX
) SRC
--where IDENTIFIANT_DREAM_IMMEUBLE = 'IMMEU-00009'
order by IDENTIFIANT_DREAM_IMMEUBLE, IDENTIFIANT_BAIL_DREAM

DROP TABLE #TRAIT_BAUX

END