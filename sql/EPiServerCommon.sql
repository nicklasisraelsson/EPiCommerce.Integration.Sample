SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUserOpenID]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonUserOpenID](		
	[strClaimedIdentifier] [varchar](255) NOT NULL,
	[strFriendlyIdentifierForDisplay] [varchar](255) NOT NULL,
	[intUserID] [int] NOT NULL
CONSTRAINT [PK_tblEPiServerCommonUserOpenID] PRIMARY KEY CLUSTERED 
(
	[strClaimedIdentifier] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUserOpenID]') AND name = N'IX_tblEPiServerCommonUserOpenID_1')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonUserOpenID_1] ON [dbo].[tblEPiServerCommonUserOpenID] 
(
	[strFriendlyIdentifierForDisplay] DESC
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonOwnerContext]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonOwnerContext](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strName] [nvarchar](200) COLLATE Latin1_General_CS_AS NOT NULL,	
 CONSTRAINT [PK_tblEPiServerCommonOwnerContext] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonOwnerContext]') AND name = N'IX_tblEPiServerCommonOwnerContext')
CREATE UNIQUE NONCLUSTERED INDEX IX_tblEPiServerCommonOwnerContext ON dbo.tblEPiServerCommonOwnerContext
	(
	strName
	)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEntityGroupAccessRights]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonEntityGroupAccessRights](
	[intEntityTypeID] [int] NOT NULL,
	[intEntityID] [int] NOT NULL,
	[intGroupID] [int] NOT NULL,
	[intAccessLevel] [int] NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonEntityGroupAccessRights] PRIMARY KEY CLUSTERED 
(
	[intEntityTypeID] ASC,
	[intEntityID] ASC,
	[intGroupID] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEntityUserAccessRights]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonEntityUserAccessRights](
	[intEntityTypeID] [int] NOT NULL,
	[intEntityID] [int] NOT NULL,
	[intUserID] [int] NOT NULL,
	[intAccessLevel] [int] NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonEntityUserAccessRights] PRIMARY KEY CLUSTERED 
(
	[intEntityTypeID] ASC,
	[intEntityID] ASC,
	[intUserID] ASC
)
)
END
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonOwnership]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonOwnership](
	[intObjectEntityID] [int] NOT NULL,
	[intObjectTypeID] [int] NOT NULL,
	[intOwnerEntityID] [int] NOT NULL,
	[intOwnerTypeID] [int] NOT NULL,
	[intOwnerContextID] [int] NOT NULL,
	CONSTRAINT PK_tblEPiServerCommonOwnership PRIMARY KEY NONCLUSTERED 
	(
	intObjectTypeID,
	intObjectEntityID
	)
)
END
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonOwnership]') AND name = N'IX_tblEPiServerCommonOwnership')
CREATE UNIQUE CLUSTERED INDEX IX_tblEPiServerCommonOwnership ON dbo.tblEPiServerCommonOwnership
	(
	intOwnerTypeID,
	intOwnerEntityID,
	intOwnerContextID
	)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonSetting]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonSetting](
	[strKey] [nvarchar](200) NOT NULL,
	[strValue] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonSetting] PRIMARY KEY CLUSTERED 
(
	[strKey] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUserModuleAccessRight]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonUserModuleAccessRight](
	[strModule] [varchar](100) NOT NULL,
	[intUserID] [int] NOT NULL,
	[intAccessLevel] [int] NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonUserModuleAccessRight] PRIMARY KEY CLUSTERED 
(
	[strModule] ASC,
	[intUserID] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonSite]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonSite](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strName] [nvarchar](200) NOT NULL,
	[strCulture] [varchar](15) NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonSite] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonSiteRemoveObjectReferences]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Daniel Furtado
-- Create date: 2009-03-25
-- Description:	Removes any object references to rows being deleted in this table
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonSiteRemoveObjectReferences] 
   ON  [dbo].[tblEPiServerCommonSite] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @strXml varchar(MAX)
	SET @strXml = ''<Root>'' + (SELECT intID AS ObjectID FROM deleted AS Obj FOR XML AUTO) + ''</Root>''

	EXEC spEPiServerCommonRemoveObjectReferences 
				@strObjectType = ''EPiServer.Common.Site, EPiServer.Common.Framework.Impl'', 
				@strObjectXml = @strXml
END'
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAccessRightSection]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonAccessRightSection](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonAccessRightSections] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonPasswordProvider]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonPasswordProvider](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strName] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonPasswordProvider] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonPasswordProvider]') AND name = N'IX_tblEPiServerCommonPasswordProvider_strName')
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblEPiServerCommonPasswordProvider_strName] ON [dbo].[tblEPiServerCommonPasswordProvider] 
(
	[strName] ASC
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonGroup](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strName] [nvarchar](200) NOT NULL,
	[intStatus] [smallint] NOT NULL, 
	[intPreviousStatus] [smallint] NOT NULL CONSTRAINT [DF_tblEPiServerCommonGroups_intPreviousStatus]  DEFAULT ((0)),
 CONSTRAINT [PK_tblEPiServerCommonGroups] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonGroupRemoveObjectReferences]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Daniel Furtado>
-- Create date: <2008-11-26>
-- Description:	<Removes any object references to rows being deleted in this table>
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonGroupRemoveObjectReferences] 
   ON  [dbo].[tblEPiServerCommonGroup] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @strXml varchar(MAX)
	SET @strXml = ''<Root>'' + (SELECT intID AS ObjectID FROM deleted AS Obj FOR XML AUTO) + ''</Root>''
	
	-- clear off the groups access rights
	DELETE FROM tblEPiServerCommonGroupAdministrativeAccessRight WHERE intGroupID = (SELECT intID FROM deleted);
	DELETE FROM tblEPiServerCommonGroupModuleAccessRight WHERE intGroupID = (SELECT intID FROM deleted);

	EXEC spEPiServerCommonRemoveObjectReferences 
				@strObjectType = ''EPiServer.Common.Security.IGroup, EPiServer.Common.Framework'', 
				@strObjectXml = @strXml
END

' 
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonUser](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strUserName] [nvarchar](100) NOT NULL,
	[strGivenName] [nvarchar](100) NULL,
	[strSurName] [nvarchar](100) NULL,
	[datBirthDate] [datetime] NOT NULL,
	[strEmail] [varchar](255) NOT NULL,
	[strCulture] [varchar](15) NOT NULL,
	[datCreateDate] [datetime] NOT NULL CONSTRAINT [DF_tblEPiServerCommonUser_datCreateDate]  DEFAULT (getdate()),
	[strAlias] [nvarchar](100) NOT NULL,
	[intPasswordProviderID] [int] NULL,
	[binPassword] [varbinary](200) NOT NULL,
	[intStatus] [smallint] NOT NULL, 
	[intPreviousStatus] [smallint] NOT NULL CONSTRAINT [DF_tblEPiServerCommonUser_intPreviousStatus]  DEFAULT ((0)), 
 CONSTRAINT [PK_tblEPiServerCommonUser] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUser]') AND name = N'IX_tblEPiServerCommonUser')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonUser] ON [dbo].[tblEPiServerCommonUser] 
(
	[strUserName] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUser]') AND name = N'IX_tblEPiServerCommonUser_1')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonUser_1] ON [dbo].[tblEPiServerCommonUser] 
(
	[strGivenName] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUser]') AND name = N'IX_tblEPiServerCommonUser_2')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonUser_2] ON [dbo].[tblEPiServerCommonUser] 
(
	[strSurName] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUser]') AND name = N'IX_tblEPiServerCommonUser_3')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonUser_3] ON [dbo].[tblEPiServerCommonUser] 
(
	[strEmail] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUser]') AND name = N'IX_tblEPiServerCommonUser_4')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonUser_4] ON [dbo].[tblEPiServerCommonUser] 
(
	[strAlias] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUser]') AND name = N'IX_tblEPiServerCommonUser_5')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonUser_5] ON [dbo].[tblEPiServerCommonUser] 
(
	[intStatus] ASC
)
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonUserRemoveObjectReferences]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Mattias Nordberg>
-- Create date: <2007-08-21>
-- Description:	<Removes any object references to rows being deleted in this table>
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonUserRemoveObjectReferences] 
   ON  [dbo].[tblEPiServerCommonUser] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @strXml varchar(MAX)
	SET @strXml = ''<Root>'' + (SELECT intID AS ObjectID FROM deleted AS Obj FOR XML AUTO) + ''</Root>''
	
    DECLARE @intUserID int
	SET @intUserID = (SELECT intID FROM deleted)

	-- clear off the groups access rights
	DELETE FROM tblEPiServerCommonUserAdministrativeAccessRight WHERE intUserID = @intUserID;
	DELETE FROM tblEPiServerCommonUserModuleAccessRight WHERE intUserID = @intUserID;

	EXEC spEPiServerCommonRemoveObjectReferences 
				@strObjectType = ''EPiServer.Common.Security.IUser, EPiServer.Common.Framework'', 
				@strObjectXml = @strXml
END


' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonUserOnPermanentRemoval]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Daniel Furtado
-- Create date: 2009-09-04
-- Description:	Update removed status for the author.
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonUserOnPermanentRemoval]
   ON  [dbo].[tblEPiServerCommonUser] 
   AFTER DELETE
AS 
BEGIN

	SET NOCOUNT ON;

	UPDATE tblEPiServerCommonAuthor 
	SET tblEPiServerCommonAuthor.intStatus = 4, 
	tblEPiServerCommonAuthor.strAuthorName = COALESCE(deleted.strAlias, tblEPiServerCommonAuthor.strAuthorName),
	tblEPiServerCommonAuthor.strAuthorEmail = deleted.strEmail
	FROM deleted
	WHERE 
	tblEPiServerCommonAuthor.intObjectTypeID IN (SELECT intID FROM tblEntityType WHERE strName IN (''EPiServer.Common.UserAuthor, EPiServer.Common.Framework.Impl'')) AND
	tblEPiServerCommonAuthor.intEntityID = deleted.intID;

END'
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonUserOnSoftRemoval]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Daniel Furtado
-- Create date: 2009-09-04
-- Description:	Update removed status for the author when user is soft-removed.
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonUserOnSoftRemoval]
   ON  [dbo].[tblEPiServerCommonUser] 
   AFTER UPDATE
AS 
BEGIN
	
	SET NOCOUNT ON;
	
	IF UPDATE(intStatus)
	BEGIN			
		UPDATE tblEPiServerCommonAuthor 
		SET
		tblEPiServerCommonAuthor.strAuthorName = (
		CASE 
			WHEN ((tblEPiServerCommonAuthor.intStatus&4)=0 AND (inserted.intStatus&4)=4 AND (tblEPiServerCommonAuthor.strAuthorName IS NULL)) THEN inserted.strAlias 
			WHEN ((tblEPiServerCommonAuthor.intStatus&4)=4 AND (inserted.intStatus&4)=0) THEN inserted.strAlias
			ELSE tblEPiServerCommonAuthor.strAuthorName
		END),
		tblEPiServerCommonAuthor.strAuthorEmail = inserted.strEmail 
		FROM inserted
		WHERE 
		tblEPiServerCommonAuthor.intObjectTypeID IN (SELECT intID FROM tblEntityType WHERE strName IN (''EPiServer.Common.UserAuthor, EPiServer.Common.Framework.Impl'')) AND
		tblEPiServerCommonAuthor.intEntityID = inserted.intID;
		
	END	
END'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonGroupChildren]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonGroupChildren](
	[intParentGroupID] [int] NOT NULL,
	[intChildGroupID] [int] NOT NULL
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonGroupChildren]') AND name = N'IX_tblEPiServerCommonGroupChildren')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonGroupChildren] ON [dbo].[tblEPiServerCommonGroupChildren] 
(
	[intParentGroupID] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonGroupChildren]') AND name = N'IX_tblEPiServerCommonGroupChildren_1')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonGroupChildren_1] ON [dbo].[tblEPiServerCommonGroupChildren] 
(
	[intChildGroupID] ASC
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttribute]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonAttribute](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strName] [nvarchar](100) NOT NULL,
	[intObjectTypeID] [int] NOT NULL,
	[strDataType] [varchar](200) NOT NULL,
	[blnHidden] [bit] NOT NULL CONSTRAINT [DF_tblEPiServerCommonAttribute_blnHidden]  DEFAULT ((0)),
 CONSTRAINT [PK_tblEPiServerCommonAttribute_1] PRIMARY KEY NONCLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttribute]') AND name = N'IX_tblEPiServerCommonAttribute_intObjectTypeID_strName')
CREATE UNIQUE CLUSTERED INDEX [IX_tblEPiServerCommonAttribute_intObjectTypeID_strName] ON [dbo].[tblEPiServerCommonAttribute] 
(
	[intObjectTypeID] ASC,
	[strName] ASC
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTag]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonTag](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strName] [nvarchar](255) NOT NULL,
	[intItemsCount] [int] NOT NULL CONSTRAINT [DF_tblEPiServerCommonTag_intItemsCount]  DEFAULT ((0)),
 CONSTRAINT [PK_tblEPiServerCommonTag] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTag]') AND name = N'IX_tblEPiServerCommonTagName')
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblEPiServerCommonTagName] ON [dbo].[tblEPiServerCommonTag] 
(
	[strName] ASC
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonActivityLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonActivityLog](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[intObjectID] [int] NULL,
	[intObjectTypeID] [int] NULL,
	[strIP] [varchar](45) NULL,
	[intUserID] [int] NULL,
	[datCreated] [datetime] NOT NULL CONSTRAINT [DF_tblEPiServerCommonEntryLog_datCreated]  DEFAULT (getdate()),
	[intAction] [smallint] NOT NULL CONSTRAINT [DF_tblEPiServerCommonEntryLog_intAction]  DEFAULT ((1)),
 CONSTRAINT [PK_tblEPiServerCommonActivityLog] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonActivityLog]') AND name = N'IX_tblEPiServerCommonActivityLog')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonActivityLog] ON [dbo].[tblEPiServerCommonActivityLog] 
(
	[intObjectID] ASC,
	[intObjectTypeID] ASC
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonGroupModuleAccessRight]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonGroupModuleAccessRight](
	[strModule] [varchar](100) NOT NULL,
	[intGroupID] [int] NOT NULL,
	[intAccessLevel] [int] NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonGroupModuleAccessRight] PRIMARY KEY CLUSTERED 
(
	[strModule] ASC,
	[intGroupID] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonVisitableItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonVisitableItem](
	[intObjectTypeID] [int] NOT NULL CONSTRAINT [DF_tblEPiServerCommonVisitableItem_intObjectTypeID]  DEFAULT ((1)),
	[intObjectID] [int] NOT NULL,
	[intNumVisits] [int] NOT NULL CONSTRAINT [DF_tblEPiServerCommonVisitableItem_intNumVisits]  DEFAULT ((0)),
	[intLastVisitID] [int] NULL,
	[intStatus] [smallint] NOT NULL, 
 CONSTRAINT [PK_tblEPiServerCommonVisitableItem] PRIMARY KEY CLUSTERED 
(
	[intObjectTypeID] ASC,
	[intObjectID] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonScheduledTaskStarter]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonScheduledTaskStarter](
	[unqTaskID] [uniqueidentifier] NOT NULL,
	[strExecAssemblyName] [varchar](255) NOT NULL,
	[strExecClassName] [varchar](255) NOT NULL,
	[blnIsStateFul] [bit] NOT NULL CONSTRAINT [DF_tblEPiServerCommonScheduledTaskStarter_blnIsStateFul]  DEFAULT ((0)),
	[imgStateData] [image] NULL,
 CONSTRAINT [PK_tblEPiServerCommonScheduledItem] PRIMARY KEY CLUSTERED 
(
	[unqTaskID] ASC
)
) TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonRatableItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonRatableItem](
	[intObjectTypeID] [int] NOT NULL,
	[intObjectID] [int] NOT NULL,
	[blnIsRatable] [bit] NOT NULL CONSTRAINT [DF_tblEPiServerCommonRatableItem_blnIsRatable]  DEFAULT ((1)),
	[intNumRatings] [int] NOT NULL CONSTRAINT [DF_tblEPiServerCommonRatableItem_intNumRatings]  DEFAULT ((0)),
	[fltSumRatings] [float] NOT NULL CONSTRAINT [DF_tblEPiServerCommonRatableItem_fltSumRatings]  DEFAULT ((0)),
	[intAvgRating] [int] NOT NULL CONSTRAINT [DF_tblEPiServerCommonRatableItem_intAvgRating]  DEFAULT ((0)),
	[intStatus] [smallint] NOT NULL, 
 CONSTRAINT [PK_tblEPiServerCommonRatableItem] PRIMARY KEY NONCLUSTERED 
(
	[intObjectTypeID] ASC,
	[intObjectID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonRatableItem]') AND name = N'IX_tblEPiServerCommonRatableItem')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonRatableItem] ON [dbo].[tblEPiServerCommonRatableItem] 
(
	[intObjectTypeID] ASC,
	[intAvgRating] ASC
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonCategory](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strName] [nvarchar](200) NOT NULL,
	[intParentID] [int] NULL,
 CONSTRAINT [PK_tblEPiServerCommonCategory] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonCategory]') AND name = N'IX_tblEPiServerCommonCategory_strName')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonCategory_strName] ON [dbo].[tblEPiServerCommonCategory] 
(
	[strName] ASC
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonTagItem](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[intObjectID] [int] NOT NULL,
	[intObjectTypeID] [int] NOT NULL,
	[intTagID] [int] NOT NULL,
	[intCategoryID] [int] NULL,
	[intAuthorID] [int] NULL,
	[datCreateDate] [datetime] NOT NULL CONSTRAINT [DF_tblEPiServerCommonTagItem_datCreateDate]  DEFAULT (getdate()),
	[intStatus] [smallint] NOT NULL, 
 CONSTRAINT [PK_tblEPiServerCommonTagItem] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItem]') AND name = N'IX_tblEPiServerCommonTagItemObjectType')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonTagItemObjectType] ON [dbo].[tblEPiServerCommonTagItem] 
(
	[intObjectTypeID] ASC,
	[intObjectID] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItem]') AND name = N'IX_tblEPiServerCommonTagItemTag')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonTagItemTag] ON [dbo].[tblEPiServerCommonTagItem] 
(
	[intTagID] ASC
)
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonTagRemoveTagItemAuthor]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Mattias Nordberg>
-- Create date: <2007-09-17>
-- Description:	<Deletes guest authors for the deleted objects>
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonTagRemoveTagItemAuthor]
   ON  [dbo].[tblEPiServerCommonTagItem] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM dbo.tblEPiServerCommonAuthor
	WHERE 
	blnReuse=0
	AND intID IN (SELECT intAuthorID FROM deleted WHERE intAuthorID IS NOT NULL)

END
 ' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonReportCase]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonReportCase](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[intObjectID] [int] NOT NULL,
	[intObjectTypeID] [int] NOT NULL,
	[intReportCaseStatus] [smallint] NOT NULL CONSTRAINT [DF_tblEPiServerCommonReportMatter_intStatus]  DEFAULT ((1)),
	[datCreated] [datetime] NOT NULL CONSTRAINT [DF_tblEPiServerCommonReportMatter_datCreated]  DEFAULT (getdate()),
	[datLastModified] [datetime] NOT NULL CONSTRAINT [DF_tblEPiServerCommonReportMatter_datLastModified]  DEFAULT (getdate()),
	[strComment] [nvarchar](max) NULL,
	[strReportDataXml] [nvarchar](max) NULL,
	[strReportDataTitle] [nvarchar](1000) NULL,
	[datReportDataCreated] [datetime] NULL,
	[intReportDataAuthorID] [int] NULL,
	[intNumReports] [int] NOT NULL CONSTRAINT [DF_tblEPiServerCommonReportMatter_intNumReports]  DEFAULT ((0)), 
	[intStatus] [smallint] NOT NULL, 
	[intPreviousStatus] [smallint] NOT NULL CONSTRAINT [DF_tblEPiServerCommonReportMatter_intPreviousStatus]  DEFAULT ((0)), 
 CONSTRAINT [PK_tblEPiServerCommonReportMatter] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueFloat]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonAttributeValueFloat](
	[intAttributeID] [int] NOT NULL,
	[intObjectID] [int] NOT NULL,
	[intSequence] [int] NOT NULL,
	[fltValue] [float] NULL,
 CONSTRAINT [PK_tblEPiServerCommonAttributeValueFloat] PRIMARY KEY CLUSTERED 
(
	[intAttributeID] ASC,
	[intObjectID] ASC,
	[intSequence] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueFloat]') AND name = N'IX_tblEPiServerCommonAttributeValueFloat_intAttributeID')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonAttributeValueFloat_intAttributeID] ON [dbo].[tblEPiServerCommonAttributeValueFloat] 
(
	[intAttributeID] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueFloat]') AND name = N'IX_tblEPiServerCommonAttributeValueFloat_intObjectID')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonAttributeValueFloat_intObjectID] ON [dbo].[tblEPiServerCommonAttributeValueFloat] 
(
	[intObjectID] ASC
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueString]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonAttributeValueString](
	[intAttributeID] [int] NOT NULL,
	[intObjectID] [int] NOT NULL,
	[intSequence] [int] NOT NULL,
	[strValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_tblEPiServerCommonAttributeValueString] PRIMARY KEY CLUSTERED 
(
	[intAttributeID] ASC,
	[intObjectID] ASC,
	[intSequence] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueString]') AND name = N'IX_tblEPiServerCommonAttributeValueString_intAttributeID')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonAttributeValueString_intAttributeID] ON [dbo].[tblEPiServerCommonAttributeValueString] 
(
	[intAttributeID] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueString]') AND name = N'IX_tblEPiServerCommonAttributeValueString_intObjectID')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonAttributeValueString_intObjectID] ON [dbo].[tblEPiServerCommonAttributeValueString] 
(
	[intObjectID] ASC
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagPredefinedTag]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonTagPredefinedTag](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[intTagID] [int] NOT NULL,
	[intObjectTypeID] [int] NOT NULL,
	[intAuthorID] [int] NULL,
 CONSTRAINT [PK_tblEPiServerCommonTagPredefinedTag] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonTagRemoveTagPredefinedTagAuthor]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Mattias Nordberg>
-- Create date: <2007-09-17>
-- Description:	<Deletes guest authors for the deleted objects>
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonTagRemoveTagPredefinedTagAuthor]
   ON  [dbo].[tblEPiServerCommonTagPredefinedTag] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM dbo.tblEPiServerCommonAuthor
	WHERE 
	blnReuse=0
	AND intID IN (SELECT intAuthorID FROM deleted WHERE intAuthorID IS NOT NULL)

END
 ' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItemCount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonTagItemCount](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[intTagID] [int] NOT NULL,
	[intObjectTypeID] [int] NOT NULL,
	[intCategoryID] [int] NULL,
	[intAuthorID] [int] NULL,
	[datUpdateDate] [datetime] NOT NULL,
	[intCount] [int] NOT NULL CONSTRAINT [DF_tblEPiServerCommonTagItemCount_intCount]  DEFAULT ((1)),
	[intStatus] [smallint] NOT NULL, 
 CONSTRAINT [PK_tblEPiServerCommonTagItemCount] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItemCount]') AND name = N'IX_tblEPiServerCommonTagItemCount_ObjectType')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonTagItemCount_ObjectType] ON [dbo].[tblEPiServerCommonTagItemCount] 
(
	[intObjectTypeID] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItemCount]') AND name = N'IX_tblEPiServerCommonTagItemCount_Category')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonTagItemCount_Category] ON [dbo].[tblEPiServerCommonTagItemCount] 
(
	[intCategoryID] ASC
)
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonTagRemoveTagItemCountAuthor]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Mattias Nordberg>
-- Create date: <2007-09-17>
-- Description:	<Deletes guest authors for the deleted objects>
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonTagRemoveTagItemCountAuthor]
   ON  [dbo].[tblEPiServerCommonTagItemCount] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM dbo.tblEPiServerCommonAuthor
	WHERE 
	blnReuse=0
	AND intID IN (SELECT intAuthorID FROM deleted WHERE intAuthorID IS NOT NULL)

END
 ' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueDateTime]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonAttributeValueDateTime](
	[intAttributeID] [int] NOT NULL,
	[intObjectID] [int] NOT NULL,
	[intSequence] [int] NOT NULL,
	[datValue] [datetime] NULL,
 CONSTRAINT [PK_tblEPiServerCommonAttributeValueDateTime] PRIMARY KEY CLUSTERED 
(
	[intAttributeID] ASC,
	[intObjectID] ASC,
	[intSequence] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueDateTime]') AND name = N'IX_tblEPiServerCommonAttributeValueDateTime_intAttributeID')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonAttributeValueDateTime_intAttributeID] ON [dbo].[tblEPiServerCommonAttributeValueDateTime] 
(
	[intAttributeID] ASC
)
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueDateTime]') AND name = N'IX_tblEPiServerCommonAttributeValueDateTime_intObjectID')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonAttributeValueDateTime_intObjectID] ON [dbo].[tblEPiServerCommonAttributeValueDateTime] 
(
	[intObjectID] ASC
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueInteger]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonAttributeValueInteger](
	[intAttributeID] [int] NOT NULL,
	[intObjectID] [int] NOT NULL,
	[intSequence] [int] NOT NULL,
	[intValue] [int] NULL,
 CONSTRAINT [PK_tblEPiServerCommonAttributeValueInteger] PRIMARY KEY CLUSTERED 
(
	[intAttributeID] ASC,
	[intObjectID] ASC,
	[intSequence] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueInteger]') AND name = N'IX_tblEPiServerCommonAttributeValueInteger_intAttributeID')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonAttributeValueInteger_intAttributeID] ON [dbo].[tblEPiServerCommonAttributeValueInteger] 
(
	[intAttributeID] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueInteger]') AND name = N'IX_tblEPiServerCommonAttributeValueInteger_intObjectID')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonAttributeValueInteger_intObjectID] ON [dbo].[tblEPiServerCommonAttributeValueInteger] 
(
	[intObjectID] ASC
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUserAdministrativeAccessRight]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonUserAdministrativeAccessRight](
	[intUserID] [int] NOT NULL,
	[intAccessRightSectionID] [int] NOT NULL,
	[intAccessLevel] [int] NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonUserAdministrativeAccessRight] PRIMARY KEY CLUSTERED 
(
	[intUserID] ASC,
	[intAccessRightSectionID] ASC
)
)
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonGroupAdministrativeAccessRight]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonGroupAdministrativeAccessRight](
	[intGroupID] [int] NOT NULL,
	[intAccessRightSectionID] [int] NOT NULL,
	[intAccessLevel] [int] NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonGroupAdministrativeAccessRight] PRIMARY KEY CLUSTERED 
(
	[intGroupID] ASC,
	[intAccessRightSectionID] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonGroupUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonGroupUser](
	[intGroupID] [int] NOT NULL,
	[intUserID] [int] NOT NULL
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonGroupUser]') AND name = N'IX_tblEPiServerCommonGroupUser')
CREATE CLUSTERED INDEX [IX_tblEPiServerCommonGroupUser] ON [dbo].[tblEPiServerCommonGroupUser] 
(
	[intGroupID] ASC
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAuthor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonAuthor](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[intObjectTypeID] [int] NOT NULL,
	[intEntityID] [int] NULL,
	[strAuthorName] [nvarchar](200) NULL,
	[strAuthorEmail] [varchar](1024) NULL,
	[strAuthorUrl] [varchar](1024) NULL,
	[blnReuse] [bit] NOT NULL DEFAULT ((0)),
	[intStatus] [smallint] NOT NULL, 
	[intPreviousStatus] [smallint] NOT NULL CONSTRAINT [DF_tblEPiServerCommonAuthor_intPreviousStatus]  DEFAULT ((0))
 CONSTRAINT [PK_tblEPiServerCommonAuthor] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAuthor]') AND name = N'IX_tblEPiServerCommonAuthor_intEntityID')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonAuthor_intEntityID] ON [dbo].[tblEPiServerCommonAuthor] 
(
	[intEntityID] ASC
)
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueChoiceInteger]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceInteger](
	[intAttributeID] [int] NOT NULL,
	[intValue] [int] NOT NULL,
	[strText] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonAttributeValueChoiceInteger] PRIMARY KEY CLUSTERED 
(
	[intAttributeID] ASC,
	[intValue] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueChoiceString]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceString](
	[intAttributeID] [int] NOT NULL,
	[strValue] [nvarchar](400) NOT NULL,
	[strText] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonAttributeValueChoiceString] PRIMARY KEY CLUSTERED 
(
	[intAttributeID] ASC,
	[strValue] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueChoiceDateTime]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceDateTime](
	[intAttributeID] [int] NOT NULL,
	[datValue] [datetime] NOT NULL,
	[strText] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonAttributeValueChoiceDateTime] PRIMARY KEY CLUSTERED 
(
	[intAttributeID] ASC,
	[datValue] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueChoiceFloat]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceFloat](
	[intAttributeID] [int] NOT NULL,
	[fltValue] [float] NOT NULL,
	[strText] [nvarchar](400) NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonAttributeValueChoiceFloat] PRIMARY KEY CLUSTERED 
(
	[intAttributeID] ASC,
	[fltValue] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonCategoryItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonCategoryItem](
	[intCategoryID] [int] NOT NULL,
	[intObjectID] [int] NOT NULL,
	[intObjectTypeID] [int] NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonCategoryItem] PRIMARY KEY CLUSTERED 
(
	[intObjectTypeID] ASC,
    [intObjectID] ASC,
    [intCategoryID] ASC
	
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonCategoryItem]') AND name = N'IX_tblEPiServerCommonCategoryItem_intObjectTypeID')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonCategoryItem_intObjectTypeID] ON [dbo].[tblEPiServerCommonCategoryItem] 
(
	[intObjectTypeID] ASC,
	[intObjectID] ASC
)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItemCountArchive]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonTagItemCountArchive](
	[intTagItemCountID] [int] NOT NULL,
	[datDate] [datetime] NOT NULL,
	[intStatus] [smallint] NOT NULL, 
	[intCount] [int] NOT NULL, 	
 CONSTRAINT [PK_tblEPiServerCommonTagItemCountArchive] PRIMARY KEY CLUSTERED 
(
	[intTagItemCountID] ASC,
	[datDate] ASC, 
	[intStatus] ASC
)
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonReport]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonReport](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[intReportCaseID] [int] NOT NULL,
	[strDescription] [nvarchar](max) NOT NULL,
	[strUrl] [nvarchar](2000) NULL,
	[intAuthorID] [int] NULL,
	[datCreated] [datetime] NOT NULL CONSTRAINT [DF_tblEPiServerCommonReport_datReportDate]  DEFAULT (getdate()), 
	[intStatus] [smallint] NOT NULL, 
	[intPreviousStatus] [smallint] NOT NULL CONSTRAINT [DF_tblEPiServerCommonReport_intPreviousStatus]  DEFAULT ((0)), 
 CONSTRAINT [PK_tblEPiServerCommonReport] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonReportCaseDecreaseReportCaseCounter]'))
EXEC dbo.sp_executesql @statement = N'
 

-- =============================================
-- Author:		<Per Ivansson>
-- Create date: <2007-12-27>
-- Description:	<Decreases the num reports counter with 1 in tblSarCommunityReportCase>
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonReportCaseDecreaseReportCaseCounter] 
   ON  [dbo].[tblEPiServerCommonReport] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prRegistration extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @intReportCaseID int
	SELECT @intReportCaseID=intReportCaseID FROM deleted

	UPDATE tblEPiServerCommonReportCase 
	SET intNumReports = intNumReports - 1
	WHERE intID = @intReportCaseID
END



' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonReportCaseIncreaseReportCaseCounter]'))
EXEC dbo.sp_executesql @statement = N'
 

-- =============================================
-- Author:		<Per Ivansson>
-- Create date: <2007-12-27>
-- Description:	<Increases the num reports counter with 1 in tblSarCommunityReportCase>
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonReportCaseIncreaseReportCaseCounter] 
   ON  [dbo].[tblEPiServerCommonReport] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prRegistration extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @intReportCaseID int
	SELECT @intReportCaseID=intReportCaseID FROM inserted

	UPDATE tblEPiServerCommonReportCase 
	SET intNumReports = intNumReports + 1
	WHERE intID = @intReportCaseID
END



' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonRatingLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonRatingLog](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[intObjectTypeID] [int] NOT NULL,
	[intObjectID] [int] NOT NULL,
	[intAuthorID] [int] NOT NULL,
	[fltRating] [float] NOT NULL,
	[datTimeStamp] [datetime] NOT NULL CONSTRAINT [DF_tblEPiServerCommonRatingLog_datTimeStamp]  DEFAULT (getdate()),
	[intStatus] [smallint] NOT NULL, 
 CONSTRAINT [PK_tblEPiServerCommonRatingLog] PRIMARY KEY NONCLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonRatingLog]') AND name = N'IX_tblEPiServerCommonRatingLog')
CREATE CLUSTERED INDEX [IX_tblEPiServerCommonRatingLog] ON [dbo].[tblEPiServerCommonRatingLog] 
(
	[intObjectTypeID] ASC,
	[intObjectID] ASC
)
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonRatingRemoveRatingAuthor]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-09-19
-- Description:	Deletes guest authors for the deleted objects
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonRatingRemoveRatingAuthor]
   ON  [dbo].[tblEPiServerCommonRatingLog] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM dbo.tblEPiServerCommonAuthor
	WHERE 
	blnReuse=0
	AND intID IN (SELECT intAuthorID FROM deleted WHERE intAuthorID IS NOT NULL)

END
 ' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trOnDeleteRecalculateValuesOnRatableItem]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Söderberg
-- Create date: 2007-06-12
-- Description:	Updates the values in tblEPiServerCommonRatableItem
-- =============================================
CREATE TRIGGER [dbo].[trOnDeleteRecalculateValuesOnRatableItem] 
   ON  [dbo].[tblEPiServerCommonRatingLog] FOR DELETE
AS 
BEGIN
SET NOCOUNT ON 

UPDATE tblEPiServerCommonRatableItem 
			SET intNumRatings = intNumRatings-del.intRemoved, 
				fltSumRatings = fltSumRatings - del.fltTotalRating, 
				intAvgRating = CASE intNumRatings WHEN del.intRemoved THEN 0 ELSE ((ROUND(((fltSumRatings - del.fltTotalRating)/(intNumRatings-del.intRemoved)), 1))*10 ) END
FROM tblEPiServerCommonRatableItem 
INNER JOIN (SELECT intObjectTypeID, intObjectID, SUM(fltRating) AS fltTotalRating, COUNT(*) AS intRemoved 
				FROM DELETED GROUP BY intObjectTypeID, intObjectID) del
ON tblEPiServerCommonRatableItem.intObjectTypeID = del.intObjectTypeID AND tblEPiServerCommonRatableItem.intObjectID = del.intObjectID

END
 ' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trOnInsertRecalculateValuesOnRatableItem]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Per SÃ¶derberg>
-- Create date: <2007-06-12>
-- Description:	<Updates the values in tblEPiServerCommonRatableItem>
-- =============================================
CREATE TRIGGER [dbo].[trOnInsertRecalculateValuesOnRatableItem]
   ON  [dbo].[tblEPiServerCommonRatingLog] FOR INSERT 
AS 
BEGIN 

SET NOCOUNT ON 

UPDATE tblEPiServerCommonRatableItem 
			SET intNumRatings = intNumRatings+ins.intInserted, 
				fltSumRatings = fltSumRatings + ins.fltTotalRating, 
				intAvgRating =  ((ROUND(((fltSumRatings + ins.fltTotalRating)/(intNumRatings+ins.intInserted)), 1))*10 )
FROM tblEPiServerCommonRatableItem 
INNER JOIN (SELECT intObjectTypeID, intObjectID, SUM(fltRating) AS fltTotalRating, COUNT(*) AS intInserted 
				FROM INSERTED GROUP BY intObjectTypeID, intObjectID) ins
ON tblEPiServerCommonRatableItem.intObjectTypeID = ins.intObjectTypeID AND tblEPiServerCommonRatableItem.intObjectID = ins.intObjectID

