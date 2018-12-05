﻿CREATE TABLE [dbo].[ESTIA_MOTIF] (
    [CSTE]     VARCHAR (4)   NOT NULL,
    [CMOTIF]   VARCHAR (4)   NOT NULL,
    [LMOTIF]   VARCHAR (60)  NULL,
    [TRIG]     VARCHAR (2)   NULL,
    [LMOTIFL]  VARCHAR (160) NULL,
    [MIGCOMPT] INT           NULL,
    [LACTIF]   VARCHAR (2)   NULL,
    CONSTRAINT [PK_ESTIA_MOTIF] PRIMARY KEY CLUSTERED ([CSTE] ASC, [CMOTIF] ASC)
);

