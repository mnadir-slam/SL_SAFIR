CREATE TABLE [dbo].[P_VLM] (
    [PK_IMMEUBLE]      INT           NOT NULL,
    [NM_IMMEUBLE]      INT           NOT NULL,
    [ADRESSE]          VARCHAR (64)  NULL,
    [VLM_ARC]          INT           NULL,
    [VLM_PKG_SIMPLE]   INT           NULL,
    [VLM_PKG_DOUBLE]   INT           NULL,
    [CD_SOCIETE]       VARCHAR (4)   NULL,
    [CD_AGENCE]        VARCHAR (4)   NULL,
    [PK_PROPRIETAIRE]  INT           NULL,
    [NM_PROPRIETAIRE]  NUMERIC (14)  NULL,
    [NOM_PROPRIETAIRE] VARCHAR (100) NULL
);

