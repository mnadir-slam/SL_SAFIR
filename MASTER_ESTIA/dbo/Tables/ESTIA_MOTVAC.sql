﻿CREATE TABLE [dbo].[ESTIA_MOTVAC] (
    [CMOTVAC] VARCHAR (4)  NOT NULL,
    [LMOTVAC] VARCHAR (60) NULL,
    [TRIG]    VARCHAR (2)  NULL,
    [LACTIF]  VARCHAR (2)  NULL,
    CONSTRAINT [PK_ESTIA_MOTVAC] PRIMARY KEY CLUSTERED ([CMOTVAC] ASC)
);

