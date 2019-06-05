CREATE TABLE [dbo].[L_INTERFACE_EASYFOLDER_FACTURES] (
    [CLE]           VARCHAR (26)    NULL,
    [NOPRE]         VARCHAR (16)    NULL,
    [MTHT]          NUMERIC (17, 2) NULL,
    [MTTTC]         NUMERIC (17, 2) NULL,
    [MTTVA]         NUMERIC (17, 2) NULL,
    [DATFAC]        DATE            NULL,
    [REF_BT_CTR_GO] VARCHAR (50)    NULL,
    [RESP_IMMB]     VARCHAR (8000)  NULL,
    [GEST_IMMB]     VARCHAR (8000)  NULL,
    [TECH_IMMB]     VARCHAR (8000)  NULL,
    [TECH_GO]       VARCHAR (8000)  NULL,
    [CGROUPE]       INT             NULL,
    [LGROUPE]       VARCHAR (64)    NULL,
    [TYPBON]        VARCHAR (9)     NULL,
    [LTIERS]        VARCHAR (76)    NULL,
    [CTIERS]        VARCHAR (14)    NULL,
    [CRIT_ENG]      VARCHAR (50)    NULL,
    [SCRIT_ENG]     VARCHAR (50)    NULL,
    [MT_ENG]        NUMERIC (17, 2) NULL,
    [NOPIECE]       VARCHAR (16)    NULL
);

