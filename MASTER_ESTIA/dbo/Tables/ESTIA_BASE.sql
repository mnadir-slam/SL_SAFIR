CREATE TABLE [dbo].[ESTIA_BASE] (
    [PK_BASE]   INT             IDENTITY (1, 1) NOT NULL,
    [FK_ORG]    INT             NULL,
    [FK_AGENCE] INT             NULL,
    [FK_GROUPE] INT             NULL,
    [CBASE]     INT             NOT NULL,
    [LBASE]     VARCHAR (60)    NULL,
    [TRIG]      VARCHAR (2)     NULL,
    [CORG]      VARCHAR (4)     NOT NULL,
    [CAGENCE]   VARCHAR (4)     NOT NULL,
    [CGROUPE]   INT             NOT NULL,
    [TBASE]     NUMERIC (17, 2) NULL,
    [REGROUP1]  VARCHAR (2)     NULL,
    [REGROUP2]  VARCHAR (16)    NULL,
    [MIGCOMPT]  INT             NULL,
    [GROUPE_ID] INT             NULL,
    [LACTIF]    VARCHAR (50)    NULL,
    CONSTRAINT [PK_ESTIA_BASE] PRIMARY KEY CLUSTERED ([CORG] ASC, [CAGENCE] ASC, [CGROUPE] ASC, [CBASE] ASC)
);

