﻿CREATE TABLE [dbo].[ESTIA_INDICE] (
    [CNUMI]  VARCHAR (10)    NOT NULL,
    [ANNEE]  INT             NOT NULL,
    [MOIS]   INT             NOT NULL,
    [VAL]    NUMERIC (20, 5) NULL,
    [DEFPRO] VARCHAR (1)     NULL,
    [TRIG]   VARCHAR (2)     NULL,
    [LACTIF] VARCHAR (2)     NULL,
    [DT]     DATE            NULL,
    [LB]     VARCHAR (20)    NULL,
    CONSTRAINT [PK_ESTIA_INDICE] PRIMARY KEY CLUSTERED ([CNUMI] ASC, [ANNEE] ASC, [MOIS] ASC)
);

