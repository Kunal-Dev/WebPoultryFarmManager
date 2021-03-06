USE [dbPoultryFarm]
GO
/****** Object:  Table [dbo].[TblUserType]    Script Date: 04/10/2017 17:39:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblUserType](
	[Id] [int] NOT NULL,
	[Name] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_TblUserType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[VwUsers_Get]    Script Date: 04/10/2017 17:39:27 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 2, 2017

-- Created By:  ()
-- Purpose: Gets records from the VwUsers view passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[VwUsers_Get]
(

	@WhereClause nvarchar (2000)  ,

	@OrderBy nvarchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN

				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				IF (@OrderBy is null or LEN(@OrderBy) < 1)
				BEGIN
					-- default order by to first column
					SET @OrderBy = '[Id]'
				END

				-- SQL Server 2005 Paging
				declare @SQL as nvarchar(4000)
				SET @SQL = 'WITH PageIndex AS ('
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + convert(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') as RowIndex'
				SET @SQL = @SQL + ', [Id]'
				SET @SQL = @SQL + ', [FirstName]'
				SET @SQL = @SQL + ', [MiddleName]'
				SET @SQL = @SQL + ', [LastName]'
				SET @SQL = @SQL + ', [LandlineNumber]'
				SET @SQL = @SQL + ', [MobileNumber]'
				SET @SQL = @SQL + ', [Address]'
				SET @SQL = @SQL + ', [UserType]'
				SET @SQL = @SQL + ', [Name]'
				SET @SQL = @SQL + ' FROM dbo.[VwUsers]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				SET @SQL = @SQL + ' ) SELECT'
				SET @SQL = @SQL + ' [Id],'
				SET @SQL = @SQL + ' [FirstName],'
				SET @SQL = @SQL + ' [MiddleName],'
				SET @SQL = @SQL + ' [LastName],'
				SET @SQL = @SQL + ' [LandlineNumber],'
				SET @SQL = @SQL + ' [MobileNumber],'
				SET @SQL = @SQL + ' [Address],'
				SET @SQL = @SQL + ' [UserType],'
				SET @SQL = @SQL + ' [Name]'
				SET @SQL = @SQL + ' FROM PageIndex'
				SET @SQL = @SQL + ' WHERE RowIndex > ' + convert(nvarchar, @PageLowerBound)
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' AND RowIndex <= ' + convert(nvarchar, @PageUpperBound)
				END
				exec sp_executesql @SQL

				-- get row count
				SET @SQL = 'SELECT COUNT(*) as TotalRowCount'
				SET @SQL = @SQL + ' FROM dbo.[VwUsers]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				exec sp_executesql @SQL
				
				END
GO
/****** Object:  StoredProcedure [dbo].[TblUserType_Update]    Script Date: 04/10/2017 17:39:27 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Updates a record in the TblUserType table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserType_Update]
(

	@Id int   ,

	@OriginalId int   ,

	@Name nvarchar (15)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					dbo.[TblUserType]
				SET
					[Id] = @Id
					,[Name] = @Name
				WHERE
[Id] = @OriginalId
GO
/****** Object:  StoredProcedure [dbo].[TblUserType_Insert]    Script Date: 04/10/2017 17:39:27 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Inserts a record into the TblUserType table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserType_Insert]
(

	@Id int   ,

	@Name nvarchar (15)  
)
AS


					
				INSERT INTO dbo.[TblUserType]
					(
					[Id]
					,[Name]
					)
				VALUES
					(
					@Id
					,@Name
					)
GO
/****** Object:  StoredProcedure [dbo].[TblUserType_GetPaged]    Script Date: 04/10/2017 17:39:27 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Gets records from the TblUserType table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserType_GetPaged]
(

	@WhereClause nvarchar (2000)  ,

	@OrderBy nvarchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				Create Table #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [Id] int 
				)
				
				-- Insert into the temp table
				declare @SQL as nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex (Id)'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + convert(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [Id]'
				SET @SQL = @SQL + ' FROM dbo.[TblUserType]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				exec sp_executesql @SQL

				-- Return paged results
				SELECT O.[Id], O.[Name]
				FROM
				    dbo.[TblUserType] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexID > @PageLowerBound
					AND O.[Id] = PageIndex.[Id]
				ORDER BY
				    PageIndex.IndexID
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) as TotalRowCount'
				SET @SQL = @SQL + ' FROM dbo.[TblUserType]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				exec sp_executesql @SQL
			
				END
GO
/****** Object:  StoredProcedure [dbo].[TblUserType_GetById]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Select records from the TblUserType table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserType_GetById]
(

	@Id int   
)
AS


				SELECT
					[Id],
					[Name]
				FROM
					dbo.[TblUserType]
				WHERE
					[Id] = @Id
			Select @@ROWCOUNT
GO
/****** Object:  StoredProcedure [dbo].[TblUserType_Get_List]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Gets all records from the TblUserType table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserType_Get_List]

AS


				
				SELECT
					[Id],
					[Name]
				FROM
					dbo.[TblUserType]
					
				Select @@ROWCOUNT
GO
/****** Object:  StoredProcedure [dbo].[TblUserType_Find]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Finds records in the TblUserType table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserType_Find]
(

	@SearchUsingOR bit   = null ,

	@Id int   = null ,

	@Name nvarchar (15)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [Id]
	, [Name]
    FROM
	dbo.[TblUserType]
    WHERE 
	 ([Id] = @Id OR @Id is null)
	AND ([Name] = @Name OR @Name is null)
						
  END
  ELSE
  BEGIN
    SELECT
	  [Id]
	, [Name]
    FROM
	dbo.[TblUserType]
    WHERE 
	 ([Id] = @Id AND @Id is not null)
	OR ([Name] = @Name AND @Name is not null)
	Select @@ROWCOUNT			
  END
GO
/****** Object:  StoredProcedure [dbo].[TblUserType_Delete]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Deletes a record in the TblUserType table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserType_Delete]
(

	@Id int   
)
AS


				DELETE FROM dbo.[TblUserType] WITH (ROWLOCK) 
				WHERE
					[Id] = @Id
GO
/****** Object:  Table [dbo].[TblUsers]    Script Date: 04/10/2017 17:39:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblUsers](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](30) NOT NULL,
	[MiddleName] [nvarchar](15) NULL,
	[LastName] [nvarchar](30) NOT NULL,
	[LandlineNumber] [nvarchar](15) NULL,
	[MobileNumber] [nvarchar](15) NULL,
	[Address] [nvarchar](200) NULL,
	[UserType] [int] NOT NULL,
 CONSTRAINT [PK_TblUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[TblUsers_Update]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Updates a record in the TblUsers table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUsers_Update]
(

	@Id bigint   ,

	@FirstName nvarchar (30)  ,

	@MiddleName nvarchar (15)  ,

	@LastName nvarchar (30)  ,

	@LandlineNumber nvarchar (15)  ,

	@MobileNumber nvarchar (15)  ,

	@Address nvarchar (200)  ,

	@UserType int   
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					dbo.[TblUsers]
				SET
					[FirstName] = @FirstName
					,[MiddleName] = @MiddleName
					,[LastName] = @LastName
					,[LandlineNumber] = @LandlineNumber
					,[MobileNumber] = @MobileNumber
					,[Address] = @Address
					,[UserType] = @UserType
				WHERE
[Id] = @Id
GO
/****** Object:  StoredProcedure [dbo].[TblUsers_Insert]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Inserts a record into the TblUsers table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUsers_Insert]
(

	@Id bigint    OUTPUT,

	@FirstName nvarchar (30)  ,

	@MiddleName nvarchar (15)  ,

	@LastName nvarchar (30)  ,

	@LandlineNumber nvarchar (15)  ,

	@MobileNumber nvarchar (15)  ,

	@Address nvarchar (200)  ,

	@UserType int   
)
AS


					
				INSERT INTO dbo.[TblUsers]
					(
					[FirstName]
					,[MiddleName]
					,[LastName]
					,[LandlineNumber]
					,[MobileNumber]
					,[Address]
					,[UserType]
					)
				VALUES
					(
					@FirstName
					,@MiddleName
					,@LastName
					,@LandlineNumber
					,@MobileNumber
					,@Address
					,@UserType
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
GO
/****** Object:  StoredProcedure [dbo].[TblUsers_GetPaged]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Gets records from the TblUsers table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUsers_GetPaged]
(

	@WhereClause nvarchar (2000)  ,

	@OrderBy nvarchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				Create Table #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [Id] bigint 
				)
				
				-- Insert into the temp table
				declare @SQL as nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex (Id)'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + convert(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [Id]'
				SET @SQL = @SQL + ' FROM dbo.[TblUsers]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				exec sp_executesql @SQL

				-- Return paged results
				SELECT O.[Id], O.[FirstName], O.[MiddleName], O.[LastName], O.[LandlineNumber], O.[MobileNumber], O.[Address], O.[UserType]
				FROM
				    dbo.[TblUsers] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexID > @PageLowerBound
					AND O.[Id] = PageIndex.[Id]
				ORDER BY
				    PageIndex.IndexID
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) as TotalRowCount'
				SET @SQL = @SQL + ' FROM dbo.[TblUsers]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				exec sp_executesql @SQL
			
				END
GO
/****** Object:  StoredProcedure [dbo].[TblUsers_GetByUserType]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Select records from the TblUsers table through a foreign key
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUsers_GetByUserType]
(

	@UserType int   
)
AS


				SET ANSI_NULLS OFF
				
				SELECT
					[Id],
					[FirstName],
					[MiddleName],
					[LastName],
					[LandlineNumber],
					[MobileNumber],
					[Address],
					[UserType]
				FROM
					dbo.[TblUsers]
				WHERE
					[UserType] = @UserType
				
				Select @@ROWCOUNT
				SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[TblUsers_GetById]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Select records from the TblUsers table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUsers_GetById]
(

	@Id bigint   
)
AS


				SELECT
					[Id],
					[FirstName],
					[MiddleName],
					[LastName],
					[LandlineNumber],
					[MobileNumber],
					[Address],
					[UserType]
				FROM
					dbo.[TblUsers]
				WHERE
					[Id] = @Id
			Select @@ROWCOUNT
GO
/****** Object:  StoredProcedure [dbo].[TblUsers_Get_List]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Gets all records from the TblUsers table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUsers_Get_List]

AS


				
				SELECT
					[Id],
					[FirstName],
					[MiddleName],
					[LastName],
					[LandlineNumber],
					[MobileNumber],
					[Address],
					[UserType]
				FROM
					dbo.[TblUsers]
					
				Select @@ROWCOUNT
GO
/****** Object:  StoredProcedure [dbo].[TblUsers_Find]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Finds records in the TblUsers table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUsers_Find]
(

	@SearchUsingOR bit   = null ,

	@Id bigint   = null ,

	@FirstName nvarchar (30)  = null ,

	@MiddleName nvarchar (15)  = null ,

	@LastName nvarchar (30)  = null ,

	@LandlineNumber nvarchar (15)  = null ,

	@MobileNumber nvarchar (15)  = null ,

	@Address nvarchar (200)  = null ,

	@UserType int   = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [Id]
	, [FirstName]
	, [MiddleName]
	, [LastName]
	, [LandlineNumber]
	, [MobileNumber]
	, [Address]
	, [UserType]
    FROM
	dbo.[TblUsers]
    WHERE 
	 ([Id] = @Id OR @Id is null)
	AND ([FirstName] = @FirstName OR @FirstName is null)
	AND ([MiddleName] = @MiddleName OR @MiddleName is null)
	AND ([LastName] = @LastName OR @LastName is null)
	AND ([LandlineNumber] = @LandlineNumber OR @LandlineNumber is null)
	AND ([MobileNumber] = @MobileNumber OR @MobileNumber is null)
	AND ([Address] = @Address OR @Address is null)
	AND ([UserType] = @UserType OR @UserType is null)
						
  END
  ELSE
  BEGIN
    SELECT
	  [Id]
	, [FirstName]
	, [MiddleName]
	, [LastName]
	, [LandlineNumber]
	, [MobileNumber]
	, [Address]
	, [UserType]
    FROM
	dbo.[TblUsers]
    WHERE 
	 ([Id] = @Id AND @Id is not null)
	OR ([FirstName] = @FirstName AND @FirstName is not null)
	OR ([MiddleName] = @MiddleName AND @MiddleName is not null)
	OR ([LastName] = @LastName AND @LastName is not null)
	OR ([LandlineNumber] = @LandlineNumber AND @LandlineNumber is not null)
	OR ([MobileNumber] = @MobileNumber AND @MobileNumber is not null)
	OR ([Address] = @Address AND @Address is not null)
	OR ([UserType] = @UserType AND @UserType is not null)
	Select @@ROWCOUNT			
  END
GO
/****** Object:  StoredProcedure [dbo].[TblUsers_Delete]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Deletes a record in the TblUsers table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUsers_Delete]
(

	@Id bigint   
)
AS


				DELETE FROM dbo.[TblUsers] WITH (ROWLOCK) 
				WHERE
					[Id] = @Id
GO
/****** Object:  Table [dbo].[TblUserRecord]    Script Date: 04/10/2017 17:39:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TblUserRecord](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[Date] [datetime] NOT NULL,
	[TotalWeight] [decimal](18, 0) NOT NULL,
	[Pieces] [bigint] NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[TotalPrice] [decimal](18, 0) NOT NULL,
	[PreviousBalance] [decimal](18, 0) NOT NULL,
	[Paid] [decimal](18, 0) NOT NULL,
	[TotalBalance] [decimal](18, 0) NOT NULL,
	[Description] [nvarchar](4000) NULL,
 CONSTRAINT [PK_TblUserRecord] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VwUsers]    Script Date: 04/10/2017 17:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VwUsers]
AS
SELECT     dbo.TblUsers.Id, dbo.TblUsers.FirstName, dbo.TblUsers.MiddleName, dbo.TblUsers.LastName, dbo.TblUsers.LandlineNumber, dbo.TblUsers.MobileNumber, dbo.TblUsers.Address, 
                      dbo.TblUsers.UserType, dbo.TblUserType.Name
FROM         dbo.TblUsers INNER JOIN
                      dbo.TblUserType ON dbo.TblUsers.UserType = dbo.TblUserType.Id
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "TblUsers"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 265
               Right = 203
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "TblUserType"
            Begin Extent = 
               Top = 6
               Left = 241
               Bottom = 157
               Right = 401
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VwUsers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VwUsers'
GO
/****** Object:  StoredProcedure [dbo].[VwUsers_Get_List]    Script Date: 04/10/2017 17:39:27 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 2, 2017

-- Created By:  ()
-- Purpose: Gets all records from the VwUsers view
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[VwUsers_Get_List]

AS


				
				SELECT
					[Id],
					[FirstName],
					[MiddleName],
					[LastName],
					[LandlineNumber],
					[MobileNumber],
					[Address],
					[UserType],
					[Name]
				FROM
					dbo.[VwUsers]
					
				Select @@ROWCOUNT
GO
/****** Object:  StoredProcedure [dbo].[TblUserRecord_Update]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Updates a record in the TblUserRecord table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserRecord_Update]
(

	@Id bigint   ,

	@UserId bigint   ,

	@Date datetime   ,

	@TotalWeight decimal (18, 0)  ,

	@Pieces bigint   ,

	@Price decimal (18, 0)  ,

	@TotalPrice decimal (18, 0)  ,

	@PreviousBalance decimal (18, 0)  ,

	@Paid decimal (18, 0)  ,

	@TotalBalance decimal (18, 0)  ,

	@Description nvarchar (4000)  
)
AS


				
				
				-- Modify the updatable columns
				UPDATE
					dbo.[TblUserRecord]
				SET
					[UserId] = @UserId
					,[Date] = @Date
					,[TotalWeight] = @TotalWeight
					,[Pieces] = @Pieces
					,[Price] = @Price
					,[TotalPrice] = @TotalPrice
					,[PreviousBalance] = @PreviousBalance
					,[Paid] = @Paid
					,[TotalBalance] = @TotalBalance
					,[Description] = @Description
				WHERE
[Id] = @Id
GO
/****** Object:  StoredProcedure [dbo].[TblUserRecord_Insert]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Inserts a record into the TblUserRecord table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserRecord_Insert]
(

	@Id bigint    OUTPUT,

	@UserId bigint   ,

	@Date datetime   ,

	@TotalWeight decimal (18, 0)  ,

	@Pieces bigint   ,

	@Price decimal (18, 0)  ,

	@TotalPrice decimal (18, 0)  ,

	@PreviousBalance decimal (18, 0)  ,

	@Paid decimal (18, 0)  ,

	@TotalBalance decimal (18, 0)  ,

	@Description nvarchar (4000)  
)
AS


					
				INSERT INTO dbo.[TblUserRecord]
					(
					[UserId]
					,[Date]
					,[TotalWeight]
					,[Pieces]
					,[Price]
					,[TotalPrice]
					,[PreviousBalance]
					,[Paid]
					,[TotalBalance]
					,[Description]
					)
				VALUES
					(
					@UserId
					,@Date
					,@TotalWeight
					,@Pieces
					,@Price
					,@TotalPrice
					,@PreviousBalance
					,@Paid
					,@TotalBalance
					,@Description
					)
				
				-- Get the identity value
				SET @Id = SCOPE_IDENTITY()
GO
/****** Object:  StoredProcedure [dbo].[TblUserRecord_GetPaged]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Gets records from the TblUserRecord table passing page index and page count parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserRecord_GetPaged]
(

	@WhereClause nvarchar (2000)  ,

	@OrderBy nvarchar (2000)  ,

	@PageIndex int   ,

	@PageSize int   
)
AS


				
				BEGIN
				DECLARE @PageLowerBound int
				DECLARE @PageUpperBound int
				
				-- Set the page bounds
				SET @PageLowerBound = @PageSize * @PageIndex
				SET @PageUpperBound = @PageLowerBound + @PageSize

				-- Create a temp table to store the select results
				Create Table #PageIndex
				(
				    [IndexId] int IDENTITY (1, 1) NOT NULL,
				    [Id] bigint 
				)
				
				-- Insert into the temp table
				declare @SQL as nvarchar(4000)
				SET @SQL = 'INSERT INTO #PageIndex (Id)'
				SET @SQL = @SQL + ' SELECT'
				IF @PageSize > 0
				BEGIN
					SET @SQL = @SQL + ' TOP ' + convert(nvarchar, @PageUpperBound)
				END
				SET @SQL = @SQL + ' [Id]'
				SET @SQL = @SQL + ' FROM dbo.[TblUserRecord]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				IF LEN(@OrderBy) > 0
				BEGIN
					SET @SQL = @SQL + ' ORDER BY ' + @OrderBy
				END
				
				-- Populate the temp table
				exec sp_executesql @SQL

				-- Return paged results
				SELECT O.[Id], O.[UserId], O.[Date], O.[TotalWeight], O.[Pieces], O.[Price], O.[TotalPrice], O.[PreviousBalance], O.[Paid], O.[TotalBalance], O.[Description]
				FROM
				    dbo.[TblUserRecord] O,
				    #PageIndex PageIndex
				WHERE
				    PageIndex.IndexID > @PageLowerBound
					AND O.[Id] = PageIndex.[Id]
				ORDER BY
				    PageIndex.IndexID
				
				-- get row count
				SET @SQL = 'SELECT COUNT(*) as TotalRowCount'
				SET @SQL = @SQL + ' FROM dbo.[TblUserRecord]'
				IF LEN(@WhereClause) > 0
				BEGIN
					SET @SQL = @SQL + ' WHERE ' + @WhereClause
				END
				exec sp_executesql @SQL
			
				END
GO
/****** Object:  StoredProcedure [dbo].[TblUserRecord_GetByUserId]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Select records from the TblUserRecord table through a foreign key
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserRecord_GetByUserId]
(

	@UserId bigint   
)
AS


				SET ANSI_NULLS OFF
				
				SELECT
					[Id],
					[UserId],
					[Date],
					[TotalWeight],
					[Pieces],
					[Price],
					[TotalPrice],
					[PreviousBalance],
					[Paid],
					[TotalBalance],
					[Description]
				FROM
					dbo.[TblUserRecord]
				WHERE
					[UserId] = @UserId
				
				Select @@ROWCOUNT
				SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dbo].[TblUserRecord_GetById]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Select records from the TblUserRecord table through an index
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserRecord_GetById]
(

	@Id bigint   
)
AS


				SELECT
					[Id],
					[UserId],
					[Date],
					[TotalWeight],
					[Pieces],
					[Price],
					[TotalPrice],
					[PreviousBalance],
					[Paid],
					[TotalBalance],
					[Description]
				FROM
					dbo.[TblUserRecord]
				WHERE
					[Id] = @Id
			Select @@ROWCOUNT
GO
/****** Object:  StoredProcedure [dbo].[TblUserRecord_Get_List]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Gets all records from the TblUserRecord table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserRecord_Get_List]

AS


				
				SELECT
					[Id],
					[UserId],
					[Date],
					[TotalWeight],
					[Pieces],
					[Price],
					[TotalPrice],
					[PreviousBalance],
					[Paid],
					[TotalBalance],
					[Description]
				FROM
					dbo.[TblUserRecord]
					
				Select @@ROWCOUNT
GO
/****** Object:  StoredProcedure [dbo].[TblUserRecord_Find]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Finds records in the TblUserRecord table passing nullable parameters
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserRecord_Find]
(

	@SearchUsingOR bit   = null ,

	@Id bigint   = null ,

	@UserId bigint   = null ,

	@Date datetime   = null ,

	@TotalWeight decimal (18, 0)  = null ,

	@Pieces bigint   = null ,

	@Price decimal (18, 0)  = null ,

	@TotalPrice decimal (18, 0)  = null ,

	@PreviousBalance decimal (18, 0)  = null ,

	@Paid decimal (18, 0)  = null ,

	@TotalBalance decimal (18, 0)  = null ,

	@Description nvarchar (4000)  = null 
)
AS


				
  IF ISNULL(@SearchUsingOR, 0) <> 1
  BEGIN
    SELECT
	  [Id]
	, [UserId]
	, [Date]
	, [TotalWeight]
	, [Pieces]
	, [Price]
	, [TotalPrice]
	, [PreviousBalance]
	, [Paid]
	, [TotalBalance]
	, [Description]
    FROM
	dbo.[TblUserRecord]
    WHERE 
	 ([Id] = @Id OR @Id is null)
	AND ([UserId] = @UserId OR @UserId is null)
	AND ([Date] = @Date OR @Date is null)
	AND ([TotalWeight] = @TotalWeight OR @TotalWeight is null)
	AND ([Pieces] = @Pieces OR @Pieces is null)
	AND ([Price] = @Price OR @Price is null)
	AND ([TotalPrice] = @TotalPrice OR @TotalPrice is null)
	AND ([PreviousBalance] = @PreviousBalance OR @PreviousBalance is null)
	AND ([Paid] = @Paid OR @Paid is null)
	AND ([TotalBalance] = @TotalBalance OR @TotalBalance is null)
	AND ([Description] = @Description OR @Description is null)
						
  END
  ELSE
  BEGIN
    SELECT
	  [Id]
	, [UserId]
	, [Date]
	, [TotalWeight]
	, [Pieces]
	, [Price]
	, [TotalPrice]
	, [PreviousBalance]
	, [Paid]
	, [TotalBalance]
	, [Description]
    FROM
	dbo.[TblUserRecord]
    WHERE 
	 ([Id] = @Id AND @Id is not null)
	OR ([UserId] = @UserId AND @UserId is not null)
	OR ([Date] = @Date AND @Date is not null)
	OR ([TotalWeight] = @TotalWeight AND @TotalWeight is not null)
	OR ([Pieces] = @Pieces AND @Pieces is not null)
	OR ([Price] = @Price AND @Price is not null)
	OR ([TotalPrice] = @TotalPrice AND @TotalPrice is not null)
	OR ([PreviousBalance] = @PreviousBalance AND @PreviousBalance is not null)
	OR ([Paid] = @Paid AND @Paid is not null)
	OR ([TotalBalance] = @TotalBalance AND @TotalBalance is not null)
	OR ([Description] = @Description AND @Description is not null)
	Select @@ROWCOUNT			
  END
GO
/****** Object:  StoredProcedure [dbo].[TblUserRecord_Delete]    Script Date: 04/10/2017 17:39:26 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
/*
----------------------------------------------------------------------------------------------------
-- Date Created: Sunday, April 9, 2017

-- Created By:  ()
-- Purpose: Deletes a record in the TblUserRecord table
----------------------------------------------------------------------------------------------------
*/


