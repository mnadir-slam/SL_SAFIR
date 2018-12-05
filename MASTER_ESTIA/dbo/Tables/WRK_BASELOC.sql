CREATE TABLE [dbo].[WRK_BASELOC] (
    [FK_BASELOC]    INT             NULL,
    [FK_ORG]        INT             NULL,
    [FK_AGENCE]     INT             NULL,
    [FK_GROUPE]     INT             NULL,
    [FK_IMMEUB]     INT             NULL,
    [FK_LOCAL]      INT             NULL,
    [FK_BASE]       INT             NULL,
    [CORG]          VARCHAR (4)     NOT NULL,
    [CAGENCE]       VARCHAR (4)     NOT NULL,
    [CGROUPE]       INT             NOT NULL,
    [CIMMEUB]       INT             NOT NULL,
    [CLOCAL]        INT             NOT NULL,
    [CBASE]         INT             NOT NULL,
    [DEFFET]        DATETIME        NOT NULL,
    [DT_FIN]        DATETIME        NULL,
    [VAL_TANTIEMES] NUMERIC (17, 2) NULL,
    [VAL_BASE]      NUMERIC (17, 2) NULL,
    [RK]            INT             NULL,
    CONSTRAINT [PK_WRK_BASELOC] PRIMARY KEY CLUSTERED ([CORG] ASC, [CAGENCE] ASC, [CGROUPE] ASC, [CIMMEUB] ASC, [CLOCAL] ASC, [CBASE] ASC, [DEFFET] ASC)
);

