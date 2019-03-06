CREATE PROCEDURE [dbo].[XP_SEND_MAIL]
(
	@SMTPServer varchar(255),
	@Port int,
	@User varchar(255),
	@Password varchar(255),
	@From varchar(100),
	@To varchar(100),
	@Subject varchar(100),
	@Body varchar(8000)
)
AS
BEGIN

	Declare @iMsg int
	Declare @hr int
	Declare @source varchar(255)
	Declare @description varchar(500)
	Declare @output varchar(1000)
	Declare @tmpstr VARCHAR(100)

--************* Create the CDO.Message Object ************************
	EXEC @hr = sp_OACreate 'CDO.Message', @iMsg OUT

--***************Configuring the Message Object ******************
	-- This is to configure a remote SMTP server.
	-- http://msdn.microsoft.com/library/default.asp?url=/library/en-us/cdosys/html/_cdosys_schema_configuration_sendusing.asp
	EXEC @hr = sp_OASetProperty @iMsg, 'Configuration.fields("http://schemas.microsoft.com/cdo/configuration/sendusing").Value','2'

	-- This is to configure the Server Name or IP address. 
	EXEC @hr = sp_OASetProperty @iMsg, 'Configuration.fields("http://schemas.microsoft.com/cdo/configuration/smtpserver").Value', @SMTPServer

	-- This is to configure the Server Port
	SET @tmpstr = CONVERT(VARCHAR(5),ISNULL(@Port,25))
	EXEC @hr = sp_oasetproperty @imsg, 'configuration.fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport").value', @tmpstr

	-- This is to configure the User Name and Password
	IF LEN(@Password) > 0
		BEGIN
		EXEC @hr = sp_oasetproperty @iMsg, 'configuration.fields("http://schemas.microsoft.com/cdo/configuration/sendusername").value', @User
		EXEC @hr = sp_oasetproperty @iMsg, 'configuration.fields("http://schemas.microsoft.com/cdo/configuration/sendpassword").value', @Password
		EXEC @hr = sp_oasetproperty @iMsg, 'configuration.fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate").value', '1'
		END

	-- Save the configurations to the message object.
	EXEC @hr = sp_OAMethod @iMsg, 'Configuration.Fields.Update', null


	-- Set the e-mail parameters.
	EXEC @hr = sp_OASetProperty @iMsg, 'To', @To
	EXEC @hr = sp_OASetProperty @iMsg, 'From', @From
	EXEC @hr = sp_OASetProperty @iMsg, 'Subject', @Subject


	-- If you are using HTML e-mail, use 'HTMLBody' instead of 'TextBody'.
	EXEC @hr = sp_OASetProperty @iMsg, 'TextBody', @Body
	EXEC @hr = sp_OAMethod @iMsg, 'Send', NULL

-- Sample error handling.
   IF @hr <> 0 
     select @hr
     BEGIN
       EXEC @hr = sp_OAGetErrorInfo NULL, @source OUT, @description OUT
       IF @hr = 0
         BEGIN
           SELECT @output = '  Source: ' + @source
           PRINT  @output
           SELECT @output = '  Description: ' + @description
           PRINT  @output
         END
       ELSE
         BEGIN
           PRINT '  sp_OAGetErrorInfo failed.'
           RETURN
         END
     END

-- Do some error handling after each step if you need to.
-- Clean up the objects created.
   EXEC @hr = sp_OADestroy @iMsg

END