END
 ' 
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonVisitLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonVisitLog](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[intObjectTypeID] [int] NOT NULL,
	[intObjectID] [int] NOT NULL,
	[intAuthorID] [int] NULL,
	[datTimeStamp] [datetime] NOT NULL CONSTRAINT [DF_tblEPiServerCommonVisitLog_datTimeStamp]  DEFAULT (getdate()),
	[intStatus] [smallint] NOT NULL, 
 CONSTRAINT [PK_tblEPiServerCommonVisitLog] PRIMARY KEY NONCLUSTERED 
(
	[intID] ASC
)
)
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonVisitLog]') AND name = N'IX_tblEPiServerCommonVisitLog')
CREATE CLUSTERED INDEX IX_tblEPiServerCommonVisitLog ON dbo.tblEPiServerCommonVisitLog
	(
	intObjectTypeID,
	intObjectID,
	intAuthorID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonOnDeleteRecalculateValuesOnVisitableItem]'))
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Per Ivansson>
-- Create date: <2008-09-01>
-- Description:	<Updates the values in tblEPiServerCommonVisitsVisitableItem>
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonOnDeleteRecalculateValuesOnVisitableItem]
   ON  [dbo].[tblEPiServerCommonVisitLog] FOR DELETE 
AS 
BEGIN 

	SET NOCOUNT ON 

	UPDATE tblEPiServerCommonVisitableItem 
	SET intNumVisits = intNumVisits-del.intRemoved
					
	FROM tblEPiServerCommonVisitableItem 
	INNER JOIN (SELECT intObjectTypeID, intObjectID, COUNT(*) AS intRemoved 
					FROM DELETED GROUP BY intObjectTypeID, intObjectID) del
	ON tblEPiServerCommonVisitableItem.intObjectTypeID = del.intObjectTypeID AND tblEPiServerCommonVisitableItem.intObjectID = del.intObjectID


	--Set a new last visit ID
	UPDATE tblEPiServerCommonVisitableItem
	SET intLastVisitID = (SELECT TOP 1 intID FROM tblEPiServerCommonVisitLog 
							WHERE tblEPiServerCommonVisitLog.intObjectTypeID = DELETED.intObjectTypeID
							AND tblEPiServerCommonVisitLog.intObjectID = DELETED.intObjectID ORDER BY datTimeStamp DESC)

	FROM tblEPiServerCommonVisitableItem 
		INNER JOIN DELETED ON DELETED.intObjectTypeID = tblEPiServerCommonVisitableItem.intObjectTypeID 
			AND DELETED.intObjectID = tblEPiServerCommonVisitableItem.intObjectID

	

	--Remove visitable item if 0 visits
	DELETE FROM tblEPiServerCommonVisitableItem
	WHERE intNumVisits < 1
	AND EXISTS (SELECT * FROM DELETED WHERE tblEPiServerCommonVisitableItem.intObjectTypeID = DELETED.intObjectTypeID AND tblEPiServerCommonVisitableItem.intObjectID = DELETED.intObjectID)
END
' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonOnInsertRecalculateValuesOnVisitableItem]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Per Ivansson>
-- Create date: <2008-09-01>
-- Description:	<Updates the values in tblEPiServerCommonVisitsVisitableItem>
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonOnInsertRecalculateValuesOnVisitableItem]
   ON  [dbo].[tblEPiServerCommonVisitLog] FOR INSERT 
AS 
BEGIN 

SET NOCOUNT ON 

UPDATE tblEPiServerCommonVisitableItem 
SET intNumVisits = intNumVisits+ins.intInserted, 
intLastVisitID = ins.intID 
				
FROM tblEPiServerCommonVisitableItem 
INNER JOIN (SELECT intID, intObjectTypeID, intObjectID, COUNT(*) AS intInserted 
				FROM INSERTED GROUP BY intID, intObjectTypeID, intObjectID) ins
ON tblEPiServerCommonVisitableItem.intObjectTypeID = ins.intObjectTypeID AND tblEPiServerCommonVisitableItem.intObjectID = ins.intObjectID

END' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[trEPiServerCommonRemoveVisitAuthor]'))
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Description:	Deletes guest authors for the deleted objects
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonRemoveVisitAuthor]
   ON  [dbo].[tblEPiServerCommonVisitLog] 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM dbo.tblEPiServerCommonAuthor
	WHERE 
	blnReuse=0
	AND intID IN (SELECT intAuthorID FROM deleted WHERE intAuthorID IS NOT NULL)

END' 
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonComment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonComment](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[intObjectTypeID] [int] NOT NULL,
	[intObjectID] [int] NOT NULL,
	[intAuthorID] [int] NULL,
	[datCreated] [datetime] NOT NULL CONSTRAINT [DF_tblEPiServerCommonComment_datCreated]  DEFAULT (getdate()),
	[datModified] [datetime] NOT NULL CONSTRAINT [DF_tblEPiServerCommonComment_datModified]  DEFAULT (getdate()),
	[strHeader] [nvarchar](max) NULL,
	[strBody] [nvarchar](max) NOT NULL,
	[strLanguageID] [varchar](10) NULL,
	[intStatus] [smallint] NOT NULL, 
	[intPreviousStatus] [smallint] NOT NULL CONSTRAINT [DF_tblEPiServerCommonComment_intPreviousStatus]  DEFAULT ((0)), 
 CONSTRAINT [PK_tblEPiServerCommonComment] PRIMARY KEY NONCLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonComment]') AND name = N'IX_tblEPiServerCommonComment_1')
CREATE NONCLUSTERED INDEX [IX_tblEPiServerCommonComment_1] ON [dbo].[tblEPiServerCommonComment] 
(
	[intAuthorID] ASC
)
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonComment]') AND name = N'IX_tblEPiServerCommonComment_2')
CREATE CLUSTERED INDEX [IX_tblEPiServerCommonComment_2] ON [dbo].[tblEPiServerCommonComment] 
(
	[intObjectTypeID] ASC, 
	[intObjectID] ASC
)
GO

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[trEPiServerCommonRemoveCommentAuthor]') AND OBJECTPROPERTY(id, N'IsTrigger') = 1)
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Ivansson
-- Create date: 2009-02-17
-- Description:	Deletes guest authors for the deleted objects
-- =============================================
CREATE TRIGGER [dbo].[trEPiServerCommonRemoveCommentAuthor]
   ON  dbo.tblEPiServerCommonComment 
   AFTER DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM dbo.tblEPiServerCommonAuthor
	WHERE 
	blnReuse=0
	AND intID IN (SELECT intAuthorID FROM deleted WHERE intAuthorID IS NOT NULL)

END'
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonOpenIDUserRealm]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonOpenIDUserRealm](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strRealm] [varchar] (100) NOT NULL, 
	[intUserID] [int] NOT NULL, 
	[datCreated] [datetime] NOT NULL DEFAULT (getdate()), 
 CONSTRAINT [PK_tblEPiServerCommonOpenIDUserRealm] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonOpenIDUserRealm]') AND name = N'IX_tblEPiServerCommonOpenIDUserRealm')
CREATE UNIQUE NONCLUSTERED INDEX [IX_tblEPiServerCommonOpenIDUserRealm] ON [dbo].[tblEPiServerCommonOpenIDUserRealm] 
(
	[strRealm] ASC, 
	[intUserID] ASC 
)
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonRatableItem_tblEntityType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonRatableItem]'))
ALTER TABLE [dbo].[tblEPiServerCommonRatableItem]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonRatableItem_tblEntityType] FOREIGN KEY([intObjectTypeID])
REFERENCES [dbo].[tblEntityType] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonRatableItem] CHECK CONSTRAINT [FK_tblEPiServerCommonRatableItem_tblEntityType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonCategory_tblEPiServerCommonCategory_Parent]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonCategory]'))
ALTER TABLE [dbo].[tblEPiServerCommonCategory]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonCategory_tblEPiServerCommonCategory_Parent] FOREIGN KEY([intParentID])
REFERENCES [dbo].[tblEPiServerCommonCategory] ([intID])
GO
ALTER TABLE [dbo].[tblEPiServerCommonCategory] CHECK CONSTRAINT [FK_tblEPiServerCommonCategory_tblEPiServerCommonCategory_Parent]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagItem_tblEPiServerCommonAuthor]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItem]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagItem]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagItem_tblEPiServerCommonAuthor] FOREIGN KEY([intAuthorID])
REFERENCES [dbo].[tblEPiServerCommonAuthor] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagItem] CHECK CONSTRAINT [FK_tblEPiServerCommonTagItem_tblEPiServerCommonAuthor]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagItem_tblEntityType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItem]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagItem]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagItem_tblEntityType] FOREIGN KEY([intObjectTypeID])
REFERENCES [dbo].[tblEntityType] ([intID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagItem] CHECK CONSTRAINT [FK_tblEPiServerCommonTagItem_tblEntityType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagItem_tblEPiServerCommonCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItem]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagItem]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagItem_tblEPiServerCommonCategory] FOREIGN KEY([intCategoryID])
REFERENCES [dbo].[tblEPiServerCommonCategory] ([intID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagItem] CHECK CONSTRAINT [FK_tblEPiServerCommonTagItem_tblEPiServerCommonCategory]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagItem_tblTag]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItem]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagItem]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagItem_tblTag] FOREIGN KEY([intTagID])
REFERENCES [dbo].[tblEPiServerCommonTag] ([intID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagItem] CHECK CONSTRAINT [FK_tblEPiServerCommonTagItem_tblTag]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonAttributeValueFloat_tblEPiServerCommonAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueFloat]'))
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueFloat]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonAttributeValueFloat_tblEPiServerCommonAttribute] FOREIGN KEY([intAttributeID])
REFERENCES [dbo].[tblEPiServerCommonAttribute] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueFloat] CHECK CONSTRAINT [FK_tblEPiServerCommonAttributeValueFloat_tblEPiServerCommonAttribute]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonAttributeValueString_tblEPiServerCommonAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueString]'))
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueString]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonAttributeValueString_tblEPiServerCommonAttribute] FOREIGN KEY([intAttributeID])
REFERENCES [dbo].[tblEPiServerCommonAttribute] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueString] CHECK CONSTRAINT [FK_tblEPiServerCommonAttributeValueString_tblEPiServerCommonAttribute]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagPredefinedTag_tblEPiServerCommonAuthor]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagPredefinedTag]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagPredefinedTag]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagPredefinedTag_tblEPiServerCommonAuthor] FOREIGN KEY([intAuthorID])
REFERENCES [dbo].[tblEPiServerCommonAuthor] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagPredefinedTag] CHECK CONSTRAINT [FK_tblEPiServerCommonTagPredefinedTag_tblEPiServerCommonAuthor]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagPredefinedTag_tblEntityType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagPredefinedTag]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagPredefinedTag]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagPredefinedTag_tblEntityType] FOREIGN KEY([intObjectTypeID])
REFERENCES [dbo].[tblEntityType] ([intID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagPredefinedTag] CHECK CONSTRAINT [FK_tblEPiServerCommonTagPredefinedTag_tblEntityType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagPredefinedTag_tblTag]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagPredefinedTag]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagPredefinedTag]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagPredefinedTag_tblTag] FOREIGN KEY([intTagID])
REFERENCES [dbo].[tblEPiServerCommonTag] ([intID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagPredefinedTag] CHECK CONSTRAINT [FK_tblEPiServerCommonTagPredefinedTag_tblTag]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagItemCount_tblEPiServerCommonAuthor]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItemCount]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagItemCount]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagItemCount_tblEPiServerCommonAuthor] FOREIGN KEY([intAuthorID])
REFERENCES [dbo].[tblEPiServerCommonAuthor] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagItemCount] CHECK CONSTRAINT [FK_tblEPiServerCommonTagItemCount_tblEPiServerCommonAuthor]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagItemCount_tblEntityType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItemCount]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagItemCount]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagItemCount_tblEntityType] FOREIGN KEY([intObjectTypeID])
REFERENCES [dbo].[tblEntityType] ([intID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagItemCount] CHECK CONSTRAINT [FK_tblEPiServerCommonTagItemCount_tblEntityType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagItemCount_tblEPiServerCommonCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItemCount]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagItemCount]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagItemCount_tblEPiServerCommonCategory] FOREIGN KEY([intCategoryID])
REFERENCES [dbo].[tblEPiServerCommonCategory] ([intID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagItemCount] CHECK CONSTRAINT [FK_tblEPiServerCommonTagItemCount_tblEPiServerCommonCategory]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagItemCount_tblTag]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItemCount]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagItemCount]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagItemCount_tblTag] FOREIGN KEY([intTagID])
REFERENCES [dbo].[tblEPiServerCommonTag] ([intID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagItemCount] CHECK CONSTRAINT [FK_tblEPiServerCommonTagItemCount_tblTag]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonAttributeValueDateTime_tblEPiServerCommonAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueDateTime]'))
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueDateTime]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonAttributeValueDateTime_tblEPiServerCommonAttribute] FOREIGN KEY([intAttributeID])
REFERENCES [dbo].[tblEPiServerCommonAttribute] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueDateTime] CHECK CONSTRAINT [FK_tblEPiServerCommonAttributeValueDateTime_tblEPiServerCommonAttribute]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonAttributeValueInteger_tblEPiServerCommonAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueInteger]'))
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueInteger]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonAttributeValueInteger_tblEPiServerCommonAttribute] FOREIGN KEY([intAttributeID])
REFERENCES [dbo].[tblEPiServerCommonAttribute] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueInteger] CHECK CONSTRAINT [FK_tblEPiServerCommonAttributeValueInteger_tblEPiServerCommonAttribute]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonUserAdministrativeAccessRight_tblEPiServerCommonAccessRightSection]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUserAdministrativeAccessRight]'))
ALTER TABLE [dbo].[tblEPiServerCommonUserAdministrativeAccessRight]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonUserAdministrativeAccessRight_tblEPiServerCommonAccessRightSection] FOREIGN KEY([intAccessRightSectionID])
REFERENCES [dbo].[tblEPiServerCommonAccessRightSection] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonUserAdministrativeAccessRight] CHECK CONSTRAINT [FK_tblEPiServerCommonUserAdministrativeAccessRight_tblEPiServerCommonAccessRightSection]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonGroupAdministrativeAccessRight_tblEPiServerCommonAccessRightSection]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonGroupAdministrativeAccessRight]'))
ALTER TABLE [dbo].[tblEPiServerCommonGroupAdministrativeAccessRight]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonGroupAdministrativeAccessRight_tblEPiServerCommonAccessRightSection] FOREIGN KEY([intAccessRightSectionID])
REFERENCES [dbo].[tblEPiServerCommonAccessRightSection] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonGroupAdministrativeAccessRight] CHECK CONSTRAINT [FK_tblEPiServerCommonGroupAdministrativeAccessRight_tblEPiServerCommonAccessRightSection]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonGroupUser_tblEPiServerCommonGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonGroupUser]'))
ALTER TABLE [dbo].[tblEPiServerCommonGroupUser]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonGroupUser_tblEPiServerCommonGroup] FOREIGN KEY([intGroupID])
REFERENCES [dbo].[tblEPiServerCommonGroup] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonGroupUser] CHECK CONSTRAINT [FK_tblEPiServerCommonGroupUser_tblEPiServerCommonGroup]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonGroupUser_tblEPiServerCommonUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonGroupUser]'))
ALTER TABLE [dbo].[tblEPiServerCommonGroupUser]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonGroupUser_tblEPiServerCommonUser] FOREIGN KEY([intUserID])
REFERENCES [dbo].[tblEPiServerCommonUser] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonGroupUser] CHECK CONSTRAINT [FK_tblEPiServerCommonGroupUser_tblEPiServerCommonUser]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonAttributeValueChoiceInteger_tblEPiServerCommonAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueChoiceInteger]'))
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceInteger]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonAttributeValueChoiceInteger_tblEPiServerCommonAttribute] FOREIGN KEY([intAttributeID])
REFERENCES [dbo].[tblEPiServerCommonAttribute] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceInteger] CHECK CONSTRAINT [FK_tblEPiServerCommonAttributeValueChoiceInteger_tblEPiServerCommonAttribute]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonAttributeValueChoiceString_tblEPiServerCommonAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueChoiceString]'))
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceString]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonAttributeValueChoiceString_tblEPiServerCommonAttribute] FOREIGN KEY([intAttributeID])
REFERENCES [dbo].[tblEPiServerCommonAttribute] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceString] CHECK CONSTRAINT [FK_tblEPiServerCommonAttributeValueChoiceString_tblEPiServerCommonAttribute]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonAttributeValueChoiceDateTime_tblEPiServerCommonAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueChoiceDateTime]'))
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceDateTime]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonAttributeValueChoiceDateTime_tblEPiServerCommonAttribute] FOREIGN KEY([intAttributeID])
REFERENCES [dbo].[tblEPiServerCommonAttribute] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceDateTime] CHECK CONSTRAINT [FK_tblEPiServerCommonAttributeValueChoiceDateTime_tblEPiServerCommonAttribute]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonAttributeValueChoiceFloat_tblEPiServerCommonAttribute]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonAttributeValueChoiceFloat]'))
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceFloat]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonAttributeValueChoiceFloat_tblEPiServerCommonAttribute] FOREIGN KEY([intAttributeID])
REFERENCES [dbo].[tblEPiServerCommonAttribute] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonAttributeValueChoiceFloat] CHECK CONSTRAINT [FK_tblEPiServerCommonAttributeValueChoiceFloat_tblEPiServerCommonAttribute]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonCategoryItem_tblEPiServerCommonCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonCategoryItem]'))
ALTER TABLE [dbo].[tblEPiServerCommonCategoryItem]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonCategoryItem_tblEPiServerCommonCategory] FOREIGN KEY([intCategoryID])
REFERENCES [dbo].[tblEPiServerCommonCategory] ([intID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonCategoryItem] CHECK CONSTRAINT [FK_tblEPiServerCommonCategoryItem_tblEPiServerCommonCategory]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonCategoryItem_tblEntityType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonCategoryItem]'))
ALTER TABLE [dbo].[tblEPiServerCommonCategoryItem]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonCategoryItem_tblEntityType] FOREIGN KEY([intObjectTypeID])
REFERENCES [dbo].[tblEntityType] ([intID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonCategoryItem] CHECK CONSTRAINT [FK_tblEPiServerCommonCategoryItem_tblEntityType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonTagItemCountArchive_tblEPiServerCommonTagItemCount]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonTagItemCountArchive]'))
ALTER TABLE [dbo].[tblEPiServerCommonTagItemCountArchive]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonTagItemCountArchive_tblEPiServerCommonTagItemCount] FOREIGN KEY([intTagItemCountID])
REFERENCES [dbo].[tblEPiServerCommonTagItemCount] ([intID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonTagItemCountArchive] CHECK CONSTRAINT [FK_tblEPiServerCommonTagItemCountArchive_tblEPiServerCommonTagItemCount]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonReport_tblEPiServerCommonReportMatter]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonReport]'))
ALTER TABLE [dbo].[tblEPiServerCommonReport]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonReport_tblEPiServerCommonReportMatter] FOREIGN KEY([intReportCaseID])
REFERENCES [dbo].[tblEPiServerCommonReportCase] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonReport] CHECK CONSTRAINT [FK_tblEPiServerCommonReport_tblEPiServerCommonReportMatter]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonRatableItem_tblEPiServerCommonRatingLog]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonRatingLog]'))
ALTER TABLE [dbo].[tblEPiServerCommonRatingLog]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonRatableItem_tblEPiServerCommonRatingLog] FOREIGN KEY([intObjectTypeID], [intObjectID])
REFERENCES [dbo].[tblEPiServerCommonRatableItem] ([intObjectTypeID], [intObjectID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonRatingLog] CHECK CONSTRAINT [FK_tblEPiServerCommonRatableItem_tblEPiServerCommonRatingLog]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonVisitLog_tblEPiServerCommonVisitableItem]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonVisitLog]'))
ALTER TABLE [dbo].[tblEPiServerCommonVisitLog]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonVisitLog_tblEPiServerCommonVisitableItem] FOREIGN KEY([intObjectTypeID], [intObjectID])
REFERENCES [dbo].[tblEPiServerCommonVisitableItem] ([intObjectTypeID], [intObjectID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonVisitLog] CHECK CONSTRAINT [FK_tblEPiServerCommonVisitLog_tblEPiServerCommonVisitableItem]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwEPiServerCommonAuthor]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vwEPiServerCommonAuthor]
AS
SELECT     a.intID, a.intObjectTypeID, a.intEntityID, COALESCE(u.strAlias, a.strAuthorName) AS strAuthorName, COALESCE(u.strEmail, a.strAuthorEmail) AS strAuthorEmail, 
                      a.strAuthorUrl, a.intStatus
FROM         dbo.tblEPiServerCommonAuthor AS a 
LEFT OUTER JOIN dbo.tblEPiServerCommonUser AS u 
	ON a.intEntityID = u.intID AND a.intObjectTypeID IN 
		(SELECT intID FROM tblEntityType WHERE strName IN (''EPiServer.Common.UserAuthor, EPiServer.Common.Framework.Impl''))
'
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonOwnership_tblEntityType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonOwnership]'))
ALTER TABLE [dbo].[tblEPiServerCommonOwnership]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonOwnership_tblEntityType] FOREIGN KEY([intObjectTypeID])
REFERENCES [dbo].[tblEntityType] ([intID])
GO
ALTER TABLE [dbo].[tblEPiServerCommonOwnership] CHECK CONSTRAINT [FK_tblEPiServerCommonOwnership_tblEntityType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonOwnership_tblEntityType1]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonOwnership]'))
ALTER TABLE [dbo].[tblEPiServerCommonOwnership]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonOwnership_tblEntityType1] FOREIGN KEY([intOwnerTypeID])
REFERENCES [dbo].[tblEntityType] ([intID])
GO
ALTER TABLE [dbo].[tblEPiServerCommonOwnership] CHECK CONSTRAINT [FK_tblEPiServerCommonOwnership_tblEntityType1]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonOwnership_tblEPiServerCommonOwnerContext]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonOwnership]'))

ALTER TABLE [dbo].[tblEPiServerCommonOwnership]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonOwnership_tblEPiServerCommonOwnerContext] FOREIGN KEY([intOwnerContextID])
REFERENCES [dbo].[tblEPiServerCommonOwnerContext] ([intID])
GO
ALTER TABLE [dbo].[tblEPiServerCommonOwnership] CHECK CONSTRAINT [FK_tblEPiServerCommonOwnership_tblEPiServerCommonOwnerContext]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEntityGroupAccessRights_tblEPiServerCommonGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEntityGroupAccessRights]'))
ALTER TABLE [dbo].[tblEPiServerCommonEntityGroupAccessRights]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonEntityGroupAccessRights_tblEPiServerCommonGroup] FOREIGN KEY([intGroupID])
REFERENCES [dbo].[tblEPiServerCommonGroup] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonEntityGroupAccessRights] CHECK CONSTRAINT [FK_tblEPiServerCommonEntityGroupAccessRights_tblEPiServerCommonGroup]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEntityGroupAccessRights_tblEntityType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEntityGroupAccessRights]'))
ALTER TABLE [dbo].[tblEPiServerCommonEntityGroupAccessRights]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonEntityGroupAccessRights_tblEntityType] FOREIGN KEY([intEntityTypeID])
REFERENCES [dbo].[tblEntityType] ([intID])
GO
ALTER TABLE [dbo].[tblEPiServerCommonEntityGroupAccessRights] CHECK CONSTRAINT [FK_tblEPiServerCommonEntityGroupAccessRights_tblEntityType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEntityUserAccessRights_tblEntityType]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEntityUserAccessRights]'))
ALTER TABLE [dbo].[tblEPiServerCommonEntityUserAccessRights]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonEntityUserAccessRights_tblEntityType] FOREIGN KEY([intEntityTypeID])
REFERENCES [dbo].[tblEntityType] ([intID])
GO
ALTER TABLE [dbo].[tblEPiServerCommonEntityUserAccessRights] CHECK CONSTRAINT [FK_tblEPiServerCommonEntityUserAccessRights_tblEntityType]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEntityUserAccessRights_tblEPiServerCommonUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEntityUserAccessRights]'))
ALTER TABLE [dbo].[tblEPiServerCommonEntityUserAccessRights]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonEntityUserAccessRights_tblEPiServerCommonUser] FOREIGN KEY([intUserID])
REFERENCES [dbo].[tblEPiServerCommonUser] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonEntityUserAccessRights] CHECK CONSTRAINT [FK_tblEPiServerCommonEntityUserAccessRights_tblEPiServerCommonUser]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonUserOpenID_tblEPiServerCommonUser]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonUserOpenID]'))
ALTER TABLE [dbo].[tblEPiServerCommonUserOpenID]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonUserOpenID_tblEPiServerCommonUser] FOREIGN KEY([intUserID])
REFERENCES [dbo].[tblEPiServerCommonUser] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonUserOpenID] CHECK CONSTRAINT [FK_tblEPiServerCommonUserOpenID_tblEPiServerCommonUser]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonEventCounterEventLog](
	[intAction] [smallint] NOT NULL,
	[strEventName] [nvarchar](200) NOT NULL,
	[intEventGroupID] [int] NOT NULL,
	[datTimeStamp] [datetime] NOT NULL CONSTRAINT [DF_tblStarStatsEventLog_datTimeStamp]  DEFAULT (getdate()),
	[blnSelectedByJob] [bit] NOT NULL DEFAULT ((0)),
	[intCategoryID] [int] NULL
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventHour]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonEventCounterEventHour](
	[intAction] [smallint] NOT NULL,
	[strEventName] [varchar](400) NOT NULL,
	[intEventGroupID] [int] NOT NULL,
	[intCategoryID] [int] NULL,
	[intCount] [int] NOT NULL,
	[datTimeStamp] [smalldatetime] NOT NULL
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventDay]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonEventCounterEventDay](
	[intAction] [smallint] NOT NULL,
	[strEventName] [varchar](400) NOT NULL,
	[intEventGroupID] [int] NOT NULL,
	[intCategoryID] [int] NULL,
	[intCount] [int] NOT NULL,
	[datTimeStamp] [smalldatetime] NOT NULL
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventName]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonEventCounterEventName](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strEventName] [varchar](400) NOT NULL,
	[strDescription] [nvarchar](400) NOT NULL,
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterJobLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonEventCounterJobLog](
	[intJobTypeID] [int] NOT NULL,
	[intJobFrequencyID] [int] NOT NULL,
	[intLastRunTime] [int] NOT NULL,
	[intDay] [int] NOT NULL,
	[intMonth] [int] NOT NULL,
	[intQuarter] [int] NOT NULL,
	[intYear] [int] NOT NULL,
	[datTimeStamp] [datetime] NULL CONSTRAINT [DF_tblStarStatsJobLog_datTimeStamp]  DEFAULT (getdate())
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventMonth]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonEventCounterEventMonth](
	[intAction] [smallint] NOT NULL,
	[strEventName] [varchar](400) NOT NULL,
	[intEventGroupID] [int] NOT NULL,
	[intCategoryID] [int] NULL,
	[intCount] [int] NOT NULL,
	[datTimeStamp] [smalldatetime] NOT NULL
)
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[tblEPiServerCommonEventGroup](
	[intID] [int] IDENTITY(1,1) NOT NULL,
	[strName] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_tblEPiServerCommonEventGroup] PRIMARY KEY CLUSTERED 
(
	[intID] ASC
)
)
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEventCounterEventDay_tblEPiServerCommonCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventDay]'))
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventDay] ADD CONSTRAINT [FK_tblEPiServerCommonEventCounterEventDay_tblEPiServerCommonCategory] FOREIGN KEY ([intCategoryID])
REFERENCES [dbo].[tblEPiServerCommonCategory] ([intID])
ON UPDATE CASCADE
ON DELETE  CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventDay] CHECK CONSTRAINT [FK_tblEPiServerCommonEventCounterEventDay_tblEPiServerCommonCategory]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEventCounterEventDay_tblEPiServerCommonEventGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventDay]'))
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventDay]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonEventCounterEventDay_tblEPiServerCommonEventGroup] FOREIGN KEY([intEventGroupID])
REFERENCES [dbo].[tblEPiServerCommonEventGroup] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventDay] CHECK CONSTRAINT [FK_tblEPiServerCommonEventCounterEventDay_tblEPiServerCommonEventGroup]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEventCounterEventHour_tblEPiServerCommonCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventHour]'))
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventHour] ADD CONSTRAINT [FK_tblEPiServerCommonEventCounterEventHour_tblEPiServerCommonCategory] FOREIGN KEY ([intCategoryID])
REFERENCES [dbo].[tblEPiServerCommonCategory] ([intID])
ON UPDATE CASCADE
ON DELETE  CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventHour] CHECK CONSTRAINT [FK_tblEPiServerCommonEventCounterEventHour_tblEPiServerCommonCategory]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEventCounterEventHour_tblEPiServerCommonEventGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventHour]'))
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventHour]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonEventCounterEventHour_tblEPiServerCommonEventGroup] FOREIGN KEY([intEventGroupID])
REFERENCES [dbo].[tblEPiServerCommonEventGroup] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventHour] CHECK CONSTRAINT [FK_tblEPiServerCommonEventCounterEventHour_tblEPiServerCommonEventGroup]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEventCounterEventLog_tblEPiServerCommonCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventLog]'))
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventLog] ADD CONSTRAINT [FK_tblEPiServerCommonEventCounterEventLog_tblEPiServerCommonCategory] FOREIGN KEY ([intCategoryID])
REFERENCES [dbo].[tblEPiServerCommonCategory] ([intID])
ON UPDATE CASCADE
ON DELETE  CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventLog] CHECK CONSTRAINT [FK_tblEPiServerCommonEventCounterEventLog_tblEPiServerCommonCategory]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEventCounterEventLog_tblEPiServerCommonEventGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventLog]'))
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventLog]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonEventCounterEventLog_tblEPiServerCommonEventGroup] FOREIGN KEY([intEventGroupID])
REFERENCES [dbo].[tblEPiServerCommonEventGroup] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventLog] CHECK CONSTRAINT [FK_tblEPiServerCommonEventCounterEventLog_tblEPiServerCommonEventGroup]
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEventCounterEventMonth_tblEPiServerCommonCategory]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventMonth]'))
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventMonth] ADD CONSTRAINT [FK_tblEPiServerCommonEventCounterEventMonth_tblEPiServerCommonCategory] FOREIGN KEY ([intCategoryID])
REFERENCES [dbo].[tblEPiServerCommonCategory] ([intID])
ON UPDATE CASCADE
ON DELETE  CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventMonth] CHECK CONSTRAINT [FK_tblEPiServerCommonEventCounterEventMonth_tblEPiServerCommonCategory]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_tblEPiServerCommonEventCounterEventMonth_tblEPiServerCommonEventGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[tblEPiServerCommonEventCounterEventMonth]'))
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventMonth]  WITH CHECK ADD  CONSTRAINT [FK_tblEPiServerCommonEventCounterEventMonth_tblEPiServerCommonEventGroup] FOREIGN KEY([intEventGroupID])
REFERENCES [dbo].[tblEPiServerCommonEventGroup] ([intID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tblEPiServerCommonEventCounterEventMonth] CHECK CONSTRAINT [FK_tblEPiServerCommonEventCounterEventMonth_tblEPiServerCommonEventGroup]
GO
/* BEGIN DEFAULT CONFIGURATION INSERT */

-- Create Admin Access Sections
SET IDENTITY_INSERT tblEPiServerCommonAccessRightSection ON

INSERT INTO tblEPiServerCommonAccessRightSection (intID, strName) VALUES (1, 'EPiServerCommon')
INSERT INTO tblEPiServerCommonAccessRightSection (intID, strName) VALUES (2, 'System Settings')
INSERT INTO tblEPiServerCommonAccessRightSection (intID, strName) VALUES (11, 'Security')

SET IDENTITY_INSERT tblEPiServerCommonAccessRightSection OFF

-- Create Admin and Anonymous Groups
SET IDENTITY_INSERT tblEPiServerCommonGroup ON

INSERT INTO tblEPiServerCommonGroup (intID, strName, intStatus) VALUES (1, 'Administrators', 1)
INSERT INTO tblEPiServerCommonGroup (intID, strName, intStatus) VALUES (2, 'Anonymous', 1)

SET IDENTITY_INSERT tblEPiServerCommonGroup OFF

-- Set Admin Access for Admin Group
INSERT INTO tblEPiServerCommonGroupAdministrativeAccessRight (intGroupID, intAccessRightSectionID, intAccessLevel) VALUES (1, 1, 1)
INSERT INTO tblEPiServerCommonGroupAdministrativeAccessRight (intGroupID, intAccessRightSectionID, intAccessLevel) VALUES (1, 2, 3)
INSERT INTO tblEPiServerCommonGroupAdministrativeAccessRight (intGroupID, intAccessRightSectionID, intAccessLevel) VALUES (1, 11, 15)
GO

/* END DEFAULT CONFIGURATION INSERT */



-- Set Version Key
IF NOT EXISTS(SELECT * FROM tblEPiServerCommonSetting WHERE strKey = 'EPiServerCommon_version')
	INSERT INTO tblEPiServerCommonSetting (strKey, strValue) VALUES('EPiServerCommon_version', '7.5.0.0')
ELSE
	UPDATE tblEPiServerCommonSetting SET strValue = '7.5.0.0' WHERE strKey = 'EPiServerCommon_version'
GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUserCount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonGetUserCount]
AS
SELECT COUNT(*) FROM tblEPiServerCommonUser WITH(NOLOCK) WHERE intStatus = 1
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUserByUserName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonGetUserByUserName]
@strUserName nvarchar(100),
@intStatus smallint
AS
SELECT intID FROM tblEPiServerCommonUser WHERE strUserName = @strUserName AND ((intStatus & @intStatus) != 0)
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveAccessRights]

@strTableName varchar(256),
@intObjectID int,
@intOwnerID int

AS

EXECUTE(''
DELETE FROM '' + @strTableName + '' WHERE
intObjectID = '' + @intObjectID + '' AND intOwnerID = '' + @intOwnerID
)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveAllAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveAllAccessRights]

@strUserTableName varchar(256),
@strGroupTableName varchar(256),
@intObjectID int

AS

EXECUTE(''
DELETE FROM '' + @strUserTableName + '' WHERE
intObjectID = '' + @intObjectID
)

EXECUTE(''
DELETE FROM '' + @strGroupTableName + '' WHERE
intObjectID = '' + @intObjectID
)
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveUser]
@intUserID int
AS

DELETE FROM tblEPiServerCommonUser WHERE intID = @intUserID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonSetAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonSetAccessRights]

@strTableName varchar(256),
@intObjectID int,
@intOwnerID int,
@intAccessLevel int

AS

DECLARE @strQuery varchar(4000)

EXECUTE(''

IF EXISTS(SELECT intAccessLevel FROM '' + @strTableName + '' WHERE
intObjectID = '' + @intObjectID + '' AND intOwnerID =  '' + @intOwnerID + '')

BEGIN

UPDATE '' + @strTableName + '' SET intAccessLevel = '' + @intAccessLevel + ''
WHERE intObjectID = '' + @intObjectID + '' AND intOwnerID = '' + @intOwnerID + ''

END
ELSE
BEGIN

INSERT INTO '' + @strTableName + '' (intObjectID, intOwnerID, intAccessLevel)
VALUES ('' + @intObjectID + '', '' + @intOwnerID + '',  '' + @intAccessLevel + '')

END'')
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUserExist]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonGetUserExist]
@intID Int
AS
IF EXISTS(SELECT intID FROM tblEPiServerCommonUser WHERE intID = @intID)
	SELECT CONVERT(bit, 1)
ELSE
	SELECT CONVERT(bit, 0)
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonGetAccessRights]

@strTableName varchar(256),
@intObjectID int,
@intOwnerID int

AS

