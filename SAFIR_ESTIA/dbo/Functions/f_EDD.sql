﻿CREATE FUNCTION dbo.f_EDD 
(
	@DT_DEBUT DATETIME,
	@DT_FIN DATETIME,
	@PK_PROPRIETAIRE INT,
	@PK_IMMEUBLE NVARCHAR(MAX),
	@DATEC BIT
)
RETURNS @retEDD TABLE   
(  
	CMANDAT varchar(16) NULL,
	CTIERS varchar(14) NULL,
	LTIERS varchar(76) NULL,
	CORG varchar(4) NULL,
	CAGENCE varchar(4) NULL,
	CGROUPE int NULL,
	REF varchar(42) NULL,
	CCRITDP int NULL,
	LCRITDP varchar(60),
	CSCRITDP int NULL,
	LIBELLE varchar(80) NULL,
	DEFFETREG date NULL,
	DATEC date NULL,
	TYPDEP varchar(2) NULL,
	MTHT numeric(17, 2) NULL,
	MTTVA numeric(17, 2) NULL,
	MTTC numeric(17, 2) NULL,
	MTRECUP numeric(17, 2) NULL,
	MTNREC numeric(17, 2) NULL,
	MTTVADED numeric(17, 2) NULL,
	TYPBON varchar(6),
	NOBON int
)  
--Returns a result set that lists all the employees who report to the   
--specific employee directly or indirectly.*/  
AS  
BEGIN  
WITH EDD_cte (CMANDAT, CTIERS, LTIERS, CORG, CAGENCE, CGROUPE, REF, CCRITDP, LCRITDP, CSCRITDP, LIBELLE, DEFFETREG, DATEC, TYPDEP, MTHT, MTTVA, MTTC, MTRECUP, MTNREC, MTTVADED, TYPBON, NOBON)
AS
(
	select HDEPCS.CMANDAT
		 , ECRITAUX.CTIERS
		 , TIERS.LTIERS
		 , HDEPCS.CORG 
		 , HDEPCS.CAGENCE
		 , HDEPCS.CGROUPE
		 , HDEPCS.REF
		 , HDEPCS.CCRITDP
		 , CRITDP.LCRITDP
		 , HDEPCS.CSCRITDP
		 , HDEPCS.LIBELLE
		 , HDEPCS.DEFFETREG
		 , HDEPCS.DATEC
		 , HDEPCS.TYPDEP
		 , HDEPCS.MTHT
		 , HDEPCS.MTTVA
		 , HDEPCS.MTTC
		 , HDEPCS.MTRECUP
		 , HDEPCS.MTNREC
		 , HDEPCS.MTTVADED
		 , BT_CTR_GO.TYPBON
		 , BT_CTR_GO.NOBON
	from MASTER_ESTIA..ESTIA_HDEPCS HDEPCS
	left join MASTER_ESTIA..ESTIA_CRITDP CRITDP
	on CRITDP.CCRITDP = HDEPCS.CCRITDP 
	left join 
	(
		select ECRITAUX.CORG, ECRITAUX.REF, ECRITAUX.CTYPTIERS, ECRITAUX.CTIERS
		from MASTER_ESTIA..ESTIA_ECRITAUX ECRITAUX
		where ECRITAUX.CORG = '11'
		and ECRITAUX.CTYPCOM = 'F'
	) ECRITAUX
	on ECRITAUX.REF = HDEPCS.REF 
	left join MASTER_ESTIA..ESTIA_TIERS TIERS
	on TIERS.CTYPTIERS = ECRITAUX.CTYPTIERS and TIERS.CTIERS = ECRITAUX.CTIERS
	LEFT JOIN MASTER_ESTIA..WRK_GROUPE_MANGES WGM
	ON WGM.PK_GROUPE = HDEPCS.FK_GROUPE--WGM.CORG = HDEPCS.CORG AND WGM.CAGENCE = HDEPCS.CAGENCE AND WGM.CGROUPE = HDEPCS.CGROUPE
	LEFT JOIN MASTER_ESTIA..ESTIA_TIERS PROPRIETAIRE
	ON PROPRIETAIRE.PK_TIERS = WGM.FK_TIERS
	left join
	(
		select PECRIP.CORG, PECRIP.REF, 'GO' as TYPBON, PECRIP.COPE as NOBON
		from MASTER_ESTIA..ESTIA_PECRIP PECRIP
		where PECRIP.COPE is not null
		and PECRIP.CORG = '11'
		union
		select LIENBN.CORG, LIENBN.REF, LIENBN.TYPBON, case LIENBN.TYPBON when 'BT' then LIENBN.[0BON] else substring(LIENBN.BANAL, 1, 12) end as NOBON
		from MASTER_ESTIA..ESTIA_LIENBN LIENBN
		where LIENBN.TYPFAC = 'F'
		and LIENBN.CORG = '11'
	) BT_CTR_GO
	on BT_CTR_GO.CORG = HDEPCS.CORG and BT_CTR_GO.REF = HDEPCS.REF
	where HDEPCS.CORG = '11'
	and CASE WHEN @DATEC = 1 THEN HDEPCS.DATEC ELSE HDEPCS.DEFFETREG END BETWEEN @DT_DEBUT AND @DT_FIN
	AND WGM.FK_TIERS = @PK_PROPRIETAIRE
	AND HDEPCS.FK_GROUPE IN (SELECT VALUE FROM dbo.ufn_SplitMultiValue(@PK_IMMEUBLE,','))
	AND HDEPCS.CMANDAT IS NOT NULL
)

-- copy the required columns to the result of the function   
   INSERT @retEDD  
   SELECT CMANDAT, CTIERS, LTIERS, CORG, CAGENCE, CGROUPE, REF, CCRITDP, LCRITDP, CSCRITDP, LIBELLE, DEFFETREG, DATEC, TYPDEP, MTHT, MTTVA, MTTC, MTRECUP, MTNREC, MTTVADED, TYPBON, NOBON 
   FROM EDD_cte   
   RETURN  
END;