﻿CREATE TABLE [dbo].[WRK_LOCAL_SURFACE] (
    [CORG]     VARCHAR (4)     NOT NULL,
    [CAGENCE]  VARCHAR (4)     NOT NULL,
    [CGROUPE]  INT             NOT NULL,
    [CIMMEUB]  INT             NOT NULL,
    [CLOCAL]   INT             NOT NULL,
    [SURF_HAB] NUMERIC (17, 2) NULL,
    [SURF_COR] NUMERIC (17, 2) NULL,
    CONSTRAINT [PK_WRK_LOCAL_SURFACE] PRIMARY KEY CLUSTERED ([CORG] ASC, [CAGENCE] ASC, [CGROUPE] ASC, [CIMMEUB] ASC, [CLOCAL] ASC)
);

