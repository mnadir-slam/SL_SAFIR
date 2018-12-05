CREATE TABLE [dbo].[L_JOB_HISTORY] (
    [INSTANCE_ID]        INT            NOT NULL,
    [PARENT_INSTANCE_ID] INT            NULL,
    [JOB_NAME]           VARCHAR (50)   NULL,
    [SQL_SEVERITY]       INT            NULL,
    [STEP_ID]            INT            NULL,
    [STEP_NAME]          VARCHAR (100)  NULL,
    [RUN_STATUS]         INT            NULL,
    [STATUS]             VARCHAR (20)   NULL,
    [MESSAGE]            VARCHAR (1024) NULL,
    [RUN_DATE]           DATETIME       NULL,
    [END_DATE]           DATETIME       NULL,
    [DUR_SECONDS]        INT            NULL,
    [DUR_MINUTES]        INT            NULL,
    [DUR_HOURS]          INT            NULL,
    [RUN_DURATION]       VARCHAR (10)   NULL,
    CONSTRAINT [PK_L_JOB_HISTORY] PRIMARY KEY CLUSTERED ([INSTANCE_ID] ASC)
);

