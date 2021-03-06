﻿
CREATE PROCEDURE [dbo].[BUDGET_CHARGES] 
(
	@PK_PROPRIETAIRE VARCHAR(MAX),
	@PK_IMMEUBLE VARCHAR(MAX),
	@ANNEE_BUDGET VARCHAR(4)
)
AS
BEGIN

	SET NOCOUNT ON;

DECLARE @DATE_DEB_COUR DATE,
		@DATE_FIN_COUR DATE,
		@DATE_DEB_PREC DATE,
		@DATE_FIN_PREC DATE

SET @DATE_DEB_COUR = cast(@ANNEE_BUDGET as varchar(4))+'0101'
SET @DATE_FIN_COUR = cast(@ANNEE_BUDGET as varchar(4))+'1231'
SET @DATE_DEB_PREC = cast(@ANNEE_BUDGET-1 as varchar(4))+'0101' 
SET @DATE_FIN_PREC = cast(@ANNEE_BUDGET-1 as varchar(4))+'1231';

with REQ_BT_COUR as
(
	select CORG
		 , CGROUPE
		 , NOBON
		 , CCRITDP
		 , CSCRITDP
		 , ANNEE
		 , SUM(ISNULL(MT_ENG, 0)) MT_ENG
		 , SUM(ISNULL(MT_REA, 0)) MT_REA
	from
	(
		select  ECRIB.CORG
				, GROUPE.CGROUPE
				, ECRIB.NOBON
				, ECRIB.CCRITDP
				, ECRIB.CSCRITDP
				, ECRIB.CEXO ANNEE
				, case ECRIB.CSTE when 'EG' then isnull(MONTANT, 0) else 0 end MT_ENG
				, MT_REA
		from MASTER_ESTIA..ESTIA_ECRIB ECRIB
		left join MASTER_ESTIA..ESTIA_GROUPE GROUPE on GROUPE.PK_GROUPE = ECRIB.FK_GROUPE
		left join
		(
			select ECRIB.CORG
				, GROUPE.CGROUPE
				, ECRIB.NOBON
				, ECRIB.CCRITDP
				, ECRIB.CSCRITDP
				, ECRIB.CEXO
				, case ECRIB.CSTE when 'RE' then isnull(MONTANT, 0) else 0 end MT_REA
			from MASTER_ESTIA..ESTIA_ECRIB ECRIB
			left join MASTER_ESTIA..ESTIA_GROUPE GROUPE on GROUPE.PK_GROUPE = ECRIB.FK_GROUPE
			where ECRIB.CORG = '11'
			and ECRIB.TYPBON = 'BT'
			and ECRIB.CSTE in ('RE')
		) REA
		on REA.CORG = ECRIB.CORG and REA.CGROUPE = GROUPE.CGROUPE and REA.NOBON = ECRIB.NOBON and REA.CCRITDP = ECRIB.CCRITDP and REA.CSCRITDP = ECRIB.CSCRITDP and REA.CEXO = ECRIB.CEXO--datepart(year, ECRIB.DATEC)
		where ECRIB.CORG = '11'
		and GROUPE.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
		and ECRIB.CEXO IN (@ANNEE_BUDGET)
		and ECRIB.TYPBON = 'BT'
		and ECRIB.CSTE in ('EG')
		and ECRIB.CTRAIT in ('LBT')
	) SRC
	group by CORG, CGROUPE, NOBON, CCRITDP, CSCRITDP, ANNEE
),
REQ_CTR_COUR as
(
	SELECT EC.CORG
		 , EC.CGROUPE
		 , EC.CCONTFRS
		 , EC.CCRITDP
		 , EC.CSCRITDP
		 , EC.CEXO ANNEE
		 , CAST(((CONTNAT.MT_CONTRAT + ISNULL(AVENANT_CTR.MT_AVENANT_CONTRAT, 0)) * VENTPCHA.TXVENT)/100 AS NUMERIC(17,2)) AS MT_ENG
		 , SUM(ISNULL(EC.MONTANT, 0)) AS MT_REA
	FROM MASTER_ESTIA..ESTIA_ECRITAUX ECRITAUX
	INNER JOIN
	(
		SELECT ECRAC.CORG
			 , EB.PK_GROUPE
			 , EB.CGROUPE
			 , EB.CCONTFRS
			 , EB.DLIMPREST
			 , EB.CCRITDP
			 , EB.CSCRITDP
			 , EB.CEXO
			 , ECRAC.REF
			 , ECRAC.ORD		
			 , ECRAC.MONTANT
		FROM MASTER_ESTIA..ESTIA_ECRAC ECRAC
		LEFT JOIN MASTER_ESTIA..WRK_GROUPE_MANGES WGM
		ON WGM.CORG = ECRAC.CORG AND WGM.CMANDAT = ECRAC.CMANDAT
		INNER JOIN
		(
			SELECT B.CORG
				 , GROUPE.PK_GROUPE
				 , GROUPE.CGROUPE
				 , CTRTIERS.CCONTFRS
				 , CTRTIERS.DLIMPREST
				 , B.CCRITDP
				 , B.CSCRITDP
				 , B.CEXO 
				 , B.REF
				 , B.ORD
			FROM MASTER_ESTIA..ESTIA_ECRIB B
			left join MASTER_ESTIA..ESTIA_GROUPE GROUPE on GROUPE.PK_GROUPE = B.FK_GROUPE
			left join MASTER_ESTIA..ESTIA_CTRTIERS CTRTIERS on CTRTIERS.PK_CTRTIERS = B.FK_CTRTIERS
			WHERE B.TYPBON = 'CTR' 
			AND B.CORG = '11'
			AND B.CSTE IN  ('RE')
		) EB
		ON EB.CORG = ECRAC.CORG AND EB.REF = ECRAC.REF AND EB.ORD = ECRAC.ORD
		WHERE ECRAC.CORG = '11'
		AND ECRAC.SENS = 'D'
	) EC
	ON EC.CORG = ECRITAUX.CORG AND EC.REF = ECRITAUX.REF
	LEFT JOIN 
	(
		SELECT CORG
				, CCONTFRS
				, ISNULL(SUM(MTTC), 0) AS MT_CONTRAT
		FROM MASTER_ESTIA..ESTIA_CONTNAT 
		GROUP BY CORG, CCONTFRS
	) CONTNAT
	ON CONTNAT.CORG = EC.CORG AND CONTNAT.CCONTFRS = EC.CCONTFRS
	LEFT JOIN 
	(
		SELECT CORG
				, CCONTFRS
				, ISNULL(SUM(MTTC), 0) AS MT_AVENANT_CONTRAT
		FROM MASTER_ESTIA..ESTIA_AVENAN
		WHERE DSIGN BETWEEN @DATE_DEB_COUR and @DATE_FIN_COUR
		GROUP BY CORG, CCONTFRS
	) AVENANT_CTR
	ON AVENANT_CTR.CORG = EC.CORG AND AVENANT_CTR.CCONTFRS = EC.CCONTFRS
	LEFT JOIN MASTER_ESTIA..ESTIA_VENTPCHA VENTPCHA on VENTPCHA.CORG = EC.CORG and VENTPCHA.CCONTFRS = EC.CCONTFRS and VENTPCHA.CCRITDP = EC.CCRITDP and VENTPCHA.CSCRITDP = EC.CSCRITDP
	WHERE ECRITAUX.CTYPECRI = 'FAC'
	AND ECRITAUX.CORG = '11'
	AND EC.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	and EC.CEXO IN (@ANNEE_BUDGET)
	AND datepart(year, EC.DLIMPREST) = EC.CEXO
	GROUP BY EC.CORG, EC.CGROUPE, EC.CCONTFRS, EC.CCRITDP, EC.CSCRITDP, EC.CEXO, CONTNAT.MT_CONTRAT, AVENANT_CTR.MT_AVENANT_CONTRAT, VENTPCHA.TXVENT
),
REQ_COUR AS
(
	SELECT CORG
		 , CGROUPE
		 , CCRITDP
		 , CSCRITDP
		 , ANNEE
		 , SUM(MT_ENG) MT_ENG
		 , SUM(MT_REA) MT_REA
	FROM
	(
		SELECT CORG, CGROUPE, CCRITDP, CSCRITDP, ANNEE, MT_ENG, MT_REA
		FROM REQ_BT_COUR
		WHERE ANNEE = @ANNEE_BUDGET
		UNION
		SELECT CORG, CGROUPE, CCRITDP, CSCRITDP, ANNEE, MT_ENG, MT_REA
		FROM REQ_CTR_COUR
		WHERE ANNEE = @ANNEE_BUDGET
	) SRC
	GROUP BY CORG, CGROUPE, CCRITDP, CSCRITDP, ANNEE
),
REQ_BT_PREC as
(
	select CORG
		 , CGROUPE
		 , NOBON
		 , CCRITDP
		 , CSCRITDP
		 , ANNEE
		 , SUM(ISNULL(MT_ENG, 0)) MT_ENG
		 , SUM(ISNULL(MT_REA, 0)) MT_REA
	from
	(
		select  ECRIB.CORG
				, GROUPE.CGROUPE
				, ECRIB.NOBON
				, ECRIB.CCRITDP
				, ECRIB.CSCRITDP
				, ECRIB.CEXO ANNEE
				, case ECRIB.CSTE when 'EG' then isnull(MONTANT, 0) else 0 end MT_ENG
				, MT_REA
		from MASTER_ESTIA..ESTIA_ECRIB ECRIB
		left join MASTER_ESTIA..ESTIA_GROUPE GROUPE on GROUPE.PK_GROUPE = ECRIB.FK_GROUPE
		left join
		(
			select ECRIB.CORG
				, GROUPE.CGROUPE
				, ECRIB.NOBON
				, ECRIB.CCRITDP
				, ECRIB.CSCRITDP
				, ECRIB.CEXO
				, case ECRIB.CSTE when 'RE' then isnull(MONTANT, 0) else 0 end MT_REA
			from MASTER_ESTIA..ESTIA_ECRIB ECRIB
			left join MASTER_ESTIA..ESTIA_GROUPE GROUPE on GROUPE.PK_GROUPE = ECRIB.FK_GROUPE
			where ECRIB.CORG = '11'
			and ECRIB.TYPBON = 'BT'
			and ECRIB.CSTE in ('RE')
		) REA
		on REA.CORG = ECRIB.CORG and REA.CGROUPE = GROUPE.CGROUPE and REA.NOBON = ECRIB.NOBON and REA.CCRITDP = ECRIB.CCRITDP and REA.CSCRITDP = ECRIB.CSCRITDP and REA.CEXO = ECRIB.CEXO--datepart(year, ECRIB.DATEC)
		where ECRIB.CORG = '11'
		and GROUPE.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
		and ECRIB.CEXO IN (@ANNEE_BUDGET-1)
		and ECRIB.TYPBON = 'BT'
		and ECRIB.CSTE in ('EG')
		and ECRIB.CTRAIT in ('LBT')
	) SRC
	group by CORG, CGROUPE, NOBON, CCRITDP, CSCRITDP, ANNEE
),
REQ_CTR_PREC as
(
	SELECT EC.CORG
		 , EC.CGROUPE
		 , EC.CCONTFRS
		 , EC.CCRITDP
		 , EC.CSCRITDP
		 , EC.CEXO ANNEE
		 , CAST(((CONTNAT.MT_CONTRAT + ISNULL(AVENANT_CTR.MT_AVENANT_CONTRAT, 0)) * VENTPCHA.TXVENT)/100 AS NUMERIC(17,2)) AS MT_ENG
		 , SUM(ISNULL(EC.MONTANT, 0)) AS MT_REA
	FROM MASTER_ESTIA..ESTIA_ECRITAUX ECRITAUX
	INNER JOIN
	(
		SELECT ECRAC.CORG
			 , EB.PK_GROUPE
			 , EB.CGROUPE
			 , EB.CCONTFRS
			 , EB.DLIMPREST
			 , EB.CCRITDP
			 , EB.CSCRITDP
			 , EB.CEXO
			 , ECRAC.REF
			 , ECRAC.ORD		
			 , ECRAC.MONTANT
		FROM MASTER_ESTIA..ESTIA_ECRAC ECRAC
		LEFT JOIN MASTER_ESTIA..WRK_GROUPE_MANGES WGM
		ON WGM.CORG = ECRAC.CORG AND WGM.CMANDAT = ECRAC.CMANDAT
		INNER JOIN
		(
			SELECT B.CORG
				 , GROUPE.PK_GROUPE
				 , GROUPE.CGROUPE
				 , CTRTIERS.CCONTFRS
				 , CTRTIERS.DLIMPREST
				 , B.CCRITDP
				 , B.CSCRITDP
				 , B.CEXO 
				 , B.REF
				 , B.ORD
			FROM MASTER_ESTIA..ESTIA_ECRIB B
			left join MASTER_ESTIA..ESTIA_GROUPE GROUPE on GROUPE.PK_GROUPE = B.FK_GROUPE
			left join MASTER_ESTIA..ESTIA_CTRTIERS CTRTIERS on CTRTIERS.PK_CTRTIERS = B.FK_CTRTIERS
			WHERE B.TYPBON = 'CTR' 
			AND B.CORG = '11'
			AND B.CSTE IN  ('RE')
		) EB
		ON EB.CORG = ECRAC.CORG AND EB.REF = ECRAC.REF AND EB.ORD = ECRAC.ORD
		WHERE ECRAC.CORG = '11'
		AND ECRAC.SENS = 'D'
	) EC
	ON EC.CORG = ECRITAUX.CORG AND EC.REF = ECRITAUX.REF
	LEFT JOIN 
	(
		SELECT CORG
				, CCONTFRS
				, ISNULL(SUM(MTTC), 0) AS MT_CONTRAT
		FROM MASTER_ESTIA..ESTIA_CONTNAT 
		GROUP BY CORG, CCONTFRS
	) CONTNAT
	ON CONTNAT.CORG = EC.CORG AND CONTNAT.CCONTFRS = EC.CCONTFRS
	LEFT JOIN 
	(
		SELECT CORG
				, CCONTFRS
				, ISNULL(SUM(MTTC), 0) AS MT_AVENANT_CONTRAT
		FROM MASTER_ESTIA..ESTIA_AVENAN
		WHERE DSIGN BETWEEN @DATE_DEB_PREC and @DATE_FIN_PREC
		GROUP BY CORG, CCONTFRS
	) AVENANT_CTR
	ON AVENANT_CTR.CORG = EC.CORG AND AVENANT_CTR.CCONTFRS = EC.CCONTFRS
	LEFT JOIN MASTER_ESTIA..ESTIA_VENTPCHA VENTPCHA on VENTPCHA.CORG = EC.CORG and VENTPCHA.CCONTFRS = EC.CCONTFRS and VENTPCHA.CCRITDP = EC.CCRITDP and VENTPCHA.CSCRITDP = EC.CSCRITDP
	WHERE ECRITAUX.CTYPECRI = 'FAC'
	AND ECRITAUX.CORG = '11'
	AND EC.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	and EC.CEXO IN (@ANNEE_BUDGET-1)
	AND datepart(year, EC.DLIMPREST) = EC.CEXO
	GROUP BY EC.CORG, EC.CGROUPE, EC.CCONTFRS, EC.CCRITDP, EC.CSCRITDP, EC.CEXO, CONTNAT.MT_CONTRAT, AVENANT_CTR.MT_AVENANT_CONTRAT, VENTPCHA.TXVENT
),
REQ_PREC AS
(
	SELECT CORG
		 , CGROUPE
		 , CCRITDP
		 , CSCRITDP
		 , ANNEE
		 , SUM(MT_REA) MT_REA
	FROM
	(
		SELECT CORG, CGROUPE, CCRITDP, CSCRITDP, ANNEE, MT_REA
		FROM REQ_BT_PREC
		UNION
		SELECT CORG, CGROUPE, CCRITDP, CSCRITDP, ANNEE, MT_REA
		FROM REQ_CTR_PREC
	) SRC
	GROUP BY CORG, CGROUPE, CCRITDP, CSCRITDP, ANNEE
),
REQ_BT_PREC_ADATE as
(
	select CORG
		 , CGROUPE
		 , NOBON
		 , CCRITDP
		 , CSCRITDP
		 , ANNEE
		 , SUM(ISNULL(MT_ENG, 0)) MT_ENG
		 , SUM(ISNULL(MT_REA, 0)) MT_REA
	from
	(
		select  ECRIB.CORG
				, GROUPE.CGROUPE
				, ECRIB.NOBON
				, ECRIB.CCRITDP
				, ECRIB.CSCRITDP
				, ECRIB.CEXO ANNEE
				, case ECRIB.CSTE when 'EG' then isnull(MONTANT, 0) else 0 end MT_ENG
				, MT_REA
		from MASTER_ESTIA..ESTIA_ECRIB ECRIB
		left join MASTER_ESTIA..ESTIA_GROUPE GROUPE on GROUPE.PK_GROUPE = ECRIB.FK_GROUPE
		left join
		(
			select ECRIB.CORG
				, GROUPE.CGROUPE
				, ECRIB.NOBON
				, ECRIB.CCRITDP
				, ECRIB.CSCRITDP
				, ECRIB.CEXO
				, case ECRIB.CSTE when 'RE' then isnull(MONTANT, 0) else 0 end MT_REA
			from MASTER_ESTIA..ESTIA_ECRIB ECRIB
			left join MASTER_ESTIA..ESTIA_GROUPE GROUPE on GROUPE.PK_GROUPE = ECRIB.FK_GROUPE
			where ECRIB.CORG = '11'
			and ECRIB.TYPBON = 'BT'
			and ECRIB.CSTE in ('RE')
			and ECRIB.DATEC <= cast(@ANNEE_BUDGET-1 as varchar(4)) + dbo.lpad(cast(datepart(month, getdate()) as varchar(2)), 2 , '0') + dbo.lpad(cast(datepart(day, getdate()) as varchar(2)), 2, '0')
		) REA
		on REA.CORG = ECRIB.CORG and REA.CGROUPE = GROUPE.CGROUPE and REA.NOBON = ECRIB.NOBON and REA.CCRITDP = ECRIB.CCRITDP and REA.CSCRITDP = ECRIB.CSCRITDP and REA.CEXO = ECRIB.CEXO--datepart(year, ECRIB.DATEC)
		where ECRIB.CORG = '11'
		and GROUPE.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
		and ECRIB.CEXO IN (@ANNEE_BUDGET-1)
		and ECRIB.TYPBON = 'BT'
		and ECRIB.CSTE in ('EG')
		and ECRIB.CTRAIT in ('LBT')
		and ECRIB.DATEC <= cast(@ANNEE_BUDGET-1 as varchar(4)) + dbo.lpad(cast(datepart(month, getdate()) as varchar(2)), 2 , '0') + dbo.lpad(cast(datepart(day, getdate()) as varchar(2)), 2, '0')
	) SRC
	group by CORG, CGROUPE, NOBON, CCRITDP, CSCRITDP, ANNEE
),
REQ_CTR_PREC_ADATE as
(
	SELECT EC.CORG
		 , EC.CGROUPE
		 , EC.CCONTFRS
		 , EC.CCRITDP
		 , EC.CSCRITDP
		 , EC.CEXO ANNEE
		 , CAST(((CONTNAT.MT_CONTRAT + ISNULL(AVENANT_CTR.MT_AVENANT_CONTRAT, 0)) * VENTPCHA.TXVENT)/100 AS NUMERIC(17,2)) AS MT_ENG
		 , SUM(ISNULL(EC.MONTANT, 0)) AS MT_REA
	FROM MASTER_ESTIA..ESTIA_ECRITAUX ECRITAUX
	INNER JOIN
	(
		SELECT ECRAC.CORG
			 , EB.PK_GROUPE
			 , EB.CGROUPE
			 , EB.CCONTFRS
			 , EB.DLIMPREST
			 , EB.CCRITDP
			 , EB.CSCRITDP
			 , EB.CEXO
			 , ECRAC.REF
			 , ECRAC.ORD		
			 , ECRAC.MONTANT
		FROM MASTER_ESTIA..ESTIA_ECRAC ECRAC
		LEFT JOIN MASTER_ESTIA..WRK_GROUPE_MANGES WGM
		ON WGM.CORG = ECRAC.CORG AND WGM.CMANDAT = ECRAC.CMANDAT
		INNER JOIN
		(
			SELECT B.CORG
				 , GROUPE.PK_GROUPE
				 , GROUPE.CGROUPE
				 , CTRTIERS.CCONTFRS
				 , CTRTIERS.DLIMPREST
				 , B.CCRITDP
				 , B.CSCRITDP
				 , B.CEXO 
				 , B.REF
				 , B.ORD
			FROM MASTER_ESTIA..ESTIA_ECRIB B
			left join MASTER_ESTIA..ESTIA_GROUPE GROUPE on GROUPE.PK_GROUPE = B.FK_GROUPE
			left join MASTER_ESTIA..ESTIA_CTRTIERS CTRTIERS on CTRTIERS.PK_CTRTIERS = B.FK_CTRTIERS
			WHERE B.TYPBON = 'CTR' 
			AND B.CORG = '11'
			AND B.CSTE IN  ('RE')
		) EB
		ON EB.CORG = ECRAC.CORG AND EB.REF = ECRAC.REF AND EB.ORD = ECRAC.ORD
		WHERE ECRAC.CORG = '11'
		AND ECRAC.SENS = 'D'
		AND ECRAC.DATEC <= cast(@ANNEE_BUDGET-1 as varchar(4)) + dbo.lpad(cast(datepart(month, getdate()) as varchar(2)), 2 , '0') + dbo.lpad(cast(datepart(day, getdate()) as varchar(2)), 2, '0')
	) EC
	ON EC.CORG = ECRITAUX.CORG AND EC.REF = ECRITAUX.REF
	LEFT JOIN 
	(
		SELECT CORG
				, CCONTFRS
				, ISNULL(SUM(MTTC), 0) AS MT_CONTRAT
		FROM MASTER_ESTIA..ESTIA_CONTNAT 
		GROUP BY CORG, CCONTFRS
	) CONTNAT
	ON CONTNAT.CORG = EC.CORG AND CONTNAT.CCONTFRS = EC.CCONTFRS
	LEFT JOIN 
	(
		SELECT CORG
				, CCONTFRS
				, ISNULL(SUM(MTTC), 0) AS MT_AVENANT_CONTRAT
		FROM MASTER_ESTIA..ESTIA_AVENAN
		WHERE DSIGN BETWEEN cast(@ANNEE_BUDGET-1 as varchar(4))+'0101' and cast(@ANNEE_BUDGET-1 as varchar(4))+'1231'
		GROUP BY CORG, CCONTFRS
	) AVENANT_CTR
	ON AVENANT_CTR.CORG = EC.CORG AND AVENANT_CTR.CCONTFRS = EC.CCONTFRS
	LEFT JOIN MASTER_ESTIA..ESTIA_VENTPCHA VENTPCHA on VENTPCHA.CORG = EC.CORG and VENTPCHA.CCONTFRS = EC.CCONTFRS and VENTPCHA.CCRITDP = EC.CCRITDP and VENTPCHA.CSCRITDP = EC.CSCRITDP
	WHERE ECRITAUX.CTYPECRI = 'FAC'
	AND ECRITAUX.CORG = '11'
	AND EC.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	and EC.CEXO IN (@ANNEE_BUDGET-1)
	AND datepart(year, EC.DLIMPREST) = EC.CEXO
	GROUP BY EC.CORG, EC.CGROUPE, EC.CCONTFRS, EC.CCRITDP, EC.CSCRITDP, EC.CEXO, CONTNAT.MT_CONTRAT, AVENANT_CTR.MT_AVENANT_CONTRAT, VENTPCHA.TXVENT
),
REQ_PREC_ADATE AS
(
	SELECT CORG
		 , CGROUPE
		 , CCRITDP
		 , CSCRITDP
		 , ANNEE
		 , SUM(MT_REA) MT_REA
	FROM
	(
		SELECT CORG, CGROUPE, CCRITDP, CSCRITDP, ANNEE, MT_REA
		FROM REQ_BT_PREC_ADATE
		UNION
		SELECT CORG, CGROUPE, CCRITDP, CSCRITDP, ANNEE, MT_REA
		FROM REQ_CTR_PREC_ADATE
	) SRC
	GROUP BY CORG, CGROUPE, CCRITDP, CSCRITDP, ANNEE
)--,
--REQ_OP AS
--(
--	SELECT CORG
--		 , CGROUPE
--		 , COPE
--		 , CCRITDP
--		 , CSCRITDP
--		 , ANNEE
--		 , SUM(ISNULL(MT_CUMUL_TTC + MT_AVENANTS_TS, 0)) MT_ENG
--		 , SUM(ISNULL(MT_FACTURE_TTC, 0)) MT_REA
--	FROM
--	(
--		SELECT PDEPOP.CORG
--			 , PDEPOP.COPE
--			 , POPE.CGROUPE
--			 , PDEPOP.CTRANCHE
--			 , PDEPOP.CDEPR
--			 , PDEPOP.NORD
--			 , PCRITDEP.CCRITDP
--			 , PCRITDEP.CSCRITDP
--			 , LEFT(PDEPOP.COPE, 4) ANNEE
--			 , CAST(PDEPOP.MTINI + (PDEPOP.MTINI*TVA.TTVA)/100 AS NUMERIC(18,2)) AS MT_INITIAL_TTC
--			 , ENG.MT_AVENANTS_TS
--			 , ENG.MT_CUMUL_TTC
--			 , ISNULL(REA.MT_FACTURE_TTC, 0) AS MT_FACTURE_TTC
--			 , ISNULL(REA.MT_PAYE_TTC, 0) AS MT_PAYE_TTC
--		FROM MASTER_ESTIA..ESTIA_POPE POPE
--		LEFT JOIN MASTER_ESTIA..ESTIA_TRANCHE TRANCHE
--		ON TRANCHE.CORG = POPE.CORG AND TRANCHE.COPE = POPE.COPE
--		LEFT JOIN MASTER_ESTIA..ESTIA_PDEPOP PDEPOP
--		ON PDEPOP.CORG = TRANCHE.CORG AND PDEPOP.COPE = TRANCHE.COPE AND PDEPOP.CTRANCHE = TRANCHE.CTRANCHE
--		LEFT JOIN MASTER_ESTIA..ESTIA_PCRITDEP PCRITDEP
--		ON PCRITDEP.CORG = PDEPOP.CORG AND PCRITDEP.COPE = PDEPOP.COPE AND PCRITDEP.CTRANCHE = PDEPOP.CTRANCHE AND PCRITDEP.CDEPR = PDEPOP.CDEPR AND PCRITDEP.NORD = PDEPOP.NORD
--		LEFT JOIN 
--		(
--			SELECT PAB.CORG
--				, PAB.COPE
--				, PAB.CTRANCHE
--				, PAB.CDEPR
--				, PAB.NORD 
--				, SUM(CASE WHEN PAB.SITUAT <> 1 THEN PAB.MTTTC ELSE 0 END) AS MT_AVENANTS_TS	   
--				, SUM(PAB.MTTTC) AS MT_CUMUL_TTC
--			FROM MASTER_ESTIA..ESTIA_PABASIT PAB
--			WHERE PAB.CORG = '11'
--			GROUP BY PAB.CORG, PAB.COPE, PAB.CTRANCHE, PAB.CDEPR, PAB.NORD
--		) ENG
--		ON ENG.CORG = PDEPOP.CORG AND ENG.COPE = PDEPOP.COPE AND ENG.CTRANCHE = PDEPOP.CTRANCHE AND ENG.CDEPR = PDEPOP.CDEPR AND ENG.NORD = PDEPOP.NORD
--		LEFT JOIN
--		(
--			SELECT PECRIP.CORG
--				, PECRIP.COPE
--				, PECRIP.CTRANCHE
--				, PECRIP.CDEPR
--				, PECRIP.NORD
--				, SUM(CASE WHEN PECRIP.CTYPECRI <> 'REG' THEN CASE SENS WHEN 'C' THEN (MONTANT + TTVA) ELSE -(MONTANT + TTVA) END ELSE 0 END) AS MT_FACTURE_TTC
--				, SUM(CASE WHEN PECRIP.CTYPECRI = 'REG' THEN CASE SENS WHEN 'D' THEN (MONTANT + TTVA) ELSE -(MONTANT + TTVA) END ELSE 0 END) AS MT_PAYE_TTC
--			FROM MASTER_ESTIA..ESTIA_PECRIP PECRIP
--			WHERE PECRIP.TYPCPTA = 'TF'
--			AND PECRIP.CTYPCOM = 'F'
--			AND PECRIP.CORG = '11'
--			GROUP BY PECRIP.CORG, PECRIP.COPE, PECRIP.CTRANCHE, PECRIP.CDEPR, PECRIP.NORD
--		) REA
--		ON REA.CORG = PDEPOP.CORG AND REA.COPE = PDEPOP.COPE AND REA.CTRANCHE = PDEPOP.CTRANCHE AND REA.CDEPR = PDEPOP.CDEPR AND REA.NORD = PDEPOP.NORD
--		LEFT JOIN MASTER_ESTIA..ESTIA_TVA TVA
--		ON TVA.CTVA = PDEPOP.CTVA
--		WHERE PDEPOP.CORG = '11'
--		--AND PDEPOP.COPE = '20170600036'
--		--AND PDEPOP.CTRANCHE = 1
--		--AND PDEPOP.CDEPR = 272
--	) SRC
--	GROUP BY CORG, CGROUPE, COPE, CCRITDP, CSCRITDP, ANNEE
--)

