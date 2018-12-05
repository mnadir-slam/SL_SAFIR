CREATE TABLE [dbo].[ESTIA_PCRITDEP] (
    [CORG]     VARCHAR (4)     NOT NULL,
    [COPE]     VARCHAR (22)    NOT NULL,
    [CTRANCHE] INT             NOT NULL,
    [CDEPR]    INT             NOT NULL,
    [NORD]     INT             NOT NULL,
    [CAGENCE]  VARCHAR (4)     NULL,
    [CGROUPE]  INT             NULL,
    [CIMMEUB]  INT             NULL,
    [CLOCAL]   INT             NULL,
    [CCRITDP]  INT             NULL,
    [CSCRITDP] INT             NULL,
    [POURC]    NUMERIC (18, 3) NULL,
    [BANAL]    VARCHAR (100)   NULL
);

