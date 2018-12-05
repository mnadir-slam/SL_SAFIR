CREATE TABLE [dbo].[WRK_HREVIS] (
    [CORG]                   VARCHAR (2)     NOT NULL,
    [CAGENCE]                VARCHAR (4)     NOT NULL,
    [CGROUPE]                INT             NOT NULL,
    [CIMMEUB]                INT             NOT NULL,
    [CLOCAL]                 INT             NOT NULL,
    [OCC]                    INT             NOT NULL,
    [CRUB]                   INT             NOT NULL,
    [CSTE]                   VARCHAR (2)     NOT NULL,
    [IND_HREVIS]             VARCHAR (1)     NULL,
    [CD_INDICE_REVISION]     VARCHAR (10)    NOT NULL,
    [DT_REVISION_PRECEDENTE] DATE            NULL,
    [MT_INITIAL]             NUMERIC (18, 3) NULL,
    [VAL_INDICE_INITIAL]     NUMERIC (20, 5) NULL,
    [VAL_INDICE_PRECEDENT]   NUMERIC (20, 5) NULL,
    [VAL_INDICE_ACTUEL]      NUMERIC (20, 5) NULL,
    [CD_INDICE_INITIAL]      INT             NULL,
    [CD_INDICE_ACTUEL]       INT             NULL,
    [DT_INDICE_INITIAL]      DATETIME        NULL,
    [DT_INDICE_ACTUEL]       DATETIME        NULL,
    CONSTRAINT [PK_WRK_HREVIS] PRIMARY KEY CLUSTERED ([CORG] ASC, [CAGENCE] ASC, [CGROUPE] ASC, [CIMMEUB] ASC, [CLOCAL] ASC, [OCC] ASC, [CRUB] ASC, [CSTE] ASC)
);

