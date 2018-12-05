CREATE TABLE [dbo].[ESTIA_TAUX] (
    [CRUB]    INT             NOT NULL,
    [DDEB]    DATE            NOT NULL,
    [DFIN]    DATE            NOT NULL,
    [MONTANT] NUMERIC (19, 4) NULL,
    [TRIG]    VARCHAR (2)     NULL,
    [LACTIF]  VARCHAR (2)     NULL
);

