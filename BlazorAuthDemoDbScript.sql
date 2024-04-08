USE [Master]
GO

IF EXISTS (SELECT * FROM sys.databases WHERE NAME = 'BlazorAuthDemoDb')
	ALTER DATABASE [BlazorAuthDemoDb] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
IF EXISTS (SELECT * FROM sys.databases WHERE NAME = 'BlazorAuthDemoDb')
	DROP DATABASE BlazorAuthDemoDb
GO

CREATE DATABASE BlazorAuthDemoDb
GO

USE BlazorAuthDemoDb
GO

IF NOT EXISTS (SELECT name FROM sys.schemas
	WHERE NAME = N'security')

	BEGIN
		EXEC ('CREATE SCHEMA [security]')
	END

/****** Object:  Table [security].[AspNetRoles] ******/
IF NOT EXISTS (SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[security].[AspNetRoles]') AND type in (N'U'))

	BEGIN
		CREATE TABLE [security].[AspNetRoles](
			[Id] [nvarchar](450) NOT NULL,
			[Name] [nvarchar](256) NULL,
			[NormalizedName] [nvarchar](256) NULL,
			[ConcurrencyStamp] [nvarchar](max) NULL,
		 CONSTRAINT [PK_AspNetRoles] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END

/****** Object:  Table [security].[AspNetRoleClaims] ******/
IF NOT EXISTS (SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[security].[AspNetRoleClaims]') AND type in (N'U'))

	BEGIN
		CREATE TABLE [security].[AspNetRoleClaims](
			[Id] [int] IDENTITY(1,1) NOT NULL,
			[RoleId] [nvarchar](450) NOT NULL,
			[ClaimType] [nvarchar](max) NULL,
			[ClaimValue] [nvarchar](max) NULL,
		 CONSTRAINT [PK_AspNetRoleClaims] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
	WHERE CONSTRAINT_NAME ='FK_AspNetRoleClaims_AspNetRoles_RoleId')

	BEGIN
		ALTER TABLE [security].[AspNetRoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
		REFERENCES [security].[AspNetRoles] ([Id])
		ON DELETE CASCADE
	END


ALTER TABLE [security].[AspNetRoleClaims] CHECK CONSTRAINT [FK_AspNetRoleClaims_AspNetRoles_RoleId]
GO

/****** Object:  Table [security].[AspNetUsers] ******/
IF NOT EXISTS (SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[security].[AspNetUsers]') AND type in (N'U'))

	BEGIN
		CREATE TABLE [security].[AspNetUsers](
			[Id] [nvarchar](450) NOT NULL,
			[UserName] [nvarchar](256) NULL,
			[NormalizedUserName] [nvarchar](256) NULL,
			[Email] [nvarchar](256) NULL,
			[NormalizedEmail] [nvarchar](256) NULL,
			[EmailConfirmed] [bit] NOT NULL,
			[PasswordHash] [nvarchar](max) NULL,
			[SecurityStamp] [nvarchar](max) NULL,
			[ConcurrencyStamp] [nvarchar](max) NULL,
			[PhoneNumber] [nvarchar](max) NULL,
			[PhoneNumberConfirmed] [bit] NOT NULL,
			[TwoFactorEnabled] [bit] NOT NULL,
			[LockoutEnd] [datetimeoffset](7) NULL,
			[LockoutEnabled] [bit] NOT NULL,
			[AccessFailedCount] [int] NOT NULL,
		 CONSTRAINT [PK_AspNetUsers] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END

/****** Object:  Table [security].[AspNetUserClaims] ******/
IF NOT EXISTS (SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[security].[AspNetUserClaims]') AND type in (N'U'))

	BEGIN
		CREATE TABLE [security].[AspNetUserClaims](
			[Id] [int] IDENTITY(1,1) NOT NULL,
			[UserId] [nvarchar](450) NOT NULL,
			[ClaimType] [nvarchar](max) NULL,
			[ClaimValue] [nvarchar](max) NULL,
		 CONSTRAINT [PK_AspNetUserClaims] PRIMARY KEY CLUSTERED 
		(
			[Id] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
	WHERE CONSTRAINT_NAME ='FK_AspNetUserClaims_AspNetUsers_UserId')

	BEGIN
		ALTER TABLE [security].[AspNetUserClaims]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId] FOREIGN KEY([UserId])
		REFERENCES [security].[AspNetUsers] ([Id])
		ON DELETE CASCADE
	END

ALTER TABLE [security].[AspNetUserClaims] CHECK CONSTRAINT [FK_AspNetUserClaims_AspNetUsers_UserId]
GO

/****** Object:  Table [security].[AspNetUserTokens] ******/
IF NOT EXISTS (SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[security].[AspNetUserTokens]') AND type in (N'U'))

	BEGIN
		CREATE TABLE [security].[AspNetUserTokens](
			[UserId] [nvarchar](450) NOT NULL,
			[LoginProvider] [nvarchar](128) NOT NULL,
			[Name] [nvarchar](128) NOT NULL,
			[Value] [nvarchar](max) NULL,
		 CONSTRAINT [PK_AspNetUserTokens] PRIMARY KEY CLUSTERED 
		(
			[UserId] ASC,
			[LoginProvider] ASC,
			[Name] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
	WHERE CONSTRAINT_NAME ='FK_AspNetUserTokens_AspNetUsers_UserId')

	BEGIN
	   ALTER TABLE [security].[AspNetUserTokens]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId] FOREIGN KEY([UserId])
		REFERENCES [security].[AspNetUsers] ([Id])
		ON DELETE CASCADE
	END

ALTER TABLE [security].[AspNetUserTokens] CHECK CONSTRAINT [FK_AspNetUserTokens_AspNetUsers_UserId]
GO


/****** Object:  Table [security].[AspNetUserLogins] ******/
IF NOT EXISTS (SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[security].[AspNetUserLogins]') AND type in (N'U'))

	BEGIN
		CREATE TABLE [security].[AspNetUserLogins](
			[LoginProvider] [nvarchar](128) NOT NULL,
			[ProviderKey] [nvarchar](128) NOT NULL,
			[ProviderDisplayName] [nvarchar](max) NULL,
			[UserId] [nvarchar](450) NOT NULL,
		 CONSTRAINT [PK_AspNetUserLogins] PRIMARY KEY CLUSTERED 
		(
			[LoginProvider] ASC,
			[ProviderKey] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
	END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
	WHERE CONSTRAINT_NAME ='FK_AspNetUserLogins_AspNetUsers_UserId')

	BEGIN
		ALTER TABLE [security].[AspNetUserLogins]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId] FOREIGN KEY([UserId])
		REFERENCES [security].[AspNetUsers] ([Id])
		ON DELETE CASCADE
	END

ALTER TABLE [security].[AspNetUserLogins] CHECK CONSTRAINT [FK_AspNetUserLogins_AspNetUsers_UserId]
GO


/****** Object:  Table [security].[AspNetUserRoles] ******/
IF NOT EXISTS (SELECT * FROM sys.objects
	WHERE object_id = OBJECT_ID(N'[security].[AspNetUserRoles]') AND type in (N'U'))

	BEGIN
		CREATE TABLE [security].[AspNetUserRoles](
			[UserId] [nvarchar](450) NOT NULL,
			[RoleId] [nvarchar](450) NOT NULL,
		 CONSTRAINT [PK_AspNetUserRoles] PRIMARY KEY CLUSTERED 
		(
			[UserId] ASC,
			[RoleId] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	END

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
	WHERE CONSTRAINT_NAME ='FK_AspNetUserRoles_AspNetRoles_RoleId')

	BEGIN
		ALTER TABLE [security].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId] FOREIGN KEY([RoleId])
		REFERENCES [security].[AspNetRoles] ([Id])
		ON DELETE CASCADE
	END
GO

ALTER TABLE [security].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetRoles_RoleId]
GO

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
	WHERE CONSTRAINT_NAME ='FK_AspNetUserRoles_AspNetUsers_UserId')

	BEGIN
		ALTER TABLE [security].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId] FOREIGN KEY([UserId])
		REFERENCES [security].[AspNetUsers] ([Id])
		ON DELETE CASCADE
	END

ALTER TABLE [security].[AspNetUserRoles] CHECK CONSTRAINT [FK_AspNetUserRoles_AspNetUsers_UserId]

