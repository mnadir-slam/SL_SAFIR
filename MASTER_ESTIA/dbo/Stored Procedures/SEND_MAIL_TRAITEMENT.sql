CREATE PROCEDURE [dbo].[SEND_MAIL_TRAITEMENT]
(
	@IND_REUSSITE	VARCHAR(1),
	@JOB_NAME		VARCHAR(255)
)
AS
BEGIN

DECLARE @OBJ VARCHAR(100)
DECLARE @MSG VARCHAR(8000)
DECLARE @DT_DEBUT datetime, @DT_FIN datetime, @DT_INTERM datetime
DECLARE @MIN int, @SEC int
SET @MSG = ''

--OBJET ET MESSAGE EN CAS DE SUCCES
IF @IND_REUSSITE = 'O'
	BEGIN
	--OBJET DU MESSAGE
	SET @OBJ = 'Reporting SLR ESTI@'	

	SET @DT_DEBUT = (SELECT MIN(RUN_DATE) FROM L_JOB_HISTORY WHERE CONVERT(VARCHAR(10), RUN_DATE, 103) = CONVERT(VARCHAR(10), GETDATE(), 103))
	SET @DT_FIN = (SELECT MAX(END_DATE) FROM L_JOB_HISTORY WHERE CONVERT(VARCHAR(10), RUN_DATE, 103) = CONVERT(VARCHAR(10), GETDATE(), 103))

	SELECT @MIN = (SELECT DATEDIFF(MINUTE, @DT_DEBUT, @DT_FIN))
	SELECT @DT_INTERM = DATEADD(MINUTE, @MIN, @DT_DEBUT)
	SELECT @SEC = (SELECT DATEDIFF(SECOND, @DT_INTERM, @DT_FIN))

	--CORPS DU MESSAGE
	DECLARE @PARAM VARCHAR(8000)
	SET @PARAM = ''

	SELECT @PARAM = @PARAM + 'Alimentation SAFIR' + CHAR(10) + '---------------------' + CHAR(10) 

	SELECT @MSG = @MSG + @PARAM + 'L''alimentation SAFIR a été effectuée avec succès.' + CHAR(10) + 'Le travail a été appelé par Planification 28 (Alimentation Estia).' + CHAR(10) + 'La dernière étape exécutée est l''étape 12 (MAIL SUCCES).' + ' - (Durée: ' + CAST(@MIN AS VARCHAR(5)) + ' minutes et ' + CAST(@SEC AS VARCHAR(5)) + ' secondes)' + CHAR(10)

	SET @PARAM = NULL

	SELECT @PARAM = @PARAM + CASE WHEN COUNT(*) > 0 AND LEN(@PARAM) > 0 THEN 'Immeubles: ' + CONVERT(VARCHAR(10),COUNT(*)) + ' élément(s) non paramétré(s)' + CHAR(10) ELSE '' END FROM P_TRANSCO_IMMEUBLE_EASYFOLDER WHERE NM_IMMEUBLE_ESTIA IS NOT NULL AND CD_IMMEUBLE_DREAM IS NULL

	IF LEN(@PARAM) > 0
		SET @MSG = @MSG + 'PARAMETRAGE MANQUANT:' + CHAR(10) + '---------------------' + CHAR(10) + @PARAM

	-- Ajout du paramétrage manquant de l'interface EDI PREIM
	--SET @MSG = @MSG + dbo.ALERTES_MAIL()
	SET @MSG = CONCAT(@MSG,  dbo.ALERTES_MAIL())

	END
ELSE
	BEGIN
	--OBJET DU MESSAGE
	SET @OBJ = 'Reporting SLR ESTI@'


	--CORPS DU MESSAGE (message d'erreur SQL Server)
	DECLARE @STEP VARCHAR(8000), @MESSAGE VARCHAR(8000)
	SET @STEP = ''
	SET @MESSAGE = ''

	SELECT @STEP = 'Echec lors de l''alimentation SAFIR' + CHAR(10) + 'Echec à l''étape "' + step_name + '":',
		   @MESSAGE = [message]
	FROM msdb..sysjobhistory
	WHERE instance_id = (SELECT MAX(instance_id) FROM msdb..sysjobhistory AS H, msdb..sysjobs AS J WHERE J.job_id=H.job_id AND J.name=@JOB_NAME AND H.run_status=0)

	SET @MSG = CASE WHEN LEN(@STEP)>0
					THEN @STEP+CHAR(10)+REPLACE(SPACE(LEN(@STEP)),' ','-')+CHAR(10)
					ELSE ''
			   END+ISNULL(@MESSAGE,'')
	END

DECLARE @DEST VARCHAR(100)
SET @DEST = (SELECT MIN(ADRESSE_MAIL) FROM L_DESTINATAIRES)

WHILE LEN(@DEST) > 0
	BEGIN
	EXEC dbo.XP_SEND_MAIL 'smtp-out.core.infoclip.fr', 25,
                          '', '', 'Reporting SLR <administrateur@viveris.fr>',
                          @DEST, @OBJ, @MSG

	SET @DEST = (SELECT MIN(ADRESSE_MAIL) FROM L_DESTINATAIRES WHERE ADRESSE_MAIL > @DEST)
	END

END