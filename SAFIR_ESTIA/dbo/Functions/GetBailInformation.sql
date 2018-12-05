
CREATE FUNCTION dbo.GetBailInformation(@pk_bail int)
RETURNS @retBailInformation TABLE 
(
    -- Columns returned by the function
    pk_bail int PRIMARY KEY NOT NULL,
	nm_immeuble int NULL, 
    nom_immeuble nvarchar(64) NULL, 
    cd_bail nvarchar(20) NULL, 
    nm_locataire numeric(7,0) NULL, 
    nom_locataire nvarchar(76) NULL
)
AS 

BEGIN
	DECLARE
	@nm_immeuble int, 
    @nom_immeuble nvarchar(64), 
    @cd_bail nvarchar(20), 
    @nm_locataire numeric(7,0), 
    @nom_locataire nvarchar(76);

	with req as
	(
		select b.pk_bail, b.nm_immeuble, i.adrlgn1 as nom_immeuble, b.cd_bail, b.nm_locataire, l.nom_locataire
		from d_bail b
		left join d_immeuble i
		on i.pk_immeuble = b.fk_immeuble
		left join d_locataire l
		on l.pk_locataire = b.fk_locataire
		where b.cd_societe = '11'
	)

   SELECT 
        @pk_bail = req.pk_bail, 
        @nm_immeuble = req.nm_immeuble, 
		@nom_immeuble = req.nom_immeuble,
        @cd_bail = req.cd_bail,
		@nm_locataire = req.nm_locataire,
		@nom_locataire = req.nom_locataire
    FROM req 
    WHERE req.pk_bail = @pk_bail;
    
	IF @pk_bail IS NOT NULL     
	BEGIN
        INSERT @retBailInformation
        SELECT @pk_bail, @nm_immeuble, @nom_immeuble, @cd_bail, @nm_locataire, @nom_locataire;
    END;
    RETURN;
END;