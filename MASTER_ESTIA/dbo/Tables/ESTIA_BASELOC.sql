CREATE TABLE [dbo].[ESTIA_BASELOC] (
    [FK_BASELOC] INT             IDENTITY (1, 1) NOT NULL,
    [FK_ORG]     INT             NULL,
    [FK_AGENCE]  INT             NULL,
    [FK_GROUPE]  INT             NULL,
    [FK_IMMEUB]  INT             NULL,
    [FK_LOCAL]   INT             NULL,
    [FK_BASE]    INT             NULL,
    [CORG]       VARCHAR (4)     NOT NULL,
    [CAGENCE]    VARCHAR (4)     NOT NULL,
    [CGROUPE]    INT             NOT NULL,
    [CIMMEUB]    INT             NOT NULL,
    [CLOCAL]     INT             NOT NULL,
    [CBASE]      INT             NOT NULL,
    [TRIG]       VARCHAR (2)     NULL,
    [MONTANT]    NUMERIC (17, 2) NULL,
    [DEFFET]     DATE            NOT NULL,
    [MIGCOMPT]   NUMERIC (18)    NULL,
    [LOCAL_ID]   VARCHAR (50)    NULL,
    CONSTRAINT [PK_ESTIA_BASELOC] PRIMARY KEY CLUSTERED ([CORG] ASC, [CAGENCE] ASC, [CGROUPE] ASC, [CIMMEUB] ASC, [CLOCAL] ASC, [CBASE] ASC, [DEFFET] ASC)
);