EXECUTE(''
SELECT intAccessLevel FROM '' + @strTableName + '' WHERE
intObjectID = '' + @intObjectID + '' AND intOwnerID = '' + @intOwnerID
)
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetAccessOwnersForObject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- Gets the users or the groups that have access rights to a specified object
CREATE PROCEDURE [dbo].[spEPiServerCommonGetAccessOwnersForObject]

@strTableName varchar(256),
@intObjectID int

AS

EXECUTE(''
SELECT intOwnerID FROM '' + @strTableName + '' WHERE
intObjectID = '' + @intObjectID
)
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingGetUserReportStatsByUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Gets a user reports. numbers of reports for different status and first and last date of report
-- =============================================

CREATE PROCEDURE [dbo].[spEPiServerCommonReportingGetUserReportStatsByUser] 
@intUserID INT,
@xmlCategories XML
AS
SET NOCOUNT ON

DECLARE @isCollectionEmpty BIT

IF (@xmlCategories IS NOT NULL)
BEGIN
	IF NOT EXISTS (SELECT * FROM @xmlCategories.nodes(''/collection/item'') AS T(c))
		SET @isCollectionEmpty = 1
	ELSE
		SET @isCollectionEmpty = 0
END


DECLARE @strQuery NVARCHAR(MAX)
DECLARE @strArgumentList NVARCHAR(200)

SET @strArgumentList = ''@intUserID INT, @xmlCategories XML''

SET @strQuery = ''SELECT author.intEntityID,
                         SUM(CASE WHEN reportcase.intReportCaseStatus = 1 THEN 1 ELSE 0 END) AS intNumNewReports,
                         SUM(CASE WHEN reportcase.intReportCaseStatus = 2 THEN 1 ELSE 0 END) AS intNumIgnoredReports,
                         SUM(CASE WHEN reportcase.intReportCaseStatus = 3 THEN 1 ELSE 0 END) AS intNumHandledReports,
                         MIN(report.datCreated) AS datFirstReport, MAX(report.datCreated) AS datLastReport
