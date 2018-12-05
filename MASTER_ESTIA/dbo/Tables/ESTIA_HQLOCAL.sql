CREATE TABLE [dbo].[ESTIA_HQLOCAL] (
    [PK_HQLOCAL] INT             IDENTITY (1, 1) NOT NULL,
    [CORG]       VARCHAR (4)     NOT NULL,
    [CAGENCE]    VARCHAR (4)     NOT NULL,
    [CGROUPE]    INT             NOT NULL,
    [CIMMEUB]    INT             NOT NULL,
    [CLOCAL]     INT             NOT NULL,
    [CRUB]       INT             NOT NULL,
    [DDEB]       DATE            NULL,
    [DFIN]       DATE            NULL,
    [NB]         NUMERIC (18, 3) NULL,
    [TRIG]       VARCHAR (2)     NULL,
    [CMETREV]    VARCHAR (6)     NULL,
    [MONTREV]    NUMERIC (18, 3) NULL,
    [MTCUMREA]   NUMERIC (17, 2) NULL,
    [MTCUMVAC]   NUMERIC (17, 2) NULL,
    [INDANC]     NUMERIC (17, 2) NULL,
    [LFACIAL]    VARCHAR (1)     NULL,
    [CCATHLM]    VARCHAR (6)     NULL,
    [MIGCOMPT]   VARCHAR (2)     NULL,
    [LOCAL_ID]   VARCHAR (2)     NULL
);

