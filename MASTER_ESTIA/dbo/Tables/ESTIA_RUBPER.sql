CREATE TABLE [dbo].[ESTIA_RUBPER] (
    [CORG]       VARCHAR (4)     NOT NULL,
    [CAGENCE]    VARCHAR (4)     NOT NULL,
    [CGROUPE]    INT             NOT NULL,
    [DDEBPER]    DATE            NULL,
    [DFINPER]    DATE            NULL,
    [CRUB]       INT             NOT NULL,
    [CPRC]       NUMERIC (17, 2) NULL,
    [REGUL]      VARCHAR (1)     NULL,
    [TRIG]       VARCHAR (2)     NULL,
    [BCOPLOC]    VARCHAR (16)    NULL,
    [LIB]        VARCHAR (80)    NULL,
    [ANALYSE]    VARCHAR (1)     NULL,
    [COMPLEMENT] VARCHAR (1)     NULL,
    [PARTIEL]    VARCHAR (2)     NULL
);

