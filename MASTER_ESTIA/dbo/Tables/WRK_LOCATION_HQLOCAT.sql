CREATE TABLE [dbo].[WRK_LOCATION_HQLOCAT] (
    [PK_BAIL]              INT             NULL,
    [CORG]                 VARCHAR (4)     NOT NULL,
    [CCOMPTE]              VARCHAR (22)    NOT NULL,
    [NOBAIL]               INT             NOT NULL,
    [MT_DG_PRINCIPAL]      NUMERIC (12, 2) NULL,
    [MT_DG_ANNEXE]         NUMERIC (12, 2) NULL,
    [IND_DG_REVISABLE]     VARCHAR (1)     NULL,
    [DT_DEBUT_FRANCHISE]   DATE            NULL,
    [DT_FIN_FRANCHISE]     DATE            NULL,
    [DUREE_FRANCHISE_MOIS] INT             NULL,
    [CD_MODE_REVISION_AXA] VARCHAR (2)     NULL,
    CONSTRAINT [PK_WRK_LOCATION_HQLOCAT] PRIMARY KEY CLUSTERED ([CORG] ASC, [CCOMPTE] ASC, [NOBAIL] ASC)
);

