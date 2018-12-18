﻿CREATE TABLE [dbo].[ESTIA_TSCAT] (
    [LISTORG]   VARCHAR (120) NULL,
    [CTSCAT]    VARCHAR (4)   NOT NULL,
    [LTSCAT]    VARCHAR (60)  NULL,
    [CTYPTIERS] VARCHAR (2)   NULL,
    [LETTRAG]   VARCHAR (1)   NULL,
    [DERCLO]    DATE          NULL,
    [BALEDIT]   VARCHAR (1)   NULL,
    [TRIG]      VARCHAR (2)   NULL,
    [SLET]      VARCHAR (2)   NULL,
    [LISTAGE]   VARCHAR (60)  NULL,
    [LACTIF]    VARCHAR (2)   NULL,
    CONSTRAINT [PK_ESTIA_TSCAT] PRIMARY KEY CLUSTERED ([CTSCAT] ASC)
);
