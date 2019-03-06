﻿CREATE PROCEDURE [dbo].[RECUP_JOB_HISTORY] 
AS
BEGIN

SET ANSI_WARNINGS OFF

INSERT INTO L_JOB_HISTORY (INSTANCE_ID, JOB_NAME, SQL_SEVERITY, STEP_ID, STEP_NAME, RUN_STATUS, STATUS, MESSAGE, RUN_DATE, DUR_SECONDS, DUR_MINUTES, DUR_HOURS, RUN_DURATION)
SELECT H.instance_id, J.name, H.sql_severity, H.step_id, H.step_name,
       H.run_status, CASE H.run_status WHEN 0 THEN 'Echec' WHEN 1 THEN 'Succès' WHEN 2 THEN 'Nouvelle tentative' WHEN 3 THEN 'Annulation' WHEN 4 THEN 'En cours' END AS status,
       H.message,
       DATEADD(second,H.run_time%100,DATEADD(minute,FLOOR(H.run_time/100)%100,DATEADD(hour,FLOOR(H.run_time/10000),CONVERT(DATETIME, STR(H.run_date,8,0), 112)))) AS run_date,
       H.run_duration%100 AS dur_seconds, FLOOR(H.run_duration/100)%100 AS dur_minutes, FLOOR(H.run_duration/10000) AS dur_hours, 
       REPLACE(STR(FLOOR(H.run_duration/10000),2,0),' ','0')+':'+REPLACE(STR(FLOOR(H.run_duration/100)%100,2,0),' ','0')+':'+REPLACE(STR(H.run_duration%100,2,0),' ','0') AS run_duration
FROM msdb..sysjobs AS J
     INNER JOIN msdb..sysjobhistory AS H 
            ON H.job_id = J.job_id
WHERE J.name = 'Alimentation Estia'
AND H.instance_id NOT IN (SELECT instance_id FROM L_JOB_HISTORY)


UPDATE L_JOB_HISTORY
SET END_DATE = DATEADD(hour, DUR_HOURS, DATEADD(minute, DUR_MINUTES, DATEADD(second,DUR_SECONDS,RUN_DATE)))
WHERE end_date IS NULL


UPDATE L_JOB_HISTORY
SET PARENT_INSTANCE_ID = (SELECT MAX(P.INSTANCE_ID) FROM L_JOB_HISTORY AS P WHERE P.INSTANCE_ID < J.INSTANCE_ID AND P.STEP_ID = 0)
FROM L_JOB_HISTORY AS J
WHERE STEP_ID > 0
AND PARENT_INSTANCE_ID IS NULL



UPDATE L_JOB_HISTORY
SET RUN_STATUS = ISNULL((SELECT MAX(RUN_STATUS) FROM L_JOB_HISTORY AS PJH WHERE PJH.PARENT_INSTANCE_ID = JH.INSTANCE_ID AND PJH.STEP_ID > 0 AND PJH.RUN_STATUS <> 1), 1),
STATUS = CASE ISNULL((SELECT MAX(RUN_STATUS) FROM L_JOB_HISTORY AS PJH WHERE PJH.PARENT_INSTANCE_ID = JH.INSTANCE_ID AND PJH.STEP_ID > 0 AND PJH.RUN_STATUS <> 1), 1) WHEN 0 THEN 'Echec' WHEN 1 THEN 'Succès' WHEN 2 THEN 'Nouvelle tentative' WHEN 3 THEN 'Annulation' WHEN 4 THEN 'En cours' END
FROM L_JOB_HISTORY AS JH
WHERE STEP_ID = 0


SET ANSI_WARNINGS OFF

END