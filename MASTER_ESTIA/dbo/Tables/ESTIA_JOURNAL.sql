﻿CREATE TABLE [dbo].[ESTIA_JOURNAL] (
    [CJOURNAL]  VARCHAR (6)    NOT NULL,
    [LJOURNAL]  VARCHAR (60)   NULL,
    [TASS]      VARCHAR (1)    NULL,
    [TYPJOU]    VARCHAR (2)    NULL,
    [JOUAUX]    VARCHAR (2)    NULL,
    [JOUCAIS]   VARCHAR (1)    NULL,
    [TYPBORD]   VARCHAR (4)    NULL,
    [LISTORG]   VARCHAR (120)  NULL,
    [TRIG]      VARCHAR (2)    NULL,
    [CTYPBOR]   VARCHAR (6)    NULL,
    [BUDGET]    VARCHAR (1)    NULL,
    [AUTORISE]  VARCHAR (1000) NULL,
    [SAUTORISE] VARCHAR (1000) NULL,
    [CAUTORISE] VARCHAR (1000) NULL,
    [TEMEDIT]   VARCHAR (1)    NULL,
    [LACTIF]    VARCHAR (1)    NULL,
    CONSTRAINT [PK_ESTIA_JOURNAL] PRIMARY KEY CLUSTERED ([CJOURNAL] ASC)
);

