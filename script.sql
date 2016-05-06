USE [master]
GO
/****** Object:  Database [s16guest35]    Script Date: 5/6/2016 4:03:20 PM ******/
CREATE DATABASE [s16guest35]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N's16guest35', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.CSDB440\MSSQL\DATA\s16guest35.mdf' , SIZE = 3136KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N's16guest35_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.CSDB440\MSSQL\DATA\s16guest35_log.ldf' , SIZE = 784KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [s16guest35] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [s16guest35].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [s16guest35] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [s16guest35] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [s16guest35] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [s16guest35] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [s16guest35] SET ARITHABORT OFF 
GO
ALTER DATABASE [s16guest35] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [s16guest35] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [s16guest35] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [s16guest35] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [s16guest35] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [s16guest35] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [s16guest35] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [s16guest35] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [s16guest35] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [s16guest35] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [s16guest35] SET  ENABLE_BROKER 
GO
ALTER DATABASE [s16guest35] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [s16guest35] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [s16guest35] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [s16guest35] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [s16guest35] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [s16guest35] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [s16guest35] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [s16guest35] SET RECOVERY FULL 
GO
ALTER DATABASE [s16guest35] SET  MULTI_USER 
GO
ALTER DATABASE [s16guest35] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [s16guest35] SET DB_CHAINING OFF 
GO
ALTER DATABASE [s16guest35] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [s16guest35] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N's16guest35', N'ON'
GO
USE [s16guest35]
GO
/****** Object:  User [s16guest35]    Script Date: 5/6/2016 4:03:21 PM ******/
CREATE USER [s16guest35] FOR LOGIN [s16guest35] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [appuser]    Script Date: 5/6/2016 4:03:21 PM ******/
CREATE USER [appuser] WITHOUT LOGIN WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [s16guest35]
GO
/****** Object:  StoredProcedure [dbo].[insert_feature]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Kevin Baktiar>
-- Create date: <5-3-16>
-- Description:	<Insert Description>
-- =============================================
CREATE PROCEDURE [dbo].[insert_feature] 
	-- Add the parameters for the stored procedure here
	@feature_desc varchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT feature_description from dbo.feature WHERE feature_description = @feature_desc)

	BEGIN

    -- Insert statements for procedure here
	INSERT INTO feature(feature_description)
	Values (@feature_desc)

	END
	ELSE
	BEGIN
		PRINT 'The feature already exists'	
		SELECT feature_id from dbo.feature WHERE feature_description = @feature_desc

		END

END

GO
/****** Object:  StoredProcedure [dbo].[insert_product]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Kevin Baktiar>
-- Create date: <5-4-16>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[insert_product] 
	-- Add the parameters for the stored procedure here
	@product_name varchar(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT product_name from dbo.product WHERE product_name = @product_name)

	BEGIN

    -- Insert statements for procedure here
	INSERT INTO product(product_name)
	Values (@product_name)

	END
	ELSE
	BEGIN
		PRINT 'The Product already exists'	
		SELECT product_id from dbo.product WHERE product_name = @product_name

		END

END

GO
/****** Object:  StoredProcedure [dbo].[new_feature_count]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[new_feature_count] 
	-- Add the parameters for the stored procedure here
	@customer_release_id int

AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT release_id FROM dbo.download WHERE release_id = @customer_release_id)

	BEGIN
		PRINT 'Invalid Customer Release ID'
	END
	ELSE

	BEGIN
		DECLARE @feature_count int
		SELECT @feature_count = COUNT(*) FROM product_feature WHERE product_feature.version_id = @customer_release_id
			IF @feature_count > 0
				PRINT CONVERT(varchar(4),@feature_count) + 'new features are in the ' + CONVERT(varchar(4),@customer_release_id) + ' release.'

			ELSE
				PRINT 'There arent any new features.'
	END

END

GO
/****** Object:  StoredProcedure [dbo].[update_product_version]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Kevin Baktiar>
-- Create date: <5-3-16,>
-- Description:	<Updates the Product Version>
-- =============================================
CREATE PROCEDURE [dbo].[update_product_version] 
	-- Add the parameters for the stored procedure here
	@product_id int,
	@version_num int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT product_id from dbo.product WHERE product_id = @product_id)

    BEGIN
		PRINT 'Invaild Product ID'
	END
	ELSE IF EXISTS(SELECT version_number from dbo.version WHERE version_number = @version_num)
	
	BEGIN
		PRINT 'Version Exists Already'
	END

	ELSE
	INSERT INTO dbo.version (version_number, product_id)
		VALUES (@version_num, @product_id)
END

GO
/****** Object:  Table [dbo].[branch]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[branch](
	[branch_id] [int] NOT NULL,
	[iteration_id] [int] NOT NULL,
	[branch_name] [varchar](25) NOT NULL,
	[file_location] [varchar](max) NOT NULL,
	[branch_date] [datetime] NOT NULL,
 CONSTRAINT [PK_branch] PRIMARY KEY CLUSTERED 
(
	[branch_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[city]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[city](
	[city_id] [int] NOT NULL,
	[state_id] [int] NOT NULL,
	[city_name] [varchar](255) NOT NULL,
 CONSTRAINT [PK_city] PRIMARY KEY CLUSTERED 
(
	[city_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[company]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[company](
	[company_id] [int] NOT NULL,
	[company_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_company] PRIMARY KEY CLUSTERED 
(
	[company_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[customer]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[customer](
	[customer_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[email] [varchar](255) NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[password] [varchar](20) NOT NULL,
	[username] [varchar](20) NOT NULL,
 CONSTRAINT [PK_customer] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[customer_address]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[customer_address](
	[customer_id] [int] NOT NULL,
	[company_id] [int] NOT NULL,
	[addressline_1] [varchar](max) NOT NULL,
	[addressline_2] [varchar](max) NULL,
	[city_id] [int] NOT NULL,
	[state_id] [int] NOT NULL,
	[zip_code] [smallint] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[download]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[download](
	[release_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[download_date] [datetime] NOT NULL,
 CONSTRAINT [PK_download] PRIMARY KEY CLUSTERED 
(
	[release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[feature]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[feature](
	[feature_id] [int] NOT NULL,
	[feature_description] [varchar](max) NOT NULL,
	[feature_deprecated] [bit] NOT NULL,
	[feature_date] [datetime] NOT NULL,
	[new_feature] [bit] NOT NULL,
 CONSTRAINT [PK_feature] PRIMARY KEY CLUSTERED 
(
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[internal_release]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[internal_release](
	[internal_release_id] [int] NOT NULL,
	[branch_id] [int] NOT NULL,
	[internal_release_date] [datetime] NOT NULL,
 CONSTRAINT [PK_internal_release] PRIMARY KEY CLUSTERED 
(
	[internal_release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[iteration]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[iteration](
	[iteration_id] [int] NOT NULL,
	[product_id] [int] NULL,
	[version_id] [int] NULL,
	[start_date] [datetime] NULL,
	[end_date] [datetime] NULL,
 CONSTRAINT [PK_iteration] PRIMARY KEY CLUSTERED 
(
	[iteration_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[login]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[login](
	[customer_id] [int] NOT NULL,
	[username] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
 CONSTRAINT [PK_login] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[phone]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[phone](
	[phone_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[area_code] [smallint] NOT NULL,
	[phone_number] [int] NOT NULL,
	[phone_type_id] [int] NULL,
 CONSTRAINT [PK_phone] PRIMARY KEY CLUSTERED 
(
	[phone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[phone_type]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[phone_type](
	[phone_type_id] [int] NOT NULL,
	[phone_type] [varchar](50) NOT NULL,
 CONSTRAINT [PK_phone_type] PRIMARY KEY CLUSTERED 
(
	[phone_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[product]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[product](
	[product_id] [int] NOT NULL,
	[product_name] [varchar](50) NOT NULL,
	[product_description] [varchar](max) NOT NULL,
 CONSTRAINT [PK_product] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[product_feature]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_feature](
	[version_id] [int] NOT NULL,
	[feature_id] [int] NOT NULL,
 CONSTRAINT [PK_product_feature] PRIMARY KEY CLUSTERED 
(
	[version_id] ASC,
	[feature_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[release]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[release](
	[release_id] [int] NOT NULL,
	[internal_release_id] [int] NOT NULL,
	[release_url] [varchar](max) NOT NULL,
	[release_version] [tinyint] NOT NULL,
	[release_date] [datetime] NOT NULL,
	[is_deprecated] [bit] NOT NULL,
	[release_type] [varchar](200) NULL,
 CONSTRAINT [PK_release] PRIMARY KEY CLUSTERED 
(
	[release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[release_download]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[release_download](
	[release_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[download_date] [datetime] NOT NULL,
 CONSTRAINT [PK_release_download] PRIMARY KEY CLUSTERED 
(
	[release_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[state]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[state](
	[state_id] [int] NOT NULL,
	[state_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_state] PRIMARY KEY CLUSTERED 
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[version]    Script Date: 5/6/2016 4:03:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[version](
	[version_id] [int] NOT NULL,
	[product_id] [int] NOT NULL,
	[version_number] [varchar](10) NOT NULL,
	[platform] [varchar](50) NOT NULL,
 CONSTRAINT [PK_version] PRIMARY KEY CLUSTERED 
(
	[version_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[branch]  WITH CHECK ADD  CONSTRAINT [FK_branch_iteration] FOREIGN KEY([iteration_id])
REFERENCES [dbo].[iteration] ([iteration_id])
GO
ALTER TABLE [dbo].[branch] CHECK CONSTRAINT [FK_branch_iteration]
GO
ALTER TABLE [dbo].[city]  WITH CHECK ADD  CONSTRAINT [FK_city_state] FOREIGN KEY([state_id])
REFERENCES [dbo].[state] ([state_id])
GO
ALTER TABLE [dbo].[city] CHECK CONSTRAINT [FK_city_state]
GO
ALTER TABLE [dbo].[customer]  WITH CHECK ADD  CONSTRAINT [FK_customer_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[customer] CHECK CONSTRAINT [FK_customer_company]
GO
ALTER TABLE [dbo].[customer_address]  WITH CHECK ADD  CONSTRAINT [FK_customer_address_city] FOREIGN KEY([city_id])
REFERENCES [dbo].[city] ([city_id])
GO
ALTER TABLE [dbo].[customer_address] CHECK CONSTRAINT [FK_customer_address_city]
GO
ALTER TABLE [dbo].[customer_address]  WITH CHECK ADD  CONSTRAINT [FK_customer_address_company] FOREIGN KEY([company_id])
REFERENCES [dbo].[company] ([company_id])
GO
ALTER TABLE [dbo].[customer_address] CHECK CONSTRAINT [FK_customer_address_company]
GO
ALTER TABLE [dbo].[customer_address]  WITH CHECK ADD  CONSTRAINT [FK_customer_address_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[customer_address] CHECK CONSTRAINT [FK_customer_address_customer]
GO
ALTER TABLE [dbo].[customer_address]  WITH CHECK ADD  CONSTRAINT [FK_customer_address_state] FOREIGN KEY([state_id])
REFERENCES [dbo].[state] ([state_id])
GO
ALTER TABLE [dbo].[customer_address] CHECK CONSTRAINT [FK_customer_address_state]
GO
ALTER TABLE [dbo].[download]  WITH CHECK ADD  CONSTRAINT [FK_download_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[download] CHECK CONSTRAINT [FK_download_customer]
GO
ALTER TABLE [dbo].[download]  WITH CHECK ADD  CONSTRAINT [FK_download_release] FOREIGN KEY([release_id])
REFERENCES [dbo].[release] ([release_id])
GO
ALTER TABLE [dbo].[download] CHECK CONSTRAINT [FK_download_release]
GO
ALTER TABLE [dbo].[internal_release]  WITH CHECK ADD  CONSTRAINT [FK_internal_release_branch] FOREIGN KEY([branch_id])
REFERENCES [dbo].[branch] ([branch_id])
GO
ALTER TABLE [dbo].[internal_release] CHECK CONSTRAINT [FK_internal_release_branch]
GO
ALTER TABLE [dbo].[iteration]  WITH CHECK ADD  CONSTRAINT [FK_iteration_version] FOREIGN KEY([version_id])
REFERENCES [dbo].[version] ([version_id])
GO
ALTER TABLE [dbo].[iteration] CHECK CONSTRAINT [FK_iteration_version]
GO
ALTER TABLE [dbo].[login]  WITH CHECK ADD  CONSTRAINT [FK_login_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[login] CHECK CONSTRAINT [FK_login_customer]
GO
ALTER TABLE [dbo].[phone]  WITH CHECK ADD  CONSTRAINT [FK_phone_customer] FOREIGN KEY([customer_id])
REFERENCES [dbo].[customer] ([customer_id])
GO
ALTER TABLE [dbo].[phone] CHECK CONSTRAINT [FK_phone_customer]
GO
ALTER TABLE [dbo].[phone]  WITH CHECK ADD  CONSTRAINT [FK_phone_phone_type] FOREIGN KEY([phone_type_id])
REFERENCES [dbo].[phone_type] ([phone_type_id])
GO
ALTER TABLE [dbo].[phone] CHECK CONSTRAINT [FK_phone_phone_type]
GO
ALTER TABLE [dbo].[product_feature]  WITH CHECK ADD  CONSTRAINT [FK_product_feature_feature] FOREIGN KEY([feature_id])
REFERENCES [dbo].[feature] ([feature_id])
GO
ALTER TABLE [dbo].[product_feature] CHECK CONSTRAINT [FK_product_feature_feature]
GO
ALTER TABLE [dbo].[product_feature]  WITH CHECK ADD  CONSTRAINT [FK_product_feature_version] FOREIGN KEY([version_id])
REFERENCES [dbo].[version] ([version_id])
GO
ALTER TABLE [dbo].[product_feature] CHECK CONSTRAINT [FK_product_feature_version]
GO
ALTER TABLE [dbo].[release]  WITH CHECK ADD  CONSTRAINT [FK_release_interal_release] FOREIGN KEY([internal_release_id])
REFERENCES [dbo].[internal_release] ([internal_release_id])
GO
ALTER TABLE [dbo].[release] CHECK CONSTRAINT [FK_release_interal_release]
GO
ALTER TABLE [dbo].[release_download]  WITH CHECK ADD  CONSTRAINT [FK_release_download_release] FOREIGN KEY([release_id])
REFERENCES [dbo].[release] ([release_id])
GO
ALTER TABLE [dbo].[release_download] CHECK CONSTRAINT [FK_release_download_release]
GO
ALTER TABLE [dbo].[version]  WITH CHECK ADD  CONSTRAINT [FK_version_product] FOREIGN KEY([product_id])
REFERENCES [dbo].[product] ([product_id])
GO
ALTER TABLE [dbo].[version] CHECK CONSTRAINT [FK_version_product]
GO
ALTER TABLE [dbo].[customer_address]  WITH CHECK ADD  CONSTRAINT [CK_customer_address_zip_code] CHECK  (([zip_code]<(100000) AND [zip_code]>(500)))
GO
ALTER TABLE [dbo].[customer_address] CHECK CONSTRAINT [CK_customer_address_zip_code]
GO
ALTER TABLE [dbo].[phone]  WITH CHECK ADD  CONSTRAINT [CK_phone_number] CHECK  (([phone_number]<(10000000) AND [phone_number]>=(1000000)))
GO
ALTER TABLE [dbo].[phone] CHECK CONSTRAINT [CK_phone_number]
GO
USE [master]
GO
ALTER DATABASE [s16guest35] SET  READ_WRITE 
GO
