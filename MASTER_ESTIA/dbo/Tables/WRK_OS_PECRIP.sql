﻿CREATE TABLE [dbo].[WRK_OS_PECRIP] (
    [CORG]                      VARCHAR (4)     NOT NULL,
    [COPE]                      VARCHAR (22)    NOT NULL,
    [CTRANCHE]                  INT             NOT NULL,
    [CDEPR]                     INT             NOT NULL,
    [NORD]                      INT             NOT NULL,
    [OS]                        VARCHAR (30)    NOT NULL,
    [CFOUR]                     VARCHAR (14)    NOT NULL,
    [CSTE1]                     VARCHAR (4)     NOT NULL,
    [MT_ENGAGEMENT_INITIAL_HT]  NUMERIC (38, 2) NULL,
    [MT_ENGAGEMENT_INITIAL_TVA] NUMERIC (38, 2) NULL,
    [MT_ENGAGEMENT_INITIAL_TTC] NUMERIC (38, 2) NULL,
    [MT_ENGAGEMENT_RESTANT_HT]  NUMERIC (38, 2) NULL,
    [MT_ENGAGEMENT_RESTANT_TVA] NUMERIC (38, 2) NULL,
    [MT_ENGAGEMENT_RESTANT_TTC] NUMERIC (38, 2) NULL,
    [MT_REALISE_HT]             NUMERIC (38, 2) NULL,
    [MT_REALISE_TVA]            NUMERIC (38, 2) NULL,
    [MT_REALISE_TTC]            NUMERIC (38, 2) NULL,
    [DT_REALISE]                DATE            NULL,
    CONSTRAINT [PK_WRK_OS_PECRIP] PRIMARY KEY CLUSTERED ([CORG] ASC, [OS] ASC, [CFOUR] ASC, [CSTE1] ASC)
);