FROM tblEPiServerCommonReport AS report  
INNER JOIN tblEPiServerCommonAuthor AS author ON report.intAuthorID=author.intID  
INNER JOIN tblEPiServerCommonReportCase AS reportcase ON report.intReportCaseID=reportcase.intID  
AND author.intObjectTypeID IN (SELECT intID FROM tblEntityType WHERE strName IN (''''EPiServer.Common.UserAuthor, EPiServer.Common.Framework.Impl'''',
                               ''''EPiServer.Common.AnonymousAuthor, EPiServer.Common.Framework.Impl''''))
AND author.intEntityID=@intUserID''


IF @xmlCategories IS NOT NULL
BEGIN
    IF @isCollectionEmpty = 1
	BEGIN
        SET @strQuery = @strQuery + '' AND NOT EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
                                         (catItem.intObjectTypeID = reportcase.intObjectTypeID AND catItem.intObjectID = reportcase.intObjectID)) ''
	END
    ELSE
    BEGIN
        SET @strQuery = @strQuery + '' AND EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
                                         (catItem.intObjectTypeID = reportcase.intObjectTypeID AND catItem.intObjectID = reportcase.intObjectID
                                         AND catItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCategories.nodes(''''/collection/item'''') AS T(c)) )) ''
    END
END


SET @strQuery = @strQuery + '' GROUP BY author.intEntityID''

EXEC sp_executesql @strQuery, @strArgumentList, @intUserID, @xmlCategories
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingGetUserReportStatsOnUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Gets a user reports. numbers of reports for different status and first and last date of report
-- =============================================

CREATE PROCEDURE [dbo].[spEPiServerCommonReportingGetUserReportStatsOnUser] 
@intUserID INT,
@xmlCategories XML
AS
SET NOCOUNT ON

DECLARE @isCollectionEmpty BIT

IF (@xmlCategories IS NOT NULL)
BEGIN
	IF NOT EXISTS (SELECT * FROM @xmlCategories.nodes(''/collection/item'') AS T(c))
		SET @isCollectionEmpty = 1
	ELSE
		SET @isCollectionEmpty = 0
END


DECLARE @strQuery NVARCHAR(MAX)
DECLARE @strArgumentList NVARCHAR(200)

SET @strArgumentList = ''@intUserID INT, @xmlCategories XML''


SET @strQuery = ''SELECT author.intEntityID, SUM(CASE WHEN reportcase.intReportCaseStatus = 1 THEN 1 ELSE 0 END) AS intNumNewReports, SUM(CASE WHEN reportcase.intReportCaseStatus=2 THEN 1 ELSE 0 END) AS intNumIgnoredReports, SUM(CASE WHEN reportcase.intReportCaseStatus=3 THEN 1 ELSE 0 END) AS intNumHandledReports, MIN(report.datCreated) AS datFirstReport, MAX(report.datCreated) AS datLastReport 
FROM tblEPiServerCommonReport AS report  
INNER JOIN tblEPiServerCommonReportCase AS reportcase ON report.intReportCaseID=reportcase.intID 
INNER JOIN tblEPiServerCommonAuthor AS author ON author.intID=reportcase.intReportDataAuthorID  
WHERE author.intObjectTypeID IN (SELECT intID FROM tblEntityType WHERE strName IN (''''EPiServer.Common.UserAuthor, EPiServer.Common.Framework.Impl'''',
                                 ''''EPiServer.Common.AnonymousAuthor, EPiServer.Common.Framework.Impl''''))
AND author.intEntityID=@intUserID ''


IF @xmlCategories IS NOT NULL
BEGIN
    IF @isCollectionEmpty = 1
    BEGIN
        SET @strQuery = @strQuery + '' AND NOT EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
                                         (catItem.intObjectTypeID = reportcase.intObjectTypeID AND catItem.intObjectID = reportcase.intObjectID)) ''   
    END
    ELSE
    BEGIN
        SET @strQuery = @strQuery + '' AND EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
                                         (catItem.intObjectTypeID = reportcase.intObjectTypeID AND catItem.intObjectID = reportcase.intObjectID
                                         AND catItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCategories.nodes(''''/collection/item'''') AS T(c)) )) ''
    END
END


SET @strQuery = @strQuery + '' GROUP BY author.intEntityID''

EXEC sp_executesql @strQuery, @strArgumentList, @intUserID, @xmlCategories
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingGetReportingUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Gets report cases
-- =============================================

CREATE PROCEDURE [dbo].[spEPiServerCommonReportingGetReportingUsers]
@xmlCategories XML,
@intPage INT,
@intPageSize INT,
@strOrderBy VARCHAR(2000)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @isCollectionEmpty BIT

	IF (@xmlCategories IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCategories.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END



	DECLARE @strParamList NVARCHAR(256)
	DECLARE @strQuery NVARCHAR(MAX)
	DECLARE @intStartRec INT
	DECLARE @intEndRec INT
	
	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)

	SET @strParamList = ''@intStartRec int, 
						@intEndRec int,
						@xmlCategories XML''

	IF @strOrderBy IS NULL
	BEGIN
		SET @strOrderBy = ''SUM(CASE WHEN reportcase.intReportCaseStatus = 1 THEN 1 ELSE 0 END) desc''
	END

	SET @strQuery = ''SELECT intEntityID, intNumNewReports, intNumIgnoredReports, intNumHandledReports, datFirstReport, datLastReport, intTotalItems  
					FROM( SELECT ROW_NUMBER() OVER (ORDER BY ''+@strOrderBy+'') AS intRowNumber,
					COUNT(*) OVER() AS intTotalItems,
					author.intEntityID, SUM(CASE WHEN reportcase.intReportCaseStatus = 1 THEN 1 ELSE 0 END) AS intNumNewReports, SUM(CASE WHEN reportcase.intReportCaseStatus=2 THEN 1 ELSE 0 END) AS intNumIgnoredReports, SUM(CASE WHEN reportcase.intReportCaseStatus=3 THEN 1 ELSE 0 END) AS intNumHandledReports, MIN(report.datCreated) AS datFirstReport, MAX(report.datCreated) AS datLastReport 
					FROM tblEPiServerCommonReport AS report
					INNER JOIN tblEPiServerCommonReportCase AS reportcase ON report.intReportCaseID=reportcase.intID  
					INNER JOIN tblEPiServerCommonAuthor AS author ON report.intAuthorID=author.intID AND (NOT author.intEntityID IS NULL) AND author.intObjectTypeID IN (SELECT intID FROM tblEntityType WHERE strName IN (''''EPiServer.Common.UserAuthor, EPiServer.Common.Framework.Impl'''', ''''EPiServer.Common.AnonymousAuthor, EPiServer.Common.Framework.Impl'''')) 
					WHERE 1 = 1''

IF @xmlCategories IS NOT NULL
BEGIN
    IF @isCollectionEmpty = 1
    BEGIN
        SET @strQuery = @strQuery + '' AND NOT EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
                                         (catItem.intObjectTypeID = reportcase.intObjectTypeID AND catItem.intObjectID = reportcase.intObjectID)) ''   
    END
    ELSE
    BEGIN
        SET @strQuery = @strQuery + '' AND EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
                                         (catItem.intObjectTypeID = reportcase.intObjectTypeID AND catItem.intObjectID = reportcase.intObjectID
                                         AND catItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCategories.nodes(''''/collection/item'''') AS T(c)) )) ''
    END
END
	
	SET @strQuery = @strQuery + '' GROUP BY author.intEntityID) UserReportStats WHERE intRowNumber >= @intStartRec AND intRowNumber <= @intEndRec ORDER BY intRowNumber''

	EXEC sp_executesql @strQuery, @strParamList, @intStartRec, @intEndRec, @xmlCategories
	
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingGetReportedUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Gets report cases
-- =============================================

CREATE PROCEDURE [dbo].[spEPiServerCommonReportingGetReportedUsers]
@xmlCategories XML,
@intPage int,
@intPageSize int,
@strOrderBy varchar(2000)
AS
BEGIN

	SET NOCOUNT ON

DECLARE @isCollectionEmpty BIT

IF (@xmlCategories IS NOT NULL)
BEGIN
	IF NOT EXISTS (SELECT * FROM @xmlCategories.nodes(''/collection/item'') AS T(c))
		SET @isCollectionEmpty = 1
	ELSE
		SET @isCollectionEmpty = 0
END


	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	DECLARE @intStartRec int
	DECLARE @intEndRec int
	
	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)

	SET @strParamList = ''@intStartRec int, 
						@intEndRec int,
						@xmlCategories XML''

	IF @strOrderBy IS NULL
	BEGIN
		SET @strOrderBy = ''SUM(CASE WHEN reportcase.intReportCaseStatus = 1 THEN 1 ELSE 0 END) desc''
	END

	SET @strQuery = ''SELECT intEntityID, intNumNewReports, intNumIgnoredReports, intNumHandledReports, datFirstReport, datLastReport, intTotalItems 
					FROM( SELECT ROW_NUMBER() OVER (ORDER BY ''+@strOrderBy+'') AS intRowNumber,
					COUNT(*) OVER() AS intTotalItems,
					author.intEntityID, SUM(CASE WHEN reportcase.intReportCaseStatus = 1 THEN 1 ELSE 0 END) AS intNumNewReports, SUM(CASE WHEN reportcase.intReportCaseStatus=2 THEN 1 ELSE 0 END) AS intNumIgnoredReports, SUM(CASE WHEN reportcase.intReportCaseStatus=3 THEN 1 ELSE 0 END) AS intNumHandledReports, MIN(report.datCreated) AS datFirstReport, MAX(report.datCreated) AS datLastReport
					FROM tblEPiServerCommonReport AS report  
					INNER JOIN tblEPiServerCommonReportCase AS reportcase ON report.intReportCaseID=reportcase.intID
					INNER JOIN tblEPiServerCommonAuthor AS author ON reportcase.intReportDataAuthorID=author.intID AND author.intObjectTypeID IN (SELECT intID FROM tblEntityType WHERE strName IN (''''EPiServer.Common.UserAuthor, EPiServer.Common.Framework.Impl'''', ''''EPiServer.Common.AnonymousAuthor, EPiServer.Common.Framework.Impl''''))  
					WHERE 1 = 1''

IF @xmlCategories IS NOT NULL
BEGIN
    IF @isCollectionEmpty = 1
    BEGIN
        SET @strQuery = @strQuery + '' AND NOT EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
                                         (catItem.intObjectTypeID = reportcase.intObjectTypeID AND catItem.intObjectID = reportcase.intObjectID)) ''   
    END
    ELSE
    BEGIN
        SET @strQuery = @strQuery + '' AND EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
                                         (catItem.intObjectTypeID = reportcase.intObjectTypeID AND catItem.intObjectID = reportcase.intObjectID
                                         AND catItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCategories.nodes(''''/collection/item'''') AS T(c)) )) ''
    END
END
	
	SET @strQuery = @strQuery + '' GROUP BY author.intEntityID) UserReportStats WHERE intRowNumber >= @intStartRec AND intRowNumber <= @intEndRec ORDER BY intRowNumber''

	EXEC sp_executesql @strQuery, @strParamList, @intStartRec, @intEndRec, @xmlCategories

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUsersRatedItems]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Daniel Furtado>
-- Create date: <2008-07-29>
-- Description:	<Retrieves a list of rated items>
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetUsersRatedItems]	
	@xmlUserCollection xml,
	@intObjectTypeID int, 
	@xmlCategoryCollection xml, 	
	@intPage int, 
	@intPageSize int	
AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	DECLARE @intStartRec int
	DECLARE @intEndRec int
	DECLARE @isCollectionEmpty BIT
	
	IF (@xmlCategoryCollection IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCategoryCollection.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END
		
	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)

	SET @strParamList = ''@xmlUserCollection XML,
                         @intObjectTypeID int, 
                         @intStartRec int, 
						 @intEndRec int,
						 @xmlCategoryCollection XML''

	SET @strQuery = ''SELECT intID, strName, intObjectID, fltRating, datTimeStamp, intAuthorID, intTotalItems FROM (
					 SELECT rl.intID, co.strName, rl.intObjectTypeID, rl.intObjectID, rl.fltRating, rl.datTimeStamp, rl.intAuthorID,
					 ROW_NUMBER() OVER (ORDER BY rl.intID) AS intRowNumber,
					 COUNT(*) OVER() as intTotalItems
					 FROM 
					 tblEPiServerCommonRatingLog as rl
					 INNER JOIN tblEntityType as co ON rl.intObjectTypeID = co.intID
					 LEFT JOIN tblEPiServerCommonAuthor as ca ON rl.intAuthorID = ca.intID AND ca.intObjectTypeID IN (SELECT intID FROM tblEntityType WHERE strName IN (''''EPiServer.Common.UserAuthor, EPiServer.Common.Framework.Impl'''')) 
					 WHERE ca.intEntityID = ANY (SELECT T.c.value(''''./@userID'''', ''''int'''') FROM @xmlUserCollection.nodes(''''/UserCollection/User'''') AS T(c)) ''
	IF @intObjectTypeID IS NOT NULL
	BEGIN
		 SET @strQuery = @strQuery + ''AND rl.intObjectTypeID = @intObjectTypeID ''
	END
	
	IF @xmlCategoryCollection IS NOT NULL
	BEGIN
		IF (@isCollectionEmpty = 1)
			SET @strQuery = @strQuery + ''AND NOT EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE 
				(catItem.intObjectTypeID = rl.intObjectTypeID AND catItem.intObjectID = rl.intObjectID)) '' 
		ELSE
			SET @strQuery = @strQuery + ''AND EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE 
				(catItem.intObjectTypeID = rl.intObjectTypeID AND catItem.intObjectID = rl.intObjectID 
				AND catItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCategoryCollection.nodes(''''/collection/item'''') AS T(c)) )) '' 
	END
 
	SET @strQuery = @strQuery + '') tblEPiServerCommonRatingLog 
								WHERE intRowNumber >= @intStartRec AND intRowNumber <= @intEndRec ORDER BY intRowNumber''

	EXEC sp_executesql @strQuery, @strParamList, @xmlUserCollection, @intObjectTypeID, @intStartRec, @intEndRec, @xmlCategoryCollection
    
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingGetReports]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Gets reports
-- =============================================

CREATE PROCEDURE [dbo].[spEPiServerCommonReportingGetReports]
@intReportCaseID INT, 
@intPage INT,
@intPageSize INT,
@strOrderBy VARCHAR(2000)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @strParamList NVARCHAR(256)
	DECLARE @strQuery NVARCHAR(MAX)
	DECLARE @intStartRec INT
	DECLARE @intEndRec INT
	
	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)

	SET @strParamList = ''@intReportCaseID INT,
						@intStartRec INT, 
						@intEndRec INT''

	IF @strOrderBy IS NULL
	BEGIN
		SET @strOrderBy = ''datCreated DESC''
	END

	SET @strQuery = ''SELECT intID, intReportCaseID, strDescription, strUrl, intAuthorID, datCreated, intStatus, intPreviousStatus, intTotalItems
					FROM( SELECT ROW_NUMBER() OVER (ORDER BY ''+@strOrderBy+'') AS intRowNumber,
							COUNT(*) OVER() AS intTotalItems,
							tblEPiServerCommonReport.intID, tblEPiServerCommonReport.intReportCaseID, tblEPiServerCommonReport.strDescription, tblEPiServerCommonReport.strUrl, tblEPiServerCommonReport.intAuthorID, tblEPiServerCommonReport.datCreated, tblEPiServerCommonReport.intStatus, tblEPiServerCommonReport.intPreviousStatus
							FROM dbo.tblEPiServerCommonReport AS tblEPiServerCommonReport
							WHERE intReportCaseID=@intReportCaseID''

	
	SET @strQuery = @strQuery + '') Reports WHERE intRowNumber >= @intStartRec AND intRowNumber <= @intEndRec ORDER BY intRowNumber''

	EXEC sp_executesql @strQuery, @strParamList, @intReportCaseID, @intStartRec, @intEndRec
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingGetReportCases]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Gets report cases
-- =============================================

CREATE PROCEDURE [dbo].[spEPiServerCommonReportingGetReportCases]
@intReportCaseStatus smallint, 
@intObjectTypeID int, 
@intObjectID int,
@xmlCategories XML,
@intStatus smallint, 
@intPage int,
@intPageSize int,
@strOrderBy varchar(2000)
AS
BEGIN

	SET NOCOUNT ON

DECLARE @isCollectionEmpty BIT

IF (@xmlCategories IS NOT NULL)
BEGIN
	IF NOT EXISTS (SELECT * FROM @xmlCategories.nodes(''/collection/item'') AS T(c))
		SET @isCollectionEmpty = 1
	ELSE
		SET @isCollectionEmpty = 0
END

	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	DECLARE @intStartRec int
	DECLARE @intEndRec int
	
	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)

	SET @strParamList = ''@intReportCaseStatus int,
						@intStatus smallint, 
						@intObjectTypeID int,
						@intObjectID int,
						@xmlCategories XML,
						@intStartRec int, 
						@intEndRec int''

	IF @strOrderBy IS NULL
	BEGIN
		SET @strOrderBy = ''datCreated desc''
	END

	SET @strQuery = ''SELECT intID, intObjectID, intObjectTypeID, intReportCaseStatus, datCreated, datLastModified, strComment, strReportDataTitle, strReportDataXml, datReportDataCreated, intReportDataAuthorID, intNumReports, intStatus, intPreviousStatus, intTotalItems
					FROM( SELECT ROW_NUMBER() OVER (ORDER BY ''+@strOrderBy+'') AS intRowNumber,
							COUNT(*) OVER() AS intTotalItems,
							tblEPiServerCommonReportCase.intID, tblEPiServerCommonReportCase.intObjectID, tblEPiServerCommonReportCase.intObjectTypeID, tblEPiServerCommonReportCase.intReportCaseStatus, tblEPiServerCommonReportCase.datCreated, tblEPiServerCommonReportCase.datLastModified, tblEPiServerCommonReportCase.strComment, tblEPiServerCommonReportCase.strReportDataTitle, tblEPiServerCommonReportCase.strReportDataXml, tblEPiServerCommonReportCase.datReportDataCreated, tblEPiServerCommonReportCase.intReportDataAuthorID, tblEPiServerCommonReportCase.intNumReports, tblEPiServerCommonReportCase.intStatus, tblEPiServerCommonReportCase.intPreviousStatus 
							FROM dbo.tblEPiServerCommonReportCase 
							WHERE 1=1 AND ((tblEPiServerCommonReportCase.intStatus & @intStatus) != 0) ''
	
	IF @intReportCaseStatus IS NOT NULL
		SET @strQuery = @strQuery + '' AND intReportCaseStatus=@intReportCaseStatus ''
	
	IF @intObjectTypeID IS NOT NULL
		SET @strQuery = @strQuery + '' AND intObjectTypeID=@intObjectTypeID ''

	IF @intObjectID IS NOT NULL
		SET @strQuery = @strQuery + '' AND intObjectID=@intObjectID ''

IF @xmlCategories IS NOT NULL
BEGIN
    IF @isCollectionEmpty = 1
    BEGIN
        SET @strQuery = @strQuery + '' AND NOT EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
                                         (catItem.intObjectTypeID = tblEPiServerCommonReportCase.intObjectTypeID AND catItem.intObjectID = tblEPiServerCommonReportCase.intObjectID)) ''   
    END
    ELSE
    BEGIN
        SET @strQuery = @strQuery + '' AND EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
                                         (catItem.intObjectTypeID = dbo.tblEPiServerCommonReportCase.intObjectTypeID AND catItem.intObjectID = tblEPiServerCommonReportCase.intObjectID
                                         AND catItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCategories.nodes(''''/collection/item'''') AS T(c)) )) ''
    END
END

	
	SET @strQuery = @strQuery + '') ReportMatters WHERE intRowNumber >= @intStartRec AND intRowNumber <= @intEndRec ORDER BY intRowNumber''

	EXEC sp_executesql @strQuery, @strParamList, @intReportCaseStatus, @intStatus, @intObjectTypeID, @intObjectID, @xmlCategories, @intStartRec, @intEndRec

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnEPiServerCommonCalculatePopularity]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
-- =============================================
-- Author:	    Daniel Furtado
-- Create date: 2008-08-19
-- Description:	Calculate the porcentage of popularity 
--              using the formula : 
--              (WR) = (v ÷ (v+m)) × R + (m ÷ (v+m)) × C 
--              where:  
--              R = average for the item (mean) = (Rating)  
--			    v = number of votes for the item = (votes)  
--				m = minimum votes required to be listed in the Top list 
--				C = the mean vote across the whole report 

-- =============================================
CREATE FUNCTION [dbo].[fnEPiServerCommonCalculatePopularity]
(
	@v float,
	@m float,
	@R float,
	@C float
)
RETURNS float
AS
BEGIN
	
	DECLARE @popularity float;

	SET @popularity = (@v / (@v+@m)) * @R + (@m / (@v+@m)) * @C;
	
	return ROUND(@popularity,2);

END
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetCategorizedItems]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE  [dbo].[spEPiServerCommonGetCategorizedItems]
@intObjectTypeID int, 
@strCategoryList varchar(2000), 
@intPage int, 
@intPageSize int

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	DECLARE @intStartRec int
	DECLARE @intEndRec int
	
	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)

	SET @strParamList = ''@intObjectTypeID int, 
						@strCategoryList varchar(2000), 
						@intStartRec int, 
						@intEndRec int''

	SET @strQuery = ''SELECT strObjectTypeName, intObjectID, intTotalItems
					FROM( SELECT ROW_NUMBER() OVER (ORDER BY CategoryItem.intObjectID) AS intRowNumber,
							COUNT(*) OVER() AS intTotalItems,
							ObjType.strName AS strObjectTypeName, CategoryItem.intObjectID FROM dbo.tblEPiServerCommonCategoryItem CategoryItem
							INNER JOIN dbo.tblEntityType ObjType ON CategoryItem.intObjectTypeID = ObjType.intID
					WHERE 1=1 ''

	IF @intObjectTypeID IS NOT NULL
		SET @strQuery = @strQuery + '' AND CategoryItem.intObjectTypeID = @intObjectTypeID ''

	IF @strCategoryList IS NOT NULL
	BEGIN
		IF @strCategoryList != ''''
		BEGIN
			SET @strQuery = @strQuery + '' AND CategoryItem.intCategoryID in ('' + @strCategoryList + '')''
		END
	END

	SET @strQuery = @strQuery + '') CategorizedItems WHERE intRowNumber >= @intStartRec AND intRowNumber <= @intEndRec''

	EXEC sp_executesql @strQuery, @strParamList, @intObjectTypeID, @strCategoryList, @intStartRec, @intEndRec
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetRatings]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-06-19
-- Description:	Gets ratings for a ratable object within a certain rating spEPiServerCommonAn
-- =============================================

CREATE PROCEDURE [dbo].[spEPiServerCommonGetRatings]
@intObjectTypeID int, 
@intObjectID int, 
@intAuthorID int,
@strAuthorEmail varchar(1024),
@fltMinRating float, 
@fltMaxRating float, 
@xmlCollection xml, 
@intPage int, 
@intPageSize int
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	DECLARE @intStartRec int
	DECLARE @intEndRec int
	DECLARE @isCollectionEmpty BIT	

	IF (@xmlCollection IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCollection.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END
		
	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)

	SET @strParamList = ''@intObjectTypeID int, 
						@intObjectID int, 
						@intAuthorID int,
						@strAuthorEmail varchar(1024),
						@fltMinRating float, 
						@fltMaxRating float, 
						@intStartRec int, 
						@intEndRec int, 
						@xmlCollection XML''

	SET @strQuery = ''SELECT intID, strObjectTypeName, intObjectID, fltRating, datTimeStamp,
							intAuthorID, intTotalItems
					FROM( SELECT ROW_NUMBER() OVER (ORDER BY RatingLog.intObjectID) AS intRowNumber,
							COUNT(*) OVER() AS intTotalItems,
							RatingLog.intID, ObjType.strName AS strObjectTypeName, RatingLog.intObjectID, RatingLog.fltRating, RatingLog.datTimeStamp, RatingLog.intAuthorID
							FROM dbo.tblEPiServerCommonRatingLog AS RatingLog
							INNER JOIN dbo.tblEntityType AS ObjType ON RatingLog.intObjectTypeID = ObjType.intID
							LEFT JOIN dbo.tblEPiServerCommonAuthor AS Auth ON RatingLog.intAuthorID = Auth.intID
					WHERE RatingLog.fltRating >= @fltMinRating AND RatingLog.fltRating <= @fltMaxRating ''

	IF @intObjectTypeID IS NOT NULL
		SET @strQuery = @strQuery + ''AND RatingLog.intObjectTypeID = @intObjectTypeID ''

	IF @intObjectID IS NOT NULL
		SET @strQuery = @strQuery + ''AND RatingLog.intObjectID = @intObjectID ''

	IF @intAuthorID IS NOT NULL
		SET @strQuery = @strQuery + ''AND RatingLog.intAuthorID = @intAuthorID ''
	ELSE IF @strAuthorEmail IS NOT NULL
		SET @strQuery = @strQuery + ''AND Auth.strAuthorEmail = @strAuthorEmail ''
	
	IF @xmlCollection IS NOT NULL
	BEGIN
		IF (@isCollectionEmpty = 1)
			SET @strQuery = @strQuery + ''AND NOT EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE 
				(catItem.intObjectTypeID = RatingLog.intObjectTypeID AND catItem.intObjectID = RatingLog.intObjectID)) '' 
		ELSE
			SET @strQuery = @strQuery + ''AND EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE 
				(catItem.intObjectTypeID = RatingLog.intObjectTypeID AND catItem.intObjectID = RatingLog.intObjectID 
				AND catItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) )) '' 
	END
	
	SET @strQuery = @strQuery + '') Ratings WHERE intRowNumber >= @intStartRec AND intRowNumber <= @intEndRec ORDER BY intRowNumber''

	EXEC sp_executesql @strQuery, @strParamList, @intObjectTypeID, 
					   @intObjectID, @intAuthorID, @strAuthorEmail, 
					   @fltMinRating, @fltMaxRating, @intStartRec, @intEndRec, @xmlCollection
					   
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetAttributeValues]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-09
-- Description:	Gets the values of an attribute from its correct value table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetAttributeValues]
@strAttributeValueTableName varchar(300),
@strAttributeValueColumnName varchar(50),
@intAttributeID int,
@intObjectID int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @strQuery nvarchar(4000)
	DECLARE @strParamList nvarchar(256)

	SET @strParamList = ''@intAttributeID int,
						 @intObjectID int''

    SET @strQuery = ''SELECT '' + @strAttributeValueColumnName + '' FROM '' + @strAttributeValueTableName + ''
		WHERE intAttributeID = @intAttributeID AND intObjectID = @intObjectID ORDER BY intSequence''
	
	EXEC sp_executesql @strQuery, @strParamList, @intAttributeID, @intObjectID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetRatedItems]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Söderberg
-- Create date: 2007-06-20
-- Description:	Gets all ratable entities from the passed site which have an average rating value within the min and max values, and of the specified objectType
-- =============================================
CREATE PROCEDURE  [dbo].[spEPiServerCommonGetRatedItems]
@intObjectTypeID int, 
@fltMinRating float, 
@fltMaxRating float, 
@xmlCollection xml, 
@intPage int, 
@intPageSize int

AS
BEGIN

	SET NOCOUNT ON

	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	DECLARE @intStartRec int
	DECLARE @intEndRec int
	DECLARE @isCollectionEmpty BIT
	
	IF (@xmlCollection IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCollection.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END
	
	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)

	SET @strParamList = ''@intObjectTypeID int, 
						@fltMinRating float, 
						@fltMaxRating float, 
						@intStartRec int, 
						@intEndRec int,
						@xmlCollection XML''

	SET @strQuery = ''SELECT strObjectTypeName, intObjectID, intTotalItems
					FROM( SELECT ROW_NUMBER() OVER (ORDER BY RatableItem.intObjectID) AS intRowNumber,
							COUNT(*) OVER() AS intTotalItems,
							ObjType.strName AS strObjectTypeName, RatableItem.intObjectID FROM dbo.tblEPiServerCommonRatableItem RatableItem
							INNER JOIN dbo.tblEntityType ObjType ON RatableItem.intObjectTypeID = ObjType.intID
					WHERE RatableItem.intAvgRating >= (ROUND(@fltMinRating, 1)*10) AND RatableItem.intAvgRating <= (ROUND(@fltMaxRating, 1)*10) ''

	IF @intObjectTypeID IS NOT NULL
		SET @strQuery = @strQuery + ''AND RatableItem.intObjectTypeID = @intObjectTypeID ''

	IF @xmlCollection IS NOT NULL
	BEGIN
		IF (@isCollectionEmpty = 1)
			SET @strQuery = @strQuery + ''AND NOT EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE 
				(catItem.intObjectTypeID = RatableItem.intObjectTypeID AND catItem.intObjectID = RatableItem.intObjectID)) '' 
		ELSE
			SET @strQuery = @strQuery + ''AND EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE 
				(catItem.intObjectTypeID = RatableItem.intObjectTypeID AND catItem.intObjectID = RatableItem.intObjectID 
				AND catItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) )) '' 
	END

	SET @strQuery = @strQuery + '') RatableItems WHERE intRowNumber >= @intStartRec AND intRowNumber <= @intEndRec''

	EXEC sp_executesql @strQuery, @strParamList, @intObjectTypeID, @fltMinRating, @fltMaxRating, @intStartRec, @intEndRec, @xmlCollection
	       
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetAttributeValueChoices]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-09
-- Description:	Gets the value choices of an attribute from its correct value table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetAttributeValueChoices]
@strAttributeValueChoiceTableName varchar(300),
@strAttributeValueChoiceColumnName varchar(50),
@intAttributeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @strQuery nvarchar(4000)
	DECLARE @strParamList nvarchar(256)

	SET @strParamList = ''@intAttributeID int''

	SET @strQuery = ''SELECT intAttributeID, strText, '' + @strAttributeValueChoiceColumnName + '' FROM '' + @strAttributeValueChoiceTableName + ''
					WHERE intAttributeID = @intAttributeID ORDER BY strText''

	EXEC sp_executesql @strQuery, @strParamList, @intAttributeID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonClearAttributeValueChoices]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-06
-- Description:	Clears all present value choices of an attribute
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonClearAttributeValueChoices]
@strAttributeValueChoiceTableName varchar(300),
@intAttributeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @strQuery nvarchar(4000)
	DECLARE @strParamList nvarchar(256)

	SET @strParamList = ''@intAttributeID int''

	SET @strQuery = ''DELETE FROM '' + @strAttributeValueChoiceTableName + '' 
						WHERE intAttributeID = @intAttributeID''

	EXEC sp_executesql @strQuery, @strParamList, @intAttributeID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonClearAttributeValues]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-06
-- Description:	Clears all present site values of an attribute
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonClearAttributeValues]
@strAttributeValueTableName varchar(300),
@intAttributeID int,
@intObjectID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @strQuery nvarchar(4000)
	DECLARE @strParamList nvarchar(256)

	SET @strParamList = ''@intAttributeID int,
						 @intObjectID int''

    SET @strQuery = ''DELETE FROM '' + @strAttributeValueTableName + '' 
		WHERE intAttributeID = @intAttributeID 
		AND intObjectID = @intObjectID''

	EXEC sp_executesql @strQuery, @strParamList, @intAttributeID, @intObjectID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetAttributeStartOfValueSequence]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2008-09-02
-- Description:	Gets where sequence for the attribute values will begin
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetAttributeStartOfValueSequence]
@strAttributeValueTableName varchar(300),
@intAttributeID int,
@intObjectID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @strQuery nvarchar(4000)
	DECLARE @strParamList nvarchar(256)

	SET @strParamList = ''@intAttributeID int,
						 @intObjectID int''

    SET @strQuery = ''SELECT IsNull(MAX(intSequence) + 1, 0) FROM '' + @strAttributeValueTableName + '' WHERE intAttributeID = @intAttributeID AND intObjectID = @intObjectID''

	EXEC sp_executesql @strQuery, @strParamList, @intAttributeID, @intObjectID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsGetVisits]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Description:	Gets visits for an entity grouped by author depending on passed @uniqueVisitors
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsGetVisits] 
@intObjectTypeID int,
@intObjectID int,
@intAuthorID int,
@strAuthorEmail varchar(1024),
@uniqueVisitors bit,
@includeUnknownVisitors bit,
@datStartDate datetime,
@datEndDate datetime,
@intPage int,
@intPageSize int,
@strOrderBy varchar(2000)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	DECLARE @intStartRec int
	DECLARE @intEndRec int

	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)

	SET @strParamList = ''@intObjectTypeID int,
						@intObjectID int,
						@intAuthorID int,
						@strAuthorEmail varchar(1024),
						@uniqueVisitors bit,
						@datStartDate datetime,
						@datEndDate datetime,
						@intStartRec int, 
						@intEndRec int''


	IF @strOrderBy IS NULL
		SET @strOrderBy = ''tblEPiServerCommonVisitLog.intID ASC''

	SET @strQuery = ''SELECT intID, intAuthorID, strObjectTypeName, intObjectID, datTimeStamp, intTotalItems ''
	IF @uniqueVisitors = 1
	BEGIN

		SET @strOrderBy = REPLACE(@strOrderBy, ''tblEPiServerCommonVisitLog.'', ''InnerVisits.'')

		SET @strQuery = @strQuery + '' FROM( SELECT ROW_NUMBER() OVER (ORDER BY ''+@strOrderBy+'') AS intRowNumber,
							COUNT(*) OVER() AS intTotalItems,
							intID, intAuthorID, strObjectTypeName, intObjectID, datTimeStamp
							FROM
							(SELECT MAX(tblEPiServerCommonVisitLog.intID) AS intID, tblEPiServerCommonVisitLog.intAuthorID, t2.strName AS strObjectTypeName, tblEPiServerCommonVisitLog.intObjectID, MAX(tblEPiServerCommonVisitLog.datTimeStamp) AS datTimeStamp
								FROM dbo.tblEPiServerCommonVisitLog AS tblEPiServerCommonVisitLog
								INNER JOIN dbo.tblEntityType AS t2 ON tblEPiServerCommonVisitLog.intObjectTypeID = t2.intID
								WHERE 1=1 ''
	END
	ELSE
	BEGIN
		SET @strQuery = @strQuery + '' FROM (SELECT ROW_NUMBER() OVER (ORDER BY ''+@strOrderBy+'') AS intRowNumber,
							COUNT(*) OVER() AS intTotalItems,
							tblEPiServerCommonVisitLog.intID, tblEPiServerCommonVisitLog.intAuthorID, t2.strName AS strObjectTypeName, tblEPiServerCommonVisitLog.intObjectID, tblEPiServerCommonVisitLog.datTimeStamp
							FROM dbo.tblEPiServerCommonVisitLog AS tblEPiServerCommonVisitLog
							INNER JOIN dbo.tblEntityType AS t2 ON tblEPiServerCommonVisitLog.intObjectTypeID = t2.intID
							LEFT JOIN dbo.tblEPiServerCommonAuthor AS t3 ON tblEPiServerCommonVisitLog.intAuthorID = t3.intID
							WHERE 1=1 ''	
	END
	

	IF @datStartDate IS NOT NULL
		SET @strQuery = @strQuery + '' AND datTimeStamp >= @datStartDate ''

	IF @datEndDate IS NOT NULL
		SET @strQuery = @strQuery + '' AND datTimeStamp <= @datEndDate ''

	IF @intAuthorID IS NOT NULL
		SET @strQuery = @strQuery + '' AND intAuthorID=@intAuthorID ''
	ELSE IF @strAuthorEmail IS NOT NULL
		SET @strQuery = @strQuery + ''AND t3.strAuthorEmail = @strAuthorEmail ''

	IF @intObjectTypeID IS NOT NULL
		SET @strQuery = @strQuery + '' AND tblEPiServerCommonVisitLog.intObjectTypeID=@intObjectTypeID ''

	IF @intObjectID IS NOT NULL
		SET @strQuery = @strQuery + '' AND intObjectID=@intObjectID ''

	IF @includeUnknownVisitors = 0
		SET @strQuery = @strQuery + '' AND intAuthorID IS NOT NULL ''

	IF @uniqueVisitors = 1
		SET @strQuery = @strQuery + '' GROUP BY tblEPiServerCommonVisitLog.intAuthorID, t2.strName, tblEPiServerCommonVisitLog.intObjectID ) InnerVisits ''
		
	SET @strQuery = @strQuery + '') Visits WHERE intRowNumber >= @intStartRec AND intRowNumber <= @intEndRec ORDER BY intRowNumber''

	EXEC sp_executesql @strQuery, @strParamList, @intObjectTypeID, @intObjectID, @intAuthorID, @strAuthorEmail, @uniqueVisitors, @datStartDate, @datEndDate, @intStartRec, @intEndRec
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsCleanUserVisits]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsCleanUserVisits] 
	@intUserID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT intID FROM tblEPiServerCommonVisitLog WHERE
	EXISTS(SELECT * FROM tblEPiServerCommonAuthor WHERE 
		tblEPiServerCommonVisitLog.intAuthorID = tblEPiServerCommonAuthor.intID
		AND intObjectTypeID IN (SELECT intID FROM tblEntityType WHERE strName IN (''EPiServer.Common.UserAuthor, EPiServer.Common.Framework.Impl'', ''EPiServer.Common.AnonymousAuthor, EPiServer.Common.Framework.Impl''))
		AND intEntityID = @intUserID)

	UPDATE tblEPiServerCommonVisitLog SET intAuthorID = NULL WHERE 
	EXISTS(SELECT * FROM tblEPiServerCommonAuthor WHERE 
		tblEPiServerCommonVisitLog.intAuthorID = tblEPiServerCommonAuthor.intID
		AND intObjectTypeID IN (SELECT intID FROM tblEntityType WHERE strName IN (''EPiServer.Common.UserAuthor, EPiServer.Common.Framework.Impl'', ''EPiServer.Common.AnonymousAuthor, EPiServer.Common.Framework.Impl''))
		AND intEntityID = @intUserID)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsRemoveAllVisits]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Description:	Deletes visits for a visitable item and author
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsRemoveAllVisits]
@intObjectTypeID int,
@intObjectID int,
@intAuthorID int
AS
BEGIN
	SET NOCOUNT ON 

	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)

	SET @strParamList = ''@intObjectTypeID int,
						@intObjectID int,
						@intAuthorID int''
				

	SET @strQuery = ''DELETE FROM tblEPiServerCommonVisitLog WHERE 1 = 1 ''
	
	IF @intAuthorID IS NOT NULL
		SET @strQuery = @strQuery + '' AND intAuthorID = @intAuthorID ''

	IF @intObjectTypeID IS NOT NULL
		SET @strQuery = @strQuery + '' AND intObjectTypeID = @intObjectTypeID ''
	
	IF @intObjectID IS NOT NULL	
		SET @strQuery = @strQuery + '' AND intObjectID = @intObjectID ''

	EXEC sp_executesql @strQuery, @strParamList, @intObjectTypeID, @intObjectID, @intAuthorID
	
SET NOCOUNT OFF 
END' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsGetNumVisits]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01>
-- Description:	Gets total number of visits for an entity
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsGetNumVisits] 
@intObjectTypeID int,
@intObjectID int
AS
BEGIN

	SET NOCOUNT ON
	DECLARE @ret int
		/*SELECT intNumVisits
		FROM tblEPiServerCommonVisitableItem
		WHERE intObjectTypeID = @intObjectTypeID
		AND intObjectID=@intObjectID*/

	SELECT dbo.fnEPiServerCommonVisitsGetNumVisits(@intObjectTypeID, @intObjectID)

END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsGetNumVisitsDateInterval]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Description:	Gets number of visits beween two dates
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsGetNumVisitsDateInterval] 
@intObjectTypeID int,
@intObjectID int,
@datStartDate datetime,
@datEndDate datetime
AS
BEGIN
	SELECT dbo.fnEPiServerCommonVisitsGetNumVisitsDateInterval(@intObjectTypeID, @intObjectID, @datStartDate, @datEndDate)
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsGetUniqueNumVisits]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01>
-- Description:	Gets number of visits beween two dates and unique visitor
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsGetUniqueNumVisits] 
@intObjectTypeID int,
@intObjectID int,
@datStartDate datetime,
@datEndDate datetime
AS
BEGIN
SET NOCOUNT ON

/*DECLARE @strParamList nvarchar(256)
DECLARE @strQuery nvarchar(4000)

SET @strParamList = ''@intObjectTypeID int,
						@intObjectID int,
						@datStartDate datetime,
						@datEndDate datetime''

SET @strQuery = ''SELECT COUNT(*) FROM (SELECT intAuthorID
FROM tblEPiServerCommonVisitLog
WHERE intObjectTypeID=@intObjectTypeID
AND intObjectID=@intObjectID ''

IF @datStartDate IS NOT NULL
	SET @strQuery = @strQuery + '' AND datTimeStamp >= @datStartDate ''

IF @datEndDate IS NOT NULL
	SET @strQuery = @strQuery + '' AND datTimeStamp <= @datEndDate ''

SET @strQuery = @strQuery + '' GROUP BY intAuthorID) d ''

EXEC sp_executesql @strQuery, @strParamList, @intObjectTypeID, @intObjectID, @datStartDate, @datEndDate*/

SELECT dbo.fnEPiServerCommonVisitsGetUniqueNumVisits(@intObjectTypeID, @intObjectID, @datStartDate, @datEndDate)

END' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetSiteList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonGetSiteList]
AS
SELECT intID, strName, strCulture FROM tblEPiServerCommonSite ORDER BY strName
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsGetVisitedItems]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Modified by: Daniel Furtado [2009-03-31]
-- Description:	Gets visited items
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsGetVisitedItems] 
@intAuthorID int,
@intObjectTypeID int,
@intStatus smallint, 
@intPage int,
@intPageSize int,
@strOrderBy varchar(2000)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	DECLARE @intStartRec int
	DECLARE @intEndRec int

	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)

	SET @strParamList = ''@intObjectTypeID int,
 						 @intAuthorID int,
 						 @intStatus smallint, 
						 @intStartRec int, 
						 @intEndRec int''

	-- replace tblEPiServerCommonVisitableItem by temp which is the name of the temp table
    -- used in the last query.
	IF(CHARINDEX(''tblEPiServerCommonVisitableItem'',@strOrderBy,0) > 0)    
		SET @strOrderBy = REPLACE(@strOrderBy,''tblEPiServerCommonVisitableItem'',''temp'');

	SET @strQuery = ''WITH temp AS ( SELECT DISTINCT VisitableItem.intObjectID, VisitableItem.intNumVisits, VisitableItem.intLastVisitID, VisitableItem.intObjectTypeID, VisitableItem.intStatus
						FROM dbo.tblEPiServerCommonVisitableItem AS VisitableItem
						INNER JOIN dbo.tblEPiServerCommonVisitLog AS VisitLog ON VisitableItem.intObjectID = VisitLog.intObjectID AND VisitableItem.intObjectTypeID = VisitLog.intObjectTypeID'';

	IF @intAuthorID IS NOT NULL 
		SET @strQuery = @strQuery + '' AND VisitLog.intAuthorID = @intAuthorID'';
	
	IF @intObjectTypeID IS NOT NULL
		SET @strQuery = @strQuery + '' AND VisitLog.intObjectTypeID = @intObjectTypeID'';

	SET @strQuery = @strQuery + '')'';             

	SET @strQuery = @strQuery + ''SELECT strObjectTypeName, intObjectID, intNumVisits, intLastVisitID, intTotalItems
								FROM (
								SELECT ROW_NUMBER() OVER (ORDER BY '' + @strOrderBy + '') AS intRowNumber, COUNT(*) OVER() AS intTotalItems, t2.strName AS strObjectTypeName, 
								intObjectID, intNumVisits, intLastVisitID
								FROM temp
								INNER JOIN dbo.tblEntityType AS t2 ON temp.intObjectTypeID = t2.intID 
								WHERE (temp.intStatus & @intStatus != 0)) temp
								WHERE intRowNumber >= @intStartRec AND intRowNumber <= @intEndRec ORDER BY intRowNumber''

	EXEC sp_executesql @strQuery, @strParamList, @intObjectTypeID, @intAuthorID, @intStatus, @intStartRec, @intEndRec

END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnEPiServerCommonVisitsGetNumVisitsDateInterval]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Description:	Gets number of visits for the passed visitable entity (objectID and objectTypeID), dates and unique
-- =============================================
CREATE FUNCTION [dbo].[fnEPiServerCommonVisitsGetNumVisitsDateInterval]
(
@intObjectTypeID int,
@intObjectID int,
@datStartDate datetime,
@datEndDate datetime
)
RETURNS int
AS
BEGIN
	DECLARE @ret int
	
	SELECT @ret = COUNT(*)
	FROM tblEPiServerCommonVisitLog
	WHERE intObjectTypeID=@intObjectTypeID
	AND intObjectID=@intObjectID
	AND (@datStartDate IS NULL OR datTimeStamp >= @datStartDate)
	AND (@datEndDate IS NULL OR datTimeStamp < @datEndDate)
	
	RETURN @ret
END' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsGetVisit]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Description:	Gets a visit by its ID
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsGetVisit] 
@intID int
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT	t1.intID, t1.intAuthorID, t2.strName, t1.intObjectID, t1.datTimeStamp
	FROM	tblEPiServerCommonVisitLog AS t1
	INNER JOIN tblEntityType AS t2 ON t1.intObjectTypeID = t2.intID
	WHERE	t1.intID = @intID
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsAddVisit]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Description:	Adds a visit to an entity
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsAddVisit]
@intObjectTypeID int, 
@intObjectID int, 
@intAuthorID int, 
@intStatus smallint
AS
BEGIN 

	IF NOT EXISTS(SELECT * FROM tblEPiServerCommonVisitableItem WHERE intObjectTypeID = @intObjectTypeID AND intObjectID = @intObjectID) 
	BEGIN
		INSERT INTO tblEPiServerCommonVisitableItem(intObjectTypeID, intObjectID, intStatus) 
		VALUES (@intObjectTypeID, @intObjectID, @intStatus)
	END

	INSERT INTO tblEPiServerCommonVisitLog (intObjectTypeID, intObjectID, intAuthorID, intStatus) 
	VALUES (@intObjectTypeID, @intObjectID, @intAuthorID, @intStatus) 

	SELECT SCOPE_IDENTITY() 
 
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnEPiServerCommonVisitsGetUniqueNumVisits]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Description:	Gets number of visits for the passed visitable entity (objectID and objectTypeID), dates and unique
-- =============================================
CREATE FUNCTION [dbo].[fnEPiServerCommonVisitsGetUniqueNumVisits]
(
@intObjectTypeID int,
@intObjectID int,
@datStartDate datetime,
@datEndDate datetime
)
RETURNS int
AS
BEGIN
--DECLARE @strParamList nvarchar(256)
--DECLARE @strQuery nvarchar(4000)
DECLARE @ret int

/*SET @strParamList = ''@intObjectTypeID int,
						@intObjectID int,
						@datStartDate datetime,
						@datEndDate datetime''

SET @strQuery = ''SELECT @ret = COUNT(*) FROM (SELECT intAuthorID
FROM tblEPiServerCommonVisitLog
WHERE intObjectTypeID=@intObjectTypeID
AND intObjectID=@intObjectID ''

ISNULL(@datStartDate, '' AND datTimeStamp >= @datStartDate '')

IF @datStartDate IS NOT NULL
	SET @strQuery = @strQuery + '' AND datTimeStamp >= @datStartDate ''

IF @datEndDate IS NOT NULL
	SET @strQuery = @strQuery + '' AND datTimeStamp <= @datEndDate ''

SET @strQuery = @strQuery + '' GROUP BY intAuthorID) d ''

EXEC sp_executesql @strQuery, @strParamList, @intObjectTypeID, @intObjectID, @datStartDate, @datEndDate*/

SELECT @ret = COUNT(*) FROM (SELECT intAuthorID
FROM tblEPiServerCommonVisitLog
WHERE intObjectTypeID=@intObjectTypeID
AND intObjectID=@intObjectID
AND (@datStartDate IS NULL OR datTimeStamp >= @datStartDate)
AND (@datEndDate IS NULL OR datTimeStamp <= @datEndDate)
GROUP BY intAuthorID) d


RETURN @ret

END' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsRemoveVisit]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Description:	Deletes a visit
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsRemoveVisit]
@intID int 
AS
BEGIN

	SET NOCOUNT ON 

	DELETE FROM tblEPiServerCommonVisitLog
	WHERE intID = @intID

	SET NOCOUNT OFF 
END' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveUserModuleAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveUserModuleAccessRights]
@intUserID Int,
@strModule varchar(100)
AS
DELETE
FROM tblEPiServerCommonUserModuleAccessRight
WHERE intUserID = @intUserID AND strModule = @strModule
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonSetUserModuleAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[spEPiServerCommonSetUserModuleAccessRights]
@intUserID Int,
@strModule varchar(100),
@intAccessLevel Int
AS
IF(EXISTS(SELECT strModule FROM tblEPiServerCommonUserModuleAccessRight WHERE intUserID = @intUserID AND strModule = @strModule))
BEGIN
	UPDATE tblEPiServerCommonUserModuleAccessRight
	SET intAccessLevel = @intAccessLevel
	WHERE intUserID = @intUserID AND strModule = @strModule
END
ELSE
BEGIN
	INSERT INTO tblEPiServerCommonUserModuleAccessRight(intUserID, strModule, intAccessLevel)
	VALUES (@intUserID, @strModule, @intAccessLevel)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetModuleUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetModuleUsers]
@strModule varchar(100)
AS
SELECT tblEPiServerCommonUser.intID, strUserName, binPassword, intPasswordProviderID, strGivenName, strSurName, strEmail, datBirthDate, strCulture, datCreateDate, strAlias, intStatus, intPreviousStatus
FROM tblEPiServerCommonUser
INNER JOIN tblEPiServerCommonUserModuleAccessRight AS d ON tblEPiServerCommonUser.intID = d.intUserID
WHERE d.strModule = @strModule
ORDER BY strUserName' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUserModuleAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[spEPiServerCommonGetUserModuleAccessRights]
@intUserID Int,
@strModule varchar(100)
AS
SELECT intUserID, strModule, intAccessLevel 
FROM tblEPiServerCommonUserModuleAccessRight
WHERE intUserID = @intUserID AND strModule = @strModule
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetPasswordProviders]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonGetPasswordProviders]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT intID, strName FROM tblEPiServerCommonPasswordProvider ORDER BY intID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonAddUser]
@strGivenName nvarchar(100),
@strSurName nvarchar(100),
@datBirthDate datetime,
@strEmail varchar(255),
@strCulture varchar(15),
@strUserName nvarchar(100),
@binPassword varbinary(100),
@strPasswordProviderName nvarchar(100),
@strAlias nvarchar(100),
@intStatus smallint
AS
SET NOCOUNT ON

DECLARE @intPasswordProviderID int
SELECT @intPasswordProviderID = intID FROM tblEPiServerCommonPasswordProvider WHERE strName=@strPasswordProviderName
IF (@intPasswordProviderID IS NULL)
BEGIN
	INSERT INTO tblEPiServerCommonPasswordProvider (strName) VALUES (@strPasswordProviderName)	
	SELECT @intPasswordProviderID = SCOPE_IDENTITY()
END

INSERT INTO tblEPiServerCommonUser(strUsername, strGivenName, strSurName, datBirthDate, strEmail, strCulture, strAlias, binPassword, intPasswordProviderID, intStatus ) VALUES(@strUserName, @strGivenName, @strSurName, @datBirthDate, @strEmail, @strCulture, @strAlias, @binPassword, @intPasswordProviderID, @intStatus)

SELECT SCOPE_IDENTITY()' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddPasswordProvider]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonAddPasswordProvider]
@strName nvarchar(200)
AS
SET NOCOUNT ON

DECLARE @intPasswordProviderID int
SELECT @intPasswordProviderID = intID FROM tblEPiServerCommonPasswordProvider WHERE strName=@strName
IF (@intPasswordProviderID IS NULL)
BEGIN
	INSERT INTO tblEPiServerCommonPasswordProvider (strName) VALUES (@strName)	
	SELECT @intPasswordProviderID = SCOPE_IDENTITY()
END

SELECT @intPasswordProviderID' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonUpdateUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonUpdateUser]
@intUserID int,
@strGivenName nvarchar(100),
@strSurName nvarchar(100),
@strEmail varchar(255),
@datBirthDate datetime,
@strCulture varchar(15),
@strUserName nvarchar(100),
@binPassword varbinary(100),
@strPasswordProviderName nvarchar(100),
@strAlias nvarchar(100),
@intStatus smallint,
@intPreviousStatus smallint
AS


DECLARE @intPasswordProviderID int
SELECT @intPasswordProviderID = intID FROM tblEPiServerCommonPasswordProvider WHERE strName=@strPasswordProviderName
IF (@intPasswordProviderID IS NULL)
BEGIN
	INSERT INTO tblEPiServerCommonPasswordProvider (strName) VALUES (@strPasswordProviderName)	
	SELECT @intPasswordProviderID = SCOPE_IDENTITY()
END

UPDATE tblEPiServerCommonUser
	SET strUsername = @strUserName, 
	strGivenName = @strGivenName, strSurName = @strSurName, 
	strEmail = @strEmail, datBirthDate = @datBirthDate, 
	strCulture = @strCulture, strAlias = @strAlias, 
	binPassword = @binPassword, intPasswordProviderID = @intPasswordProviderID,
	intStatus = @intStatus, intPreviousStatus = @intPreviousStatus 
WHERE intID = @intUserID' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonGetGroups]
@intStatus smallint
AS
SELECT intID, strName, intStatus, intPreviousStatus 
FROM tblEPiServerCommonGroup
WHERE ((intStatus & @intStatus) != 0)
ORDER BY strName
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetChildGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonGetChildGroups]
@intParentGroupID int, 
@intStatus smallint 
AS
SELECT tblEPiServerCommonGroup.intID, tblEPiServerCommonGroup.strName, tblEPiServerCommonGroup.intStatus, tblEPiServerCommonGroup.intPreviousStatus
FROM tblEPiServerCommonGroupChildren
INNER JOIN tblEPiServerCommonGroup ON tblEPiServerCommonGroup.intID = tblEPiServerCommonGroupChildren.intChildGroupID
WHERE intParentGroupID = @intParentGroupID AND ((tblEPiServerCommonGroup.intStatus & @intStatus) != 0) 
ORDER BY strName
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetGroup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonGetGroup]
@intID int
AS
SELECT intID, strName, intStatus, intPreviousStatus
FROM tblEPiServerCommonGroup
WHERE intID = @intID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddGroup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonAddGroup]
@strName nvarchar(200), 
@intStatus smallint 
AS
DECLARE @newID int

INSERT INTO tblEPiServerCommonGroup(strName, intStatus) VALUES(@strName, @intStatus)
SET @newID = @@identity

SELECT @newID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonFindGroup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonFindGroup]
@strSearchFor nvarchar(200)
AS

SELECT intID, strName, intStatus, intPreviousStatus
FROM tblEPiServerCommonGroup
WHERE intID LIKE @strSearchFor OR
	strName LIKE @strSearchFor
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonUpdateGroup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonUpdateGroup]
@intID int,
@strName nvarchar(200), 
@intStatus smallint, 
@intPreviousStatus smallint 
AS
UPDATE tblEPiServerCommonGroup
SET strName = @strName, 
intStatus = @intStatus, 
intPreviousStatus = @intPreviousStatus 
WHERE intID = @intID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetParentGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonGetParentGroups]
@intChildGroupID int, 
@intStatus smallint 
AS
SELECT tblEPiServerCommonGroup.intID, tblEPiServerCommonGroup.strName, tblEPiServerCommonGroup.intStatus, tblEPiServerCommonGroup.intPreviousStatus
FROM tblEPiServerCommonGroupChildren
INNER JOIN tblEPiServerCommonGroup ON tblEPiServerCommonGroup.intID = tblEPiServerCommonGroupChildren.intParentGroupID
WHERE intChildGroupID = @intChildGroupID AND ((tblEPiServerCommonGroup.intStatus & @intStatus) != 0)
ORDER BY strName
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetGroupByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetGroupByName]
@strName nvarchar(200)
AS
SELECT intID, strName, intStatus, intPreviousStatus
FROM tblEPiServerCommonGroup
WHERE strName = @strName' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetAdministrativeAccessRightGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetAdministrativeAccessRightGroups]
@intAccessRightSectionID int
AS
SELECT g.intID, g.strName, g.intStatus, g.intPreviousStatus
FROM tblEPiServerCommonGroup as g
INNER JOIN tblEPiServerCommonGroupAdministrativeAccessRight as a ON a.intGroupID = g.intID
WHERE a.intAccessRightSectionID = @intAccessRightSectionID
ORDER BY strName
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUserGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonGetUserGroups]
@intUserID Int, 
@intStatus smallint 
AS
SELECT tblEPiServerCommonGroup.intID, tblEPiServerCommonGroup.strName, tblEPiServerCommonGroup.intStatus, tblEPiServerCommonGroup.intPreviousStatus
FROM tblEPiServerCommonGroupUser
INNER JOIN tblEPiServerCommonGroup ON tblEPiServerCommonGroup.intID = tblEPiServerCommonGroupUser.intGroupID
WHERE intUserID = @intUserID AND ((tblEPiServerCommonGroup.intStatus & @intStatus) != 0) 
ORDER BY strName
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetModuleGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[spEPiServerCommonGetModuleGroups]
@strModule varchar(100)
AS
SELECT g.intID, strName, intStatus, intPreviousStatus
FROM tblEPiServerCommonGroup AS g
INNER JOIN tblEPiServerCommonGroupModuleAccessRight AS d ON g.intID = d.intGroupID
WHERE d.strModule = @strModule
ORDER BY strName
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveGroup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveGroup]
@intID int
AS
DELETE FROM tblEPiServerCommonGroup WHERE intID = @intID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetGroupUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetGroupUsers]
@intGroupID int, 
@intStatus smallint 
AS
SELECT tblEPiServerCommonUser.intID, strUserName, binPassword, intPasswordProviderID, strGivenName, strSurName, strEmail, datBirthDate, strCulture, datCreateDate, strAlias, intStatus, intPreviousStatus
FROM tblEPiServerCommonUser 
INNER JOIN tblEPiServerCommonGroupUser ON tblEPiServerCommonUser.intID = tblEPiServerCommonGroupUser.intUserID
WHERE tblEPiServerCommonGroupUser.intGroupID = @intGroupID AND ((tblEPiServerCommonUser.intStatus & @intStatus) != 0)
ORDER BY strUserName' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetAdministrativeAccessRightUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetAdministrativeAccessRightUsers]
@intAccessRightSectionID int
AS
SELECT tblEPiServerCommonUser.intID, strUserName, binPassword, intPasswordProviderID, strGivenName, strSurName, strEmail, datBirthDate, strCulture, datCreateDate, strAlias, intStatus, intPreviousStatus
FROM tblEPiServerCommonUser
INNER JOIN tblEPiServerCommonUserAdministrativeAccessRight as a ON tblEPiServerCommonUser.intID = a.intUserID
WHERE a.intAccessRightSectionID = @intAccessRightSectionID
ORDER BY strUserName' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetLatestActivatedUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetLatestActivatedUsers]
@intTop int
AS
SELECT TOP (@intTop) intID FROM tblEPiServerCommonUser 
WHERE intStatus = 1 
ORDER BY datCreateDate DESC, intID DESC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetUsers]
@intStatus smallint 
AS
SELECT intID, strUserName, binPassword, intPasswordProviderID, strGivenName, strSurName, strEmail, datBirthDate, strCulture, datCreateDate, strAlias, intStatus, intPreviousStatus
FROM tblEPiServerCommonUser
WHERE ((intStatus & @intStatus) != 0)
ORDER BY strUserName' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUsersByAlias]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetUsersByAlias]
@strAlias nvarchar(100),
@intStatus smallint
AS
SELECT intID, strUserName, binPassword, intPasswordProviderID, strGivenName, strSurName, strEmail, datBirthDate, strCulture, datCreateDate, strAlias, intStatus, intPreviousStatus
FROM tblEPiServerCommonUser 
WHERE strAlias = @strAlias AND ((intStatus & @intStatus) != 0)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonFindUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonFindUser]
@strSearchFor nvarchar(200),
@intStatus smallint
AS
SELECT intID, strUserName, binPassword, intPasswordProviderID, strGivenName, strSurName, strEmail, datBirthDate, strCulture, datCreateDate, strAlias, intStatus, intPreviousStatus
FROM tblEPiServerCommonUser 
WHERE (intID LIKE @strSearchFor OR strUserName LIKE @strSearchFor OR strGivenName LIKE @strSearchFor OR strSurName LIKE @strSearchFor OR strAlias LIKE @strSearchFor)
AND ((intStatus & @intStatus) != 0)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUserByEMail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetUserByEMail]
@strEmail varchar(255),
@intStatus smallint
AS
SELECT intID, strUserName, binPassword, intPasswordProviderID, strGivenName, strSurName, strEmail, datBirthDate, strCulture, datCreateDate, strAlias, intStatus, intPreviousStatus
FROM tblEPiServerCommonUser 
WHERE strEmail = @strEmail AND ((intStatus & @intStatus) != 0)' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetUser]
@intUserID int
AS
SELECT intID, strUserName, binPassword, intPasswordProviderID, strGivenName, strSurName, strEmail, datBirthDate, strCulture, datCreateDate, strAlias, intStatus, intPreviousStatus
FROM tblEPiServerCommonUser
WHERE intID = @intUserID' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveChildGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveChildGroups]
@intParentGroupID int
AS
DELETE FROM tblEPiServerCommonGroupChildren WHERE intParentGroupID = @intParentGroupID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveParentGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveParentGroups]
@intChildGroupID int
AS
DELETE FROM tblEPiServerCommonGroupChildren WHERE intChildGroupID = @intChildGroupID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddChildGroup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonAddChildGroup]
@intParentGroupID Int,
@intChildGroupID Int
AS
INSERT INTO tblEPiServerCommonGroupChildren (intParentGroupID, intChildGroupID) VALUES (@intParentGroupID, @intChildGroupID)
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUserAdministrativeAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetUserAdministrativeAccessRights]
@intUserID Int
AS
SELECT intUserID, intAccessRightSectionID, intAccessLevel
FROM tblEPiServerCommonUserAdministrativeAccessRight
WHERE intUserID = @intUserID
'
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveUserAdministrativeAccessRightSection]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveUserAdministrativeAccessRightSection]
@intSectionID Int,
@intUserID Int
AS
DELETE FROM tblEPiServerCommonUserAdministrativeAccessRight WHERE intAccessRightSectionID = @intSectionID AND intUserID = @intUserID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonSetUserAdministrativeAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonSetUserAdministrativeAccessRights]
@intUserID Int,
@intAccessRightSectionID int,
@intAccessLevel int
AS
IF NOT EXISTS (SELECT * FROM tblEPiServerCommonUserAdministrativeAccessRight WHERE intUserID = @intUserID AND intAccessRightSectionID = @intAccessRightSectionID)
BEGIN
	INSERT INTO tblEPiServerCommonUserAdministrativeAccessRight(intUserID, intAccessRightSectionID, intAccessLevel)
	VALUES(@intUserID, @intAccessRightSectionID, @intAccessLevel)
END
ELSE
BEGIN
	UPDATE tblEPiServerCommonUserAdministrativeAccessRight
	SET intAccessRightSectionID = @intAccessRightSectionID, intAccessLevel = @intAccessLevel
	WHERE intUserID = @intUserID AND intAccessRightSectionID = @intAccessRightSectionID
END
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetGroupAdministrativeAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetGroupAdministrativeAccessRights]
@intGroupID Int
AS
SELECT intGroupID, intAccessRightSectionID, intAccessLevel
FROM tblEPiServerCommonGroupAdministrativeAccessRight
WHERE intGroupID = @intGroupID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonSetGroupAdministrativeAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonSetGroupAdministrativeAccessRights]
@intGroupID Int,
@intAccessRightSectionID int,
@intAccessLevel int
AS
IF NOT EXISTS(SELECT * FROM tblEPiServerCommonGroupAdministrativeAccessRight WHERE intGroupID = @intGroupID AND intAccessRightSectionID = @intAccessRightSectionID)
BEGIN
	INSERT INTO tblEPiServerCommonGroupAdministrativeAccessRight(intGroupID, intAccessRightSectionID, intAccessLevel)
	VALUES(@intGroupID, @intAccessRightSectionID, @intAccessLevel)

END
ELSE
BEGIN
	UPDATE tblEPiServerCommonGroupAdministrativeAccessRight
	SET intAccessRightSectionID = @intAccessRightSectionID, intAccessLevel = @intAccessLevel
	WHERE intGroupID = @intGroupID AND intAccessRightSectionID = @intAccessRightSectionID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveGroupAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveGroupAccessRights]
@intGroupID Int
AS
DELETE FROM tblEPiServerCommonGroupAdministrativeAccessRight
WHERE intGroupID = @intGroupID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveGroupAdministrativeAccessRightSection]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveGroupAdministrativeAccessRightSection]
@intSectionID Int,
@intGroupID Int
AS
DELETE FROM tblEPiServerCommonGroupAdministrativeAccessRight WHERE intAccessRightSectionID = @intSectionID AND intGroupID = @intGroupID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddGroupUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonAddGroupUsers]
@intGroupID Int,
@intUserID Int
AS
INSERT INTO tblEPiServerCommonGroupUser (intGroupID, intUserID) VALUES (@intGroupID, @intUserID)
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveGroupUsers]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveGroupUsers]
@intGroupID int
AS
DELETE FROM tblEPiServerCommonGroupUser WHERE intGroupID = @intGroupID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveUserGroups]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveUserGroups]
@intUserID int
AS
DELETE FROM tblEPiServerCommonGroupUser WHERE intUserID = @intUserID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveAttribute]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-09
-- Description:	Removes an attribute by its id
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveAttribute]
@intAttributeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM tblEPiServerCommonAttribute WHERE intID = @intAttributeID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAttribute]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-06
-- Description:	Adds an attribute to a specific object type
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAttribute] 
@strName nvarchar(100),
@blnHidden bit,
@intObjectTypeID int,
@strDataType varchar(400)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO dbo.tblEPiServerCommonAttribute (strName, intObjectTypeID, strDataType, blnHidden) 
	VALUES (@strName, @intObjectTypeID, @strDataType, @blnHidden)

	SELECT SCOPE_IDENTITY()
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonUpdateAttribute]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-06
-- Description:	Updates an attribute of a spEPiServerCommonEcific object type
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonUpdateAttribute] 
@intID int,
@strName nvarchar(100),
@blnHidden bit,
@intObjectTypeID int,
@strDataType varchar(400)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE dbo.tblEPiServerCommonAttribute 
	SET strName = @strName, intObjectTypeID = @intObjectTypeID, 
		strDataType = @strDataType, blnHidden = @blnHidden
	WHERE intID = @intID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetAttributesByObjectType]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-09
-- Description:	Gets the attributes assigned to a spEPiServerCommonEcific object type
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetAttributesByObjectType]
@intObjectTypeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT a.intID, a.strName, ot.strName AS strObjectTypeName, a.strDataType, a.blnHidden 
	FROM tblEPiServerCommonAttribute AS a
	INNER JOIN tblEntityType AS ot ON a.intObjectTypeID = ot.intID
	WHERE a.intObjectTypeID = @intObjectTypeID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetAttribute]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-08-13
-- Description:	Gets an attribute by its id
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetAttribute]
@intID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT a.intID, a.strName, ot.strName AS strObjectTypeName, a.strDataType, a.blnHidden 
	FROM tblEPiServerCommonAttribute AS a
	INNER JOIN tblEntityType AS ot ON a.intObjectTypeID = ot.intID
	WHERE a.intID = @intID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetRelatedTags]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-24
-- Description:	Gets tags related to the one specified.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetRelatedTags]
	@intTagID int = null, -- the id of the tag to find related tags for
	@strTagName nvarchar(255), -- the name of the tag to find related tags for, used when @intTagID is not specified
	@intMaxCount int -- maximum number of returned related tags
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @intTagID IS NULL
		SELECT @intTagID = intID FROM tblEPiServerCommonTag WHERE strName = @strTagName
	SELECT intID, strName, intItemsCount
	FROM tblEPiServerCommonTag as tag
	INNER JOIN (
		SELECT TOP (@intMaxCount) intTagID, COUNT(*) AS tagsCount
		FROM tblEPiServerCommonTagItem AS ti
		INNER JOIN (
			SELECT intObjectID, intObjectTypeID, intCategoryID
			FROM tblEPiServerCommonTagItem
			WHERE intTagID = @intTagID
		) AS tgi ON (
			ti.intObjectID = tgi.intObjectID 
			AND ti.intObjectTypeID = tgi.intObjectTypeID 
			AND ((ti.intCategoryID IS NULL AND tgi.intCategoryID IS NULL) OR (ti.intCategoryID = tgi.intCategoryID))
		)
		WHERE intTagID <> @intTagID
		GROUP BY intTagID
		ORDER BY tagsCount DESC
	) AS related ON (tag.intID = related.intTagID)
	ORDER BY tagsCount DESC, intItemsCount DESC
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetTagCloud]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Kristoffer Sjoberg
-- Create date: 2007-07-03
-- Description:	Gets the most popular tags from database.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetTagCloud] 
	@strTypeName NVARCHAR(255) = NULL, -- name of the type to get tag cloud for
	@intEntityID INT = NULL, -- the id for the entity whose tag cloud is to be retrieved (optional)
	@xmlCollection xml, -- collection of categories.
	@intAuthorID INT = NULL, -- the author id by which to filter
	@datSince DATETIME = NULL, -- start date of counting number of tags that form the tag cloud
	@intMaxItemsCount INT = 30, -- maximum number of tags returned in the cloud
	@blnFilterByDate BIT = 1, -- indicates if the date shall be used
	@intStatus SMALLINT 
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @intTypeID INT
	-- check if type exists, if not then there is no tag cloud
	IF @strTypeName IS NOT NULL BEGIN
		SELECT @intTypeID = intID
		FROM tblEntityType
		WHERE strName = @strTypeName
		IF @intTypeID IS NULL
			RETURN
	END
	
	DECLARE @strParamList nvarchar(512)
	DECLARE @strQuery nvarchar(4000)
	
	DECLARE @isCollectionEmpty BIT	
		
	IF (@xmlCollection IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCollection.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END
	
	SET @strParamList = ''@strTypeName NVARCHAR(255),
						 @intEntityID INT,
						 @intAuthorID INT,
						 @datSince DATETIME,
						 @intMaxItemsCount INT,
						 @blnFilterByDate BIT,
						 @intStatus SMALLINT,
						 @xmlCollection XML,
						 @intTypeID INT''
	
	DECLARE @strLetter NVARCHAR(1)
	
	-- the simplest version, simple return of total items tagged with a tag
	IF @intTypeID IS NULL AND @blnFilterByDate = 0 BEGIN
		SET @strQuery = ''
		DECLARE @strLetter NVARCHAR(1)
		DECLARE letters_cursor CURSOR FAST_FORWARD FOR
			SELECT DISTINCT SUBSTRING(tag.strName,1,1) letter
			FROM tblEPiServerCommonTagItem AS ti WITH(NOLOCK)
			INNER JOIN tblEPiServerCommonTag AS tag WITH(NOLOCK) ON (ti.intTagID = tag.intID)
			WHERE ((@intAuthorID IS NULL) OR (intAuthorID=@intAuthorID)) AND (ti.intStatus & @intStatus != 0) ''
			
			IF @xmlCollection IS NOT NULL
			BEGIN
				IF (@isCollectionEmpty = 1)
					SET @strQuery = @strQuery + ''AND (ti.intCategoryID IS NULL) ''
				ELSE 
					SET @strQuery = @strQuery + ''AND ti.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
			END	
		
		SET @strQuery = @strQuery + ''
			ORDER BY 1
		OPEN letters_cursor
		FETCH NEXT FROM letters_cursor INTO @strLetter
		WHILE @@fetch_status = 0 BEGIN
			PRINT @strLetter
			SELECT TOP (@intMaxItemsCount) tag.intID as tagID, tag.strName as tagName, ISNULL(COUNT(tag.intID),0) AS intCount
			FROM tblEPiServerCommonTagItem AS ti WITH(NOLOCK)
			INNER JOIN tblEPiServerCommonTag AS tag WITH(NOLOCK) ON (ti.intTagID = tag.intID)
			WHERE SUBSTRING(strName,1,1)=@strLetter 
				AND ((@intAuthorID IS NULL) OR (intAuthorID=@intAuthorID)) AND (ti.intStatus & @intStatus != 0) ''
				
				IF @xmlCollection IS NOT NULL
				BEGIN
					IF (@isCollectionEmpty = 1)
						SET @strQuery = @strQuery + ''AND (ti.intCategoryID IS NULL) ''
					ELSE 
						SET @strQuery = @strQuery + ''AND ti.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
				END
			
		SET @strQuery = @strQuery + ''
			GROUP BY tag.intID, tag.strName
			HAVING ISNULL(COUNT(tag.intID),0) > 0 
			ORDER BY intCount DESC	
			FETCH NEXT FROM letters_cursor INTO @strLetter
		END
		CLOSE letters_cursor
		DEALLOCATE letters_cursor''
		
		EXEC sp_executesql @strQuery, @strParamList, @strTypeName, @intEntityID, @intAuthorID, @datSince, @intMaxItemsCount, @blnFilterByDate, @intStatus, @xmlCollection, @intTypeID
	
	END
	-- we are looking for a specific taggable entity
	ELSE IF (@intTypeID IS NOT NULL) AND (@intEntityID IS NOT NULL) BEGIN
		-- need to take care of type and/or site, but not about date - no need to join items count archives
		IF @blnFilterByDate = 0 BEGIN
		
			SET @strQuery =	''
			DECLARE @strLetter NVARCHAR(1)
			DECLARE letters_cursor CURSOR FAST_FORWARD FOR
				SELECT DISTINCT SUBSTRING(tag.strName,1,1) letter
				FROM tblEPiServerCommonTagItem AS ti WITH(NOLOCK)
				INNER JOIN tblEPiServerCommonTag AS tag WITH(NOLOCK) ON (ti.intTagID = tag.intID)
				WHERE 
					(ti.intObjectTypeID = @intTypeID AND ti.intObjectID = @intEntityID)
					AND ((@intAuthorID IS NULL) OR (intAuthorID=@intAuthorID)) AND (ti.intStatus & @intStatus != 0) ''
					
			IF @xmlCollection IS NOT NULL
			BEGIN
				IF (@isCollectionEmpty = 1)
					SET @strQuery = @strQuery + ''AND (ti.intCategoryID IS NULL) ''
				ELSE 
					SET @strQuery = @strQuery + ''AND ti.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
			END	
					
			SET @strQuery = @strQuery + ''
				ORDER BY 1
			OPEN letters_cursor
			FETCH NEXT FROM letters_cursor INTO @strLetter
			WHILE @@fetch_status = 0 BEGIN
				PRINT @strLetter
				SELECT TOP (@intMaxItemsCount) tag.intID as tagID, tag.strName as tagName, ISNULL(COUNT(tag.intID),0) AS intCount
				FROM tblEPiServerCommonTagItem AS ti WITH(NOLOCK)
				INNER JOIN tblEPiServerCommonTag AS tag WITH(NOLOCK) ON (ti.intTagID = tag.intID)
				WHERE SUBSTRING(strName,1,1)=@strLetter 
					AND (ti.intObjectTypeID = @intTypeID AND ti.intObjectID = @intEntityID)
					AND ((@intAuthorID IS NULL) OR (intAuthorID=@intAuthorID)) AND (ti.intStatus & @intStatus != 0) ''
					
			IF @xmlCollection IS NOT NULL
			BEGIN
				IF (@isCollectionEmpty = 1)
					SET @strQuery = @strQuery + ''AND (ti.intCategoryID IS NULL) ''
				ELSE 
					SET @strQuery = @strQuery + ''AND ti.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
			END
					
			SET @strQuery = @strQuery + ''
				GROUP BY tag.intID, tag.strName
				HAVING ISNULL(COUNT(tag.intID),0) > 0
				ORDER BY intCount DESC	
				FETCH NEXT FROM letters_cursor INTO @strLetter
			END
			CLOSE letters_cursor
			DEALLOCATE letters_cursor''
						
			EXEC sp_executesql @strQuery, @strParamList, @strTypeName, @intEntityID, @intAuthorID, @datSince, @intMaxItemsCount, @blnFilterByDate, @intStatus, @xmlCollection, @intTypeID
						
		END
		-- tag cloud since specific date - need to include archives in search
		ELSE BEGIN
		
			SET @strQuery = ''
			DECLARE @strLetter NVARCHAR(1)
			DECLARE letters_cursor CURSOR FAST_FORWARD FOR
				SELECT DISTINCT SUBSTRING(tag.strName,1,1) letter
				FROM tblEPiServerCommonTagItem AS ti WITH(NOLOCK)
				INNER JOIN tblEPiServerCommonTag AS tag WITH(NOLOCK) ON (ti.intTagID = tag.intID)
				WHERE 
					(ti.intObjectTypeID = @intTypeID AND ti.intObjectID = @intEntityID)
					AND ((@intAuthorID IS NULL) OR (intAuthorID=@intAuthorID)) AND (ti.intStatus & @intStatus != 0) ''
			
			IF @xmlCollection IS NOT NULL
			BEGIN
				IF (@isCollectionEmpty = 1)
					SET @strQuery = @strQuery + ''AND (ti.intCategoryID IS NULL) ''
				ELSE 
					SET @strQuery = @strQuery + ''AND ti.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
			END	   
					
			SET @strQuery = @strQuery + ''
				ORDER BY 1
			OPEN letters_cursor
			FETCH NEXT FROM letters_cursor INTO @strLetter
			WHILE @@fetch_status = 0 BEGIN
				PRINT @strLetter
				SELECT TOP (@intMaxItemsCount) tag.intID as tagID, tag.strName as tagName, ISNULL(COUNT(tag.intID),0) AS intCount
				FROM tblEPiServerCommonTagItem AS ti WITH(NOLOCK)
				INNER JOIN tblEPiServerCommonTag AS tag WITH(NOLOCK) ON (ti.intTagID = tag.intID)
				WHERE SUBSTRING(strName,1,1)=@strLetter 
					AND (ti.intObjectTypeID = @intTypeID AND ti.intObjectID = @intEntityID)
					AND	ti.datCreateDate > @datSince
					AND ((@intAuthorID IS NULL) OR (intAuthorID=@intAuthorID)) AND (ti.intStatus & @intStatus != 0) ''
				
			IF @xmlCollection IS NOT NULL
			BEGIN
				IF (@isCollectionEmpty = 1)
					SET @strQuery = @strQuery + ''AND (ti.intCategoryID IS NULL) ''
				ELSE 
					SET @strQuery = @strQuery + ''AND ti.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
			END
					
			SET @strQuery = @strQuery + ''
				GROUP BY tag.intID, tag.strName
				HAVING ISNULL(COUNT(tag.intID),0) > 0
				ORDER BY intCount DESC	
				FETCH NEXT FROM letters_cursor INTO @strLetter
			END
			CLOSE letters_cursor
			DEALLOCATE letters_cursor''
			
			EXEC sp_executesql @strQuery, @strParamList, @strTypeName, @intEntityID, @intAuthorID, @datSince, @intMaxItemsCount, @blnFilterByDate, @intStatus, @xmlCollection, @intTypeID

		END
	END
	-- we are not looking for a specific taggable entity
	ELSE BEGIN 
		IF @blnFilterByDate = 0 BEGIN
		
			SET @strQuery = ''
			DECLARE @strLetter NVARCHAR(1)
			DECLARE letters_cursor CURSOR FAST_FORWARD FOR
				SELECT DISTINCT SUBSTRING(tag.strName,1,1) letter
				FROM tblEPiServerCommonTagItemCount AS tic WITH(NOLOCK)
				INNER JOIN tblEPiServerCommonTag AS tag WITH(NOLOCK) ON (tic.intTagID = tag.intID)
				WHERE ((@intTypeID IS NULL) OR (tic.intObjectTypeID = @intTypeID))
					AND ((@intAuthorID IS NULL) OR (intAuthorID=@intAuthorID)) AND (tic.intStatus & @intStatus != 0) ''
			
			IF @xmlCollection IS NOT NULL
			BEGIN
				IF (@isCollectionEmpty = 1)
					SET @strQuery = @strQuery + ''AND (tic.intCategoryID IS NULL) ''
				ELSE 
					SET @strQuery = @strQuery + ''AND tic.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
			END

			SET @strQuery = @strQuery + ''
				ORDER BY 1
			OPEN letters_cursor
			FETCH NEXT FROM letters_cursor INTO @strLetter
			WHILE @@fetch_status = 0 BEGIN
				PRINT @strLetter
				SELECT TOP (@intMaxItemsCount) tag.intID as tagID, tag.strName as tagName, ISNULL(SUM(tic.intCount),0) AS intCount
				FROM tblEPiServerCommonTagItemCount AS tic WITH(NOLOCK)
				INNER JOIN tblEPiServerCommonTag AS tag WITH(NOLOCK) ON (tic.intTagID = tag.intID)
				WHERE SUBSTRING(strName,1,1)=@strLetter 
					AND ((@intTypeID IS NULL) OR (tic.intObjectTypeID = @intTypeID))
					AND ((@intAuthorID IS NULL) OR (intAuthorID=@intAuthorID)) AND (tic.intStatus & @intStatus != 0) ''

			IF @xmlCollection IS NOT NULL
			BEGIN
				IF (@isCollectionEmpty = 1)
					SET @strQuery = @strQuery + ''AND (tic.intCategoryID IS NULL) ''
				ELSE 
					SET @strQuery = @strQuery + ''AND tic.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
			END

			SET @strQuery = @strQuery + ''
				GROUP BY tag.intID, tag.strName
				HAVING ISNULL(SUM(tic.intCount),0) > 0
				ORDER BY intCount DESC	
				FETCH NEXT FROM letters_cursor INTO @strLetter
			END
			CLOSE letters_cursor
			DEALLOCATE letters_cursor''
			
			EXEC sp_executesql @strQuery, @strParamList, @strTypeName, @intEntityID, @intAuthorID, @datSince, @intMaxItemsCount, @blnFilterByDate, @intStatus, @xmlCollection, @intTypeID
			
		END 
		-- tag cloud since specific date - need to include archives in search
		ELSE BEGIN
			SET @strQuery = ''
			DECLARE @strLetter NVARCHAR(1)
			DECLARE letters_cursor CURSOR FAST_FORWARD FOR
				SELECT DISTINCT SUBSTRING(tag.strName,1,1) letter
				FROM tblEPiServerCommonTagItemCount AS tic WITH(NOLOCK)
				INNER JOIN tblEPiServerCommonTag AS tag WITH(NOLOCK) ON (tic.intTagID = tag.intID)
				LEFT OUTER JOIN (
					SELECT intTagItemCountID, intCount
					FROM tblEPiServerCommonTagItemCountArchive as one WITH(NOLOCK)
					WHERE datDate = (
						SELECT MAX(datDate) 
						FROM tblEPiServerCommonTagItemCountArchive as two WITH(NOLOCK)
						WHERE datDate < @datSince and two.intTagItemCountID = one.intTagItemCountID)
					AND (one.intStatus & @intStatus != 0)
				) AS tica ON (tic.intID = tica.intTagItemCountID)
				WHERE ((@intTypeID IS NULL) OR (tic.intObjectTypeID = @intTypeID)) 
				AND ((@intAuthorID IS NULL) OR (tic.intAuthorID=@intAuthorID))
				AND (tic.intStatus & @intStatus != 0) ''

			IF @xmlCollection IS NOT NULL
			BEGIN
				IF (@isCollectionEmpty = 1)
					SET @strQuery = @strQuery + ''AND (tic.intCategoryID IS NULL) ''
				ELSE 
					SET @strQuery = @strQuery + ''AND tic.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
			END

			SET @strQuery = @strQuery + ''
				ORDER BY 1
			OPEN letters_cursor
			FETCH NEXT FROM letters_cursor INTO @strLetter
			WHILE @@fetch_status = 0 BEGIN
				SELECT TOP (@intMaxItemsCount) tag.intID as tagID, tag.strName as tagName, (SUM(ISNULL(tic.intCount,0)) - SUM(ISNULL(tica.intCount,0))) AS intCount
				FROM tblEPiServerCommonTagItemCount AS tic WITH(NOLOCK)
				INNER JOIN tblEPiServerCommonTag AS tag WITH(NOLOCK) ON (tic.intTagID = tag.intID)
				LEFT OUTER JOIN (
					SELECT intTagItemCountID, intCount
					FROM tblEPiServerCommonTagItemCountArchive as one WITH(NOLOCK)
					WHERE datDate = (
						SELECT MAX(datDate) 
						FROM tblEPiServerCommonTagItemCountArchive as two WITH(NOLOCK)
						WHERE datDate < @datSince and two.intTagItemCountID = one.intTagItemCountID)
					AND (intStatus & @intStatus != 0)
				) AS tica ON (tic.intID = tica.intTagItemCountID)
				WHERE SUBSTRING(strName,1,1)=@strLetter
					AND ((@intTypeID IS NULL) OR (tic.intObjectTypeID = @intTypeID)) 
					AND ((@intAuthorID IS NULL) OR (tic.intAuthorID=@intAuthorID))
					AND (tic.intStatus & @intStatus != 0) ''

			IF @xmlCollection IS NOT NULL
			BEGIN
				IF (@isCollectionEmpty = 1)
					SET @strQuery = @strQuery + ''AND (tic.intCategoryID IS NULL) ''
				ELSE 
					SET @strQuery = @strQuery + ''AND tic.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
			END

			SET @strQuery = @strQuery + ''
				GROUP BY tag.intID, tag.strName
				HAVING (SUM(ISNULL(tic.intCount,0)) - SUM(ISNULL(tica.intCount,0))) > 0
				ORDER BY intCount DESC
				FETCH NEXT FROM letters_cursor INTO @strLetter
			END
			CLOSE letters_cursor
			DEALLOCATE letters_cursor''
			
			EXEC sp_executesql @strQuery, @strParamList, @strTypeName, @intEntityID, @intAuthorID, @datSince, @intMaxItemsCount, @blnFilterByDate, @intStatus, @xmlCollection, @intTypeID
		END
	END
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagUpdateTagItemStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Pierre Dahlström
-- Create date: 2010-05-25
-- Description:	Update status of tag items.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagUpdateTagItemStatus] 
	@intObjectID int, 
	@intObjectTypeID int,
	@intOldStatus smallint, 
	@intNewStatus smallint
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @intID int
	DECLARE @intTagID int
	DECLARE @intCategoryID int
	DECLARE @intAuthorID int
	
	CREATE TABLE #tblEPiServerCommonTagItem(
		intID int, 
		intTagID int, 
		intObjectTypeID int,
		intCategoryID int,
		intAuthorID int
	)
		
	-- get the tag items with the old status
	INSERT INTO #tblEPiServerCommonTagItem (intID, intTagID, intObjectTypeID, intCategoryID, intAuthorID)
		SELECT intID, intTagID, @intObjectTypeID, intCategoryID, intAuthorID
			FROM tblEpiServerCommonTagItem 
			WHERE intObjectID = @intObjectID AND intObjectTypeID = @intObjectTypeID	AND intStatus <> @intNewStatus	
	
	DECLARE tag_item_cursor CURSOR FAST_FORWARD FOR
		SELECT intID, intTagID, intObjectTypeID, intCategoryID, intAuthorID FROM #tblEPiServerCommonTagItem
	
	-- remove with old status
	OPEN tag_item_cursor
	FETCH NEXT FROM tag_item_cursor 
		INTO @intID, @intTagID, @intObjectTypeID, @intCategoryID, @intAuthorID
		
	WHILE @@fetch_status = 0 
	BEGIN
		EXEC spEPiServerCommonTagUpdateTagItemsCount @intTagID, @intObjectTypeID, @intCategoryID, @intAuthorID, 1, 0, @intOldStatus
		FETCH NEXT FROM tag_item_cursor 
			INTO @intID, @intTagID, @intObjectTypeID, @intCategoryID, @intAuthorID
	END
	CLOSE tag_item_cursor
	
	-- update to new status of all tag items
	UPDATE tblEpiServerCommonTagItem 
		SET	intStatus = @intNewStatus
	WHERE intID IN (SELECT intID FROM #tblEPiServerCommonTagItem)
	
	-- add with new status
	OPEN tag_item_cursor
	FETCH NEXT FROM tag_item_cursor 
		INTO @intID, @intTagID, @intObjectTypeID, @intCategoryID, @intAuthorID
		
	WHILE @@fetch_status = 0 
	BEGIN
		EXEC spEPiServerCommonTagUpdateTagItemsCount @intTagID, @intObjectTypeID, @intCategoryID, @intAuthorID, 1, 1, @intNewStatus
		FETCH NEXT FROM tag_item_cursor 
			INTO @intID, @intTagID, @intObjectTypeID, @intCategoryID, @intAuthorID
	END
	CLOSE tag_item_cursor
	
	DEALLOCATE tag_item_cursor
	DROP TABLE #tblEPiServerCommonTagItem
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRatingUpdateRatingItemStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Pierre Dahlstrom
-- Create date: 2010-06-11
-- Description:	Update status of ratings.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonRatingUpdateRatingItemStatus] 
	@intObjectID int, 
	@intObjectTypeID int,
	@intStatus smallint
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE tblEPiServerCommonRatableItem 
		SET	intStatus = @intStatus
	WHERE intObjectID = @intObjectID AND intObjectTypeID = @intObjectTypeID	AND intStatus <> @intStatus	
	
	UPDATE tblEPiServerCommonRatingLog
		SET	intStatus = @intStatus
	WHERE intObjectID = @intObjectID AND intObjectTypeID = @intObjectTypeID	AND intStatus <> @intStatus	
	
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsUpdateVisitsItemStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Pierre Dahlstrom
-- Create date: 2010-06-11
-- Description:	Update status of ratings.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsUpdateVisitsItemStatus] 
	@intObjectID int, 
	@intObjectTypeID int,
	@intStatus smallint
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE tblEPiServerCommonVisitableItem 
		SET	intStatus = @intStatus
	WHERE intObjectID = @intObjectID AND intObjectTypeID = @intObjectTypeID	AND intStatus <> @intStatus	
	
	UPDATE tblEPiServerCommonVisitLog
		SET	intStatus = @intStatus
	WHERE intObjectID = @intObjectID AND intObjectTypeID = @intObjectTypeID	AND intStatus <> @intStatus	
	
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagUpdateTagItemsCount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-05-09
-- Description:	Update number of items tagged with specific tag.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagUpdateTagItemsCount] 
	@intTagID int, -- id of the tag
	@intObjectTypeID int, -- id of the object (entity) type
	@intCategoryID int = null, -- id of the site of the entity
	@intAuthorID int = null, -- id of the user (tagger)
	@intArchiveIntervalHours int = 1, -- interval in days for items count archive
	@blnTagAdded bit = 1, -- indicates if the tag was added (1) or removed (0)
	@intStatus smallint
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @intItemsCountID INT
	DECLARE @datLastUpdate DATETIME
	DECLARE @intCount INT

	-- get the id of the record to update
	SELECT @intItemsCountID = intID, @datLastUpdate = datUpdateDate, @intCount = intCount
		FROM tblEPiServerCommonTagItemCount WITH(UPDLOCK)
		WHERE intTagID = @intTagID AND
			intObjectTypeID = @intObjectTypeID AND
			((@intCategoryID IS NULL AND intCategoryID IS NULL) OR (intCategoryID = @intCategoryID)) AND
			((@intAuthorID IS NULL AND intAuthorID IS NULL) OR (intAuthorID = @intAuthorID)) AND 
			intStatus = @intStatus
			
	-- there is no information about the count and we''re adding a tag, create one
	IF @intItemsCountID IS NULL AND @blnTagAdded = 1 BEGIN
		-- insert values into tag items count table
		INSERT INTO tblEPiServerCommonTagItemCount (intTagID, intObjectTypeID, intCategoryID, intAuthorID, datUpdateDate, intCount, intStatus)
			VALUES (@intTagID, @intObjectTypeID, @intCategoryID, @intAuthorID, CURRENT_TIMESTAMP, 1, @intStatus)
		SET @intItemsCountID = SCOPE_IDENTITY()
		-- insert values into tag items count archive table
		INSERT INTO tblEPiServerCommonTagItemCountArchive (intTagItemCountID, datDate, intStatus, intCount)
			VALUES (@intItemsCountID, CURRENT_TIMESTAMP, @intStatus, 1)
	END
	-- there is an entry with items count, update it
	ELSE BEGIN
		-- archive current items count if necessary
		IF (DATEDIFF(hh, @datLastUpdate, CURRENT_TIMESTAMP) > @intArchiveIntervalHours) BEGIN
			INSERT INTO tblEPiServerCommonTagItemCountArchive (intTagItemCountID, datDate, intStatus, intCount)
				VALUES (@intItemsCountID, CURRENT_TIMESTAMP, @intStatus, @intCount)
		END
		-- update current items count table
		IF @blnTagAdded = 1 BEGIN
			UPDATE tblEPiServerCommonTagItemCount
				SET intCount = @intCount + 1
				WHERE intID = @intItemsCountID
		END
		ELSE IF @intCount > 0 BEGIN
			UPDATE tblEPiServerCommonTagItemCount
				SET intCount = @intCount - 1
				WHERE intID = @intItemsCountID
		END
	END
	-- update tag items count with no division into object type or site
	IF @blnTagAdded = 1 BEGIN
		UPDATE tblEPiServerCommonTag
			SET intItemsCount = intItemsCount + 1
			WHERE intID = @intTagID
	END
	ELSE BEGIN
--		SELECT @intCount = intItemsCount FROM tblEPiServerCommonTag
--			WHERE intID = @intTagID
		UPDATE tblEPiServerCommonTag
			SET intItemsCount = CASE WHEN intItemsCount<=0 THEN 0 ELSE intItemsCount-1 END
			WHERE intID = @intTagID
	END

	IF @@ERROR <> 0 BEGIN
		RAISERROR (N''Error updating tag items count - SQL Server error.'', 16, 1)
		RETURN;
	END
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetMostPopularTags]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Kristoffer Sjoberg
-- Create date: 2007-07-03
-- Description:	Gets the most popular tags from database.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetMostPopularTags] 
	@strObjectType nvarchar(255) = null, -- the type to filter returned tags
	@xmlCollection xml,
	@intAuthorID int = null, -- the author to filter returned tags
	@strSearchFor nvarchar(255) = null, -- the search criteria
	@intMaxItems int, 
	@intStatus smallint
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	DECLARE @isCollectionEmpty BIT
		
	IF (@xmlCollection IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCollection.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END
	
	SET @strParamList = ''@intMaxItems int,
						 @intObjectTypeID int,
						 @strSearchFor nvarchar(255),
						 @intStatus smallint, 
						 @xmlCollection XML,
						 @intAuthorID int''
	
	-- determine the requested object type id
	DECLARE @intObjectTypeID int
	IF @strObjectType IS NOT NULL BEGIN
		SELECT @intObjectTypeID = intID
		FROM tblEntityType
		WHERE strName = @strObjectType
	END
	
	SET @strQuery = ''SELECT TOP (@intMaxItems) tblEPiServerCommonTag.intID, tblEPiServerCommonTag.strName, SUM(intCount) AS intTaggedCount
				     FROM tblEPiServerCommonTagItemCount AS tagCount
					 INNER JOIN tblEPiServerCommonTag ON tagCount.intTagID = tblEPiServerCommonTag.intID ''
					 
	SET @strQuery = @strQuery + ''WHERE	((intObjectTypeID=@intObjectTypeID) OR (@intObjectTypeID IS NULL))
								  AND   ((@intAuthorID IS NULL) OR (intAuthorID=@intAuthorID))
							      AND   ((tblEPiServerCommonTag.strName LIKE @strSearchFor) OR (@strSearchFor IS NULL)) 
							      AND	(intStatus & @intStatus != 0) ''
	
	IF @xmlCollection IS NOT NULL
	BEGIN
		IF (@isCollectionEmpty = 1)
			SET @strQuery = @strQuery + ''AND (tagCount.intCategoryID IS NULL) ''
		ELSE 
			SET @strQuery = @strQuery + ''AND tagCount.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
	END	

	SET @strQuery = @strQuery + ''GROUP BY tblEPiServerCommonTag.intID, tblEPiServerCommonTag.strName
							    ORDER BY SUM(tagCount.intCount) DESC''
	
	EXEC sp_executesql @strQuery, @strParamList, @intMaxItems, @intObjectTypeID, @strSearchFor, @intStatus, @xmlCollection, @intAuthorID 

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagAddTag]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-19
-- Description:	Adds a new tag to the database. If tag already exists, nothing changes.
-- In return the added (or existing) tag data is selected.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagAddTag] 
	@strName nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @intTagID int

	SELECT @intTagID = intID FROM tblEPiServerCommonTag WHERE strName = @strName

	-- if the tag does not exist, add it
	IF @intTagID IS NULL
	BEGIN
		INSERT INTO tblEPiServerCommonTag (strName)
		VALUES (@strName)
		SET @intTagID = SCOPE_IDENTITY()
	END

	-- select added or previously existing tag
	SELECT intID, strName, intItemsCount
	FROM tblEPiServerCommonTag
	WHERE intID = @intTagID

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagRemoveTag]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-19
-- Description:	Removes a tag from the database.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagRemoveTag] 
	@intTagID int = null, -- id of the tag to remove
	@strTagName nvarchar(255) -- name of the tag to remove (used when id is not spStarCommunityEcified)
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE FROM tblEPiServerCommonTag
	WHERE intID = ISNULL(@intTagID, (SELECT intID FROM tblEPiServerCommonTag WHERE strName = @strTagName))
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetEntityTagsCount]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-25
-- Description:	Gets number of items tagged with tag, filtered with specified paramters.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetEntityTagsCount] 
	@intTagID int = null, 
	@strTagName nvarchar(255),
	@strObjectTypeName nvarchar(255) = null,
	@xmlCollection xml,	
	@datSince datetime = null, 
	@intStatus smallint 
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @strParamList nvarchar(512)
	DECLARE @strQuery nvarchar(4000)
	
	DECLARE @intObjectTypeID INT
	DECLARE @isCollectionEmpty BIT
			
	IF (@xmlCollection IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCollection.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END
	
	SET @strParamList = ''@intTagID int, 
						 @strTagName nvarchar(255),
						 @strObjectTypeName nvarchar(255),
						 @datSince datetime,
						 @intObjectTypeID int,
						 @intStatus smallint, 
						 @xmlCollection xml,
						 @isCollectionEmpty BIT''


	IF @intTagID IS NULL
		SELECT @intTagID = intID FROM tblEPiServerCommonTag WHERE strName = @strTagName

	-- there is no such tag, return 0
	IF @intTagID IS NULL BEGIN
		SELECT 0
		RETURN
	END

	-- total items count
	IF  (@isCollectionEmpty = 1) AND (@strObjectTypeName IS NULL) 
	BEGIN
		SELECT ISNULL(intItemsCount, 0)
		FROM tblEPiServerCommonTag 
		WHERE intID = @intTagID
		RETURN
	END
	
	-- determine object type id
	IF @strObjectTypeName IS NOT NULL BEGIN
		SELECT @intObjectTypeID = intID FROM tblEntityType WHERE strName = @strObjectTypeName
		-- no such type, return 0
		IF @intObjectTypeID IS NULL BEGIN
			SELECT 0
			RETURN
		END
	END

	SET @strQuery = ''
	IF @datSince IS NULL BEGIN
		SELECT ISNULL(SUM(intCount), 0)
		FROM tblEPiServerCommonTagItemCount	
		WHERE intTagID = @intTagID AND
			((@intObjectTypeID IS NULL) OR (intObjectTypeID = @intObjectTypeID)) AND 
			(intStatus & @intStatus != 0) ''
			
	IF @xmlCollection IS NOT NULL
	BEGIN
		IF (@isCollectionEmpty = 1)
			SET @strQuery = @strQuery + ''AND tblEPiServerCommonTagItemCount.intCategoryID IS NULL ''
		ELSE
			SET @strQuery = @strQuery + ''AND tblEPiServerCommonTagItemCount.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
	END

	SET @strQuery = @strQuery + ''
	END
	ELSE
	BEGIN
		SELECT (ISNULL(SUM(tic.intCount),0) - ISNULL(SUM(tica.intCount), 0)) AS intCount
		FROM tblEPiServerCommonTagItemCount AS tic
		INNER JOIN tblEPiServerCommonTag AS tag ON (tic.intTagID = tag.intID)
		LEFT OUTER JOIN (
			SELECT intTagItemCountID, intCount
			FROM tblEPiServerCommonTagItemCountArchive AS one
			WHERE datDate = (
				SELECT MAX(datDate) 
				FROM tblEPiServerCommonTagItemCountArchive AS two
				WHERE datDate < @datSince and two.intTagItemCountID = one.intTagItemCountID)
			AND (one.intStatus & @intStatus != 0)
		) AS tica ON (tic.intID = tica.intTagItemCountID)
		WHERE intTagID = @intTagID AND
			((@intObjectTypeID IS NULL) OR (intObjectTypeID = @intObjectTypeID)) AND 
			(intStatus & @intStatus != 0) ''
	
	IF @xmlCollection IS NOT NULL
	BEGIN
		IF (@isCollectionEmpty = 1)
			SET @strQuery = @strQuery + ''AND tic.intCategoryID IS NULL ''
		ELSE
			SET @strQuery = @strQuery + ''AND tic.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''	
	END


	SET @strQuery = @strQuery + ''END''
	
	EXEC sp_executesql @strQuery, @strParamList, @intTagID, @strTagName, @strObjectTypeName, @datSince, @intObjectTypeID, @intStatus, @xmlCollection, @isCollectionEmpty

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetTaggedItems]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-27
-- Description:	Gets items tagged with specific tag (ID and type name).
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetTaggedItems]
	@intTagID int = null, -- the id of the tag
	@strTagName nvarchar(255),  -- the name of the tag, used when tag id is not specified
	@strObjectTypeName nvarchar(255) = null, -- name of the object type to get items for
	@intAuthorID int = null, -- id of the author to retrieve the items for (or null for any author)
	@intStatus smallint, 
	@xmlCollection xml,
	@intPage int, -- page number
	@intPageSize int -- page size
AS
BEGIN
	SET NOCOUNT ON;
	-- determine the tag id
	IF @intTagID IS NULL
		SELECT @intTagID = intID FROM tblEPiServerCommonTag WITH (NOLOCK) WHERE strName = @strTagName
	-- if there is no tag, no items can be tagged with it	
	IF @intTagID IS NULL
		RETURN
	DECLARE @rowStart INT, @rowEnd INT, @top INT
	-- compute the start and end row
	IF @intPage <= 0 SET @intPage = 1
	SET @rowStart = (@intPageSize * (@intPage - 1)) + 1;
	SET @rowEnd = @rowStart + @intPageSize - 1;
	SET @top = @intPage * @intPageSize
	CREATE TABLE #tblEPiServerCommonTemp(
		intID int IDENTITY PRIMARY KEY,
		intObjectID int,
		strObjectTypeName nvarchar(255)
	)
	
	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	
	DECLARE @isCollectionEmpty BIT	
		
	IF (@xmlCollection IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCollection.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END
	
	SET @strParamList = ''@intTagID int,
						 @strTagName nvarchar(255),
						 @strObjectTypeName nvarchar(255),
						 @intAuthorID int,
						 @intStatus smallint, 
						 @xmlCollection XML,
						 @count int OUTPUT,
						 @top int''
	
	DECLARE @count INT
	IF @intAuthorID IS NULL -- any author
	BEGIN
		-- get the count using precalculated values from tblEPiServerCommonTagItemCount table
		
		SET @strQuery = ''
		SELECT @count = ISNULL(SUM(intCount), 0)
			FROM tblEPiServerCommonTagItemCount AS tic WITH (NOLOCK)
			INNER JOIN tblEntityType AS objType ON tic.intObjectTypeID = objType.intID
			WHERE tic.intTagID = @intTagID AND
				((@strObjectTypeName IS NULL) OR (objType.strName = @strObjectTypeName)) AND 
				(tic.intStatus & @intStatus != 0) ''
				
		IF @xmlCollection IS NOT NULL
		BEGIN
			IF (@isCollectionEmpty = 1)
				SET @strQuery = @strQuery + ''AND (tic.intCategoryID IS NULL) ''
			ELSE 
				SET @strQuery = @strQuery + ''AND tic.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
		END

		SET @strQuery = @strQuery + ''
		INSERT INTO #tblEPiServerCommonTemp (intObjectID, strObjectTypeName)
			SELECT TOP (@top) tagItem.intObjectID, objType.strName
			FROM tblEPiServerCommonTagItem AS tagItem
			INNER JOIN tblEPiServerCommonTag AS tag WITH (NOLOCK) ON tag.intID = tagItem.intTagID
			INNER JOIN tblEntityType AS objType ON tagItem.intObjectTypeID = objType.intID
			WHERE tag.intID = @intTagID AND
				((@strObjectTypeName IS NULL) OR (objType.strName = @strObjectTypeName)) AND
				(tagItem.intStatus & @intStatus != 0) ''
				
		IF @xmlCollection IS NOT NULL
		BEGIN
			IF (@isCollectionEmpty = 1)
				SET @strQuery = @strQuery + ''AND (tagItem.intCategoryID IS NULL) ''
			ELSE 
				SET @strQuery = @strQuery + ''AND tagItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
		END

		SET @strQuery = @strQuery + ''GROUP BY tagItem.intObjectID, objType.strName''
		
		EXEC sp_executesql @strQuery, @strParamList, @intTagID, @strTagName, @strObjectTypeName, @intAuthorID, @intStatus, @xmlCollection, @count OUTPUT, @top

	END
	ELSE
	BEGIN
		-- @intAuthorID was specified
		SET @strQuery = ''
		INSERT INTO #tblEPiServerCommonTemp (intObjectID, strObjectTypeName)
			SELECT tagItem.intObjectID, objType.strName
			FROM tblEPiServerCommonTagItem AS tagItem
			INNER JOIN tblEPiServerCommonTag AS tag WITH (NOLOCK) ON tag.intID = tagItem.intTagID
			INNER JOIN tblEntityType AS objType ON tagItem.intObjectTypeID = objType.intID
			WHERE tag.intID = @intTagID AND
				((@strObjectTypeName IS NULL) OR (objType.strName = @strObjectTypeName)) AND
				(tagItem.intAuthorID=@intAuthorID) AND 
				(tagItem.intStatus & @intStatus != 0) ''

		IF @xmlCollection IS NOT NULL
		BEGIN
			IF (@isCollectionEmpty = 1)
				SET @strQuery = @strQuery + ''AND (tagItem.intCategoryID IS NULL) ''
			ELSE 
				SET @strQuery = @strQuery + ''AND tagItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
		END

		SET @strQuery = @strQuery + ''
			GROUP BY tagItem.intObjectID, objType.strName

		SET @count = @@ROWCOUNT''


		EXEC sp_executesql @strQuery, @strParamList, @intTagID, @strTagName, @strObjectTypeName, @intAuthorID, @intStatus, @xmlCollection, @count OUTPUT, @top

	END
	
	SELECT intObjectID, strObjectTypeName, @count
	FROM #tblEPiServerCommonTemp
	WHERE intID BETWEEN @rowStart AND @rowEnd
	DROP TABLE #tblEPiServerCommonTemp
	
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetPredefinedTags]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-25
-- Description:	Returns tags predefined for given parameters.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetPredefinedTags] 
	@intEntityTypeID INT, -- the type name the tag was predefined for
	@intAuthorID INT = NULL, -- the user id the tag was predefined for
	@xmlCollection xml,
	@intPredefinedTagTypeID	INT
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	
	DECLARE @isCollectionEmpty BIT
			
	IF (@xmlCollection IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCollection.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END
	
	SET @strParamList = ''@intEntityTypeID INT,
						 @intAuthorID INT,
						 @xmlCollection XML,
						 @intPredefinedTagTypeID INT''


	-- select tags that are used in the predefinitions
	SET @strQuery = ''SELECT tag.intID, tag.strName, tag.intItemsCount, objType.strName, preDef.intAuthorID, predef.intID
				FROM tblEPiServerCommonTag as tag
				INNER JOIN tblEPiServerCommonTagPredefinedTag AS predef ON tag.intID = predef.intTagID
				INNER JOIN tblEntityType AS objType ON predef.intObjectTypeID = objType.intID
				WHERE ((@intEntityTypeID IS NULL) OR (objType.intID = @intEntityTypeID)) AND
				((@intAuthorID IS NULL AND predef.intAuthorID IS NULL) OR (predef.intAuthorID = @intAuthorID)) ''

	IF @xmlCollection IS NOT NULL
	BEGIN
		IF (@isCollectionEmpty = 1)
			SET @strQuery = @strQuery + ''AND NOT EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
										(catItem.intObjectTypeID = @intPredefinedTagTypeID AND catItem.intObjectID = predef.intID) ''
		ELSE
			SET @strQuery = @strQuery + ''AND EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE
										(catItem.intObjectTypeID = @intPredefinedTagTypeID AND catItem.intObjectID = predef.intID
										 AND catItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ))''
	END

	SET @strQuery = @strQuery + ''ORDER BY tag.strName''

	PRINT @strQuery	

	EXEC sp_executesql @strQuery, @strParamList, @intEntityTypeID, @intAuthorID, @xmlCollection, @intPredefinedTagTypeID

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetPredefinedTagById]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetPredefinedTagById] 
	@intPredefinedTagID INT 
AS
BEGIN
	SET NOCOUNT ON;

	-- select tags that are used in the predefinitions
	SELECT tag.intID, tag.strName, tag.intItemsCount, objType.strName, preDef.intAuthorID, predef.intID
	FROM tblEPiServerCommonTag as tag
	INNER JOIN tblEPiServerCommonTagPredefinedTag AS predef ON tag.intID = predef.intTagID
	INNER JOIN tblEntityType AS objType ON predef.intObjectTypeID = objType.intID
	WHERE predef.intID = @intPredefinedTagID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetEntityTag]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Håkan Lindqvist
-- Create date: 2008-12-17
-- Description:	Gets a entitytag by its ID.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetEntityTag] 
	@intID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT tag.intID, tag.strName, 
		tagItem.intID, tagItem.datCreateDate,
		tagItem.intAuthorID, tagItem.intCategoryID, tagItem.intStatus, tag.intItemsCount
	FROM tblEPiServerCommonTag AS tag
	INNER JOIN tblEPiServerCommonTagItem AS tagItem ON (
		tagItem.intTagID = tag.intID)
	INNER JOIN tblEntityType AS objectType ON objectType.intID = tagItem.intObjectTypeID
	WHERE tagItem.intID = @intID

END
' 
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetTagByID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-19
-- Description:	Gets a tag by its ID.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetTagByID] 
	@intID int
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT intID, strName, intItemsCount
	FROM tblEPiServerCommonTag
	WHERE intID = @intID

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagRemovePredefinedTag]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-25
-- Description:	Removes a predefined tag from the database.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagRemovePredefinedTag] 
	@intPredefinedTagID int
AS
BEGIN
	SET NOCOUNT ON;
	
	DELETE tblEPiServerCommonTagPredefinedTag
	WHERE intID = @intPredefinedTagID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetTagByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-19
-- Description:	Gets a tag by its name.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetTagByName] 
	@strName nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT intID, strName, intItemsCount
	FROM tblEPiServerCommonTag
	WHERE strName = @strName

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetEntityTags]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-23
-- Description:	Gets all tags associated with spEPiServerCommonEcific entity.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetEntityTags]
	@intObjectID int, -- if of the entity to get the tags for
	@intObjectTypeID int, -- id of the entity type
	@xmlCollection xml
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	
	DECLARE @isCollectionEmpty BIT
		
	IF (@xmlCollection IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCollection.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END

	
	SET @strParamList = ''@intObjectID int,
						 @intObjectTypeID int,
						 @xmlCollection XML''
	
	SET @strQuery = ''SELECT tag.intID, tag.strName, 
					 tagItem.intID, tagItem.datCreateDate,
					 tagItem.intAuthorID, tagItem.intCategoryID, tagItem.intStatus, tag.intItemsCount
					 FROM tblEPiServerCommonTag AS tag
					 INNER JOIN tblEPiServerCommonTagItem AS tagItem ON 
					 (tagItem.intTagID = tag.intID AND tagItem.intObjectID = @intObjectID)
					 INNER JOIN tblEntityType AS objectType ON objectType.intID = tagItem.intObjectTypeID ''

	SET @strQuery = @strQuery + ''WHERE objectType.intID = @intObjectTypeID ''
	
	IF @xmlCollection IS NOT NULL
	BEGIN
		IF (@isCollectionEmpty = 1)
			SET @strQuery = @strQuery + ''AND intCategoryID IS NULL ''
		ELSE
			SET @strQuery = @strQuery + ''AND tagItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
	END

	EXEC sp_executesql @strQuery, @strParamList, @intObjectID, @intObjectTypeID, @xmlCollection

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetMostRatedItems]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =========================================================
-- Author:		Daniel Furtado
-- Create date: 2008-08-19
-- Description:	Retrieve the most popular items
-- =========================================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetMostRatedItems]	
	@strObjectTypeName nvarchar(250),
	@minimumVotesRequired int,	
	@maxItems int, 
	@intStatus smallint, 
	@xmlCollection xml, 
	@intPage int,
	@intPageSize int
AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	DECLARE @intStartRec int
	DECLARE @intEndRec int
	DECLARE @C float
	DECLARE @isCollectionEmpty BIT	

	IF (@xmlCollection IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCollection.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END
		
	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)

	-- getting the C value which is the average rating for the items
	IF @strObjectTypeName IS NOT NULL
	BEGIN
		WITH temp AS ( 
			SELECT intObjectTypeID, intObjectID, fltRating, intStatus, COUNT(*) OVER(PARTITION BY intObjectTypeID,intObjectID) AS numVotes
			FROM tblEPiServerCommonRatingLog 
		) 
		SELECT @C = ROUND(SUM(average)/total, 2) FROM (
		SELECT intObjectID, (sum(fltRating)/numVotes) AS average, COUNT(*) OVER() AS total FROM temp
		INNER JOIN tblEntityType ON tblEntityType.intID = intObjectTypeID
		AND tblEntityType.strName = @strObjectTypeName
		WHERE (intStatus & @intStatus != 0)
		GROUP BY intObjectID, numVotes ) temp GROUP BY total;
	END
	ELSE
	BEGIN
		WITH temp AS ( 
			SELECT intObjectTypeID, intObjectID, fltRating, intStatus, COUNT(*) OVER(PARTITION BY intObjectTypeID,intObjectID) AS numVotes
			FROM tblEPiServerCommonRatingLog 	
		) 
		SELECT @C = ROUND(SUM(average)/total, 2) FROM (
		SELECT intObjectID, (sum(fltRating)/numVotes) AS average, COUNT(*) OVER() AS total FROM temp 
		WHERE (intStatus & @intStatus != 0)
		GROUP BY intObjectID, numVotes ) temp GROUP BY total;
	END

	SET @strParamList = ''@strObjectTypeName nvarchar(250),
						 @minimumVotesRequired int,						 
						 @maxItems int,												
				         @intStartRec int, 
						 @intEndRec int, 
						 @intStatus smallint, 
						 @xmlCollection XML''


	SET @strQuery = ''WITH temp AS ( 
		 				SELECT intObjectTypeID, intObjectID, fltRating, intStatus, COUNT(*) OVER(PARTITION BY intObjectTypeID,intObjectID) AS numVotes
						FROM tblEPiServerCommonRatingLog 	
				     )

					SELECT intObjectId, strName, popularityRate, intObjectTypeID, numVotes, intRowNumber, intTotalItems FROM (
					SELECT 
					intObjectTypeID, strName, intObjectId, numVotes, popularityRate,
					ROW_NUMBER() OVER (ORDER BY popularityRate DESC) AS intRowNumber,
					COUNT(*) OVER() as intTotalItems FROM ( SELECT ''

	
    SET @strQuery = @strQuery + ''intObjectTypeID, intObjectID, (SUM(fltRating)/numVotes) as mean , numVotes, 
								 dbo.fnEPiServerCommonCalculatePopularity(numVotes, @minimumVotesRequired, (SUM(fltRating)/numVotes), '' + CAST(@C AS nvarchar(10)) + '') as popularityRate
								 FROM temp 
								 WHERE numVotes >= @minimumVotesRequired AND (intStatus & @intStatus != 0) ''
    
    SET @strQuery = @strQuery + '' GROUP BY intObjectTypeID,intObjectID, numVotes ) temp
                                  INNER JOIN tblEntityType  ON tblEntityType.intID = intObjectTypeID ''

    IF @strObjectTypeName IS NOT NULL
		SET @strQuery = @strQuery + '' AND tblEntityType.strName = @strObjectTypeName ''
	
	IF @xmlCollection IS NOT NULL
	BEGIN
		IF (@isCollectionEmpty = 1)
			SET @strQuery = @strQuery + ''AND NOT EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE 
				(catItem.intObjectTypeID = temp.intObjectTypeID AND catItem.intObjectID = temp.intObjectID)) '' 
		ELSE
			SET @strQuery = @strQuery + ''AND EXISTS (SELECT * FROM tblEPiServerCommonCategoryItem AS catItem WHERE 
				(catItem.intObjectTypeID = temp.intObjectTypeID AND catItem.intObjectID = temp.intObjectID 
				AND catItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) )) '' 
	END
	
	SET @strQuery = @strQuery +	'' ) temp WHERE intRowNumber >= @intStartRec and intRowNumber <= @intEndRec ORDER BY popularityRate DESC'' 	  

	EXEC sp_executesql @strQuery, @strParamList, @strObjectTypeName, @minimumVotesRequired, @maxItems, @intStartRec, @intEndRec, @intStatus, @xmlCollection
    
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonLoggingGetLogEntries]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-12-14
-- Description:	Gets log entries for object id and type
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonLoggingGetLogEntries]
@intObjectID int,
@intObjectTypeID int
AS

BEGIN
	SET NOCOUNT ON;

	SELECT t1.intID, t2.strName, t1.intObjectID, t1.strIP, 
	t1.intUserID, t1.datCreated, t1.intAction
	FROM tblEPiServerCommonActivityLog AS t1
	INNER JOIN tblEntityType AS t2 ON t1.intObjectTypeID=t2.intID
	WHERE intObjectID=@intObjectID
	AND intObjectTypeID=@intObjectTypeID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonLoggingGetActivityLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-12-14
-- Description:	Gets log entries for object id and type
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonLoggingGetActivityLog]
@intID int
AS

BEGIN
	SET NOCOUNT ON;

	SELECT t1.intID, t2.strName, t1.intObjectID, t1.strIP, 
	t1.intUserID, t1.datCreated, t1.intAction
	FROM tblEPiServerCommonActivityLog AS t1
	INNER JOIN tblEntityType AS t2 ON t1.intObjectTypeID=t2.intID
	WHERE t1.intID=@intID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetRating]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Söderberg
-- Create date: 2007-06-20
-- Description:	Gets a rating by id
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetRating] 
@intID int
AS
BEGIN

	SET NOCOUNT ON

		SELECT	r.intID, ot.strName AS strObjectTypeName, 
				r.intObjectID, r.fltRating, 
				r.datTimeStamp, r.intAuthorID
		FROM dbo.tblEPiServerCommonRatingLog AS r
		INNER JOIN tblEntityType AS ot ON r.intObjectTypeID = ot.intID
		AND r.intID = @intID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingGetReportCase]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Gets a report case by ID
-- =============================================

CREATE  PROCEDURE [dbo].[spEPiServerCommonReportingGetReportCase] 
@intID int
AS
SET NOCOUNT ON
SELECT t1.intID, t1.intObjectID, t1.intObjectTypeID, t1.intReportCaseStatus, 
t1.datCreated, t1.datLastModified, t1.strComment, t1.strReportDataTitle,
t1.strReportDataXml, t1.datReportDataCreated, t1.intReportDataAuthorID, t1.intNumReports, t1.intStatus, t1.intPreviousStatus
FROM 	tblEPiServerCommonReportCase AS t1
WHERE 	t1.intID = @intID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetRatingByAuthor]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Söderberg
-- Create date: 2007-06-18
-- Description:	Gets a rating
-- =============================================

CREATE PROCEDURE [dbo].[spEPiServerCommonGetRatingByAuthor] 
@intObjectTypeID int, 
@intObjectID int, 
@intAuthorID int,
@strAuthorEmail varchar(1024)
AS
BEGIN

	SET NOCOUNT ON

	IF @intAuthorID IS NOT NULL
	BEGIN
		SELECT	r.intID, ot.strName AS strObjectTypeName, 
				r.intObjectID, r.fltRating, 
				r.datTimeStamp, r.intAuthorID
		FROM dbo.tblEPiServerCommonRatingLog AS r
		INNER JOIN tblEntityType AS ot ON r.intObjectTypeID = ot.intID
		INNER JOIN tblEPiServerCommonAuthor AS a 
			ON (a.intID = r.intAuthorID)
		WHERE r.intObjectTypeID = @intObjectTypeID AND r.intObjectID = @intObjectID
		AND r.intAuthorID = @intAuthorID
	END
	ELSE
	BEGIN
		SELECT	r.intID, ot.strName AS strObjectTypeName, 
				r.intObjectID, r.fltRating, 
				r.datTimeStamp, r.intAuthorID
		FROM dbo.tblEPiServerCommonRatingLog AS r
		INNER JOIN tblEntityType AS ot ON r.intObjectTypeID = ot.intID
		INNER JOIN tblEPiServerCommonAuthor AS a 
			ON (a.intID = r.intAuthorID AND a.strAuthorEmail = @strAuthorEmail)
		WHERE r.intObjectTypeID = @intObjectTypeID AND r.intObjectID = @intObjectID
	END
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagGetTags]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-19
-- Description:	Gets tags from database.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagGetTags] 
	@strObjectType nvarchar(255) = null, -- the type to filter returned tags
	@intAuthorID int = null, -- the user to filter returned tags
	@xmlCollection xml,
	@intPage int, -- page number
	@intPageSize int -- page size
AS
BEGIN
	SET NOCOUNT ON;	
	
	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	
	DECLARE @isCollectionEmpty BIT
		
	IF (@xmlCollection IS NOT NULL)
	BEGIN
		IF NOT EXISTS (SELECT * FROM @xmlCollection.nodes(''/collection/item'') AS T(c))
			SET @isCollectionEmpty = 1
		ELSE
			SET @isCollectionEmpty = 0
	END
		
	
	SET @strParamList = ''@strObjectType nvarchar(255),
						 @intAuthorID int,
						 @intPage int,
						 @intPageSize int,
						 @xmlCollection XML''
	
	SET @strQuery = ''
	DECLARE @rowStart int
	DECLARE @rowEnd int
	DECLARE @topItems int
	-- determine the requested object type id
	DECLARE @intObjectTypeID int
	IF @strObjectType IS NOT NULL BEGIN
		SELECT @intObjectTypeID = intID
		FROM tblEntityType
		WHERE strName = @strObjectType
	END
	-- compute the start and end row
	IF @intPage <= 0 SET @intPage = 1
	SET @rowStart = (@intPageSize * (@intPage - 1)) + 1;
	SET @rowEnd = @rowStart + @intPageSize - 1;
	SET @topItems = @intPage * @intPageSize
	CREATE TABLE #tblEPiServerCommonTemp(
		intID int IDENTITY PRIMARY KEY,
		intTagID int
	)
	
	DECLARE @tagsCount int
	
	-- get the total number of tags that fits the filter specified
	SELECT @tagsCount = ISNULL(SUM(intCount), 0)
		FROM tblEPiServerCommonTagItemCount AS tic
		WHERE ((@strObjectType IS NULL) OR (tic.intObjectTypeID = @intObjectTypeID)) AND
			((@intAuthorID IS NULL) OR (tic.intAuthorID = @intAuthorID)) ''
	
	IF @xmlCollection IS NOT NULL
	BEGIN
		IF (@isCollectionEmpty = 1)
			SET @strQuery = @strQuery + ''AND (tic.intCategoryID IS NULL) ''
		ELSE 
			SET @strQuery = @strQuery + ''AND tic.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
	END	

	SET @strQuery = @strQuery + ''

	INSERT INTO #tblEPiServerCommonTemp (intTagID)
		SELECT TOP (@topItems) tag.intID
		FROM tblEPiServerCommonTag AS tag
		INNER JOIN tblEPiServerCommonTagItem AS tagItem ON tag.intID = tagItem.intTagID
		WHERE (@strObjectType IS NULL OR tagItem.intObjectTypeID = @intObjectTypeID) AND
		((@intAuthorID IS NULL)	OR (@intAuthorID IS NOT NULL AND tagItem.intAuthorID = @intAuthorID)) ''
	
	IF @xmlCollection IS NOT NULL
	BEGIN
		IF (@isCollectionEmpty = 1)
			SET @strQuery = @strQuery + ''AND (tagItem.intCategoryID IS NULL) ''
		ELSE 
			SET @strQuery = @strQuery + ''AND tagItem.intCategoryID = ANY (SELECT T.c.value(''''./@itemID'''',''''int'''') FROM @xmlCollection.nodes(''''/collection/item'''') AS T(c)) ''
	END	
		
	SET @strQuery = @strQuery + ''
		ORDER BY tag.strName
	
	-- select requested page
	SELECT DISTINCT tag.intID, tag.strName, tag.intItemsCount, @tagsCount as intTotalCount
	FROM #tblEPiServerCommonTemp tmp
	INNER JOIN tblEPiServerCommonTag as tag on tmp.intTagID = tag.intID
	WHERE tmp.intID BETWEEN @rowStart AND @rowEnd
	DROP TABLE #tblEPiServerCommonTemp''

	EXEC sp_executesql @strQuery, @strParamList, @strObjectType, @intAuthorID, @intPage, @intPageSize, @xmlCollection
	
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonLoggingAddActivityLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-12-14
-- Description:	Adds an entry log
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonLoggingAddActivityLog]
@intObjectID int,
@intObjectTypeID int,
@strIP varchar(45),
@intUserID int,
@intAction tinyint
AS

BEGIN
	SET NOCOUNT ON;

	INSERT INTO tblEPiServerCommonActivityLog
	(
		intObjectID, 
		intObjectTypeID,
		strIP,
		intUserID,
		intAction
	)
	VALUES
	(
		@intObjectID, 
		@intObjectTypeID,
		@strIP,
		@intUserID,
		@intAction
	)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAttributeValueChoiceFloat]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-11
-- Description:	Adds a attribute value choice to the float table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAttributeValueChoiceFloat]
@intAttributeID int,
@strText nvarchar(400),
@fltValue float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO tblEPiServerCommonAttributeValueChoiceFloat (intAttributeID, fltValue, strText) 
	VALUES(@intAttributeID, @fltValue, @strText)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAttributeValueDateTime]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-09
-- Description:	Adds an attribute value to the DateTime table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAttributeValueDateTime] 
@intAttributeID int,
@intObjectID int,
@intSequence int,
@datValue datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO tblEPiServerCommonAttributeValueDateTime (intAttributeID, intObjectID, intSequence, datValue)
	VALUES (@intAttributeID, @intObjectID, @intSequence, @datValue)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAttributeValueChoiceDateTime]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-11
-- Description:	Adds a attribute value choice to the datetime table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAttributeValueChoiceDateTime]
@intAttributeID int,
@strText nvarchar(400),
@datValue datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO tblEPiServerCommonAttributeValueChoiceDateTime (intAttributeID, datValue, strText) 
	VALUES(@intAttributeID, @datValue, @strText)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAttributeValueChoiceInteger]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-11
-- Description:	Adds a attribute value choice to the integer table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAttributeValueChoiceInteger]
@intAttributeID int,
@strText nvarchar(400),
@intValue int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO tblEPiServerCommonAttributeValueChoiceInteger (intAttributeID, intValue, strText) 
	VALUES(@intAttributeID, @intValue, @strText)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAttributeValueChoiceBoolean]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-11
-- Description:	Adds a boolean attribute value choice to the integer table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAttributeValueChoiceBoolean]
@intAttributeID int,
@strText nvarchar(400),
@blnValue bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO tblEPiServerCommonAttributeValueChoiceInteger (intAttributeID, intValue, strText) 
	VALUES(@intAttributeID, CAST(@blnValue AS int), @strText)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAttributeValueInteger]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-09
-- Description:	Adds an attribute value to the Integer table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAttributeValueInteger] 
@intAttributeID int,
@intObjectID int,
@intSequence int,
@intValue int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO tblEPiServerCommonAttributeValueInteger (intAttributeID, intObjectID, intSequence, intValue)
	VALUES (@intAttributeID, @intObjectID, @intSequence, @intValue)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAttributeValueBoolean]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-09
-- Description:	Adds a Boolean attribute value to the Integer table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAttributeValueBoolean]
@intAttributeID int,
@intObjectID int,
@intSequence int,
@blnValue bit
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO tblEPiServerCommonAttributeValueInteger (intAttributeID, intObjectID, intSequence, intValue)
	VALUES (@intAttributeID, @intObjectID, @intSequence, CAST(@blnValue AS int))
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAttributeValueChoiceString]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-11
-- Description:	Adds a attribute value choice to the string table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAttributeValueChoiceString]
@intAttributeID int,
@strText nvarchar(400),
@strValue nvarchar(400)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO tblEPiServerCommonAttributeValueChoiceString (intAttributeID, strValue, strText) 
	VALUES(@intAttributeID, @strValue, @strText)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAttributeValueFloat]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-09
-- Description:	Adds an attribute value to the Float table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAttributeValueFloat] 
@intAttributeID int,
@intObjectID int,
@intSequence int,
@fltValue float
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO tblEPiServerCommonAttributeValueFloat (intAttributeID, intObjectID, intSequence, fltValue)
	VALUES (@intAttributeID, @intObjectID, @intSequence, @fltValue)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAttributeValueString]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-07-09
-- Description:	Adds an attribute value to the String table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAttributeValueString] 
@intAttributeID int,
@intObjectID int,
@intSequence int,
@strValue nvarchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO tblEPiServerCommonAttributeValueString (intAttributeID, intObjectID, intSequence, strValue)
	VALUES (@intAttributeID, @intObjectID, @intSequence, @strValue)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagRemoveTaggedEntityTagsInternal]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Kristoffer Sjöberg
-- Create date: 2007-09-18
-- Description:	Removes all tags from the entities with ids provided and updates the tagged items count table. 
-- Used when a tagged item is removed from the database. This procedure is called from
-- spEPiServerCommonRemoveObjectReferences
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagRemoveTaggedEntityTagsInternal] 
	@intObjectTypeID int,
	@xmlDoc XML
AS
BEGIN
	SET NOCOUNT ON;
	
	IF @intObjectTypeID IS NULL
		RETURN;
    -- table variable holds OPENXMLs output:
	DECLARE @tempObjs TABLE (ObjectID int NOT NULL)
    -- populate the table variable
	INSERT @tempObjs (ObjectID) SELECT T.c.value(''./@ObjectID'',''int'') FROM @xmlDoc.nodes(''/Root/Obj'') AS T(c)
    
	CREATE TABLE #tblEPiServerCommonAffectedRows (intID INT, datDate DATETIME, intCount INT, intStatus SMALLINT)
	
	INSERT INTO #tblEPiServerCommonAffectedRows (intID, datDate, intCount, intStatus)
		SELECT DISTINCT tic.intID, tic.datUpdateDate, tic.intCount, tic.intStatus 
		FROM tblEPiServerCommonTagItemCount AS tic
		INNER JOIN tblEPiServerCommonTagItem AS ti ON (
			tic.intTagID = ti.intTagID AND
			tic.intObjectTypeID = ti.intObjectTypeID AND
			((tic.intStatus = ti.intStatus)) AND
			((tic.intCategoryID IS NULL AND ti.intCategoryID IS NULL) OR (tic.intCategoryID = ti.intCategoryID)) AND
			((tic.intAuthorID IS NULL AND ti.intAuthorID IS NULL) OR (tic.intAuthorID = ti.intAuthorID))
		)
		WHERE ti.intObjectTypeID = @intObjectTypeID AND
			ti.intObjectID IN (SELECT ObjectID FROM @tempObjs)

	-- get tags affected	
	CREATE TABLE #tblEPiServerCommonAffectedTags (intID INT)
	INSERT INTO #tblEPiServerCommonAffectedTags (intID)
		SELECT intTagID
		FROM tblEPiServerCommonTagItem AS ti
		WHERE ti.intObjectTypeID = @intObjectTypeID AND
			ti.intObjectID IN (SELECT ObjectID FROM @tempObjs)
		GROUP BY (intTagID)

	-- archive records if necessary
	INSERT INTO tblEPiServerCommonTagItemCountArchive (intTagItemCountID, datDate, intStatus, intCount)
		SELECT ar.intID, CURRENT_TIMESTAMP, ar.intStatus, ar.intCount
		FROM #tblEPiServerCommonAffectedRows AS ar
		WHERE (DATEDIFF(hh, ar.datDate, CURRENT_TIMESTAMP) > 24)

	-- update count
	UPDATE tblEPiServerCommonTagItemCount
		SET intCount = intCount - 1, datUpdateDate = CURRENT_TIMESTAMP
		WHERE intID IN (SELECT intID FROM #tblEPiServerCommonAffectedRows)

	-- update tag count
	UPDATE tblEPiServerCommonTag
		SET intItemsCount = intItemsCount - 1
		WHERE intID IN (SELECT intID FROM #tblEPiServerCommonAffectedTags)

	-- now delete the tags associated with the deleted item.
	DELETE FROM tblEPiServerCommonTagItem
		WHERE intObjectTypeID = @intObjectTypeID AND
			intObjectID IN (SELECT ObjectID FROM @tempObjs)

	DROP TABLE #tblEPiServerCommonAffectedTags
	DROP TABLE #tblEPiServerCommonAffectedRows
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetCategoriesByEntity]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		NRA
-- Create date: 2007-04-05
-- Description:	Gets categories connected to an entity from the database
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetCategoriesByEntity]
	@intEPiServerCommonEntityID int,
	@intObjectTypeID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT	c.intID, c.strName, c.intParentID
	FROM	tblEPiServerCommonCategory c
	INNER	JOIN tblEPiServerCommonCategoryItem ci ON c.intID = ci.intCategoryID AND ci.intObjectID = @intEPiServerCommonEntityID AND ci.intObjectTypeID = @intObjectTypeID
	ORDER BY c.strName
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetCategories]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		NRA
-- Create date: 2007-04-05
-- Description:	Gets categories based on a site from the database
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetCategories]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT	intID, strName, intParentID
	FROM	tblEPiServerCommonCategory
	WHERE	intParentID IS NULL
	ORDER BY strName
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		NRA
-- Create date: 2007-04-05
-- Description:	Adds a category
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddCategory] 
@strName nvarchar(200),
@intParentID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO tblEPiServerCommonCategory (strName, intParentID)
	VALUES (@strName, @intParentID)

	SELECT SCOPE_IDENTITY()
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetCategoryByName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		NRA
-- Create date: 2007-04-05
-- Description:	Gets a category by its name
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetCategoryByName] 
@strName nvarchar(200),
@intParentID int
AS
BEGIN
	SET NOCOUNT ON;

	IF (@intParentID IS NOT NULL)
	BEGIN
		SELECT	intID, strName, intParentID
		FROM	tblEPiServerCommonCategory
		WHERE	strName = @strName
		AND		intParentID = @intParentID
	END
	ELSE
	BEGIN
		--This is the rare case where we want to get a global (no site) root category
		SELECT	intID, strName, intParentID
		FROM	tblEPiServerCommonCategory
		WHERE	strName = @strName
		AND		intParentID IS NULL
	END
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		NRA
-- Create date: 2007-04-05
-- Description:	Gets a category by its ID
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetCategory] 
@intID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT	intID, strName, intParentID
	FROM	tblEPiServerCommonCategory
	WHERE	intID = @intID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonUpdateCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		NRA
-- Create date: 2007-04-05
-- Description:	Updates a category
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonUpdateCategory] 
@intID int,
@strName nvarchar(200),
@intParentID int
AS
BEGIN
	UPDATE	tblEPiServerCommonCategory
	SET		strName = @strName,
			intParentID = @intParentID
	WHERE	intID = @intID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		NRA
-- Create date: 2007-04-05
-- Description:	Removes a category
-- Updated: PD, added removal of child categories
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveCategory] 
@intID int
AS
BEGIN
	CREATE TABLE #CategoriesToRemove (Id int, RecursionLevel int)
	CREATE TABLE #CurrentParents (Id int)
	CREATE TABLE #CurrentChildren (Id int)
	
	DECLARE @CurrentLevel int
	SET @CurrentLevel = 0

	--Start with insert @intID into #CurrentParents
	INSERT INTO #CurrentParents VALUES (@intID)
	
	WHILE (@@ROWCOUNT > 0)
	BEGIN
		--Select all children	
		INSERT INTO #CurrentChildren SELECT intID FROM tblEPiServerCommonCategory WHERE intParentID IN (SELECT Id FROM #CurrentParents)

		--Move parents to #CategoriesToRemove
		INSERT INTO #CategoriesToRemove SELECT Id, @CurrentLevel FROM #CurrentParents
		SET @CurrentLevel = @CurrentLevel + 1
		
		--Delete #CurrentParents
		DELETE FROM #CurrentParents
		
		--Move children to #CurrentParents
		INSERT INTO #CurrentParents SELECT Id FROM #CurrentChildren

		--Delete #CurrentChildren
		DELETE FROM #CurrentChildren
	END

	WHILE (@CurrentLevel > 0)
	BEGIN
		SET @CurrentLevel = @CurrentLevel - 1
		
		DELETE FROM	tblEPiServerCommonCategory
		WHERE intID IN (SELECT Id FROM #CategoriesToRemove WHERE RecursionLevel = @CurrentLevel)
	END

	SELECT Id FROM #CategoriesToRemove
	
	DROP TABLE #CategoriesToRemove
	DROP TABLE #CurrentParents
	DROP TABLE #CurrentChildren

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetChildCategories]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		NRA
-- Create date: 2007-04-05
-- Description:	Gets child categories based on a parent from the database
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetChildCategories]
	@intParentCategoryID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT	intID, strName, intParentID
	FROM	tblEPiServerCommonCategory
	WHERE	intParentID = @intParentCategoryID
	ORDER BY strName
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingIsReportedEntity]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Gets if this object has report cases of status New (1)
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonReportingIsReportedEntity]
@intObjectID int,
@intObjectTypeID int 
AS
BEGIN
	SET NOCOUNT ON 

	IF EXISTS(SELECT * FROM tblEPiServerCommonReportCase WHERE intObjectID=@intObjectID AND intObjectTypeID=@intObjectTypeID AND intReportCaseStatus=1)
		SELECT 1
	ELSE
		SELECT 0

	SET NOCOUNT OFF 
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingAddReport]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Adds a report and adds a report case if neccessary
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonReportingAddReport]
@strDescription nvarchar(MAX),
@strUrl nvarchar(2000),
@datReportDate datetime,
@intAuthorID int,
@intObjectID int, 
@intObjectTypeID int,
@strReportDataTitle nvarchar(1000),
@strReportDataXml nvarchar(MAX),
@datReportDataCreated datetime,
@intReportDataAuthorID int,
@intStatus smallint, 
@intPreviousStatus smallint

AS

DECLARE @intReportCaseID int

BEGIN
	SET NOCOUNT ON 

	--Create a new report matter if this is the first report
	SELECT TOP 1 @intReportCaseID = intID 
	FROM tblEPiServerCommonReportCase 
	WHERE intObjectID=@intObjectID
	AND intObjectTypeID=@intObjectTypeID
	AND intReportCaseStatus = 1 -- Open matter

	IF @intReportCaseID IS NULL --Create a new report matter and connect to report
	BEGIN
		INSERT INTO tblEPiServerCommonReportCase
		(
			intObjectID, 
			intObjectTypeID, 
			strReportDataTitle, 
			strReportDataXml,
			datReportDataCreated,
			intReportDataAuthorID,
			intStatus, 
			intPreviousStatus
		)
		values
		(
			@intObjectID, 
			@intObjectTypeID, 
			@strReportDataTitle, 
			@strReportDataXml,
			@datReportDataCreated,
			@intReportDataAuthorID,
			@intStatus, 
			@intPreviousStatus
		)

		SELECT @intReportCaseID = SCOPE_IDENTITY()
	END

	INSERT INTO tblEPiServerCommonReport 
	(
		intReportCaseID,
		strDescription, 
		strUrl,
		datCreated,
		intAuthorID, 
		intStatus, 
		intPreviousStatus
	) 
	VALUES 
	(
		@intReportCaseID, 
		@strDescription, 
		@strUrl,
		@datReportDate,
		@intAuthorID, 
		@intStatus, 
		@intPreviousStatus 
	) 

	SELECT SCOPE_IDENTITY()

	SET NOCOUNT OFF 
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingUpdateReportCase]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Updates a report case
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonReportingUpdateReportCase]
@intID int, 
@intReportCaseStatus smallint,
@strComment nvarchar(MAX),
@datLastModified datetime, 
@intStatus smallint, 
@intPreviousStatus smallint 
AS
BEGIN
	SET NOCOUNT ON 

	UPDATE tblEPiServerCommonReportCase
	SET intReportCaseStatus = @intReportCaseStatus,
	strComment = @strComment, 
	datLastModified = @datLastModified, 
	intStatus = @intStatus, 
	intPreviousStatus = @intPreviousStatus 
	WHERE intID = @intID

	SET NOCOUNT OFF 
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingRemoveReportCase]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Removes a report case
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonReportingRemoveReportCase]
@intID int 
AS
BEGIN
	SET NOCOUNT ON 

	DELETE FROM tblEPiServerCommonReportCase 
	WHERE intID = @intID

	SET NOCOUNT OFF 
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonUpdateRatableEntity]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Söderberg
-- Create date: 2007-06-20
-- Description:	Updates a ratable entity
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonUpdateRatableEntity] 
@intObjectTypeID int, 
@intObjectID int, 
@blnIsRatable bit,
@intStatus smallint
AS
BEGIN
	SET NOCOUNT ON

	IF NOT EXISTS(SELECT * FROM tblEPiServerCommonRatableItem WHERE intObjectTypeID = @intObjectTypeID AND intObjectID = @intObjectID)
	BEGIN 
		INSERT INTO tblEPiServerCommonRatableItem(intObjectTypeID, intObjectID, blnIsRatable, intStatus) 
		VALUES (@intObjectTypeID, @intObjectID, @blnIsRatable, @intStatus)
	END
	ELSE
	BEGIN
		UPDATE	tblEPiServerCommonRatableItem 
		SET		blnIsRatable = @blnIsRatable 
		WHERE	intObjectTypeID = @intObjectTypeID 
		AND		intObjectID = @intObjectID 
	END
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetRatableEntityValues]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Söderberg
-- Create date: 2007-06-20
-- Description:	Gets the number of ratings, sum of all ratings and if the item is ratable for a specific entity
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetRatableEntityValues]
@intObjectTypeID int, 
@intObjectID int
AS
BEGIN

	SET NOCOUNT ON

	SELECT blnIsRatable, intNumRatings, fltSumRatings 
	FROM tblEPiServerCommonRatableItem 
	WHERE intObjectTypeID = @intObjectTypeID 
	AND intObjectID = @intObjectID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Söderberg
-- Create date: 2007-06-18
-- Description:	Rates an entity
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonRate]
@intObjectTypeID int, 
@intObjectID int, 
@fltRating float, 
@intAuthorID int,
@intOldAuthorID int, 
@intStatus smallint
AS
BEGIN

	SET NOCOUNT ON 

	IF NOT EXISTS(SELECT * FROM tblEPiServerCommonRatableItem WHERE intObjectTypeID = @intObjectTypeID AND intObjectID = @intObjectID) 
	BEGIN
		INSERT INTO tblEPiServerCommonRatableItem(intObjectTypeID, intObjectID, intStatus) 
		VALUES (@intObjectTypeID, @intObjectID, @intStatus)
	END

	DECLARE @intRatingLogID int 
	
	/*SELECT @intRatingLogID = r.intID FROM tblEPiServerCommonRatingLog AS r
		INNER JOIN tblEPiServerCommonAuthor AS a ON (r.intAuthorID = a.intID)
		INNER JOIN tblEPiServerCommonAuthor AS a2 ON (a.intID = @intAuthorID)
		WHERE r.intObjectTypeID = @intObjectTypeID AND r.intObjectID = @intObjectID
		AND (a.intUserID = a2.intUserID OR a.strAuthorEmail = a2.strAuthorEmail)*/

	-- if there is already a rating by an equal author, we delete the rating and later replace it
	IF @intOldAuthorID IS NOT NULL
		DELETE FROM tblEPiServerCommonRatingLog WHERE intObjectTypeID = @intObjectTypeID AND intObjectID = @intObjectID AND intAuthorID = @intOldAuthorID

	INSERT INTO tblEPiServerCommonRatingLog (intObjectTypeID, intObjectID, fltRating, intAuthorID, intStatus) 
	VALUES (@intObjectTypeID, @intObjectID, @fltRating, @intAuthorID, @intStatus) 

	SELECT SCOPE_IDENTITY() 

	SET NOCOUNT OFF 
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetAuthorsByEntityID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-09-04
-- Description:	Gets an author from the author table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetAuthorsByEntityID]
@intEntityID int,
@intObjectTypeID int = NULL,
@intStatus smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT intID, intObjectTypeID, intEntityID, strAuthorName, strAuthorEmail, strAuthorUrl, intStatus, intPreviousStatus FROM dbo.tblEPiServerCommonAuthor 
		WHERE ((@intEntityID IS NULL) OR (intEntityID = @intEntityID)) AND ((@intObjectTypeID IS NULL) OR (intObjectTypeID = @intObjectTypeID)) AND (intStatus & @intStatus != 0)
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetAuthor]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-08-24
-- Description:	Gets an author from the author table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonGetAuthor]
@intID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT intID, intObjectTypeID, intEntityID, strAuthorName, strAuthorEmail, strAuthorUrl, intStatus, intPreviousStatus FROM dbo.tblEPiServerCommonAuthor WHERE intID = @intID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveAuthor]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-08-29
-- Description:	Removes an author from the author table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveAuthor]
@intID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DELETE FROM tblEPiServerCommonAuthor
	WHERE intID = @intID
	
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonUpdateAuthor]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-08-24
-- Description:	Updates an author in the author table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonUpdateAuthor]
@intID int,
@intObjectTypeID int,
@intEntityID int,
@strAuthorName nvarchar(200),
@strAuthorEmail varchar(1024),
@strAuthorUrl varchar(1024),
@intStatus smallint,
@intPreviousStatus smallint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    UPDATE dbo.tblEPiServerCommonAuthor 
		SET intObjectTypeID = @intObjectTypeID, intEntityID = @intEntityID, strAuthorName = @strAuthorName, 
			strAuthorEmail = @strAuthorEmail, strAuthorUrl = @strAuthorUrl,
			intStatus = @intStatus, intPreviousStatus = @intPreviousStatus 
	WHERE intID = @intID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddAuthor]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Mattias Nordberg
-- Create date: 2007-08-24
-- Description:	Adds an author to the author table
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddAuthor]
@intObjectTypeID int,
@intEntityID int,
@strAuthorName nvarchar(200),
@strAuthorEmail varchar(1024),
@strAuthorUrl varchar(1024),
@blnReuse bit, 
@intStatus smallint 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    INSERT INTO dbo.tblEPiServerCommonAuthor (intEntityID, intObjectTypeID, strAuthorName, strAuthorEmail, strAuthorUrl, blnReuse, intStatus) 
	VALUES (@intEntityID, @intObjectTypeID, @strAuthorName, @strAuthorEmail, @strAuthorUrl, @blnReuse, @intStatus)

	SELECT SCOPE_IDENTITY()
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveCategoryEntityItem]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		NRA
-- Create date: 2007-04-11
-- Description:	Removes a category from an entity
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveCategoryEntityItem] 
@intCategoryID int,
@intObjectID int,
@intObjectTypeID int
AS
BEGIN
	DELETE 
	FROM	tblEPiServerCommonCategoryItem 
	WHERE	intCategoryID = @intCategoryID
	AND		intObjectID = @intObjectID
	AND		intObjectTypeID = @intObjectTypeID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonAddCategoryEntityItem]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		NRA
-- Create date: 2007-04-11
-- Description:	Adds a category to an entity
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonAddCategoryEntityItem] 
@intCategoryID int,
@intObjectID int,
@intObjectTypeID int
AS
BEGIN

    INSERT INTO tblEPiServerCommonCategoryItem (intCategoryID, intObjectID, intObjectTypeID)
	VALUES (@intCategoryID, @intObjectID, @intObjectTypeID)

END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveCategoryEntityItems]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		NRA
-- Create date: 2007-04-11
-- Description:	Removes all categories from an entity
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveCategoryEntityItems] 
@intObjectID int,
@intObjectTypeID int
AS
BEGIN
	DELETE 
	FROM	tblEPiServerCommonCategoryItem 
	WHERE	intObjectID = @intObjectID
	AND		intObjectTypeID = @intObjectTypeID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingGetReport]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Gets a report by ID
-- =============================================

CREATE  PROCEDURE [dbo].[spEPiServerCommonReportingGetReport] 
@intID int
AS
SET NOCOUNT ON
SELECT intID, intReportCaseID, strDescription, strUrl, intAuthorID, datCreated, intStatus, intPreviousStatus
FROM 	tblEPiServerCommonReport
WHERE 	intID = @intID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingUpdateReport]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Updates a report
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonReportingUpdateReport]
@intID int, 
@intReportCaseID int,
@strDescription ntext, 
@strUrl nvarchar(2000), 
@intAuthorID int, 
@intStatus smallint, 
@intPreviousStatus smallint 
AS
BEGIN
	SET NOCOUNT ON 

	UPDATE tblEPiServerCommonReport 
	SET intReportCaseID = @intReportCaseID,
	strDescription = @strDescription, 
	strUrl = @strUrl,
	intAuthorID = @intAuthorID, 
	intStatus = @intStatus, 
	intPreviousStatus = @intPreviousStatus 
	WHERE intID = @intID

	SET NOCOUNT OFF 
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingRemoveReport]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		Per Ivansson
-- Create date: 2007-11-29
-- Description:	Removes a report
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonReportingRemoveReport]
@intID int 
AS
BEGIN
	SET NOCOUNT ON 

	DELETE FROM tblEPiServerCommonReport 
	WHERE intID = @intID

	SET NOCOUNT OFF 
END
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveGroupModuleAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveGroupModuleAccessRights]
@intGroupID Int,
@strModule varchar(100)
AS
DELETE
FROM tblEPiServerCommonGroupModuleAccessRight
WHERE intGroupID = @intGroupID AND strModule = @strModule
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetGroupModuleAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[spEPiServerCommonGetGroupModuleAccessRights]
@intGroupID Int,
@strModule varchar(100)
AS
SELECT intGroupID, strModule, intAccessLevel
FROM tblEPiServerCommonGroupModuleAccessRight
WHERE intGroupID = @intGroupID AND strModule = @strModule
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonSetGroupModuleAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[spEPiServerCommonSetGroupModuleAccessRights]
@intGroupID Int,
@strModule varchar(100),
@intAccessLevel Int
AS
IF(EXISTS(SELECT strModule FROM tblEPiServerCommonGroupModuleAccessRight WHERE intGroupID = @intGroupID AND strModule = @strModule))
BEGIN
	UPDATE tblEPiServerCommonGroupModuleAccessRight SET intAccessLevel = @intAccessLevel WHERE intGroupID = @intGroupID AND strModule = @strModule
END
ELSE
BEGIN
	INSERT INTO tblEPiServerCommonGroupModuleAccessRight (intGroupID, strModule, intAccessLevel) VALUES (@intGroupID, @strModule, @intAccessLevel)
END
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonSetSetting]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonSetSetting]
@strKey nvarchar(200),
@strValue nvarchar(1000)
AS
IF EXISTS (SELECT strValue FROM tblEPiServerCommonSetting WHERE strKey = @strKey)
BEGIN
	UPDATE tblEPiServerCommonSetting SET strValue = @strValue WHERE strKey = @strKey
END
ELSE
BEGIN
	INSERT INTO tblEPiServerCommonSetting (strValue, strKey) VALUES(@strValue, @strKey)
END
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveSetting]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveSetting]
@strKey varchar(200)
AS
DELETE FROM tblEPiServerCommonSetting WHERE strKey = @strKey
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetSetting]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE PROCEDURE [dbo].[spEPiServerCommonGetSetting]
@strKey varchar(200)
AS
SELECT strValue FROM tblEPiServerCommonSetting WHERE strKey = @strKey
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnEPiServerCommonVisitsGetNumVisits]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Description:	Gets number of visits for the passed visitable entity (objectID and objectTypeID)
-- =============================================
CREATE FUNCTION [dbo].[fnEPiServerCommonVisitsGetNumVisits]
(
@intObjectTypeID int,
@intObjectID int
)
RETURNS int
AS
BEGIN
	DECLARE @ret int
	SELECT @ret = intNumVisits
		FROM tblEPiServerCommonVisitableItem
		WHERE intObjectTypeID = @intObjectTypeID
		AND intObjectID=@intObjectID
	
	IF @ret IS NULL 
		SET @ret = 0 

	RETURN @ret
END' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonVisitsGetLastVisitID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Per Ivansson
-- Create date: 2008-09-01
-- Description:	Gets the last visit ID for an entity
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonVisitsGetLastVisitID] 
@intObjectTypeID int,
@intObjectID int
AS
BEGIN

	SET NOCOUNT ON

	SELECT intLastVisitID
	FROM tblEPiServerCommonVisitableItem
	WHERE intObjectTypeID = @intObjectTypeID
	AND intObjectID=@intObjectID

END' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveScheduledTaskStarter]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveScheduledTaskStarter]
@unqTaskID uniqueidentifier
AS
DELETE FROM tblEPiServerCommonScheduledTaskStarter WHERE unqTaskID = @unqTaskID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonSetScheduledTaskStarter]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonSetScheduledTaskStarter]
@unqTaskID uniqueidentifier,
@strExecAssemblyName varchar(255),
@strExecClassName varchar(255),
@blnIsStateFul bit,
@imgStateData image
AS
IF EXISTS(SELECT unqTaskID FROM tblEPiServerCommonScheduledTaskStarter WHERE unqTaskID = @unqTaskID)
BEGIN
	UPDATE tblEPiServerCommonScheduledTaskStarter SET strExecAssemblyName = @strExecAssemblyName, strExecClassName = @strExecClassName, blnIsStateFul = @blnIsStateFul, imgStateData = @imgStateData
	WHERE unqTaskID = @unqTaskID
END
ELSE
BEGIN
	INSERT INTO tblEPiServerCommonScheduledTaskStarter (unqTaskID, strExecAssemblyName, strExecClassName, blnIsStateFul, imgStateData)
	VALUES (@unqTaskID, @strExecAssemblyName, @strExecClassName, @blnIsStateFul, @imgStateData)
END
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetScheduledTaskStarter]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonGetScheduledTaskStarter]
@unqTaskID uniqueidentifier
AS
SELECT unqTaskID, strExecAssemblyName, strExecClassName, blnIsStateFul, imgStateData FROM tblEPiServerCommonScheduledTaskStarter WHERE unqTaskID = @unqTaskID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveObjectReferences]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveObjectReferences] 
@strObjectType varchar(400),
@strObjectXml varchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @intObjectTypeID int
	DECLARE @xmlDoc XML

	SELECT @intObjectTypeID = intID FROM dbo.tblEntityType WHERE strName = @strObjectType

	IF @intObjectTypeID IS NOT NULL
	BEGIN
		SET @xmlDoc = convert(xml,@strObjectXml)

		-- table variable holds OPENXMLs output:
		DECLARE @tempObjs TABLE (ObjectID int NOT NULL)

		-- populate the table variable
		INSERT @tempObjs (ObjectID) SELECT T.c.value(''./@ObjectID'',''int'') FROM @xmlDoc.nodes(''/Root/Obj'') AS T(c)
		
		DELETE FROM dbo.tblEPiServerCommonAttributeValueDateTime
		WHERE EXISTS (SELECT intID FROM dbo.tblEPiServerCommonAttribute 
						WHERE intID = dbo.tblEPiServerCommonAttributeValueDateTime.intAttributeID 
						AND intObjectTypeID = @intObjectTypeID)
		AND dbo.tblEPiServerCommonAttributeValueDateTime.intObjectID IN (SELECT ObjectID FROM @tempObjs)

		DELETE FROM dbo.tblEPiServerCommonAttributeValueFloat
		WHERE EXISTS (SELECT intID FROM dbo.tblEPiServerCommonAttribute 
						WHERE intID = dbo.tblEPiServerCommonAttributeValueFloat.intAttributeID 
						AND intObjectTypeID = @intObjectTypeID)
		AND dbo.tblEPiServerCommonAttributeValueFloat.intObjectID IN (SELECT ObjectID FROM @tempObjs)

		DELETE FROM dbo.tblEPiServerCommonAttributeValueInteger
		WHERE EXISTS (SELECT intID FROM dbo.tblEPiServerCommonAttribute 
						WHERE intID = dbo.tblEPiServerCommonAttributeValueInteger.intAttributeID 
						AND intObjectTypeID = @intObjectTypeID)
		AND dbo.tblEPiServerCommonAttributeValueInteger.intObjectID IN (SELECT ObjectID FROM @tempObjs)
		
		DELETE FROM dbo.tblEPiServerCommonAttributeValueString
		WHERE EXISTS (SELECT intID FROM dbo.tblEPiServerCommonAttribute 
						WHERE intID = dbo.tblEPiServerCommonAttributeValueString.intAttributeID 
						AND intObjectTypeID = @intObjectTypeID)
		AND dbo.tblEPiServerCommonAttributeValueString.intObjectID IN (SELECT ObjectID FROM @tempObjs)

		DELETE FROM dbo.tblEPiServerCommonCategoryItem WHERE intObjectTypeID = @intObjectTypeID
		AND dbo.tblEPiServerCommonCategoryItem.intObjectID IN (SELECT ObjectID FROM @tempObjs)
		
		DELETE FROM dbo.tblEPiServerCommonRatableItem WHERE intObjectTypeID = @intObjectTypeID
		AND dbo.tblEPiServerCommonRatableItem.intObjectID IN (SELECT ObjectID FROM @tempObjs)

		-- Remove tags on this object
		EXEC spEPiServerCommonTagRemoveTaggedEntityTagsInternal @intObjectTypeID, @xmlDoc
		
		--Remove visits on this object
		DELETE FROM dbo.tblEPiServerCommonVisitableItem WHERE intObjectTypeID = @intObjectTypeID
		AND dbo.tblEPiServerCommonVisitableItem.intObjectID IN (SELECT ObjectID FROM @tempObjs)

		--Remove comments on this object
		DELETE FROM dbo.tblEPiServerCommonComment WHERE intObjectTypeID = @intObjectTypeID
		AND intObjectID IN (SELECT ObjectID FROM @tempObjs)
		
	END
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonRemoveObjectAttributeReferences]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonRemoveObjectAttributeReferences] 
	@strObjectType varchar(400),
	@intObjectID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Remove references to the items that are being removed
	DELETE tblEPiServerCommonAttributeValueInteger
	OUTPUT tblEPiServerCommonAttribute.intObjectTypeID, DELETED.intObjectID
	FROM tblEPiServerCommonAttribute
	INNER JOIN tblEPiServerCommonAttributeValueInteger ON tblEPiServerCommonAttribute.intID = tblEPiServerCommonAttributeValueInteger.intAttributeID
	WHERE tblEPiServerCommonAttribute.strDataType = @strObjectType
	AND tblEPiServerCommonAttributeValueInteger.intValue = @intObjectID
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagAddTagItem]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-23
-- Description:	Adds a new TagItem to the database. Items count for a tag is updated to reflect the number
-- of items tagged with the tag.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagAddTagItem] 
	@intObjectID int, -- id of the object tagged
	@intObjectTypeID int, -- id of the type of the object tagged
	@strTagName nvarchar(255), -- tag
	@intCategoryID int = null, -- id of the category that the tag item is assigned.
	@intAuthorID int = null, -- id of a user if logged in user is tagging
	@intArchiveIntervalHours int = 1, -- the interval (in hours) between archiving the number of items tagged
	@intStatus smallint 
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRAN;

	DECLARE @intTagID int, @intTagItemID int

	-- find the tag id; if not exists, add one to the database
	SELECT @intTagID = intID
		FROM tblEPiServerCommonTag WITH (UPDLOCK)
		WHERE strName = @strTagName
	
	IF @intTagID IS NULL BEGIN
		INSERT INTO tblEPiServerCommonTag (strName)
		VALUES (@strTagName)
	
		SET @intTagID = SCOPE_IDENTITY()
	END

	-- insert new tag item
	IF NOT EXISTS (SELECT * 
		FROM tblEPiServerCommonTagItem WITH (UPDLOCK)
		WHERE intObjectID = @intObjectID 
			AND intObjectTypeID = @intObjectTypeID
			AND intTagID = @intTagID
			AND intStatus = @intStatus 
			AND ((intCategoryID IS NULL AND @intCategoryID IS NULL) OR (intCategoryID = @intCategoryID))
			AND ((intAuthorID IS NULL AND @intAuthorID IS NULL) OR (intAuthorID = @intAuthorID)))
	BEGIN
		INSERT INTO tblEPiServerCommonTagItem (intObjectID, intObjectTypeID, intTagID, intCategoryID, intAuthorID, intStatus)
			VALUES (@intObjectID, @intObjectTypeID, @intTagID, @intCategoryID, @intAuthorID, @intStatus)
		SET @intTagItemID = SCOPE_IDENTITY()
		-- update items count
		EXEC spEPiServerCommonTagUpdateTagItemsCount @intTagID, @intObjectTypeID, @intCategoryID, @intAuthorID, @intArchiveIntervalHours, 1, @intStatus
		SELECT @intTagItemID AS intTagItemID
	END
	ELSE BEGIN
		ROLLBACK TRAN;
		RAISERROR (N''This item is already tagged with the tag specified.'', 16, 1)
		RETURN;
	END

	IF @@ERROR <> 0 BEGIN
		ROLLBACK TRAN;
		RAISERROR (N''Error tagging an item - SQL Server error.'', 16, 1)
		RETURN;
	END

	COMMIT TRAN;
	
	RETURN 0
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagAddPredefinedTag]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-25
-- Description:	Adds a tag predefinition.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagAddPredefinedTag]
	@intTagID int, -- id of the tag
	@intObjectTypeID int, -- id of the object type to predefine tag	
	@intAuthorID int -- id of the author to predefine tag
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO tblEPiServerCommonTagPredefinedTag (intTagID, intObjectTypeID, intAuthorID)
	VALUES (@intTagID, @intObjectTypeID, @intAuthorID)
	
	SELECT SCOPE_IDENTITY()
END
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonTagRemoveTagItem]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		Michal Michalowski
-- Create date: 2007-04-23
-- Description:	Removes a tag from an object.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonTagRemoveTagItem] 
	@intId int, -- tag item id to remove
	@intArchiveIntervalHours int = 1 -- items count archive interval
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @intTagID int, @intObjectTypeID int, @intCategoryID int, @intAuthorID int, @intStatus int
	
	SELECT @intTagID = intTagID, @intObjectTypeID = intObjectTypeID, @intCategoryID = intCategoryID, @intAuthorID = intAuthorID, @intStatus = intStatus
	FROM tblEPiServerCommonTagItem
	WHERE intID = @intID
	IF @intTagID IS NULL BEGIN
		RETURN
	END

	EXEC spEPiServerCommonTagUpdateTagItemsCount @intTagID, @intObjectTypeID, @intCategoryID, @intAuthorID, @intArchiveIntervalHours, 0, @intStatus

	DELETE FROM tblEPiServerCommonTagItem
	WHERE intID = @intID

	IF @@ERROR <> 0 BEGIN 
		RAISERROR (N''Error removing tag item - SQL Server error.'', 16, 1)
	END

	RETURN 0
END
' 
END
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonCommentsAddComment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Ivansson
-- Create date: 2000-02-17
-- Description:	Adds a comment to an entity
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonCommentsAddComment]
@intObjectTypeID int, 
@intObjectID int, 
@intAuthorID int,
@strHeader nvarchar(MAX) = null,
@strBody nvarchar(MAX),
@strLanguageID varchar(10),
@intStatus smallint
AS
BEGIN 
	INSERT INTO tblEPiServerCommonComment (intObjectTypeID, intObjectID, intAuthorID, strHeader, strBody, strLanguageID, intStatus) 
	VALUES (@intObjectTypeID, @intObjectID, @intAuthorID, @strHeader, @strBody, @strLanguageID, @intStatus) 

	SELECT SCOPE_IDENTITY() 
END'
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonCommentsGetComment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Ivansson
-- Create date: 2009-02-17
-- Description:	Gets a comment by its ID
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonCommentsGetComment] 
@intID int
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT	t1.intID, t1.intAuthorID, t1.intObjectTypeID, t1.intObjectID, t1.strHeader, t1.strBody, 
	t1.datCreated, t1.datModified, t1.strLanguageID, t1.intStatus, t1.intPreviousStatus
	FROM	tblEPiServerCommonComment AS t1
	WHERE	t1.intID = @intID
END'
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonCommentsGetComments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Ivansson
-- Create date: 2009-02-18
-- Description:	Gets comments for an entity
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonCommentsGetComments] 
@intObjectTypeID int,
@intObjectID int,
@intAuthorID int,
@strAuthorEmail varchar(2000),
@datStartDate datetime,
@datEndDate datetime,
@intPage int,
@intPageSize int,
@intStatus smallint,
@strOrderBy varchar(2000)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @strParamList nvarchar(256)
	DECLARE @strQuery nvarchar(4000)
	DECLARE @intStartRec int
	DECLARE @intEndRec int

	SET @intStartRec = ((@intPage - 1) * @intPageSize) + 1 
	SET @intEndRec = (@intPageSize * @intPage)
	

	SET @strParamList = ''@intObjectTypeID int,
						@intObjectID int,
						@intAuthorID int,
						@strAuthorEmail varchar(2000),
						@datStartDate datetime,
						@datEndDate datetime,
						@intStartRec int, 
						@intEndRec int,
						@intStatus smallint''
	
	IF @strOrderBy IS NULL 
		SET @strOrderBy = ''tblEPiServerCommonComment.intID''
		
	SET @strQuery = ''SELECT intID, intAuthorID, intObjectTypeID, intObjectID, strHeader, strBody, 
															datCreated, datModified, strLanguageID, intStatus, intPreviousStatus, intTotalItems ''
	
	BEGIN
		SET @strQuery = @strQuery + '' FROM (SELECT ROW_NUMBER() OVER (ORDER BY ''+@strOrderBy+'') AS intRowNumber,
							COUNT(*) OVER() AS intTotalItems,
							tblEPiServerCommonComment.intID, tblEPiServerCommonComment.intAuthorID, 
							tblEPiServerCommonComment.intObjectTypeID, tblEPiServerCommonComment.intObjectID, 
							tblEPiServerCommonComment.strHeader, tblEPiServerCommonComment.strBody, 
							tblEPiServerCommonComment.datCreated, tblEPiServerCommonComment.datModified,
							tblEPiServerCommonComment.strLanguageID,
							tblEPiServerCommonComment.intStatus, tblEPiServerCommonComment.intPreviousStatus
							FROM tblEPiServerCommonComment AS tblEPiServerCommonComment
							LEFT JOIN tblEPiServerCommonAuthor AS t3 ON tblEPiServerCommonComment.intAuthorID = t3.intID
							WHERE ((tblEPiServerCommonComment.intStatus & @intStatus) != 0) ''
							
		IF(@intObjectTypeID <> -1 AND @intObjectID <> -1)
			SET @strQuery = @strQuery + '' AND (tblEPiServerCommonComment.intObjectTypeID = @intObjectTypeID AND tblEPiServerCommonComment.intObjectID = @intObjectID) ''
	END
	

	IF @datStartDate IS NOT NULL
		SET @strQuery = @strQuery + '' AND datCreated >= @datStartDate ''

	IF @datEndDate IS NOT NULL
		SET @strQuery = @strQuery + '' AND datCreated <= @datEndDate ''

	IF @intAuthorID IS NOT NULL
		SET @strQuery = @strQuery + '' AND intAuthorID=@intAuthorID ''
	ELSE IF @strAuthorEmail IS NOT NULL
		SET @strQuery = @strQuery + ''AND t3.strAuthorEmail = @strAuthorEmail ''

	SET @strQuery = @strQuery + '') Comments WHERE intRowNumber >= @intStartRec AND intRowNumber <= @intEndRec ORDER BY intRowNumber''

	EXEC sp_executesql @strQuery, @strParamList, @intObjectTypeID, @intObjectID, @intAuthorID, @strAuthorEmail, @datStartDate, @datEndDate, @intStartRec, @intEndRec, @intStatus
END'
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonCommentsGetNumComments]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Ivansson
-- Create date: 2009-02-18
-- Description:	Gets total number of comments for an entity
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonCommentsGetNumComments] 
@intObjectTypeID int,
@intObjectID int,
@intStatus smallint
AS
BEGIN
	SELECT COUNT(*)
	FROM tblEPiServerCommonComment
	WHERE intObjectTypeID = @intObjectTypeID
	AND intObjectID=@intObjectID
	AND ((intStatus & @intStatus) != 0)
END'
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonCommentsRemoveComment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Ivansson
-- Create date: 2000-02-17
-- Description:	Removes a comment
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonCommentsRemoveComment]
@intID int
AS
BEGIN 

	DELETE FROM tblEPiServerCommonComment
	WHERE intID = @intID
END'
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonCommentsUpdateComment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Per Ivansson
-- Create date: 2009-02-18
-- Description:	Update a comment
-- =============================================
                
CREATE PROCEDURE [dbo].[spEPiServerCommonCommentsUpdateComment]
@intID int,
@intAuthorID int,
@strHeader nvarchar(MAX),
@strBody nvarchar(MAX),
@strLanguageID varchar(10),
@intStatus smallint,
@intPreviousStatus smallint
AS
BEGIN 
	UPDATE tblEPiServerCommonComment
	SET intAuthorID = @intAuthorID,
		strHeader = @strHeader,
		strBody = @strBody,
		datModified = GETDATE(),
		strLanguageID = @strLanguageID,
		intStatus = @intStatus,
		intPreviousStatus = @intPreviousStatus
	WHERE intID = @intID
END'
END

GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonReportingGetUserReportsCleanup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonReportingGetUserReportsCleanup]
	@intUserID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT tblEPiServerCommonReport.intID, tblEPiServerCommonReport.intReportCaseID, tblEPiServerCommonReport.strDescription, tblEPiServerCommonReport.strUrl, tblEPiServerCommonReport.intAuthorID, tblEPiServerCommonReport.datCreated, tblEPiServerCommonReport.intStatus, tblEPiServerCommonReport.intPreviousStatus
	FROM 	tblEPiServerCommonReport
	INNER JOIN tblEPiServerCommonAuthor ON tblEPiServerCommonReport.intAuthorID = tblEPiServerCommonAuthor.intID
	AND tblEPiServerCommonAuthor.intObjectTypeID IN (SELECT intID FROM tblEntityType WHERE strName IN (''EPiServer.Common.UserAuthor, EPiServer.Common.Framework.Impl'', ''EPiServer.Common.AnonymousAuthor, EPiServer.Common.Framework.Impl''))
	WHERE tblEPiServerCommonAuthor.intEntityID = @intUserID
END'
END

GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetOwnerContextID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonGetOwnerContextID] 
@strName nvarchar(200),
@intId INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON;

	SET @intId = (SELECT intID FROM tblEPiServerCommonOwnerContext WHERE strName = @strName)
	
	IF (@intId IS NULL) AND (@strName IS NOT NULL) AND (@strName <> '''')
	BEGIN
		INSERT INTO tblEPiServerCommonOwnerContext (strName) VALUES (@strName)
		SET @intId = SCOPE_IDENTITY()
	END

END'
END
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonSetOwnership]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE spEPiServerCommonSetOwnership 
@intObjectEntityID int,
@intObjectTypeID int,
@intOwnerEntityID int,
@intOwnerTypeID int,
@strOwnerContextName nvarchar(200)
AS
BEGIN 

DECLARE @intOwnerContextID int

IF @intOwnerEntityID IS NOT NULL
BEGIN 

	EXEC spEPiServerCommonGetOwnerContextID @strOwnerContextName, @intOwnerContextID OUTPUT

	DELETE FROM tblEPiServerCommonOwnership WHERE intObjectEntityID = @intObjectEntityID AND intObjectTypeID = @intObjectTypeID

	INSERT INTO tblEPiServerCommonOwnership(
		intObjectEntityID,
		intObjectTypeID,
		intOwnerEntityID,
		intOwnerTypeID,
		intOwnerContextID
	)
	VALUES(
		@intObjectEntityID,
		@intObjectTypeID,
		@intOwnerEntityID,
		@intOwnerTypeID,
		@intOwnerContextID)
END
ELSE
BEGIN 
	DELETE FROM tblEPiServerCommonOwnership 
	WHERE intObjectEntityID = @intObjectEntityID 
	AND intObjectTypeID = @intObjectTypeID
END

END'
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetOwnership]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetOwnership]
@intObjectEntityID int,
@intObjectTypeID int
AS
SELECT 
	intOwnerEntityID,
	ownerType.strName,
	ownerContext.strName
FROM tblEPiServerCommonOwnership
INNER JOIN tblEntityType AS ownerType ON ownerType.intID = intOwnerTypeID
INNER JOIN tblEPiServerCommonOwnerContext AS ownerContext ON ownerContext.intID = intOwnerContextID
WHERE intObjectEntityID = @intObjectEntityID AND intObjectTypeID = @intObjectTypeID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetObjectsByOwner]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonGetObjectsByOwner]
@intOwnerEntityID int,
@intOwnerTypeID int
AS
SELECT 
	intObjectEntityID,
	objectType.strName,
	ownerContext.strName
FROM tblEPiServerCommonOwnership
INNER JOIN tblEntityType AS objectType ON objectType.intID = intObjectTypeID
INNER JOIN tblEPiServerCommonOwnerContext AS ownerContext ON ownerContext.intID = intOwnerContextID
WHERE intOwnerEntityID = @intOwnerEntityID AND intOwnerTypeID = @intOwnerTypeID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonSetEntityGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonSetEntityGuid]
@unqID uniqueidentifier,
@intObjectTypeID int,
@intObjectID int
AS

DELETE FROM tblEntityGuid WHERE
intObjectTypeID = @intObjectTypeID AND intObjectID = @intObjectID

INSERT INTO tblEntityGuid (unqID, intObjectTypeID, intObjectID)
VALUES (@unqID, @intObjectTypeID, @intObjectID)
' 
END
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEntitySecurityGetUserAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonEntitySecurityGetUserAccessRights]

@intEntityTypeID INT,
@intEntityID INT,
@intUserID INT

AS

SELECT intAccessLevel FROM tblEPiServerCommonEntityUserAccessRights WHERE
intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID AND intUserID=@intUserID
' 
END
GO

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEntitySecuritySetUserAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonEntitySecuritySetUserAccessRights]

@intEntityTypeID INT,
@intEntityID INT,
@intUserID INT,
@intAccessLevel INT

AS

IF EXISTS(SELECT intAccessLevel FROM tblEPiServerCommonEntityUserAccessRights WITH(UPDLOCK) WHERE
intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID AND intUserID=@intUserID)
BEGIN
	UPDATE tblEPiServerCommonEntityUserAccessRights SET intAccessLevel=@intAccessLevel
		WHERE intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID AND intUserID=@intUserID
END
ELSE
BEGIN
	INSERT INTO tblEPiServerCommonEntityUserAccessRights (intEntityTypeID, intEntityID, intUserID, intAccessLevel)
		VALUES (@intEntityTypeID, @intEntityID, @intUserID, @intAccessLevel)
END
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEntitySecurityRemoveUserAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonEntitySecurityRemoveUserAccessRights]

