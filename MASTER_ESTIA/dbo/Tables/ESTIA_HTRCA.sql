CREATE TABLE [dbo].[ESTIA_HTRCA] (
    [CORG]    VARCHAR (4)     NOT NULL,
    [CAGENCE] VARCHAR (4)     NOT NULL,
    [CGROUPE] INT             NOT NULL,
    [CIMMEUB] INT             NOT NULL,
    [CLOCAL]  INT             NOT NULL,
    [OCC]     INT             NOT NULL,
    [MTMINI]  NUMERIC (17, 2) NOT NULL,
    [MTMAXI]  NUMERIC (17, 2) NULL,
    [PRCCA]   NUMERIC (17, 2) NULL,
    [TRIG]    VARCHAR (2)     NULL,
    [DDEB]    DATE            NULL,
    [DREVIS]  DATE            NULL,
    [ANCIND]  INT             NULL,
    [NOUIND]  INT             NULL,
    [CNUMI]   VARCHAR (10)    NULL,
    CONSTRAINT [PK_ESTIA_HTRCA] PRIMARY KEY CLUSTERED ([CORG] ASC, [CAGENCE] ASC, [CGROUPE] ASC, [CIMMEUB] ASC, [CLOCAL] ASC, [OCC] ASC, [MTMINI] ASC)
);

