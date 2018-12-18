﻿CREATE TABLE [dbo].[ESTIA_FINDIV] (
    [CTYPTIERS]   VARCHAR (2)   NOT NULL,
    [CTIERS]      VARCHAR (14)  NOT NULL,
    [FINGEST]     DATE          NULL,
    [CMOTGES]     VARCHAR (4)   NULL,
    [TRIG]        VARCHAR (2)   NULL,
    [DEBGEST]     DATE          NULL,
    [RTYPTIERS]   VARCHAR (2)   NULL,
    [RTIERS]      VARCHAR (14)  NULL,
    [MODETVA]     VARCHAR (2)   NULL,
    [CONTCA]      VARCHAR (1)   NULL,
    [BLCTFAC]     VARCHAR (1)   NULL,
    [LISTORG]     VARCHAR (120) NULL,
    [MIGCOMPT]    INT           NULL,
    [CPRIOR]      VARCHAR (4)   NULL,
    [PARTICULIER] VARCHAR (4)   NULL,
    CONSTRAINT [PK_ESTIA_FINDIV] PRIMARY KEY CLUSTERED ([CTYPTIERS] ASC, [CTIERS] ASC)
);