CREATE PROCEDURE [dbo].[TblUserRecord_Delete]
(

	@Id bigint   
)
AS


				DELETE FROM dbo.[TblUserRecord] WITH (ROWLOCK) 
				WHERE
					[Id] = @Id
GO
/****** Object:  ForeignKey [FK_TblUserRecord_TblUsers]    Script Date: 04/10/2017 17:39:24 ******/
ALTER TABLE [dbo].[TblUserRecord]  WITH CHECK ADD  CONSTRAINT [FK_TblUserRecord_TblUsers] FOREIGN KEY([UserId])
REFERENCES [dbo].[TblUsers] ([Id])
GO
ALTER TABLE [dbo].[TblUserRecord] CHECK CONSTRAINT [FK_TblUserRecord_TblUsers]
GO
/****** Object:  ForeignKey [FK_TblUsers_TblUserType]    Script Date: 04/10/2017 17:39:24 ******/
ALTER TABLE [dbo].[TblUsers]  WITH CHECK ADD  CONSTRAINT [FK_TblUsers_TblUserType] FOREIGN KEY([UserType])
REFERENCES [dbo].[TblUserType] ([Id])
GO
ALTER TABLE [dbo].[TblUsers] CHECK CONSTRAINT [FK_TblUsers_TblUserType]
GO
