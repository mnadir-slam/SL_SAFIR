﻿CREATE TABLE [dbo].[WRK_LOCATION_NEGOCH] (
    [PK_BAIL]          INT            NULL,
    [CORG]             VARCHAR (4)    NOT NULL,
    [CCOMPTE]          VARCHAR (22)   NOT NULL,
    [NOBAIL]           INT            NOT NULL,
    [PC_RECUP_TF]      NUMERIC (9, 2) NULL,
    [PC_RECUP_HO]      NUMERIC (9, 2) NULL,
    [PC_RECUP_TB]      NUMERIC (9, 2) NULL,
    [PC_RECUP_AS]      NUMERIC (9, 2) NULL,
    [PC_RECUP_605]     NUMERIC (9, 2) NULL,
    [PC_RECUP_606]     NUMERIC (9, 2) NULL,
    [PC_RECUP_TOM]     NUMERIC (9, 2) NULL,
    [IND_GROS_TRAVAUX] VARCHAR (1)    NULL,
    CONSTRAINT [PK_WRK_LOCATION_NEGOCH] PRIMARY KEY CLUSTERED ([CORG] ASC, [CCOMPTE] ASC, [NOBAIL] ASC)
);
