﻿CREATE TABLE [dbo].[F_COMPTABILITE_LOCATAIRE] (
    [DT_REF]                   DATETIME        NULL,
    [PK_ECRITURE]              INT             NOT NULL,
    [FK_TEMPS]                 DATETIME        NULL,
    [FK_PROPRIETAIRE]          INT             NULL,
    [FK_MANDAT_GERANCE]        INT             NULL,
    [FK_IMMEUBLE]              INT             NULL,
    [FK_BAIL]                  INT             NULL,
    [FK_BAIL_LOYER_IVG]        INT             NULL,
    [FK_BAIL_CHARGES_IVG]      INT             NULL,
    [FK_LOCATAIRE_LOYER_IVG]   INT             NULL,
    [FK_LOCATAIRE_CHARGES_IVG] INT             NULL,
    [FK_LOCATAIRE]             INT             NULL,
    [FK_RUBRIQUE]              INT             NULL,
    [IND_QUITTANCEMENT]        VARCHAR (1)     NULL,
    [IND_ENCAISSEMENT]         VARCHAR (1)     NULL,
    [IND_ELEMENT_PERMANENT]    VARCHAR (1)     NULL,
    [DT_COMPTABLE]             DATETIME        NULL,
    [DT_TERME]                 DATETIME        NULL,
    [DT_SAISIE]                DATETIME        NULL,
    [CD_TYPE_SAISIE]           VARCHAR (6)     NULL,
    [NUM_SAISIE]               VARCHAR (42)    NULL,
    [PIECE_COMPTABLE]          VARCHAR (16)    NULL,
    [NUM_FACTURE]              VARCHAR (16)    NULL,
    [LB_ECRITURE]              VARCHAR (80)    NULL,
    [MT_DEBIT]                 NUMERIC (17, 2) NULL,
    [MT_CREDIT]                NUMERIC (17, 2) NULL,
    [MT_QUITTANCE]             NUMERIC (17, 2) NULL,
    [MT_ENCAISSE]              NUMERIC (17, 2) NULL,
    [MT_SOLDE]                 NUMERIC (17, 2) NULL,
    [VALID_PROP]               VARCHAR (1)     NULL,
    CONSTRAINT [PK_F_COMPTABILITE_LOCATAIRE] PRIMARY KEY CLUSTERED ([PK_ECRITURE] ASC)
);