@intEntityTypeID INT,
@intEntityID INT,
@intUserID INT

AS

DELETE FROM tblEPiServerCommonEntityUserAccessRights WHERE
	intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID AND intUserID=@intUserID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEntitySecurityRemoveAllAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonEntitySecurityRemoveAllAccessRights]

@intEntityTypeID INT,
@intEntityID INT

AS

DELETE FROM tblEPiServerCommonEntityUserAccessRights WHERE
	intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID
	
DELETE FROM tblEPiServerCommonEntityGroupAccessRights WHERE
	intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEntitySecurityGetAccessOwnerUsersForObject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonEntitySecurityGetAccessOwnerUsersForObject]

@intEntityTypeID INT,
@intEntityID INT

AS

SELECT intUserID FROM tblEPiServerCommonEntityUserAccessRights WHERE intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEntitySecurityGetAccessOwnerGroupsForObject]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonEntitySecurityGetAccessOwnerGroupsForObject]

@intEntityTypeID INT,
@intEntityID INT

AS

SELECT intGroupID FROM tblEPiServerCommonEntityGroupAccessRights WHERE intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEntitySecurityRemoveGroupAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonEntitySecurityRemoveGroupAccessRights]

@intEntityTypeID INT,
@intEntityID INT,
@intGroupID INT

