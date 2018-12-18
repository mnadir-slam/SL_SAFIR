﻿CREATE TABLE [dbo].[PDEPOP] (
    [corg]          VARCHAR (500)  NULL,
    [cope]          VARCHAR (50)   NULL,
    [cdepr]         VARCHAR (50)   NULL,
    [mtini]         VARCHAR (50)   NULL,
    [ctva]          VARCHAR (50)   NULL,
    [cfour]         VARCHAR (50)   NULL,
    [mtcau]         VARCHAR (50)   NULL,
    [pourcrg]       VARCHAR (50)   NULL,
    [nantis]        VARCHAR (50)   NULL,
    [marsign]       VARCHAR (50)   NULL,
    [mtpen]         VARCHAR (50)   NULL,
    [temrj]         VARCHAR (50)   NULL,
    [cfourp]        VARCHAR (50)   NULL,
    [prorata]       VARCHAR (50)   NULL,
    [dmlev]         VARCHAR (50)   NULL,
    [reserv]        VARCHAR (50)   NULL,
    [dlreserv]      VARCHAR (50)   NULL,
    [nord]          VARCHAR (50)   NULL,
    [dlaijour]      VARCHAR (50)   NULL,
    [jpdlai]        VARCHAR (50)   NULL,
    [temapp]        VARCHAR (50)   NULL,
    [lnord]         VARCHAR (50)   NULL,
    [situat]        VARCHAR (50)   NULL,
    [suivi]         VARCHAR (50)   NULL,
    [totmil]        VARCHAR (50)   NULL,
    [ancpt]         VARCHAR (50)   NULL,
    [mocpt]         VARCHAR (50)   NULL,
    [edisit]        VARCHAR (50)   NULL,
    [actua]         VARCHAR (50)   NULL,
    [revis]         VARCHAR (50)   NULL,
    [coefix]        VARCHAR (50)   NULL,
    [coefva]        VARCHAR (50)   NULL,
    [soumis]        VARCHAR (50)   NULL,
    [cagence]       VARCHAR (50)   NULL,
    [cmodreg]       VARCHAR (50)   NULL,
    [cagenceb]      VARCHAR (50)   NULL,
    [cfourb]        VARCHAR (50)   NULL,
    [datlib]        VARCHAR (50)   NULL,
    [anbas]         VARCHAR (50)   NULL,
    [mobas]         VARCHAR (50)   NULL,
    [mtsstraite]    VARCHAR (50)   NULL,
    [temcp]         VARCHAR (50)   NULL,
    [noavts]        VARCHAR (50)   NULL,
    [mtlib]         VARCHAR (50)   NULL,
    [dtlib]         VARCHAR (50)   NULL,
    [dors]          VARCHAR (50)   NULL,
    [strait]        VARCHAR (50)   NULL,
    [ttiers]        VARCHAR (50)   NULL,
    [pdirect]       VARCHAR (50)   NULL,
    [deffet]        VARCHAR (50)   NULL,
    [jurid]         VARCHAR (50)   NULL,
    [calcrg]        VARCHAR (50)   NULL,
    [utilret 1 ]    VARCHAR (50)   NULL,
    [utilret 2 ]    VARCHAR (50)   NULL,
    [utilret 3 ]    VARCHAR (50)   NULL,
    [utilret 4 ]    VARCHAR (50)   NULL,
    [utilret 5 ]    VARCHAR (50)   NULL,
    [utilret 6 ]    VARCHAR (50)   NULL,
    [utilret 7 ]    VARCHAR (50)   NULL,
    [utilret 8 ]    VARCHAR (50)   NULL,
    [utilret 9 ]    VARCHAR (50)   NULL,
    [utilret 10 ]   VARCHAR (50)   NULL,
    [tauxret 1 ]    VARCHAR (50)   NULL,
    [tauxret 2 ]    VARCHAR (50)   NULL,
    [tauxret 3 ]    VARCHAR (50)   NULL,
    [tauxret 4 ]    VARCHAR (50)   NULL,
    [tauxret 5 ]    VARCHAR (50)   NULL,
    [tauxret 6 ]    VARCHAR (50)   NULL,
    [tauxret 7 ]    VARCHAR (50)   NULL,
    [tauxret 8 ]    VARCHAR (50)   NULL,
    [tauxret 9 ]    VARCHAR (50)   NULL,
    [tauxret 10 ]   VARCHAR (50)   NULL,
    [ctranche]      VARCHAR (50)   NULL,
    [aspol]         VARCHAR (50)   NULL,
    [ascon]         VARCHAR (50)   NULL,
    [asdat]         VARCHAR (50)   NULL,
    [drecept]       VARCHAR (50)   NULL,
    [ddecomp]       VARCHAR (50)   NULL,
    [dnotif]        VARCHAR (50)   NULL,
    [dgap]          VARCHAR (50)   NULL,
    [lib]           VARCHAR (50)   NULL,
    [rlib]          VARCHAR (50)   NULL,
    [cphase]        VARCHAR (50)   NULL,
    [cassur]        VARCHAR (50)   NULL,
    [cbanque]       VARCHAR (50)   NULL,
    [guichet]       VARCHAR (50)   NULL,
    [ccompte]       VARCHAR (50)   NULL,
    [rib]           VARCHAR (50)   NULL,
    [comment]       VARCHAR (1000) NULL,
    [ctypvir]       VARCHAR (50)   NULL,
    [cdecala]       VARCHAR (50)   NULL,
    [cdecald]       VARCHAR (50)   NULL,
    [duree]         VARCHAR (50)   NULL,
    [repere]        VARCHAR (50)   NULL,
    [ctypprel]      VARCHAR (50)   NULL,
    [ctypdat]       VARCHAR (50)   NULL,
    [type]          VARCHAR (50)   NULL,
    [rg]            VARCHAR (50)   NULL,
    [mtconv]        VARCHAR (50)   NULL,
    [devise]        VARCHAR (50)   NULL,
    [mtttcconv]     VARCHAR (50)   NULL,
    [ddersit]       VARCHAR (50)   NULL,
    [rabais]        VARCHAR (50)   NULL,
    [prolasm]       VARCHAR (50)   NULL,
    [temoin]        VARCHAR (50)   NULL,
    [mixte]         VARCHAR (50)   NULL,
    [acouv]         VARCHAR (50)   NULL,
    [ccouv]         VARCHAR (50)   NULL,
    [debenc]        VARCHAR (50)   NULL,
    [mttcini]       VARCHAR (50)   NULL,
    [critlib1]      VARCHAR (50)   NULL,
    [critlib2]      VARCHAR (50)   NULL,
    [critlib3]      VARCHAR (50)   NULL,
    [pxmil]         VARCHAR (50)   NULL,
    [ctiersb]       VARCHAR (50)   NULL,
    [txpresta]      VARCHAR (50)   NULL,
    [tempresta]     VARCHAR (50)   NULL,
    [ddexec]        VARCHAR (50)   NULL,
    [dfinprev]      VARCHAR (50)   NULL,
    [pavanc]        VARCHAR (50)   NULL,
    [remumod]       VARCHAR (50)   NULL,
    [remufor]       VARCHAR (50)   NULL,
    [dmarnot]       VARCHAR (50)   NULL,
    [fractr]        VARCHAR (50)   NULL,
    [fracbc]        VARCHAR (50)   NULL,
    [grpt]          VARCHAR (50)   NULL,
    [natav]         VARCHAR (50)   NULL,
    [cmodcomp]      VARCHAR (50)   NULL,
    [gestcomp]      VARCHAR (50)   NULL,
    [codnat]        VARCHAR (50)   NULL,
    [cleiban]       VARCHAR (50)   NULL,
    [migcompt]      VARCHAR (50)   NULL,
    [coordbanq_id]  VARCHAR (50)   NULL,
    [exhono]        VARCHAR (50)   NULL,
    [ccoreta]       VARCHAR (50)   NULL,
    [infotimestamp] VARCHAR (50)   NULL,
    [TRIG]          VARCHAR (50)   NULL,
    [CTYPAVANCE]    VARCHAR (50)   NULL,
    [POURCAVANCE]   VARCHAR (50)   NULL,
    [NBMOISACTU]    VARCHAR (50)   NULL,
    [DDERMAJ ]      VARCHAR (50)   NULL
);
