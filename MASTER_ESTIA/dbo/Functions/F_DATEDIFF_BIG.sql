CREATE FUNCTION dbo.F_DATEDIFF_BIG (@DATEPART CHAR(11), @DT1 DATETIME2, @DT2 DATETIME2)
RETURNS BIGINT
AS
/******************************************************************************
* FONCTION UDF SCALAIRE dbo.F_DATEDIFF_BIG                         2015-08-13 *
*******************************************************************************
* Frédéric BROUARD  -  alias SQLpro   -   SARL SQL SPOT  -  SQLpro@outlook.fr *
* Architecte de données :  expertise, audit, conseil, formation, modélisation *
* tuning, sur les SGBD Relationnels, le langage SQL, MS SQL Server/PostGreSQL *
* blog: http://blog.developpez.com/sqlpro  site: http://sqlpro.developpez.com *
*******************************************************************************
* Cette fonction étend la capacité de la fonction intégrée DATEDIFF lorsqu'il *
* y a dépassement de capacité pour la valeur résultante. Exemple :            *
* SELECT DATEDIFF(minute, '0001-01-01', '9999-12-31');                        *
* --> Msg 535, Niveau 16, État 0, Ligne 91                                    *
*     La fonction datediff a provoqué un dépassement de capacité. Le nombre   *
*     de parties de date qui séparent deux instances de date/heure est trop   * 
*     important. Essayez d'utiliser datediff avec une partie de date moins    *
*     précise.                                                                *
*******************************************************************************
* PARAMÈTRES EN ENTRÉE :                                                      *
*    @DATEPART CHAR(11)     granularité de temps pour calculer la différence  *
*    @DT1      DATETIME2    date/heure debut                                  * 
*    @DT2      DATETIME2    date/heure fin                                    * 
*******************************************************************************
* VALEURS POSSIBLE POUR LE PARAMÈTRE @DATEPART :                              *
*    valeures acceptées              descriptions                             *
*    ------------------------------  ----------------------                   *
*    year,         yy,  yyyy         année                                    *
*    quarter,      qq,  q            trimestre                                *
*    month,        mm,  m            mois                                     *
*    dayofyear,    dy,  y            jour                                     *
*    day,          dd,  d            jour                                     *
*    week,         wk,  ww           semaine                                  *
*    hour,         hh                heures                                   *
*    minute,       mi,  n            minutes                                  *
*    second,       ss,  s            secondes                                 *
*    millisecond,  ms                millisecondes                            *
*******************************************************************************
* VALEUR EN SORTIE :                                                          *
*    type SQL BIGINT        nombre d'unité temporelles entre les deux valeurs *
*******************************************************************************
* EXEMPLES D'UTILISATION :                                                    *
*    SELECT dbo.F_DATEDIFF_BIG('minute', '0001-01-01', '9999-12-31')          *
*    --> 5258963520                                                           *
*    SELECT dbo.F_DATEDIFF_BIG('millisecond', '0001-01-01', '9999-12-31')     *
*    --> 315537811200000                                                      *
*******************************************************************************
* LIMITES :                                                                   *
*    la granularité est limitée à la milliseconde                             *
*    la validité du calcul est assurée pour la plage des dates ISO SQL :      *
*    [0001-01-01 00:00:00.0000000, 9999-12-31 23:59:59.9999999]               *
******************************************************************************/
BEGIN
-- test de validité des paramètres
IF @DT1 > @DT2  
   RETURN NULL;

SET @DATEPART = LOWER(@DATEPART);

IF @DATEPART NOT IN ('year',        'yy', 'yyyy',
                     'quarter',     'qq', 'q',
                     'month',       'mm', 'm',
                     'week',        'wk', 'ww',
                     'dayofyear',   'dy', 'y',
                     'day',         'dd', 'd',
                     'hour',        'hh',
                     'minute',      'mi', 'n',
                     'second',      'ss', 's',
                     'millisecond', 'ms')
   RETURN NULL;

-- sans conversion primaire :
IF @DATEPART IN ('year',        'yy', 'yyyy')
   RETURN CAST(DATEDIFF(YEAR,    @DT1, @DT2) AS BIGINT);
IF @DATEPART IN ('quarter',     'qq', 'q')
   RETURN CAST(DATEDIFF(QUARTER, @DT1, @DT2) AS BIGINT);
IF @DATEPART IN ('month',       'mm', 'm')
   RETURN CAST(DATEDIFF(MONTH,   @DT1, @DT2) AS BIGINT);
IF @DATEPART IN ('week',        'wk', 'ww')
   RETURN CAST(DATEDIFF(WEEK,    @DT1, @DT2) AS BIGINT);
IF @DATEPART IN ('dayofyear',   'dy', 'y',
                 'day',         'dd', 'd')
   RETURN CAST(DATEDIFF(DAY,     @DT1, @DT2) AS BIGINT);

-- pour les autres cas

-- variable de sortie
DECLARE @RETVAL BIGINT;

-- initialisation pour le nombre de jours
SET @RETVAL = CAST(DATEDIFF(DAY, @DT1, @DT2) AS BIGINT);

-- ajout des parties d'heure si précision heure
IF @DATEPART IN ('hour', 'hh')
BEGIN
     SET @RETVAL = @RETVAL * 24 + DATEDIFF(HOUR, CAST(@DT1 AS TIME), CAST(@DT2 AS TIME));  
     RETURN @RETVAL;
END;

-- ajout des parties de minutes si précision minute
IF @DATEPART IN ('minute', 'mi', 'n')
BEGIN
     SET @RETVAL = @RETVAL * 1440 + DATEDIFF(MINUTE, CAST(@DT1 AS TIME), CAST(@DT2 AS TIME));  
     RETURN @RETVAL;
END;

-- ajout des parties de seconde si précision seconde
IF @DATEPART IN ('second', 'ss', 's')
BEGIN
     SET @RETVAL = @RETVAL * 86400 + DATEDIFF(SECOND, CAST(@DT1 AS TIME), CAST(@DT2 AS TIME));  
     RETURN @RETVAL;
END;

-- ajout des parties de milliseconde si précision milliseconde
IF @DATEPART IN ('millisecond', 'ms')
BEGIN
     SET @RETVAL = @RETVAL * 86400000 + DATEDIFF(millisecond, CAST(@DT1 AS TIME), CAST(@DT2 AS TIME));  
     RETURN @RETVAL;
END;

RETURN NULL;
END;