AS

DELETE FROM tblEPiServerCommonEntityGroupAccessRights WHERE
	intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID AND intGroupID=@intGroupID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEntitySecuritySetGroupAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonEntitySecuritySetGroupAccessRights]

@intEntityTypeID INT,
@intEntityID INT,
@intGroupID INT,
@intAccessLevel INT

AS

IF EXISTS(SELECT intAccessLevel FROM tblEPiServerCommonEntityGroupAccessRights WITH(UPDLOCK) WHERE
intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID AND intGroupID=@intGroupID)
BEGIN
	UPDATE tblEPiServerCommonEntityGroupAccessRights SET intAccessLevel=@intAccessLevel
		WHERE intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID AND intGroupID=@intGroupID
END
ELSE
BEGIN
	INSERT INTO tblEPiServerCommonEntityGroupAccessRights (intEntityTypeID, intEntityID, intGroupID, intAccessLevel)
		VALUES (@intEntityTypeID, @intEntityID, @intGroupID, @intAccessLevel)
END
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEntitySecurityGetGroupAccessRights]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonEntitySecurityGetGroupAccessRights]

@intEntityTypeID INT,
@intEntityID INT,
@intGroupID INT

AS

SELECT intAccessLevel FROM tblEPiServerCommonEntityGroupAccessRights WHERE
intEntityTypeID=@intEntityTypeID AND intEntityID=@intEntityID AND intGroupID=@intGroupID
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonUserRemoveUserOpenID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Daniel Furtado
-- Create date: 2009-10-23
-- Description:	Remove OpenIDs for a specific user.
-- =============================================
CREATE PROCEDURE [dbo].[spEPiServerCommonUserRemoveUserOpenID]	
	@strClaimedIdentifier VARCHAR(255)
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DELETE FROM tblEPiServerCommonUserOpenID WHERE strClaimedIdentifier = @strClaimedIdentifier;	
	
