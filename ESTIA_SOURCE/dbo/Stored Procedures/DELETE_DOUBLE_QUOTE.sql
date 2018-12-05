

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DELETE_DOUBLE_QUOTE]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- création et remplissage de la table temporaire de travail
	-- notez l'ajout de la colonne OK préassignée à la valeur zéro
	SELECT c.TABLE_NAME, c.COLUMN_NAME, 0 AS OK
	INTO   #UPDSTAT
	FROM INFORMATION_SCHEMA.COLUMNS c INNER JOIN INFORMATION_SCHEMA.TABLES t 
	ON c.TABLE_NAME = t.TABLE_NAME
	WHERE c.TABLE_NAME <> 'L_RECUPERATION_ESTIA'
	--AND (c.TABLE_NAME IN ('CPTGLOB'))

	DECLARE @SQL VARCHAR(8000)
	DECLARE @TBL VARCHAR(128)
	DECLARE @COL VARCHAR(128)

	-- tant qu'il y a au moins une table à traiter
	WHILE EXISTS(SELECT * FROM   #UPDSTAT WHERE  OK = 0)
	BEGIN
	-- prendre le nom de la première table à traiter
	   /*SET @TBL, @COL = (SELECT TOP 1 @TBL=TABLE_NAME, @COL=COLUMN_NAME FROM #UPDSTAT WHERE OK = 0 ORDER  BY 1)*/
	   SELECT TOP 1 @TBL=TABLE_NAME, @COL=COLUMN_NAME FROM #UPDSTAT WHERE OK = 0 ORDER  BY TABLE_NAME, COLUMN_NAME
	   --SET @COL = (SELECT TOP 1 COLUMN_NAME FROM #UPDSTAT WHERE OK = 0 ORDER  BY 1)
	-- construire le texte du traitement 
	   SET @SQL = 'UPDATE ' + @TBL + ' SET ' + @COL + ' = REPLACE (' + @COL + ', CHAR(34), '''')'
	   PRINT @SQL
	-- exécuter le traitement           
	   EXEC (@SQL)
	-- flaguer l'objet traité dans la table des objets à traiter
	   UPDATE #UPDSTAT
	   SET    OK = 1
	   WHERE  TABLE_NAME = @TBL
	   AND COLUMN_NAME = @COL
	END

	-- supprimez la table temporaire de traitement
	DROP TABLE #UPDSTAT

END