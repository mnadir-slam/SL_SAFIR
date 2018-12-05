CREATE TABLE [dbo].[ESTIA_LOCASSUR] (
    [CORG]        VARCHAR (4)     NOT NULL,
    [CAGENCE]     VARCHAR (4)     NOT NULL,
    [CGROUPE]     INT             NOT NULL,
    [CIMMEUB]     INT             NOT NULL,
    [CLOCAL]      INT             NOT NULL,
    [OCC]         INT             NOT NULL,
    [CTYPASS]     VARCHAR (4)     NULL,
    [DATEFF]      DATE            NULL,
    [DATRESIL]    DATE            NULL,
    [NUMCONT]     VARCHAR (60)    NULL,
    [DECHEANCE]   DATE            NULL,
    [AGTYPTIERS]  VARCHAR (2)     NULL,
    [AGTIERS]     VARCHAR (14)    NULL,
    [TRIG]        VARCHAR (2)     NULL,
    [CITYPTIERS]  VARCHAR (2)     NULL,
    [CITIERS]     VARCHAR (14)    NULL,
    [MTMINIGAR]   NUMERIC (17, 2) NULL,
    [MIGCOMPT]    INT             NULL,
    [MTASSUR]     NUMERIC (17, 2) NULL,
    [LOCASSUR_ID] INT             NULL
);