END' 
END
GO


SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonUserAddOpenID]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Daniel Furtado
-- Create date: 2009-10-27
-- Description:	Add OpenID for a specific user.
-- =============================================
CREATE PROCEDURE spEPiServerCommonUserAddOpenID
	@intUserID INT,
	@strClaimedIdentifier varchar(255),
	@strFriendlyIdentifierForDisplay varchar(255)	
AS
BEGIN
	
	SET NOCOUNT ON;

	IF NOT EXISTS(SELECT * FROM tblEPiServerCommonUserOpenID WHERE strClaimedIdentifier = @strClaimedIdentifier)    
		INSERT INTO tblEPiServerCommonUserOpenID (intUserID, strClaimedIdentifier, strFriendlyIdentifierForDisplay) VALUES (@intUserID, @strClaimedIdentifier, @strFriendlyIdentifierForDisplay);

END'
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonUserGetUserByOpenIDClaimedIdent]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Daniel Furtado
-- Create date: 2009-10-27
-- Description:	Get User by its openID''s claimed identifier.
-- =============================================
CREATE PROCEDURE spEPiServerCommonUserGetUserByOpenIDClaimedIdent
	@strClaimedIdentifier VARCHAR(255)
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT tblEPiServerCommonUser.intID, tblEPiServerCommonUser.strUserName, tblEPiServerCommonUser.binPassword, tblEPiServerCommonUser.intPasswordProviderID, 
	tblEPiServerCommonUser.strGivenName, tblEPiServerCommonUser.strSurName, tblEPiServerCommonUser.strEmail, tblEPiServerCommonUser.datBirthDate, tblEPiServerCommonUser.strCulture, 
	tblEPiServerCommonUser.datCreateDate, tblEPiServerCommonUser.strAlias, tblEPiServerCommonUser.intStatus, tblEPiServerCommonUser.intPreviousStatus 
	FROM tblEPiServerCommonUser
	INNER JOIN tblEPiServerCommonUserOpenID ON tblEPiServerCommonUserOpenID.intUserID = tblEPiServerCommonUser.intID
	WHERE tblEPiServerCommonUserOpenID.strClaimedIdentifier = @strClaimedIdentifier;
	
