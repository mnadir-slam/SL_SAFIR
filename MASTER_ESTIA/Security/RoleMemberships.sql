ALTER ROLE [db_owner] ADD MEMBER [VIVERIS\Administrateur];


GO
ALTER ROLE [db_owner] ADD MEMBER [VIVERIS\francois.duong];


GO



GO
ALTER ROLE [db_datawriter] ADD MEMBER [user_excel];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [VIVERIS\margaux.esteve];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [VIVERIS\christian.moreau];


GO



GO
ALTER ROLE [db_datareader] ADD MEMBER [user_excel];


GO
ALTER ROLE [db_datareader] ADD MEMBER [VIVERIS\margaux.esteve];


GO
ALTER ROLE [db_datareader] ADD MEMBER [VIVERIS\christian.moreau];


GO
ALTER ROLE [db_owner] ADD MEMBER [user_test];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [abo_rapport];


GO
ALTER ROLE [db_datareader] ADD MEMBER [abo_rapport];