select CGROUPE
	 , LGROUPE
	 , LB_CATEGORIE
	 , ANNEE_BUDGET
	 , CD_CRITERE
	 , LB_CRITERE
	 , CD_SOUS_CRITERE
	 , LB_SOUS_CRITERE
	 , SUM(BUDGET_INI_TTC) BUDGET_INI_TTC
	 , SUM(BUDGET_REV_TTC) BUDGET_REV_TTC
	 , SUM(MT_ENG_COUR) MT_ENG_COUR
	 , SUM(MT_REA_COUR) MT_REA_COUR
	 , SUM(MT_REA_PREC) MT_REA_PREC
	 , SUM(MT_REA_PREC_ADATE) MT_REA_PREC_ADATE
from
(
	select LBUDLOC.CGROUPE
		 , GROUPE.LGROUPE
		 , case when LBUDLOC.CSCRITDP = 990 then 'Budget fonctionnement non récupérable' else 'Budget fonctionnement récupérable' end LB_CATEGORIE
		 , LBUDLOC.CBUDLOC ANNEE_BUDGET
		 , LBUDLOC.CCRITDP CD_CRITERE
		 , CRITDP.LCRITDP LB_CRITERE
		 , LBUDLOC.CSCRITDP CD_SOUS_CRITERE
		 , SCRITDP.LSCRITDP LB_SOUS_CRITERE
		 , LBUDLOC.MTHT BUDGET_INI_HT
		 , LBUDLOC.MTTVA BUDGET_INI_TVA
		 , LBUDLOC.MONTANT BUDGET_INI_TTC
		 , LBUDLOC_REV.MTHT BUDGET_REV_TVA
		 , LBUDLOC_REV.MTTVA BUDGET_REV_HT
		 , LBUDLOC_REV.MONTANT BUDGET_REV_TTC
		 , isnull(REQ_COUR.MT_ENG, 0) MT_ENG_COUR
		 , isnull(REQ_COUR.MT_REA, 0) MT_REA_COUR
		 , isnull(REQ_PREC.MT_REA, 0) MT_REA_PREC
		 , isnull(REQ_PREC_ADATE.MT_REA, 0) MT_REA_PREC_ADATE
	from MASTER_ESTIA..ESTIA_LBUDLOC LBUDLOC
	left join
	(
		select CORG
			 , CGROUPE
			 , CBUDLOC
			 , CCRITDP
			 , CSCRITDP
			 , MTHT
			 , MTTVA
			 , MONTANT
		from MASTER_ESTIA..ESTIA_LBUDLOC LBUDLOC
		where LBUDLOC.CORG = '11'
		and LBUDLOC.VERSION = (select max(VERSION) from MASTER_ESTIA..ESTIA_LBUDLOC WHERE CORG = LBUDLOC.CORG and CGROUPE = LBUDLOC.CGROUPE and CBUDLOC = LBUDLOC.CBUDLOC)
		--and LBUDLOC.CGROUPE = 610
		--and LBUDLOC.CBUDLOC = 2019
	) LBUDLOC_REV
	on LBUDLOC_REV.CORG = LBUDLOC.CORG and LBUDLOC_REV.CGROUPE = LBUDLOC.CGROUPE and LBUDLOC_REV.CBUDLOC = LBUDLOC.CBUDLOC and LBUDLOC_REV.CCRITDP = LBUDLOC.CCRITDP and LBUDLOC_REV.CSCRITDP = LBUDLOC.CSCRITDP
	left join MASTER_ESTIA..ESTIA_GROUPE GROUPE
	on GROUPE.CORG = LBUDLOC.CORG and GROUPE.CGROUPE = LBUDLOC.CGROUPE
	left join MASTER_ESTIA..WRK_GROUPE_MANGES WGM
	on WGM.PK_GROUPE = GROUPE.PK_GROUPE
	left join MASTER_ESTIA..ESTIA_TIERS PROP
	on PROP.PK_TIERS = WGM.FK_TIERS
	left join MASTER_ESTIA..ESTIA_CRITDP CRITDP 
	on CRITDP.CCRITDP = LBUDLOC.CCRITDP
	left join MASTER_ESTIA..ESTIA_SCRITDP SCRITDP 
	on SCRITDP.CORG = LBUDLOC.CORG and SCRITDP.CGROUPE = LBUDLOC.CGROUPE and SCRITDP.CCRITDP = LBUDLOC.CCRITDP and SCRITDP.CSCRITDP = LBUDLOC.CSCRITDP
	left join REQ_COUR 
	on REQ_COUR.CORG = LBUDLOC.CORG and REQ_COUR.CGROUPE = LBUDLOC.CGROUPE and REQ_COUR.CCRITDP = LBUDLOC.CCRITDP and REQ_COUR.CSCRITDP = LBUDLOC.CSCRITDP and REQ_COUR.ANNEE = LBUDLOC.CBUDLOC
	left join REQ_PREC 
	on REQ_PREC.CORG = LBUDLOC.CORG and REQ_PREC.CGROUPE = LBUDLOC.CGROUPE and REQ_PREC.CCRITDP = LBUDLOC.CCRITDP and REQ_PREC.CSCRITDP = LBUDLOC.CSCRITDP and REQ_PREC.ANNEE = LBUDLOC.CBUDLOC-1
	left join REQ_PREC_ADATE 
	on REQ_PREC_ADATE.CORG = LBUDLOC.CORG and REQ_PREC_ADATE.CGROUPE = LBUDLOC.CGROUPE and REQ_PREC_ADATE.CCRITDP = LBUDLOC.CCRITDP and REQ_PREC_ADATE.CSCRITDP = LBUDLOC.CSCRITDP and REQ_PREC_ADATE.ANNEE = LBUDLOC.CBUDLOC-1
	left join MASTER_ESTIA..P_CRITERES PC on PC.CD_CRITERE = LBUDLOC.CCRITDP
	where LBUDLOC.CORG = '11'
	and LBUDLOC.VERSION = 1 and len(LBUDLOC.CBUDLOC) = 4
	and PROP.PK_TIERS IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_PROPRIETAIRE,','))
	and GROUPE.PK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	and LBUDLOC.CBUDLOC = @ANNEE_BUDGET
	--and LBUDLOC.CGROUPE = 610
	--and CBUDLOC in (2019)
) SRC
group by CGROUPE, LGROUPE, LB_CATEGORIE, CD_CRITERE, LB_CRITERE, CD_SOUS_CRITERE, LB_SOUS_CRITERE, ANNEE_BUDGET
order by CGROUPE, ANNEE_BUDGET, LB_CATEGORIE, CD_SOUS_CRITERE;

END