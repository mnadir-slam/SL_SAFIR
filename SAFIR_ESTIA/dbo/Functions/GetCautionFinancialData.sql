

CREATE FUNCTION [dbo].[GetCautionFinancialData](@dt date, @pk_bail int)
RETURNS @retCautionFinancialData TABLE 
(
    -- Columns returned by the function
    pk_bail int PRIMARY KEY NOT NULL,
	mt_loyer_facial numeric(18,2) NULL, 
    mt_loyer_actuel numeric(18,2) NULL, 
    mt_charges numeric(18,2) NULL, 
    mt_dg numeric(18,2) NULL, 
    mt_loyer_franchise numeric(18,2) NULL,
	mt_palier numeric(18,2) NULL
)
AS 

BEGIN
	DECLARE
	@mt_loyer_facial  numeric(18,2), 
    @mt_loyer_actuel  numeric(18,2),  
    @mt_charges  numeric(18,2), 
    @mt_dg  numeric(18,2),
	@mt_loyer_franchise numeric(18,2),
	@mt_palier  numeric(18,2);

	with req as
	(
		select location.fk_bail as pk_bail,
			   sum(case when psre.ind_calcul_loyer = 'O' and psre.ind_loyer_facial = 'O' then hqlocat.nb else 0 end) as mt_loyer_facial,
			   sum(case when psre.ind_calcul_loyer = 'O' and psre.ind_calcul_franchise = 'N' and psre.ind_calcul_palier = 'N' then hqlocat.nb else 0 end) as mt_loyer_actuel,
			   sum(case when psre.ind_calcul_charges = 'O' then hqlocat.nb else 0 end) as mt_charges,
			   convert(numeric(13,2), 0) as mt_dg,
			   sum(case when psre.ind_calcul_franchise = 'O' then hqlocat.nb else 0 end) as mt_loyer_franchise,
			   sum(case when psre.ind_calcul_palier = 'O' then hqlocat.nb else 0 end) as mt_palier

		from master_estia.dbo.estia_location as location
			 inner join master_estia.dbo.estia_hqlocat as hqlocat
				   on hqlocat.corg = location.corg
				   and hqlocat.cagence = location.cagence
				   and hqlocat.cgroupe = location.cgroupe
				   and hqlocat.cimmeub = location.cimmeub
				   and hqlocat.clocal = location.clocal
				   and hqlocat.occ = location.occ
			 inner join master_estia.dbo.p_rubrique as p
				   on p.cd_rubrique = hqlocat.crub
			 inner join master_estia.dbo.p_sous_reg_eltfac as psre
				   on psre.cd_sous_reg_eltfac = p.cd_sous_reg_eltfac

		where @dt between hqlocat.ddeb and isnull(hqlocat.dfin, '2999/01/01')
		and location.fk_bail = @pk_bail
		and (location.datsorquit is null or location.datsorquit > @dt)
		group by location.fk_bail
	)

   SELECT 
        @pk_bail = req.pk_bail, 
        @mt_loyer_facial = req.mt_loyer_facial, 
		@mt_loyer_actuel = req.mt_loyer_actuel,
        @mt_charges = req.mt_charges,
		@mt_dg = req.mt_dg,
		@mt_loyer_franchise = req.mt_loyer_franchise,
		@mt_palier = req.mt_palier
    FROM req 
    WHERE req.pk_bail = @pk_bail;
    
	IF @pk_bail IS NOT NULL     
	BEGIN
        INSERT @retCautionFinancialData
        SELECT @pk_bail, @mt_loyer_facial, @mt_loyer_actuel, @mt_charges, @mt_dg, @mt_loyer_franchise, @mt_palier;
    END;
    RETURN;
END;