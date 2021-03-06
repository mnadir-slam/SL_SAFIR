﻿CREATE TABLE [dbo].[ESTIA_BAIL] (
    [CBAIL]      VARCHAR (4)     NOT NULL,
    [LBAIL]      VARCHAR (60)    NULL,
    [APLBAIL]    VARCHAR (1)     NULL,
    [DNUMI]      INT             NULL,
    [DERTERM]    VARCHAR (1)     NULL,
    [DURBAIL]    INT             NULL,
    [DURPREAV]   INT             NULL,
    [FINMOIS]    VARCHAR (1)     NULL,
    [POURDG]     NUMERIC (17, 2) NULL,
    [CNUMI]      VARCHAR (10)    NULL,
    [TRIG]       VARCHAR (2)     NULL,
    [CQUABAIL]   VARCHAR (6)     NULL,
    [PEREVISION] INT             NULL,
    [DGREV]      VARCHAR (1)     NULL,
    [TEMINFO]    VARCHAR (1)     NULL,
    [CEPVAR]     VARCHAR (12)    NULL,
    [BEPVAR]     VARCHAR (12)    NULL,
    [REPVAR]     VARCHAR (12)    NULL,
    [DELREL]     INT             NULL,
    [TAUXRED]    VARCHAR (1)     NULL,
    [INTRET]     VARCHAR (1)     NULL,
    [LACTIF]     VARCHAR (1)     NULL,
    CONSTRAINT [PK_ESTIA_BAIL] PRIMARY KEY CLUSTERED ([CBAIL] ASC)
);