END'
END
GO



SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonGetUserOpenIDs]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		Daniel Furtado
-- Create date: 2009-10-27
-- Description:	Get OpenIDs for a specific user.
-- =============================================
CREATE PROCEDURE spEPiServerCommonGetUserOpenIDs
	@intUserID INT
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT strClaimedIdentifier, strFriendlyIdentifierForDisplay from tblEPiServerCommonUserOpenID where intUserID = @intUserID;	

END'
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonOpenIDAddUserRealm]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonOpenIDAddUserRealm]
@strRealm varchar(100),  
@intUserID int 

AS

BEGIN
	SET NOCOUNT ON 

	DECLARE @intUserRealmID int
	
	SELECT @intUserRealmID = intID FROM tblEPiServerCommonOpenIDUserRealm WHERE strRealm = @strRealm AND intUserID = @intUserID
	
	IF @intUserRealmID IS NULL
	BEGIN
		INSERT INTO tblEPiServerCommonOpenIDUserRealm
			(strRealm, intUserID)
		VALUES
			(@strRealm, @intUserID)
			
		SELECT SCOPE_IDENTITY()
	END

	SET NOCOUNT OFF
END
' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonOpenIDGetUserRealm]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonOpenIDGetUserRealm]
@intID int 
AS

SELECT intID, strRealm, intUserID, datCreated FROM tblEPiServerCommonOpenIDUserRealm WHERE intID = @intID

' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonOpenIDGetUserRealmByRealm]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[spEPiServerCommonOpenIDGetUserRealmByRealm]
@strRealm varchar(100), 
@intUserID int 
AS

SELECT intID, strRealm, intUserId, datCreated FROM tblEPiServerCommonOpenIDUserRealm 
WHERE strRealm = @strRealm AND intUserID = @intUserID

' 
END
GO
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonOpenIDRemoveUserRealm]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[spEPiServerCommonOpenIDRemoveUserRealm]
@intID int
AS
DELETE FROM tblEPiServerCommonOpenIDUserRealm WHERE intID = @intID
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEventCounterRemoveLogs]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



CREATE  PROCEDURE [dbo].[spEPiServerCommonEventCounterRemoveLogs]
AS
SET NOCOUNT ON

--Remove the logs which have not been chosen by current job

DELETE FROM tblEPiServerCommonEventCounterEventLog WHERE blnSelectedByJob = 1

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEventCounterAddEventLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonEventCounterAddEventLog] 
@intAction int,
@strEventName nvarchar(200),
@strEventGroupName nvarchar(200),
@datTimeStamp datetime,
@xmlCategories xml
AS

DECLARE @intEventGroupID int;
SELECT @intEventGroupID = intId FROM tblEPiServerCommonEventGroup WITH(UPDLOCK) WHERE strName = @strEventGroupName
IF @intEventGroupID IS NULL
BEGIN
	INSERT INTO tblEPiServerCommonEventGroup (strName) VALUES (@strEventGroupName)
	SET @intEventGroupID = SCOPE_IDENTITY()
END

INSERT INTO tblEPiServerCommonEventCounterEventLog (intAction, strEventName, intEventGroupID, datTimeStamp, intCategoryID)
SELECT @intAction, @strEventName, @intEventGroupID, @datTimeStamp, null
UNION SELECT @intAction, @strEventName, @intEventGroupID, @datTimeStamp, T.c.value(''(./ID)[1]'',''int'') FROM @xmlCategories.nodes(''/object/categories/category'') AS T(c)

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEventCounterGetResults]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[spEPiServerCommonEventCounterGetResults]
(
	@datStartDate datetime,
	@datEndDate datetime,
	@intResolution int,
	@intAction int,
	@strEventName nvarchar(200),
	@strEventGroupName nvarchar(200),
	@intCategoryID int
)
AS

SET NOCOUNT ON

DECLARE @datNow datetime
SET @datNow = GETDATE()

DECLARE @strSQL nvarchar(max)
DECLARE @strParameters nvarchar(max)
SET @strParameters = N''@strEventGroupName nvarchar(200), @intCategoryID int''

DECLARE @monthDone datetime;
DECLARE @dayDone datetime;

IF @intResolution IN (1,2,3)
BEGIN
	SET @monthDone = (SELECT MAX(datTimeStamp) FROM
		tblEPiServerCommonEventCounterEventMonth 
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventMonth.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND 	strEventName = @strEventName)
END

IF @intResolution IN (1,2,3,4)
BEGIN
	SET @dayDone = (SELECT MAX(datTimeStamp) FROM
		tblEPiServerCommonEventCounterEventDay
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventDay.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND 	strEventName = @strEventName)
END

--Year
IF @intResolution = 1
BEGIN
	SELECT item, SUM(count) AS count
	FROM (
		SELECT YEAR(datTimeStamp) AS item, 
				SUM(intCount) AS count
		FROM 	tblEPiServerCommonEventCounterEventMonth 
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventMonth.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND		DATEADD(month, 1 - DATEPART(month, datTimeStamp), DATEADD(day, 1 - DATEPART(day, datTimeStamp), datTimeStamp)) 
			BETWEEN @datStartDate AND @datEndDate
		AND 	strEventName = @strEventName
		AND intAction = @intAction
		GROUP BY YEAR(datTimeStamp)

		UNION

		SELECT 	YEAR(datTimeStamp) AS item, 
				SUM(intCount) AS count
		FROM 	tblEPiServerCommonEventCounterEventDay
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventDay.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND		DATEADD(month, 1 - DATEPART(month, datTimeStamp), DATEADD(day, 1 - DATEPART(day, datTimeStamp), datTimeStamp)) 
			BETWEEN @datStartDate AND @datEndDate
		AND 	strEventName = @strEventName
		AND intAction = @intAction
		AND		(DATEADD(day, 1 - DATEPART(day, datTimeStamp), datTimeStamp) > @monthDone OR (@monthDone is NULL))
		GROUP BY YEAR(datTimeStamp)

		UNION

		SELECT 	YEAR(datTimeStamp) AS item, 
				SUM(intCount) AS count
		FROM 	tblEPiServerCommonEventCounterEventHour
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventHour.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND		DATEADD(month, 1 - DATEPART(month, datTimeStamp), DATEADD(day, 1 - DATEPART(day, datTimeStamp), dbo.fnEPiServerCommonGetDayStart(datTimeStamp))) 
			BETWEEN @datStartDate AND @datEndDate
		AND 	strEventName = @strEventName
		AND intAction = @intAction
		AND		(dbo.fnEPiServerCommonGetDayStart(datTimeStamp) > @dayDone OR (@dayDone is NULL))
		GROUP BY YEAR(datTimeStamp) 
	) AS t
	GROUP BY	item
	ORDER BY	item
	
END

--Quarter
ELSE IF @intResolution = 2
BEGIN
	SELECT item, SUM(count) AS count, intYear
	FROM (
		SELECT dbo.fnEPiServerCommonGetQuarter(datTimeStamp) AS item,
				SUM(intCount) AS count,
				YEAR(datTimeStamp) AS intYear
		FROM 	tblEPiServerCommonEventCounterEventMonth 
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventMonth.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND		DATEADD(month, dbo.fnEPiServerCommonGetQuarter(datTimeStamp) * 3 - 2 - DATEPART(month, datTimeStamp), DATEADD(day, 1 - DATEPART(day, datTimeStamp), datTimeStamp)) 
			BETWEEN @datStartDate AND @datEndDate
		AND 	strEventName = @strEventName
		AND intAction = @intAction
		GROUP BY dbo.fnEPiServerCommonGetQuarter(datTimeStamp),
				YEAR(datTimeStamp)

		UNION

		SELECT 	dbo.fnEPiServerCommonGetQuarter(datTimeStamp) AS item, 
				SUM(intCount) AS count,
				YEAR(datTimeStamp) AS intYear
		FROM 	tblEPiServerCommonEventCounterEventDay
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventDay.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND		DATEADD(month, dbo.fnEPiServerCommonGetQuarter(datTimeStamp) * 3 - 2 - DATEPART(month, datTimeStamp), DATEADD(day, 1 - DATEPART(day, datTimeStamp), datTimeStamp)) 
			BETWEEN @datStartDate AND @datEndDate
		AND 	strEventName = @strEventName
		AND intAction = @intAction
		AND		(DATEADD(day, 1 - DATEPART(day, datTimeStamp), datTimeStamp) > @monthDone OR (@monthDone is NULL))
		GROUP BY dbo.fnEPiServerCommonGetQuarter(datTimeStamp),
				YEAR(datTimeStamp)

		UNION

		SELECT dbo.fnEPiServerCommonGetQuarter(datTimeStamp) AS item, 
				SUM(intCount) AS count,
				YEAR(datTimeStamp) AS intYear
		FROM 	tblEPiServerCommonEventCounterEventHour
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventHour.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND		DATEADD(month, dbo.fnEPiServerCommonGetQuarter(datTimeStamp) * 3 - 2 - DATEPART(month, datTimeStamp), DATEADD(day, 1 - DATEPART(day, datTimeStamp), dbo.fnEPiServerCommonGetDayStart(datTimeStamp))) 
			BETWEEN @datStartDate AND @datEndDate
		AND 	strEventName = @strEventName
		AND intAction = @intAction
		AND		(DATEADD(day, 1 - DATEPART(day, datTimeStamp), dbo.fnEPiServerCommonGetDayStart(datTimeStamp)) > @dayDone OR (@dayDone is NULL))
		GROUP BY dbo.fnEPiServerCommonGetQuarter(datTimeStamp),
				YEAR(datTimeStamp)
	) AS t
	GROUP BY	item, intYear
	ORDER BY	intYear, item
END

--Month
ELSE IF @intResolution = 3
BEGIN
	SELECT item, SUM(count) AS count, intYear
	FROM (
		SELECT	MONTH(datTimeStamp) AS item,
				SUM(intCount) AS count,
				YEAR(datTimeStamp) AS intYear
		FROM 	tblEPiServerCommonEventCounterEventMonth 
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventMonth.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND		DATEADD(day, 1 - DATEPART(day, datTimeStamp), datTimeStamp)
			BETWEEN @datStartDate AND @datEndDate
		AND 	strEventName = @strEventName
		AND intAction = @intAction
		GROUP BY MONTH(datTimeStamp),
				YEAR(datTimeStamp)

		UNION

		SELECT 	MONTH(datTimeStamp) AS item,
				SUM(intCount) AS count,
				YEAR(datTimeStamp) AS intYear
		FROM 	tblEPiServerCommonEventCounterEventDay
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventDay.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND		DATEADD(day, 1 - DATEPART(day, datTimeStamp), datTimeStamp)
			BETWEEN @datStartDate AND @datEndDate
		AND 	strEventName = @strEventName
		AND intAction = @intAction
		AND		(DATEADD(day, 1 - DATEPART(day, datTimeStamp), datTimeStamp) > @monthDone OR (@monthDone is NULL))
		GROUP BY MONTH(datTimeStamp),
				YEAR(datTimeStamp)

		UNION

		SELECT	MONTH(datTimeStamp) AS item,
				SUM(intCount) AS count,
				YEAR(datTimeStamp) AS intYear
		FROM 	tblEPiServerCommonEventCounterEventHour
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventHour.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND		DATEADD(day, 1 - DATEPART(day, datTimeStamp), dbo.fnEPiServerCommonGetDayStart(datTimeStamp))
			BETWEEN @datStartDate AND @datEndDate
		AND 	strEventName = @strEventName
		AND intAction = @intAction
		AND		(DATEADD(day, 1 - DATEPART(day, datTimeStamp), dbo.fnEPiServerCommonGetDayStart(datTimeStamp)) > @dayDone OR (@dayDone is NULL))
		GROUP BY MONTH(datTimeStamp),
				YEAR(datTimeStamp)
	) AS t
	GROUP BY	item, intYear
	ORDER BY	intYear, item
END

--Day
ELSE IF @intResolution = 4
BEGIN
	SELECT item, SUM(count) AS count, intMonth, intYear
	FROM (
		SELECT 	DAY(datTimeStamp) AS item,
				SUM(intCount) AS count,
				MONTH(datTimeStamp) AS intMonth,
				YEAR(datTimeStamp) AS intYear
		FROM 	tblEPiServerCommonEventCounterEventDay
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventDay.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND		datTimeStamp
			BETWEEN @datStartDate AND @datEndDate
		AND 	strEventName = @strEventName
		AND intAction = @intAction
		GROUP BY YEAR(datTimeStamp),
				MONTH(datTimeStamp),
				DAY(datTimeStamp)
		UNION

		SELECT	DAY(datTimeStamp) AS item,
				SUM(intCount) AS count,
				MONTH(datTimeStamp) AS intMonth,
				YEAR(datTimeStamp) AS intYear
		FROM 	tblEPiServerCommonEventCounterEventHour
		INNER JOIN tblEPiServerCommonEventGroup 
			ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventHour.intEventGroupID
			AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
		WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
		AND		dbo.fnEPiServerCommonGetDayStart(datTimeStamp)
			BETWEEN @datStartDate AND @datEndDate
		AND 	strEventName = @strEventName
		AND intAction = @intAction
		AND		(dbo.fnEPiServerCommonGetDayStart(datTimeStamp) > @dayDone OR (@dayDone is NULL)) 
		GROUP BY YEAR(datTimeStamp),
				MONTH(datTimeStamp),
				DAY(datTimeStamp)
	) AS t
	GROUP BY	item, intMonth, intYear
	ORDER BY	intYear, intMonth, item
END

--Hour
ELSE IF @intResolution = 5
BEGIN
	SELECT	DATEPART(hour, datTimeStamp) AS item,
			SUM(intCount) AS count,
			DAY(datTimeStamp) AS intDay,
			MONTH(datTimeStamp) AS intMonth,
			YEAR(datTimeStamp) AS intYear
	FROM 	tblEPiServerCommonEventCounterEventHour
	INNER JOIN tblEPiServerCommonEventGroup 
		ON tblEPiServerCommonEventGroup.intID = tblEPiServerCommonEventCounterEventHour.intEventGroupID
		AND tblEPiServerCommonEventGroup.strName = @strEventGroupName
	WHERE	(intCategoryID = @intCategoryID OR (@intCategoryID IS NULL AND intCategoryID IS NULL))
	AND		dbo.fnEPiServerCommonGetDayStart(datTimeStamp)
		BETWEEN @datStartDate AND @datEndDate
	AND 	strEventName = @strEventName
	AND intAction = @intAction
	GROUP BY YEAR(datTimeStamp),
			MONTH(datTimeStamp),
			DAY(datTimeStamp),
			DATEPART(hour, datTimeStamp)
	ORDER BY	intYear, intMonth, intDay, item
END' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEventCounterAddJobLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

CREATE PROCEDURE [dbo].[spEPiServerCommonEventCounterAddJobLog]
(
	@intJobTypeID int,
	@intJobFrequencyID int,
	@datTimeStamp datetime
)
AS

DECLARE @intHour int
DECLARE @intDay int
DECLARE @intMonth int
DECLARE @intQuarter int
DECLARE @intYear int

SET @intHour = DATEPART(hh, @datTimeStamp)
SET @intDay = DATEPART(d, @datTimeStamp)
SET @intMonth  = DATEPART(m, @datTimeStamp)
SET @intQuarter = DATEPART(qq, @datTimeStamp)
SET @intYear = DATEPART(yy, @datTimeStamp)

DECLARE @intLastRunTime int
SET @intLastRunTime = 0

--Hour
IF @intJobFrequencyID = 1
	SET @intLastRunTime = @intHour
--Day
ELSE IF @intJobFrequencyID = 2
	SET @intLastRunTime = @intDay
--Month
ELSE IF @intJobFrequencyID = 3
	SET @intLastRunTime = @intMonth
--Quarter
ELSE IF @intJobFrequencyID = 4
	SET @intLastRunTime = @intQuarter
--Year
ELSE IF @intJobFrequencyID = 5
	SET @intLastRunTime = @intYear

IF @intJobFrequencyID = 1
BEGIN
	IF EXISTS (	
		SELECT * 
		FROM 	tblEPiServerCommonEventCounterJobLog 
		WHERE 	intJobTypeID = @intJobTypeID 
		AND 	intJobFrequencyID = @intJobFrequencyID 
		AND 	intDay = @intDay
		AND 	intMonth = @intMonth
		AND 	intYear = @intYear
		  )
	BEGIN
		UPDATE 	tblEPiServerCommonEventCounterJobLog
		SET	datTimeStamp = @datTimeStamp,
			intLastRunTime = @intLastRunTime	
		WHERE 	intJobTypeID = @intJobTypeID
		AND	intJobFrequencyID = @intJobFrequencyID 
		AND 	intDay = @intDay
		AND 	intMonth = @intMonth
		AND 	intYear = @intYear
	END
	ELSE
	BEGIN
		INSERT INTO tblEPiServerCommonEventCounterJobLog (intJobTypeID, intJobFrequencyID, intLastRunTime, intDay, intMonth, intQuarter, intYear)
		VALUES (@intJobTypeID, @intJobFrequencyID, @intLastRunTime, @intDay, @intMonth, @intQuarter, @intYear)
	END
END
ELSE IF @intJobFrequencyID = 2
BEGIN
	IF EXISTS (	
		SELECT * 
		FROM 	tblEPiServerCommonEventCounterJobLog 
		WHERE 	intJobTypeID = @intJobTypeID 
		AND 	intJobFrequencyID = @intJobFrequencyID 
		AND 	intMonth = @intMonth
		AND 	intYear = @intYear
		  )
	BEGIN
		UPDATE 	tblEPiServerCommonEventCounterJobLog
		SET	datTimeStamp = @datTimeStamp,
			intLastRunTime = @intLastRunTime,
			intDay = @intDay
		WHERE 	intJobTypeID = @intJobTypeID
		AND	intJobFrequencyID = @intJobFrequencyID 
		AND 	intMonth = @intMonth
		AND 	intYear = @intYear
	END
	ELSE
	BEGIN
		INSERT INTO tblEPiServerCommonEventCounterJobLog (intJobTypeID, intJobFrequencyID, intLastRunTime, intDay, intMonth, intQuarter, intYear)
		VALUES (@intJobTypeID, @intJobFrequencyID, @intLastRunTime, @intDay, @intMonth, @intQuarter, @intYear)
	END
END
ELSE IF @intJobFrequencyID = 3
BEGIN
	IF EXISTS (	
		SELECT * 
		FROM 	tblEPiServerCommonEventCounterJobLog 
		WHERE 	intJobTypeID = @intJobTypeID 
		AND 	intJobFrequencyID = @intJobFrequencyID 
		AND 	intYear = @intYear
		  )
	BEGIN
		UPDATE 	tblEPiServerCommonEventCounterJobLog
		SET	datTimeStamp = @datTimeStamp,
			intLastRunTime = @intLastRunTime,
			intMonth = @intMonth,
			intDay = @intDay
		WHERE 	intJobTypeID = @intJobTypeID
		AND	intJobFrequencyID = @intJobFrequencyID 
		AND 	intYear = @intYear
	END
	ELSE
	BEGIN
		INSERT INTO tblEPiServerCommonEventCounterJobLog (intJobTypeID, intJobFrequencyID, intLastRunTime, intDay, intMonth, intQuarter, intYear)
		VALUES (@intJobTypeID, @intJobFrequencyID, @intLastRunTime, @intDay, @intMonth, @intQuarter, @intYear)
	END
END
ELSE IF @intJobFrequencyID = 4
BEGIN
	IF EXISTS (	
		SELECT * 
		FROM 	tblEPiServerCommonEventCounterJobLog 
		WHERE 	intJobTypeID = @intJobTypeID 
		AND 	intJobFrequencyID = @intJobFrequencyID 
		AND 	intYear = @intYear
		  )
	BEGIN
		UPDATE 	tblEPiServerCommonEventCounterJobLog
		SET	datTimeStamp = @datTimeStamp,
			intLastRunTime = @intLastRunTime,
			intQuarter = @intQuarter,
			intMonth = @intMonth,
			intDay = @intDay
		WHERE 	intJobTypeID = @intJobTypeID
		AND	intJobFrequencyID = @intJobFrequencyID 
		AND 	intYear = @intYear
	END
	ELSE
	BEGIN
		INSERT INTO tblEPiServerCommonEventCounterJobLog (intJobTypeID, intJobFrequencyID, intLastRunTime, intDay, intMonth, intQuarter, intYear)
		VALUES (@intJobTypeID, @intJobFrequencyID, @intLastRunTime, @intDay, @intMonth, @intQuarter, @intYear)
	END
END
ELSE IF @intJobFrequencyID = 5
BEGIN
	IF EXISTS (	
		SELECT * 
		FROM 	tblEPiServerCommonEventCounterJobLog 
		WHERE 	intJobTypeID = @intJobTypeID 
		AND 	intJobFrequencyID = @intJobFrequencyID 
		AND 	intYear = @intYear
		  )
	BEGIN
		UPDATE 	tblEPiServerCommonEventCounterJobLog
		SET	datTimeStamp = @datTimeStamp,
			intLastRunTime = @intLastRunTime,
			intYear = @intYear,
			intQuarter = @intQuarter,
			intMonth = @intMonth,
			intDay = @intDay
		WHERE 	intJobTypeID = @intJobTypeID
		AND	intJobFrequencyID = @intJobFrequencyID 
		AND 	intYear = @intYear
	END
	ELSE
	BEGIN
		INSERT INTO tblEPiServerCommonEventCounterJobLog (intJobTypeID, intJobFrequencyID, intLastRunTime, intDay, intMonth, intQuarter, intYear)
		VALUES (@intJobTypeID, @intJobFrequencyID, @intLastRunTime, @intDay, @intMonth, @intQuarter, @intYear)
	END
END

' 
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEventCounterAddEventHour]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[spEPiServerCommonEventCounterAddEventHour]
@datNow DATETIME,
@blnAddJobLog BIT = 1
AS

SET NOCOUNT ON


INSERT INTO tblEPiServerCommonEventCounterEventHour (intAction, strEventName, intEventGroupID, intCategoryID, intCount, datTimeStamp)

--Get the data from the event log (except the current hour) and insert it into the hour aggregate table
SELECT 	intAction,
		strEventName,  
		intEventGroupID,
		intCategoryID,
		COUNT(*) AS intCount,
		DATEADD(hour, DATEPART(hour, datTimeStamp), dbo.fnEPiServerCommonGetDayStart(datTimeStamp))
FROM 	tblEPiServerCommonEventCounterEventLog 
WHERE 	blnSelectedByJob = 1
GROUP 	BY strEventName, 
		intEventGroupID,
		intCategoryID,
		intAction,
		DATEADD(hour, DATEPART(hour, datTimeStamp), dbo.fnEPiServerCommonGetDayStart(datTimeStamp))
ORDER BY DATEADD(hour, DATEPART(hour, datTimeStamp), dbo.fnEPiServerCommonGetDayStart(datTimeStamp))

IF @@ERROR <> 0
BEGIN
	RAISERROR(''Error inserting to event hour'', 16, 1)
	RETURN(-1)
END

IF @blnAddJobLog = 1
	EXEC spEPiServerCommonEventCounterAddJobLog 1, 1, @datNow
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEventCounterAddEventDay]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[spEPiServerCommonEventCounterAddEventDay]
@datNow DATETIME,
@blnDisregardPreviousJobCompletion BIT = 0,
@blnAddJobLog BIT = 1
AS

SET NOCOUNT ON

DECLARE @intCurrentYear int
DECLARE @intCurrentMonth int
DECLARE @intCurrentDay int
DECLARE @datCurrentDayRounded datetime

SET @intCurrentYear = DATEPART(yy, @datNow)
SET @intCurrentMonth = DATEPART(m, @datNow)
SET @intCurrentDay = DATEPART(d, @datNow)

SET @datCurrentDayRounded = CONVERT(DATETIME, (
			CONVERT(VARCHAR(4),@intCurrentYear)+''-''+
			CONVERT(VARCHAR(2),@intCurrentMonth)+''-''+
			CONVERT(VARCHAR(2),@intCurrentDay)+'' ''+
			''00:00:00'' ) )

INSERT INTO tblEPiServerCommonEventCounterEventDay (intAction, strEventName, intEventGroupID, intCategoryID, intCount, datTimeStamp)

--Get the data in the hour aggregate table from yesterday and back
SELECT intAction,
	strEventName,
	intEventGroupID,
	intCategoryID,
	SUM(intCount) AS intCount,
	dbo.fnEPiServerCommonGetDayStart(datTimeStamp)
FROM 	tblEPiServerCommonEventCounterEventHour 
WHERE	datTimeStamp < @datCurrentDayRounded
AND	NOT EXISTS (
		SELECT 	* 
		FROM 	tblEPiServerCommonEventCounterEventDay 
		WHERE 	tblEPiServerCommonEventCounterEventDay.datTimeStamp = dbo.fnEPiServerCommonGetDayStart(tblEPiServerCommonEventCounterEventHour.datTimeStamp)
	)
GROUP	BY strEventName, 
		intEventGroupID,
		intCategoryID,
		intAction,
		dbo.fnEPiServerCommonGetDayStart(datTimeStamp)
ORDER	BY dbo.fnEPiServerCommonGetDayStart(datTimeStamp)

IF @@ERROR <> 0
BEGIN
	RAISERROR(''Error inserting to event day'', 16, 1)
	RETURN(-1)
END

IF @@ROWCOUNT = 0
	PRINT(''No data to aggregate'')

IF @blnAddJobLog = 1
	EXEC spEPiServerCommonEventCounterAddJobLog 1, 2, @datNow
ELSE
	PRINT(''No job log added'')
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEventCounterAddEventMonth]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[spEPiServerCommonEventCounterAddEventMonth]
@datNow DATETIME,
@blnAddJobLog BIT = 1
AS

SET NOCOUNT ON

DECLARE @intCurrentYear int
DECLARE @intCurrentMonth int
DECLARE @datCurrentMonthRounded datetime

SET @intCurrentYear = DATEPART(yy, @datNow)
SET @intCurrentMonth = DATEPART(m, @datNow)
SET @datCurrentMonthRounded = CONVERT(DATETIME, (
	CONVERT(VARCHAR(4),@intCurrentYear)+''-''+
	CONVERT(VARCHAR(2),@intCurrentMonth)+
	''-01 00:00:00'' ) )

PRINT @datCurrentMonthRounded

INSERT INTO tblEPiServerCommonEventCounterEventMonth (intAction, strEventName, intEventGroupID, intCategoryID, intCount, datTimeStamp)

--Only get the data from the day aggregate table for last month and back
SELECT 	intAction,
	strEventName,
	intEventGroupID,
	intCategoryID,
	SUM(intCount) AS intCount,
	DATEADD(day, 1 - DATEPART(day, datTimeStamp), dbo.fnEPiServerCommonGetDayStart(datTimeStamp))
FROM 	tblEPiServerCommonEventCounterEventDay
WHERE	datTimeStamp < @datCurrentMonthRounded
AND	NOT EXISTS (
		SELECT 	* 
		FROM 	tblEPiServerCommonEventCounterEventMonth 
		WHERE 	tblEPiServerCommonEventCounterEventMonth.datTimeStamp = DATEADD(day, 1 - DATEPART(day, tblEPiServerCommonEventCounterEventDay.datTimeStamp), dbo.fnEPiServerCommonGetDayStart(tblEPiServerCommonEventCounterEventDay.datTimeStamp))
	)
GROUP 	BY strEventName, 
		intEventGroupID,
		intCategoryID,
		intAction,
		DATEADD(day, 1 - DATEPART(day, datTimeStamp), dbo.fnEPiServerCommonGetDayStart(datTimeStamp))
ORDER	BY	DATEADD(day, 1 - DATEPART(day, datTimeStamp), dbo.fnEPiServerCommonGetDayStart(datTimeStamp))

IF @@ERROR <> 0
BEGIN
	RAISERROR(''Error inserting to event month'', 16, 1)
	RETURN(-1)
END

IF @@ROWCOUNT = 0
	PRINT(''No data to aggregate'')

--Add the job log
IF @blnAddJobLog = 1
	EXEC spEPiServerCommonEventCounterAddJobLog 1, 3, @datNow
ELSE
	PRINT(''No job log added'')
' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spEPiServerCommonEventCounterRunJobs]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


CREATE PROCEDURE [dbo].[spEPiServerCommonEventCounterRunJobs]
@blnAddJobLog BIT = 1,
@datNow DATETIME = NULL
AS

DECLARE @intError int

DECLARE @ReturnCode int    
SELECT @ReturnCode = 0


DECLARE @intCurrentHour int
DECLARE @intCurrentDay int
DECLARE @intCurrentMonth int
DECLARE @intCurrentYear int
DECLARE @datCurrentHourRounded datetime


IF (@datNow IS NULL)
	SET @datNow = GETDATE()

SET @intCurrentHour = DATEPART(hh, @datNow)
SET @intCurrentDay = DATEPART(d, @datNow)
SET @intCurrentMonth = DATEPART(m, @datNow)
SET @intCurrentYear = DATEPART(yy, @datNow)

SET @datCurrentHourRounded = CONVERT(DATETIME, (
				CONVERT(VARCHAR(4),@intCurrentYear)+''-''+
				CONVERT(VARCHAR(2),@intCurrentMonth)+''-''+
				CONVERT(VARCHAR(2),@intCurrentDay)+'' ''+
				CONVERT(VARCHAR(2),@intCurrentHour)
				+'':00:00'' ) )

UPDATE 	tblEPiServerCommonEventCounterEventLog 
SET 	blnSelectedByJob = 1 
WHERE 	datTimeStamp < @datCurrentHourRounded

PRINT @datCurrentHourRounded

BEGIN TRANSACTION EPiServerCommonEventCounterJobs

--Events

EXEC @ReturnCode = spEPiServerCommonEventCounterAddEventHour @datNow, @blnAddJobLog
IF (@@ERROR <> 0 OR @ReturnCode <> 0)
BEGIN
	RAISERROR(''Error in add event hour'', 16, 1)
	GOTO ErrExit
END

EXEC @ReturnCode = spEPiServerCommonEventCounterAddEventDay @datNow, @blnAddJobLog
IF (@@ERROR <> 0 OR @ReturnCode <> 0)
BEGIN
	RAISERROR(''Error in add event day'', 16, 1)
	GOTO ErrExit
END

EXEC @ReturnCode = spEPiServerCommonEventCounterAddEventMonth @datNow, @blnAddJobLog
IF (@@ERROR <> 0 OR @ReturnCode <> 0)
BEGIN
	RAISERROR(''Error in add event month'', 16, 1)
	GOTO ErrExit
END

--Completion with success, commit the transaction
COMMIT TRANSACTION EPiServerCommonEventCounterJobs

--Remove the logs for the past hour and back
EXEC spEPiServerCommonEventCounterRemoveLogs

GOTO EndSave

--On error, rollback the data
ErrExit:
IF @@TRANCOUNT > 0
BEGIN
	ROLLBACK TRANSACTION EPiServerCommonEventCounterJobs

	RETURN(-1)
END

ErrExitUniqueLog:
BEGIN

	RETURN(-1)
END

EndSave:

' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnEPiServerCommonGetDayStart]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[fnEPiServerCommonGetDayStart]
(
	@datTimeStamp datetime
)
RETURNS smalldatetime
AS
BEGIN
	return CAST(FLOOR(CAST(@datTimeStamp AS FLOAT)) AS smalldatetime)
END
' 
END
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnEPiServerCommonGetQuarter]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'
CREATE FUNCTION [dbo].[fnEPiServerCommonGetQuarter]
(
	@datTimeStamp datetime
)
RETURNS int
AS
BEGIN
	return (MONTH(@datTimeStamp) - 1) / 3 + 1
END
' 
END
