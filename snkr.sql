USE [master]
GO
/****** Object:  Database [snkrkorea]    Script Date: 3/25/2018 9:46:49 PM ******/
CREATE DATABASE [snkrkorea] ON  PRIMARY 
( NAME = N'snkrkorea', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\snkrkorea.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'snkrkorea_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\snkrkorea_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [snkrkorea].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [snkrkorea] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [snkrkorea] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [snkrkorea] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [snkrkorea] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [snkrkorea] SET ARITHABORT OFF 
GO
ALTER DATABASE [snkrkorea] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [snkrkorea] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [snkrkorea] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [snkrkorea] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [snkrkorea] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [snkrkorea] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [snkrkorea] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [snkrkorea] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [snkrkorea] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [snkrkorea] SET  ENABLE_BROKER 
GO
ALTER DATABASE [snkrkorea] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [snkrkorea] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [snkrkorea] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [snkrkorea] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [snkrkorea] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [snkrkorea] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [snkrkorea] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [snkrkorea] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [snkrkorea] SET  MULTI_USER 
GO
ALTER DATABASE [snkrkorea] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [snkrkorea] SET DB_CHAINING OFF 
GO
USE [snkrkorea]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [snkrkorea]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	

GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_category]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_category](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[description] [nvarchar](150) NULL,
	[parentId] [int] NULL,
 CONSTRAINT [PK_tbl_category] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_color]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_color](
	[id] [nvarchar](20) NOT NULL,
	[name] [nvarchar](50) NULL,
 CONSTRAINT [PK_tbl_color] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_comment]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_comment](
	[id] [int] IDENTITY(100,1) NOT NULL,
	[title] [nvarchar](50) NULL,
	[commentContent] [nvarchar](max) NOT NULL,
	[time] [datetime] NULL,
	[parentId] [int] NULL,
	[productId] [int] NULL,
	[postId] [int] NULL,
	[authorId] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_comment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_deal]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_deal](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[dealContent] [nvarchar](50) NULL,
	[startTime] [datetime] NOT NULL,
	[duration] [int] NOT NULL,
 CONSTRAINT [PK_tbl_deal] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_gender]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_gender](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[gender] [nvarchar](20) NULL,
 CONSTRAINT [PK_tbl_gender] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_image]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_image](
	[imageId] [int] IDENTITY(1,1) NOT NULL,
	[productId] [int] NULL,
	[postId] [int] NULL,
	[url] [varchar](255) NOT NULL,
 CONSTRAINT [PK_tbl_image] PRIMARY KEY CLUSTERED 
(
	[imageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_order]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_order](
	[id] [int] IDENTITY(99999,1) NOT NULL,
	[date] [datetime] NOT NULL,
	[totalPrice] [float] NOT NULL,
	[status] [int] NOT NULL,
	[userId] [varchar](50) NOT NULL,
	[approveder_id] [varchar](50) NULL,
	[description] [nvarchar](500) NULL,
	[fullname] [nvarchar](50) NULL,
	[address] [nvarchar](250) NULL,
	[phone] [varchar](20) NULL,
 CONSTRAINT [PK_tbl_order] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_order_status]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_order_status](
	[order_statusId] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_order_status] PRIMARY KEY CLUSTERED 
(
	[order_statusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_order_voucher]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_order_voucher](
	[voucherId] [varchar](50) NOT NULL,
	[orderId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_order_voucher] PRIMARY KEY CLUSTERED 
(
	[voucherId] ASC,
	[orderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_orderdetail]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_orderdetail](
	[orderId] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[quantity] [int] NOT NULL,
	[size] [nvarchar](20) NULL,
	[color] [nvarchar](20) NULL,
 CONSTRAINT [PK_tbl_orderdetail] PRIMARY KEY CLUSTERED 
(
	[orderId] ASC,
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_post]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_post](
	[postId] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](250) NOT NULL,
	[postContent] [nvarchar](max) NULL,
	[timePost] [datetime] NOT NULL,
	[userId] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_post] PRIMARY KEY CLUSTERED 
(
	[postId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_product]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_product](
	[productId] [int] IDENTITY(99999,1) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[brand] [nvarchar](50) NULL,
	[price] [float] NOT NULL,
	[country] [nvarchar](50) NULL,
	[description] [nvarchar](max) NULL,
	[material] [nvarchar](50) NULL,
	[categoryID] [int] NULL,
	[quantity] [int] NULL,
	[lastModified] [datetime] NULL,
	[tag] [nvarchar](250) NULL,
	[deleted] [bit] NULL,
 CONSTRAINT [PK_tbl_product] PRIMARY KEY CLUSTERED 
(
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_product_color]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_product_color](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productId] [int] NULL,
	[color] [nvarchar](20) NULL,
 CONSTRAINT [PK_tbl_product_color] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_product_deal]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_product_deal](
	[dealId] [int] NOT NULL,
	[productId] [int] NOT NULL,
	[discount] [int] NOT NULL,
	[type] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_product_deal] PRIMARY KEY CLUSTERED 
(
	[dealId] ASC,
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_product_size]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_product_size](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[productId] [int] NULL,
	[size] [nvarchar](20) NULL,
 CONSTRAINT [PK_tbl_product_size] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_rating]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_rating](
	[productId] [int] NOT NULL,
	[rate] [int] NOT NULL,
	[userId] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_rating] PRIMARY KEY CLUSTERED 
(
	[productId] ASC,
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_role]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_role](
	[roleid] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tbl_role] PRIMARY KEY CLUSTERED 
(
	[roleid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_size]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_size](
	[id] [nvarchar](20) NOT NULL,
	[name] [varchar](10) NULL,
 CONSTRAINT [PK_tbl_size] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_user]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_user](
	[userId] [varchar](50) NOT NULL,
	[password] [varchar](50) NOT NULL,
	[email] [varchar](250) NULL,
	[fullname] [nvarchar](50) NULL,
	[address] [nchar](250) NULL,
	[phone] [varchar](15) NULL,
	[gender] [int] NULL,
	[role] [int] NOT NULL,
	[date_reg] [datetime] NULL,
	[expired] [bit] NULL,
 CONSTRAINT [PK_tbl_user] PRIMARY KEY CLUSTERED 
(
	[userId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_voucher]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_voucher](
	[voucherId] [varchar](50) NOT NULL,
	[type] [bit] NOT NULL,
	[discount] [int] NOT NULL,
	[description] [nvarchar](250) NULL,
	[startTime] [date] NOT NULL,
	[duration] [int] NOT NULL,
	[quantity] [int] NOT NULL,
 CONSTRAINT [PK_tbl_voucher] PRIMARY KEY CLUSTERED 
(
	[voucherId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_voucher_product]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_voucher_product](
	[voucherId] [varchar](50) NOT NULL,
	[productId] [int] NOT NULL,
 CONSTRAINT [PK_tbl_voucher_product] PRIMARY KEY CLUSTERED 
(
	[voucherId] ASC,
	[productId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[ListProductWithImage]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListProductWithImage]
AS
SELECT        dbo.tbl_product.productId, dbo.tbl_product.name, dbo.tbl_product.price, dbo.tbl_product.quantity, dbo.tbl_image.url, dbo.tbl_product.deleted
FROM            dbo.tbl_image RIGHT OUTER JOIN
                         dbo.tbl_product ON dbo.tbl_image.productId = dbo.tbl_product.productId
WHERE        (dbo.tbl_product.deleted = 0)

GO
/****** Object:  View [dbo].[ListProductDealUpComing]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListProductDealUpComing]
AS
SELECT        dbo.ListProductWithImage.productId, dbo.ListProductWithImage.name, dbo.ListProductWithImage.price, dbo.ListProductWithImage.quantity, MAX(dbo.ListProductWithImage.url) AS url
FROM            dbo.tbl_product_deal INNER JOIN
                         dbo.tbl_deal ON dbo.tbl_product_deal.dealId = dbo.tbl_deal.id CROSS JOIN
                         dbo.ListProductWithImage
GROUP BY dbo.ListProductWithImage.productId, dbo.ListProductWithImage.name, dbo.ListProductWithImage.price, dbo.ListProductWithImage.quantity

GO
/****** Object:  View [dbo].[ProductDetail_Left]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductDetail_Left]
AS
SELECT        tbl_product_1.productId, tbl_product_1.name, tbl_product_1.brand, tbl_product_1.country, tbl_product_1.description, tbl_product_1.material, tbl_product_1.quantity, dbo.tbl_product_deal.discount, 
                         dbo.tbl_product_deal.type, dbo.tbl_deal.startTime, dbo.tbl_deal.duration, tbl_product_1.price, tbl_product_1.tag, tbl_product_1.lastModified, tbl_product_1.deleted
FROM            dbo.tbl_deal INNER JOIN
                         dbo.tbl_product_deal ON dbo.tbl_deal.id = dbo.tbl_product_deal.dealId RIGHT OUTER JOIN
                         dbo.tbl_product AS tbl_product_1 ON dbo.tbl_product_deal.productId = tbl_product_1.productId
WHERE        (GETDATE() >= dbo.tbl_deal.startTime) AND (GETDATE() < DATEADD(hour, dbo.tbl_deal.duration, dbo.tbl_deal.startTime))

GO
/****** Object:  View [dbo].[ProductDetail]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductDetail]
AS
SELECT        dbo.tbl_product.productId, dbo.tbl_product.name, dbo.tbl_product.brand, dbo.tbl_product.price, dbo.tbl_product.country, dbo.tbl_product.description, dbo.tbl_product.material, dbo.tbl_product.categoryID, 
                         dbo.tbl_product.quantity, dbo.tbl_product.lastModified, dbo.tbl_product.tag, dbo.ProductDetail_Left.discount, dbo.ProductDetail_Left.type, dbo.ProductDetail_Left.startTime, dbo.ProductDetail_Left.duration, 
                         dbo.tbl_product.deleted
FROM            dbo.ProductDetail_Left RIGHT OUTER JOIN
                         dbo.tbl_product ON dbo.ProductDetail_Left.productId = dbo.tbl_product.productId

GO
/****** Object:  View [dbo].[ListProductWithFirstImage]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListProductWithFirstImage]
AS
SELECT        productId, name, price, quantity, MAX(url) AS url
FROM            dbo.ListProductWithImage
GROUP BY productId, name, price, quantity

GO
/****** Object:  View [dbo].[ListProductWithDeal]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListProductWithDeal]
AS
SELECT        dbo.tbl_product.name, dbo.tbl_product.price, dbo.tbl_product_deal.discount, dbo.tbl_product_deal.type, dbo.tbl_product.productId
FROM            dbo.tbl_product INNER JOIN
                         dbo.tbl_product_deal ON dbo.tbl_product.productId = dbo.tbl_product_deal.productId INNER JOIN
                         dbo.tbl_deal ON dbo.tbl_product_deal.dealId = dbo.tbl_deal.id
WHERE        (GETDATE() > dbo.tbl_deal.startTime) AND (GETDATE() < DATEADD(hour, dbo.tbl_deal.duration, dbo.tbl_deal.startTime))

GO
/****** Object:  View [dbo].[ListProductItem]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListProductItem]
AS
SELECT        TOP (100) PERCENT t3.productId, t3.name, t3.price, t3.url, v1.discount, v1.type, t3.lastModified, t3.categoryID, t3.tag, t3.deleted
FROM            (SELECT        t1.productId, t1.url, t2.name, t2.price, t2.lastModified, t2.categoryID, t2.tag, t2.deleted
                          FROM            (SELECT        productId, MIN(url) AS url
                                                    FROM            dbo.ListProductWithImage
                                                    GROUP BY productId) AS t1 INNER JOIN
                                                    dbo.tbl_product AS t2 ON t1.productId = t2.productId) AS t3 LEFT OUTER JOIN
                         dbo.ListProductWithDeal AS v1 ON t3.productId = v1.productId

GO
/****** Object:  View [dbo].[ListAllComment]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListAllComment]
AS
SELECT        dbo.tbl_user.fullname, dbo.tbl_comment.title, dbo.tbl_comment.commentContent, dbo.tbl_comment.time, dbo.tbl_comment.productId, dbo.tbl_comment.postId, dbo.tbl_comment.parentId, dbo.tbl_comment.id, 
                         dbo.tbl_comment.authorId
FROM            dbo.tbl_comment INNER JOIN
                         dbo.tbl_user ON dbo.tbl_comment.authorId = dbo.tbl_user.userId

GO
/****** Object:  View [dbo].[ListAllPost]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListAllPost]
AS
SELECT        dbo.tbl_post.postId, dbo.tbl_post.title, dbo.tbl_post.timePost, dbo.tbl_user.fullname, dbo.tbl_post.postContent, dbo.tbl_image.url
FROM            dbo.tbl_post INNER JOIN
                         dbo.tbl_user ON dbo.tbl_post.userId = dbo.tbl_user.userId LEFT OUTER JOIN
                         dbo.tbl_image ON dbo.tbl_post.postId = dbo.tbl_image.postId

GO
/****** Object:  View [dbo].[ListAllUser]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ListAllUser]
AS
SELECT        dbo.tbl_role.name, dbo.tbl_user.userId, dbo.tbl_user.email, dbo.tbl_user.fullname, dbo.tbl_user.phone, dbo.tbl_user.gender AS genderId, dbo.tbl_gender.gender AS genderName
FROM            dbo.tbl_role INNER JOIN
                         dbo.tbl_user ON dbo.tbl_role.roleid = dbo.tbl_user.role INNER JOIN
                         dbo.tbl_gender ON dbo.tbl_user.gender = dbo.tbl_gender.id

GO
/****** Object:  View [dbo].[ListOrderWithVoucher]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*step 1*/
CREATE VIEW [dbo].[ListOrderWithVoucher]
AS
SELECT        dbo.tbl_order.id, dbo.tbl_order.userId, dbo.tbl_order.date, dbo.tbl_order.totalPrice, dbo.tbl_voucher.discount, dbo.tbl_voucher.voucherId, dbo.tbl_order.approveder_id, dbo.tbl_order.description, 
                         dbo.tbl_order_status.name AS status, dbo.tbl_order.fullname, dbo.tbl_order.address, dbo.tbl_order.phone
FROM            dbo.tbl_voucher INNER JOIN
                         dbo.tbl_order_voucher ON dbo.tbl_voucher.voucherId = dbo.tbl_order_voucher.voucherId RIGHT OUTER JOIN
                         dbo.tbl_order INNER JOIN
                         dbo.tbl_order_status ON dbo.tbl_order.status = dbo.tbl_order_status.order_statusId ON dbo.tbl_order_voucher.orderId = dbo.tbl_order.id

GO
/****** Object:  View [dbo].[ProductColor]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductColor]
AS
SELECT        dbo.tbl_product_color.productId, dbo.tbl_product_color.color AS colorId, dbo.tbl_color.name AS colorName
FROM            dbo.tbl_color INNER JOIN
                         dbo.tbl_product_color ON dbo.tbl_color.id = dbo.tbl_product_color.color

GO
/****** Object:  View [dbo].[ProductInOrder]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductInOrder]
AS
SELECT        dbo.tbl_orderdetail.orderId, dbo.tbl_orderdetail.quantity, dbo.tbl_orderdetail.productId, dbo.tbl_product.name, dbo.tbl_product.brand, dbo.tbl_product.price, dbo.tbl_product.country, dbo.tbl_product.material, 
                         dbo.tbl_orderdetail.size, dbo.tbl_orderdetail.color
FROM            dbo.tbl_orderdetail INNER JOIN
                         dbo.tbl_product ON dbo.tbl_orderdetail.productId = dbo.tbl_product.productId

GO
/****** Object:  View [dbo].[ProductSize]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ProductSize]
AS
SELECT        dbo.tbl_product_size.productId, dbo.tbl_product_size.size AS sizeId, dbo.tbl_size.name AS sizeName
FROM            dbo.tbl_product_size INNER JOIN
                         dbo.tbl_size ON dbo.tbl_product_size.size = dbo.tbl_size.id

GO
/****** Object:  View [dbo].[View_AllOrder]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*step 2*/
CREATE VIEW [dbo].[View_AllOrder]
AS
SELECT        dbo.tbl_order.id, dbo.tbl_order.date, dbo.tbl_order.totalPrice, dbo.tbl_order.userId, dbo.tbl_order.approveder_id, dbo.tbl_order_voucher.voucherId, dbo.tbl_order.status, dbo.tbl_order.description, 
                         dbo.tbl_order.fullname, dbo.tbl_order.address, dbo.tbl_order.phone
FROM            dbo.tbl_order LEFT OUTER JOIN
                         dbo.tbl_order_voucher ON dbo.tbl_order.id = dbo.tbl_order_voucher.orderId

GO
/****** Object:  View [dbo].[View_AllProduct]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_AllProduct]
AS
SELECT        dbo.tbl_product.productId, dbo.tbl_product.name, dbo.tbl_product.brand, dbo.tbl_product.price, dbo.tbl_product.country, dbo.tbl_product.description, dbo.tbl_product.material, dbo.tbl_product.quantity, 
                         dbo.tbl_product.lastModified, dbo.tbl_product.tag, dbo.tbl_category.name AS categoryName, dbo.tbl_product.categoryID, dbo.tbl_product.deleted
FROM            dbo.tbl_product INNER JOIN
                         dbo.tbl_category ON dbo.tbl_product.categoryID = dbo.tbl_category.id

GO
/****** Object:  View [dbo].[View_GetAllRole]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_GetAllRole]
AS
SELECT        name
FROM            dbo.tbl_role


GO
/****** Object:  View [dbo].[View_OrderNotApproved]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_OrderNotApproved]
AS
SELECT        id, date, totalPrice, status, userId, approveder_id
FROM            dbo.tbl_order
WHERE        (status = 1)

GO
/****** Object:  View [dbo].[View_ProductSale]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_ProductSale]
AS
SELECT        dbo.tbl_product.productId, dbo.tbl_product.name, dbo.tbl_product.brand, dbo.tbl_product.price, dbo.tbl_product.country, dbo.tbl_product.description, dbo.tbl_product.material, dbo.tbl_product.categoryID, 
                         dbo.tbl_product.quantity, dbo.tbl_product_deal.discount, dbo.tbl_product_deal.type, dbo.tbl_deal.startTime, dbo.tbl_deal.duration
FROM            dbo.tbl_deal INNER JOIN
                         dbo.tbl_product_deal ON dbo.tbl_deal.id = dbo.tbl_product_deal.dealId INNER JOIN
                         dbo.tbl_product ON dbo.tbl_product_deal.productId = dbo.tbl_product.productId AND dbo.tbl_product_deal.productId = dbo.tbl_product.productId



GO
/****** Object:  View [dbo].[View_User]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_User]
AS
SELECT        TOP (100) PERCENT dbo.tbl_user.userId, dbo.tbl_user.email, dbo.tbl_user.fullname, dbo.tbl_user.address, dbo.tbl_user.phone, dbo.tbl_user.date_reg, dbo.tbl_role.name AS role, dbo.tbl_gender.gender
FROM            dbo.tbl_user INNER JOIN
                         dbo.tbl_role ON dbo.tbl_user.role = dbo.tbl_role.roleid LEFT OUTER JOIN
                         dbo.tbl_gender ON dbo.tbl_user.gender = dbo.tbl_gender.id
WHERE        (dbo.tbl_user.expired = 0)
ORDER BY dbo.tbl_user.userId

GO
SET IDENTITY_INSERT [dbo].[sysdiagrams] ON 

INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'Diagram_1', 1, 2, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000002800000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF2A000000030000000400000005000000060000000700000008000000090000000A000000FEFFFFFF0C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F0000002000000021000000220000002300000024000000250000002600000027000000FEFFFFFFFEFFFFFF42000000FEFFFFFF2C0000002D0000002E0000002F000000300000003100000032000000330000003400000035000000360000003700000038000000390000003A0000003B0000003C0000003D0000003E0000003F0000004000000041000000FEFFFFFF4300000044000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000A093320BC4BDD3012900000080060000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000002000000FA110000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000B000000EA39000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000005F00000000000000000434000A1E500C050000803E0000000F00FFFF3C0000003E000000007D0000D73B00002F3D000032B20000D7EC0000DCFFFFFF87920000DE805B10F195D011B0A000AA00BDCB5C000008003000000000020000030000003C006B0000000900000000000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D00002800430000000000000053444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C00002800430000000000000051444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C380000000411000000B8010000003400A50900000700008001000000AA020000008000000C00008053636847726964004038000084E4000074626C5F63617465676F727900003400A50900000700008004000000A8020000008000000B0000805363684772696400EA6F00006432000074626C5F636F6D6D656E740000007C00A509000007000080050000006A0000000180000051000080436F6E74726F6C00D66A0000502D000052656C6174696F6E736869702027464B5F74626C5F636F6D6D656E745F74626C5F636F6D6D656E7427206265747765656E202774626C5F636F6D6D656E742720616E64202774626C5F636F6D6D656E742703000000002800B50100000700008006000000310000006700000002800000436F6E74726F6C89756700002B2F000000003000A50900000700008007000000A202000000800000080000805363684772696400E4570000FCB7000074626C5F6465616C00003400A50900000700008009000000A402000000800000090000805363684772696400DE3F0000EA6F000074626C5F696D61676500000000003400A5090000070000800A000000A4020000008000000900008053636847726964003A2000000A41000074626C5F6F7264657200000000003800A5090000070000800D000000B20200000080000010000080536368477269640074400000F087000074626C5F6F726465725F73746174757300008000A5090000070000800E000000620000000180000057000080436F6E74726F6C00772A00005354000052656C6174696F6E736869702027464B5F74626C5F6F726465725F74626C5F6F726465725F73746174757327206265747765656E202774626C5F6F726465725F7374617475732720616E64202774626C5F6F72646572271B00002800B5010000070000800F000000310000006D00000002800000436F6E74726F6C00971A0000E880000000003C00A50900000700008010000000B4020000008000001100008053636847726964003A200000A08C000074626C5F6F726465725F766F756368657200000000008400A50900000700008011000000620000000180000059000080436F6E74726F6C00992800005754000052656C6174696F6E736869702027464B5F74626C5F6F726465725F766F75636865725F74626C5F6F7264657227206265747765656E202774626C5F6F726465722720616E64202774626C5F6F726465725F766F75636865722700000000002800B50100000700008012000000310000006F00000002800000436F6E74726F6C00D21700008D76000000003800A50900000700008013000000B0020000008000000F000080536368477269640050FBFFFFDC50000074626C5F6F7264657264657461696C0000008000A50900000700008014000000520000000180000055000080436F6E74726F6C00AC100000DB4F000052656C6174696F6E736869702027464B5F74626C5F6F7264657264657461696C5F74626C5F6F7264657227206265747765656E202774626C5F6F726465722720616E64202774626C5F6F7264657264657461696C2772271B00002800B50100000700008015000000310000006B00000002800000436F6E74726F6C00131100006B4F000000003000A50900000700008016000000A202000000800000080000805363684772696400DE3F00008C55000074626C5F706F737400007000A50900000700008017000000520000000180000047000080436F6E74726F6C0069490000E363000052656C6174696F6E736869702027464B5F74626C5F696D6167655F74626C5F706F737427206265747765656E202774626C5F706F73742720616E64202774626C5F696D616765270000002800B50100000700008018000000310000005D00000002800000436F6E74726F6C000A3E00002B6B000000003400A50900000700008019000000A8020000008000000B000080536368477269640040380000EABA000074626C5F70726F647563740000007C00A5090000070000801A000000520000000180000053000080436F6E74726F6C00CB4100001FD8000052656C6174696F6E736869702027464B5F74626C5F70726F647563745F74626C5F63617465676F727927206265747765656E202774626C5F63617465676F72792720616E64202774626C5F70726F64756374271B00002800B5010000070000801B000000310000006900000002800000436F6E74726F6C0011440000ACDE000000007C00A5090000070000801C000000620000000180000051000080436F6E74726F6C00234400002848000052656C6174696F6E736869702027464B5F74626C5F636F6D6D656E745F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F636F6D6D656E742761696C00002800B5010000070000801D000000310000006700000002800000436F6E74726F6C00BB7B00001D9E000000007800A5090000070000801E00000062000000018000004D000080436F6E74726F6C0061420000C27B000052656C6174696F6E736869702027464B5F74626C5F696D6167655F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F696D6167652700000000002800B5010000070000801F000000310000006300000002800000436F6E74726F6C89AF4B0000F49B000000008400A50900000700008020000000620000000180000059000080436F6E74726F6C89A7090000395A000052656C6174696F6E736869702027464B5F74626C5F6F7264657264657461696C5F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F6F7264657264657461696C2700650000002800B50100000700008021000000310000006F00000002800000436F6E74726F6C00D10B0000D2A4000000003800A50900000700008022000000B202000000800000100000805363684772696400E457000002D0000074626C5F70726F647563745F6465616C00008000A50900000700008023000000520000000180000055000080436F6E74726F6C006F610000D8C3000052656C6174696F6E736869702027464B5F74626C5F70726F647563745F6465616C5F74626C5F6465616C27206265747765656E202774626C5F6465616C2720616E64202774626C5F70726F647563745F6465616C2700000000002800B50100000700008024000000310000006B00000002800000436F6E74726F6C003B52000000CB000000008400A5090000070000802500000062000000018000005B000080436F6E74726F6C009C4D000025C9000052656C6174696F6E736869702027464B5F74626C5F70726F647563745F6465616C5F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F70726F647563745F6465616C270000002800B50100000700008026000000310000007100000002800000436F6E74726F6C004757000057CB000000003400A50900000700008027000000A6020000008000000A0000805363684772696400AE150000ACBC000074626C5F726174696E67745F00003000A50900000700008028000000A202000000800000080000805363684772696400186000008C55000074626C5F726F6C6500003000A50900000700008029000000A202000000800000080000805363684772696400465000003831000074626C5F7573657200007000A5090000070000802A000000620000000180000045000080436F6E74726F6C00835A00007749000052656C6174696F6E736869702027464B5F74626C5F757365725F74626C5F726F6C6527206265747765656E202774626C5F726F6C652720616E64202774626C5F757365722700000000002800B5010000070000802B000000310000005B00000002800000436F6E74726F6C0059550000FC53000000007000A5090000070000802C000000620000000180000047000080436F6E74726F6C6C96350000EF3B000052656C6174696F6E736869702027464B5F74626C5F6F726465725F74626C5F7573657227206265747765656E202774626C5F757365722720616E64202774626C5F6F72646572270000002800B5010000070000802D000000310000005D00000002800000436F6E74726F6C006E300000663D000000007000A5090000070000802E000000620000000180000048000080436F6E74726F6C8996350000B13D000052656C6174696F6E736869702027464B5F74626C5F6F726465725F74626C5F757365723127206265747765656E202774626C5F757365722720616E64202774626C5F6F726465722700002800B5010000070000802F000000310000005F00000002800000436F6E74726F6C898D3E0000B342000000007400A5090000070000803000000052000000018000004B000080436F6E74726F6C72A26500001B3D000052656C6174696F6E736869702027464B5F74626C5F636F6D6D656E745F74626C5F7573657227206265747765656E202774626C5F757365722720616E64202774626C5F636F6D6D656E74270000002800B50100000700008031000000310000006100000002800000436F6E74726F6C0060640000613F000000007000A50900000700008032000000620000000180000045000080436F6E74726F6C00854900007B49000052656C6174696F6E736869702027464B5F74626C5F706F73745F74626C5F7573657227206265747765656E202774626C5F757365722720616E64202774626C5F706F73742700000000002800B50100000700008033000000310000005B00000002800000436F6E74726F6C72334700004651000000003400A50900000700008034000000A8020000008000000B000080536368477269640096000000F087000074626C5F766F75636865720000008800A5090000070000803500000052000000018000005D000080436F6E74726F6C00F21500004F90000052656C6174696F6E736869702027464B5F74626C5F6F726465725F766F75636865725F74626C5F766F756368657227206265747765656E202774626C5F766F75636865722720616E64202774626C5F6F726465725F766F75636865722703000000002800B50100000700008036000000310000007300000002800000436F6E74726F6C00661100009592000000003C00A50900000700008037000000B80200000080000013000080536368477269646500000000A6A4000074626C5F766F75636865725F70726F647563740000008C00A50900000700008038000000520000000180000061000080436F6E74726F6C72210A0000C298000052656C6174696F6E736869702027464B5F74626C5F766F75636865725F70726F647563745F74626C5F766F756368657227206265747765656E202774626C5F766F75636865722720616E64202774626C5F766F75636865725F70726F647563742700000000002800B50100000700008039000000310000007700000002800000436F6E74726F6C72A5F6FFFFF59F000000008C00A5090000070000803A000000620000000180000061000080436F6E74726F6C003D0A000088AB000052656C6174696F6E736869702027464B5F74626C5F766F75636865725F70726F647563745F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F766F75636865725F70726F647563742700000000002800B5010000070000803B000000310000007700000002800000436F6E74726F6C00B92B00007DAE000000007800A5090000070000803D00000052000000018000004F000080436F6E74726F6C000A2B00002FBF000052656C6174696F6E736869702027464B5F74626C5F726174696E675F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F726174696E67270000002800B5010000070000803E000000310000006500000002800000436F6E74726F6C6C312B0000BFBE0000000000000000214334120800000088160000930E0000785634120700000014010000740062006C005F00630061007400650067006F007200790000002800640062006F0029000000003F00000000F5F4F43ECDCC4C3F0000803F0000803F00000000F5F4F43ECDCC4C3F0000803F0000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000F0AF8D660000000000000000A4B18D66488F8E6600000000C0DE3720020000000300000000000000000000000000000000000000020000000000000000000040000000000000A841000098C10000004000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B004000039030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000B90A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000D000000740062006C005F00630061007400650067006F007200790000002143341208000000881600007F180000785634120700000014010000740062006C005F0063006F006D006D0065006E00740000002800640062006F00290000000000803FEFEE6E3FEFEE6E3FF3F2723F0000803F2F0000003B00000047000000590000006B00000083000000A3000000C5000000EF0000002501000061010000AF0100000902000077020000F9020000970300004F0400002F0500003D0600008B0700001D090000F10A00002B0D0000D10F0000FD120000CF160000651B0000E3200000772700006F2F0000FF3800006F4400001F5200008D62000055760000018E00006BAA000089CC000083F50000A72601009B61010057A801003BFD01001563020067DD02001B70000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000371C0000000000002D0100000A0000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B0040000390300000000000001000000881600007F18000000000000080000000800000002000000020000001C010000240900000000000001000000391300004D0C000000000000040000000400000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C000000740062006C005F0063006F006D006D0065006E007400000005000B00EA6F000090330000026C000090330000026C00007C2E0000167100007C2E000016710000643200000000000002000000F0F0F00000000000000000000000000000000000010000000600000000000000756700002B2F000072100000580100003E0000000100000200007210000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611A0046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F0063006F006D006D0065006E007400214334120800000088160000930E0000785634120700000014010000740062006C005F006400650061006C0000002800640062006F002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B004000039030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000D70A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000009000000740062006C005F006400650061006C000000214334120800000088160000930E0000785634120700000014010000740062006C005F0069006D0061006700650000002800640062006F00290000000000803F0000803FEFEE6E3FEFEE6E3FF3F2723F0000803F000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000003B000000000000000000000000000000000000003C010000000000000000000000000000B8EA3020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B004000039030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000D70A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000A000000740062006C005F0069006D00610067006500000021433412080000008816000004160000785634120700000014010000740062006C005F006F00720064006500720000002800640062006F00290000006D0065002C002000760061006C00750065002000460052004F004D0020007300790073002E0065007800740065006E006400650064005F00700072006F0070006500720074006900650073002000570048004500520045002000280063006C0061007300730020003D00200031002900200041004E004400200028006D0069006E006F0072005F006900640020003D00200030002900200041004E004400200028006D0061006A006F0072005F006900640020003D0020004F0042004A004500430054005F004900440028004E00000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B0040000390300000000000001000000881600000416000000000000070000000700000002000000020000001C010000D70A0000000000000100000039130000930E000000000000050000000500000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000A000000740062006C005F006F00720064006500720000002143341208000000881600009D090000785634120700000014010000740062006C005F006F0072006400650072005F0073007400610074007500730000002800640062006F0029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B0040000390300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000D70A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000011000000740062006C005F006F0072006400650072005F00730074006100740075007300000004000B00964B0000F0870000964B00001A850000F22B00001A850000F22B00000E5700000000000002000000F0F0F00000000000000000000000000000000000010000000F00000000000000971A0000E8800000AC1000005801000031000000010000020000AC10000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611D0046004B005F00740062006C005F006F0072006400650072005F00740062006C005F006F0072006400650072005F007300740061007400750073002143341208000000881600009D090000785634120700000014010000740062006C005F006F0072006400650072005F0076006F007500630068006500720000002800640062006F002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B0040000390300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000D70A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000012000000740062006C005F006F0072006400650072005F0076006F0075006300680065007200000004000B00302A00000E570000302A0000CE8500005C2B0000CE8500005C2B0000A08C00000000000002000000F0F0F00000000000000000000000000000000000010000001200000000000000D21700008D760000AF1100005801000039000000010000020000AF11000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F00740062006C005F006F0072006400650072005F0076006F00750063006800650072005F00740062006C005F006F007200640065007200214334120800000088160000180C0000785634120700000014010000740062006C005F006F007200640065007200640065007400610069006C0000002800640062006F00290000006C00750065002000460052004F004D0020007300790073002E0065007800740065006E006400650064005F00700072006F0070006500720074006900650073002000570048004500520045002000280063006C0061007300730020003D00200031002900200041004E004400200028006D0069006E006F0072005F006900640020003D00200030002900200041004E004400200028006D0061006A006F0072005F006900640020003D0020004F0042004A004500430054005F004900440028004E00000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B004000039030000000000000100000088160000180C000000000000030000000300000002000000020000001C010000D70A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000010000000740062006C005F006F007200640065007200640065007400610069006C00000002000B003A20000072510000D8110000725100000000000002000000F0F0F00000000000000000000000000000000000010000001500000000000000131100006B4F00008B0F000058010000220000000100000200008B0F000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611C0046004B005F00740062006C005F006F007200640065007200640065007400610069006C005F00740062006C005F006F0072006400650072002143341208000000881600000E110000785634120700000014010000740062006C005F0070006F007300740000002800640062006F002900000061006D0065002C002000760061006C00750065002000460052004F004D0020007300790073002E0065007800740065006E006400650064005F00700072006F0070006500720074006900650073002000570048004500520045002000280063006C0061007300730020003D00200031002900200041004E004400200028006D0069006E006F0072005F006900640020003D00200030002900200041004E004400200028006D0061006A006F0072005F006900640020003D0020004F0042004A004500430054005F004900440028004E00000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B0040000390300000000000001000000881600000E11000000000000050000000500000002000000020000001C010000D70A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000009000000740062006C005F0070006F0073007400000002000B00004B00009A660000004B0000EA6F00000000000002000000F0F0F000000000000000000000000000000000000100000018000000000000000A3E00002B6B0000470C00005801000039000000010000020000470C000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61150046004B005F00740062006C005F0069006D006100670065005F00740062006C005F0070006F0073007400214334120800000088160000F01F0000785634120700000014010000740062006C005F00700072006F00640075006300740000002800640062006F00290000000000803FEFEE6E3FEFEE6E3FF3F2723F0000803F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000009230000000000002D0100000D0000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B004000039030000000000000100000088160000F01F0000000000000B0000000B00000002000000020000001C01000015090000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C000000740062006C005F00700072006F006400750063007400000002000B006243000084E4000062430000DADA00000000000002000000F0F0F00000000000000000000000000000000000010000001B0000000000000011440000ACDE0000C50F00005801000036000000010000020000C50F000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611B0046004B005F00740062006C005F00700072006F0064007500630074005F00740062006C005F00630061007400650067006F007200790004000B00BA450000EABA0000BA45000038B100000C7B000038B100000C7B0000E34A00000000000002000000F0F0F00000000000000000000000000000000000010000001D00000000000000BB7B00001D9E0000C50F00005801000032000000010000020000C50F000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611A0046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F00700072006F00640075006300740004000B00F8430000EABA0000F843000084B00000004B000084B00000004B00007D7E00000000000002000000F0F0F00000000000000000000000000000000000010000001F00000000000000AF4B0000F49B0000140E00005801000039000000010000020000140E000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61180046004B005F00740062006C005F0069006D006100670065005F00740062006C005F00700072006F00640075006300740004000B0074400000EABA00007440000038B10000220B000038B10000220B0000F45C00000000000002000000F0F0F00000000000000000000000000000000000010000002100000000000000D10B0000D2A40000C81000005801000032000000010000020000C810000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F00740062006C005F006F007200640065007200640065007400610069006C005F00740062006C005F00700072006F006400750063007400214334120800000088160000930E0000785634120700000014010000740062006C005F00700072006F0064007500630074005F006400650061006C0000002800640062006F00290000000000000000400000000000408D40000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000F0AF8D660000000000000000A4B18D66488F8E6600000000E0CCA5140200000003000000000000000000000000000000000000000200000000000000000000000000000000006A4400006AC40000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B004000039030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000D70A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000011000000740062006C005F00700072006F0064007500630074005F006400650061006C00000002000B00066300008FC600000663000002D000000000000002000000F0F0F000000000000000000000000000000000000100000024000000000000003B52000000CB00001C10000058010000370000000100000200001C10000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611C0046004B005F00740062006C005F00700072006F0064007500630074005F006400650061006C005F00740062006C005F006400650061006C0004000B00C84E0000BCCA000098560000BCCA0000985600000AD70000E45700000AD700000000000002000000F0F0F000000000000000000000000000000000000100000026000000000000004757000057CB00000512000058010000310000000100000200000512000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611F0046004B005F00740062006C005F00700072006F0064007500630074005F006400650061006C005F00740062006C005F00700072006F0064007500630074002143341208000000881600009D090000785634120700000014010000740062006C005F0072006100740069006E00670000002800640062006F0029000000E4B00008E4A00200000300000F800000E4B00100E4A04200000302000F800000E4800008E4A00200000300000F800000E4B00100E4A14200000300000F800000E4800008E4A001000002000001800000FF8001000002000002800100FF8001000002000004800200FF8005000003000007800000E4800200E4A005000003000008800100FF80020000A005000003010007800400E4A00000E48002000003010007800100E4800500E4A002000003020007800300E4A00000E48105000003010007800100E4800200E4800200000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B0040000390300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000240900000000000001000000391300003403000000000000000000000000000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000B000000740062006C005F0072006100740069006E00670000002143341208000000881600009D090000785634120700000014010000740062006C005F0072006F006C00650000002800640062006F0029000000000000000000000000000000004000000000003070400000000000003340000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000F0AF8D660000000000000000A4B18D66488F8E660000000070CFA514020000000300000000000000000000000000000000000000020000000000000000000040000000000000A841000098C10000004000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B0040000390300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000D70A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000009000000740062006C005F0072006F006C0065000000214334120800000088160000FA1A0000785634120700000014010000740062006C005F00750073006500720000002800640062006F0029000000000000000000000000000000004000000000003073400000000000003340000000000000F03F00000000000000000000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000F0AF8D660000000000000000A4B18D66488F8E660000000090D4A514020000000300000000000000000000000000000000000000020000000000000000000040000000000000A841000098C10000004000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C000000340000000000000000000000222900007D1E0000000000002D0100000B0000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B004000039030000000000000100000088160000FA1A000000000000090000000900000002000000020000001C01000024090000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000009000000740062006C005F007500730065007200000004000B003A6B00008C5500003A6B00004D530000FE5B00004D530000FE5B0000324C00000000000002000000F0F0F00000000000000000000000000000000000010000002B0000000000000059550000FC530000260B00005801000032000000010000020000260B000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61140046004B005F00740062006C005F0075007300650072005F00740062006C005F0072006F006C00650004000B0046500000863D00002A3D0000863D00002A3D0000964B0000C2360000964B00000000000002000000F0F0F00000000000000000000000000000000000010000002D000000000000006E300000663D00000D0C000058010000350000000100000200000D0C000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61150046004B005F00740062006C005F006F0072006400650072005F00740062006C005F00750073006500720004000B0046500000483F0000DE3D0000483F0000DE3D0000584D0000C2360000584D00000000000002000000F0F0F00000000000000000000000000000000000010000002F000000000000008D3E0000B3420000BB0C00005801000035000000010000020000BB0C000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61160046004B005F00740062006C005F006F0072006400650072005F00740062006C005F007500730065007200310002000B00CE660000B23E0000EA6F0000B23E00000000000002000000F0F0F0000000000000000000000000000000000001000000310000000000000060640000613F0000F80D00005801000032000000010000020000F80D000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61170046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F00750073006500720004000B003C5A0000324C00003C5A00004D530000004B00004D530000004B00008C5500000000000002000000F0F0F0000000000000000000000000000000000001000000330000000000000033470000465100007D0B000058010000390000000100000200007D0B000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61140046004B005F00740062006C005F0070006F00730074005F00740062006C005F00750073006500720021433412080000008816000089130000785634120700000014010000740062006C005F0076006F007500630068006500720000002800640062006F00290000000000003F00000000F5F4F43ECDCC4C3F0000803F0000803F00000000F5F4F43ECDCC4C3F0000803F0000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000F0AF8D660000000000000000A4B18D66488F8E6628E5372028E5372002000000020000000000000000000000A8BA971400000000020000000000000000000040000000000000A841000098C10000004000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000AB170000000000002D010000080000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B0040000390300000000000001000000881600008913000000000000060000000600000002000000020000001C010000240900000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C000000740062006C005F0076006F0075006300680065007200000002000B001E170000E69100003A200000E69100000000000002000000F0F0F0000000000000000000000000000000000001000000360000000000000066110000959200002613000058010000390000000100000200002613000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61200046004B005F00740062006C005F006F0072006400650072005F0076006F00750063006800650072005F00740062006C005F0076006F00750063006800650072002143341208000000AC1700009D090000785634120700000014010000740062006C005F0076006F00750063006800650072005F00700072006F00640075006300740000002800640062006F00290000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003CD12080BFB314100000000100110444044200811004088104620081100401210442008110040221044200811004032104420081100404210442008110040521044200811004062104420081100407A0B9B314C0E43120010000001C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000FE01000076020000B3010000EC040000B10300003A020000B1030000B0040000390300000000000001000000AC1700009D09000000000000020000000200000002000000020000001C0100006D0B0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000007000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000014000000740062006C005F0076006F00750063006800650072005F00700072006F006400750063007400000002000B00B80B0000799B0000B80B0000A6A400000000000002000000F0F0F00000000000000000000000000000000000010000003900000000000000A5F6FFFFF59F00006414000058010000390000000100000200006414000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61220046004B005F00740062006C005F0076006F00750063006800650072005F00700072006F0064007500630074005F00740062006C005F0076006F007500630068006500720004000B0036420000EABA00003642000084B00000B80B000084B00000B80B000043AE00000000000002000000F0F0F00000000000000000000000000000000000010000003B00000000000000B92B00007DAE00002A14000058010000320000000100000200002A14000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61220046004B005F00740062006C005F0076006F00750063006800650072005F00700072006F0064007500630074005F00740062006C005F00700072006F00640075006300740002000B0040380000C6C00000362C0000C6C000000000000002000000F0F0F00000000000000000000000000000000000010000003E00000000000000312B0000BFBE0000140E00005801000032000000010000020000140E000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61190046004B005F00740062006C005F0072006100740069006E0067005F00740062006C005F00700072006F0064007500630074000000000000000000000000000000000000000000000001000000FEFFFFFFFEFFFFFF0400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B271000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F57390000020060862F0BC4BDD301020200001048450000000000000000000000000000000000D60100004400610074006100200053006F0075007200630065003D004E0047004F0043004E00540053004500360032003200390032005C00530051004C0045005800500052004500530053003B0049006E0069007400690061006C00200043006100740061006C006F0067003D0073006E006B0072006B006F007200650061003B005000650072007300690073007400200053006500630075007200690074007900200049006E0066006F003D0054007200750065003B0055007300650072002000490044003D00730061003B004D0075006C007400690070006C00650041006300740069007600650052006500730075006C00740053006500740073003D00460061006C00730065003B000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000002B000000F42D00000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000020000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000030000006A0500000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000001900000012000000000000000C000000DCFFFFFF879200000100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000010000000100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700340035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000040000000400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300340030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000050000000500000000000000460000000100270001000000640062006F00000046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F0063006F006D006D0065006E00740000000000000000000000C402000000000600000006000000050000000800000001AEA00E70AEA00E0000000000000000AD070000000000070000000700000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000090000000900000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000A0000000A00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000D0000000D00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000E0000000E000000000000004C000000011F3E1901000000640062006F00000046004B005F00740062006C005F006F0072006400650072005F00740062006C005F006F0072006400650072005F0073007400610074007500730000000000000000000000C402000000000F0000000F0000000E0000000800000001B3A00E30B3A00E0000000000000000AD070000000000100000001000000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001100000011000000000000004E000000011F3E1901000000640062006F00000046004B005F00740062006C005F006F0072006400650072005F0076006F00750063006800650072005F00740062006C005F006F00720064006500720000000000000000000000C402000000001200000012000000110000000800000001B4A00EF0B4A00E0000000000000000AD070000000000130000001300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001400000014000000000000004A000000011F3E1901000000640062006F00000046004B005F00740062006C005F006F007200640065007200640065007400610069006C005F00740062006C005F006F00720064006500720000000000000000000000C402000000001500000015000000140000000800000001B2A00EF0B2A00E0000000000000000AD070000000000160000001600000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001700000017000000000000003C000000011F3E1901000000640062006F00000046004B005F00740062006C005F0069006D006100670065005F00740062006C005F0070006F007300740000000000000000000000C402000000001800000018000000170000000800000001AEA00EB0AEA00E0000000000000000AD070000000000190000001900000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300320035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001A0000001A000000000000004800000001B70D6801000000640062006F00000046004B005F00740062006C005F00700072006F0064007500630074005F00740062006C005F00630061007400650067006F007200790000000000000000000000C402000000001B0000001B0000001A0000000800000001ADA00EB0ADA00E0000000000000000AD0700000000001C0000001C0000000000000046000000016E737401000000640062006F00000046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F00700072006F00640075006300740000000000000000000000C402000000001D0000001D0000001C0000000800000001AA970E08AA970E0000000000000000AD0700000000001E0000001E000000000000004200000001B70D6801000000640062006F00000046004B005F00740062006C005F0069006D006100670065005F00740062006C005F00700072006F00640075006300740000000000000000000000C402000000001F0000001F0000001E0000000800000001A4970E08A4970E0000000000000000AD0700000000002000000020000000000000004E000000011F3E1901000000640062006F00000046004B005F00740062006C005F006F007200640065007200640065007400610069006C005F00740062006C005F00700072006F00640075006300740000000000000000000000C402000000002100000021000000200000000800000001A7970E88A7970E0000000000000000AD070000000000220000002200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000002300000023000000000000004A000000011F3E1901000000640062006F00000046004B005F00740062006C005F00700072006F0064007500630074005F006400650061006C005F00740062006C005F006400650061006C0000000000000000000000C402000000002400000024000000230000000800000001B1970E48B1970E0000000000000000AD07000000000025000000250000000000000050000000011F3E1901000000640062006F00000046004B005F00740062006C005F00700072006F0064007500630074005F006400650061006C005F00740062006C005F00700072006F00640075006300740000000000000000000000C402000000002600000026000000250000000800000001AE970E48AE970E0000000000000000AD070000000000270000002700000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300340030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000280000002800000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700370035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000290000002900000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300340030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000002A0000002A000000000000003A000000011F3E1901000000640062006F00000046004B005F00740062006C005F0075007300650072005F00740062006C005F0072006F006C00650000000000000000000000C402000000002B0000002B0000002A0000000800000001B1970E08B1970E0000000000000000AD0700000000002C0000002C000000000000003C000000011F3E1901000000640062006F00000046004B005F00740062006C005F006F0072006400650072005F00740062006C005F00750073006500720000000000000000000000C402000000002D0000002D0000002C0000000800000001AB970EC8AB970E0000000000000000AD0700000000002E0000002E000000000000003E000000011F3E1901000000640062006F00000046004B005F00740062006C005F006F0072006400650072005F00740062006C005F007500730065007200310000000000000000000000C402000000002F0000002F0000002E0000000800000001B0970E88B0970E0000000000000000AD07000000000030000000300000000000000040000000011F3E1901000000640062006F00000046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F00750073006500720000000000000000000000C402000000003100000031000000300000000800000001AE970E08AE970E0000000000000000AD0700000000003200000032000000000000003A000000011F3E1901000000640062006F00000046004B005F00740062006C005F0070006F00730074005F00740062006C005F00750073006500720000000000000000000000C402000000003300000033000000320000000800000001AC970E08AC970E0000000000000000AD070000000000340000003400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300340030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000003500000035000000000000005200000001FFFFFF01000000640062006F00000046004B005F00740062006C005F006F0072006400650072005F0076006F00750063006800650072005F00740062006C005F0076006F007500630068006500720000000000000000000000C402000000003600000036000000350000000800000001AB970E48AB970E0000000000000000AD070000000000370000003700000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003900320035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000380000003800000000000000560000000106DC1B01000000640062006F00000046004B005F00740062006C005F0076006F00750063006800650072005F00700072006F0064007500630074005F00740062006C005F0076006F007500630068006500720000000000000000000000C402000000003900000039000000380000000800000001AF970E88AF970E0000000000000000AD0700000000003A0000003A0000000000000056000000012DE76101000000640062006F00000046004B005F00740062006C005F0076006F00750063006800650072005F00700072006F0064007500630074005F00740062006C005F00700072006F00640075006300740000000000000000000000C402000000003B0000003B0000003A0000000800000001AD970EC8AD970E0000000000000000AD0700000000003D0000003D000000000000004400000001B70D6801000000640062006F00000046004B005F00740062006C005F0072006100740069006E0067005F00740062006C005F00700072006F00640075006300740000000000000000000000C402000000003E0000003E0000003D0000000800000001AC970E48AC970E0000000000000000AD070000000000640000001A000000010000001900000024000000250000000500000004000000040000004C000000020000002300000007000000220000002500000024000000110000000A000000100000002100000024000000140000000A00000013000000800000004B0000000E0000000D0000000A000000240000002700000017000000160000000900000025000000240000001C00000019000000040000002C000000250000001E000000190000000900000026000000250000002000000019000000130000001A000000350000002500000019000000220000007F000000600000003A000000190000003700000020000000270000003D00000019000000270000005C000000570000002A000000280000002900000024000000270000002C000000290000000A000000720000006D0000002E000000290000000A0000007800000073000000300000002900000004000000770000007200000032000000290000001600000021000000240000003500000034000000100000006B0000005A000000380000003400000037000000250000002600000000000000000000000000000054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D0054007200750065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F002200000000800500140000004400690061006700720061006D005F00310000000002260028000000740062006C005F0076006F00750063006800650072005F00700072006F006400750063007400000008000000640062006F0000000002260018000000740062006C005F0076006F0075006300680065007200000008000000640062006F0000000002260012000000740062006C005F007500730065007200000008000000640062006F0000000002260012000000740062006C005F0072006F006C006500000008000000640062006F0000000002260016000000740062006C005F0072006100740069006E006700000008000000640062006F0000000002260022000000740062006C005F00700072006F0064007500630074005F006400650061006C00000008000000640062006F0000000002260018000000740062006C005F00700072006F006400750063007400000008000000640062006F0000000002260012000000740062006C005F0070006F0073007400000008000000640062006F0000000002260020000000740062006C005F006F007200640065007200640065007400610069006C00000008000000640062006F0000000002260024000000740062006C005F006F0072006400650072005F0076006F0075006300680065007200000008000000640062006F0000000002260022000000740062006C005F006F0072006400650072005F00730074006100740075007300000008000000640062006F0000000002260014000000740062006C005F006F007200640065007200000008000000640062006F0000000002260014000000740062006C005F0069006D00610067006500000008000000640062006F0000000002260012000000740062006C005F006400650061006C00000008000000640062006F0000000002260018000000740062006C005F0063006F006D006D0065006E007400000008000000640062006F000000000224001A000000740062006C005F00630061007400650067006F0072007900000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D00000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'Diagram_0', 1, 3, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000003400000001000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF36000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D000000FEFFFFFF0F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F000000200000002100000022000000230000002400000025000000260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F00000030000000310000003200000033000000FEFFFFFFFEFFFFFF55000000FEFFFFFF38000000390000003A0000003B0000003C0000003D0000003E0000003F000000400000004100000042000000430000004400000045000000460000004700000048000000490000004A0000004B0000004C0000004D0000004E0000004F0000005000000051000000520000005300000054000000FEFFFFFF5600000057000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000906D33595EBFD3013500000080070000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000200000092160000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000000E0000000B4B000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000005F00000000000000000438000A1ED00D05000080530000000F00FFFF460000000000000053000000007D0000996200002F3D00008CEE000025E5000050700000E1330000DE805B10F195D011B0A000AA00BDCB5C000008003000000000020000030000003C006B0000000900000000000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D00002800430000000000000053444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C00002800430000000000000051444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C470000009815000000C7016C00003400A50900000700008001000000AA020000008000000C0000805363684772696400F69F00009A74000074626C5F63617465676F727900003400A50900000700008004000000A40200000080000009000080536368477269640098D000007E36000074626C5F636F6C6F7200000000003400A50900000700008005000000A8020000008000000B0000805363684772696400186000002067000074626C5F636F6D6D656E740000007C00A509000007000080060000006A0000000180000051000080436F6E74726F6C00045B00000C62000052656C6174696F6E736869702027464B5F74626C5F636F6D6D656E745F74626C5F636F6D6D656E7427206265747765656E202774626C5F636F6D6D656E742720616E64202774626C5F636F6D6D656E742703000000002800B50100000700008007000000310000006700000002800000436F6E74726F6C00A3570000E763000000003000A50900000700008008000000A202000000800000080000805363684772696400249000008A1B000074626C5F6465616C00003400A5090000070000800A000000A402000000800000090000805363684772696400DE3F00009033000074626C5F696D61676500000000003400A5090000070000800B000000A4020000008000000900008053636847726964003A2000007062000074626C5F6F7264657200000000003800A5090000070000800E000000B202000000800000100000805363684772696400DE3F00009E9D000074626C5F6F726465725F73746174757300008000A5090000070000800F000000620000000180000057000080436F6E74726F6C0096350000436D000052656C6174696F6E736869702027464B5F74626C5F6F726465725F74626C5F6F726465725F73746174757327206265747765656E202774626C5F6F726465725F7374617475732720616E64202774626C5F6F72646572270000002800B50100000700008010000000310000006D00000002800000436F6E74726F6C001B2B0000CC88000000003C00A50900000700008011000000B40200000080000011000080536368477269640074400000D0B6000074626C5F6F726465725F766F756368657200000000008400A50900000700008012000000620000000180000059000080436F6E74726F6C005B2A0000BD75000052656C6174696F6E736869702027464B5F74626C5F6F726465725F766F75636865725F74626C5F6F7264657227206265747765656E202774626C5F6F726465722720616E64202774626C5F6F726465725F766F75636865722700720000002800B50100000700008013000000310000006F00000002800000436F6E74726F6C009419000070AE000000003800A50900000700008014000000B0020000008000000F00008053636847726964003A2000006243000074626C5F6F7264657264657461696C0000008000A50900000700008015000000520000000180000055000080436F6E74726F6C00C52900003656000052656C6174696F6E736869702027464B5F74626C5F6F7264657264657461696C5F74626C5F6F7264657227206265747765656E202774626C5F6F726465722720616E64202774626C5F6F7264657264657461696C2729000000002800B50100000700008016000000310000006B00000002800000436F6E74726F6C000B2C0000525E000000003000A50900000700008017000000A202000000800000080000805363684772696400DE3F0000964B000074626C5F706F737400007000A50900000700008018000000520000000180000047000080436F6E74726F6C0069490000683F000052656C6174696F6E736869702027464B5F74626C5F696D6167655F74626C5F706F737427206265747765656E202774626C5F706F73742720616E64202774626C5F696D616765270000002800B50100000700008019000000310000005D00000002800000436F6E74726F6C00AF4B00009345000000003400A5090000070000801A000000A8020000008000000B0000805363684772696400BC7F00000E6A000074626C5F70726F647563740000007C00A5090000070000801B000000520000000180000053000080436F6E74726F6C74189500004978000052656C6174696F6E736869702027464B5F74626C5F70726F647563745F74626C5F63617465676F727927206265747765656E202774626C5F63617465676F72792720616E64202774626C5F70726F64756374276400002800B5010000070000801C000000310000006900000002800000436F6E74726F6C0072930000D977000000007C00A5090000070000801D000000620000000180000051000080436F6E74726F6C0074750000F371000052656C6174696F6E736869702027464B5F74626C5F636F6D6D656E745F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F636F6D6D656E742774276400002800B5010000070000801E000000310000006700000002800000436F6E74726F6C002C6800002F7A000000007800A5090000070000801F00000062000000018000004D000080436F6E74726F6C003A5500001D39000052656C6174696F6E736869702027464B5F74626C5F696D6167655F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F696D61676527000D1B00002800B50100000700008020000000310000006300000002800000436F6E74726F6C00B77A0000C140000000008400A50900000700008021000000620000000180000059000080436F6E74726F6C6CA53500002351000052656C6174696F6E736869702027464B5F74626C5F6F7264657264657461696C5F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F6F7264657264657461696C2700720000002800B50100000700008022000000310000006F00000002800000436F6E74726F6C00E46E00009750000000003C00A50900000700008023000000B402000000800000110000805363684772696400B8A100006432000074626C5F70726F647563745F636F6C6F7200000000003800A50900000700008024000000B202000000800000100000805363684772696400EA6F00008A1B000074626C5F70726F647563745F6465616C00008000A50900000700008025000000520000000180000055000080436F6E74726F6C0046850000FB20000052656C6174696F6E736869702027464B5F74626C5F70726F647563745F6465616C5F74626C5F6465616C27206265747765656E202774626C5F6465616C2720616E64202774626C5F70726F647563745F6465616C2700000000002800B50100000700008026000000310000006B00000002800000436F6E74726F6C00818300008B20000000008400A5090000070000802700000062000000018000005B000080436F6E74726F6C00917900006227000052656C6174696F6E736869702027464B5F74626C5F70726F647563745F6465616C5F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F70726F647563745F6465616C270000002800B50100000700008028000000310000007100000002800000436F6E74726F6C008D8B0000C241000000003800A50900000700008029000000B20200000080000010000080536368477269640082AA0000D449000074626C5F70726F647563745F73697A6500003400A5090000070000802A000000A6020000008000000A0000805363684772696400BC7F00001293000074626C5F726174696E67745F00007800A5090000070000802B00000052000000018000004F000080436F6E74726F6C74478900004787000052656C6174696F6E736869702027464B5F74626C5F726174696E675F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F726174696E67270000002800B5010000070000802C000000310000006500000002800000436F6E74726F6C001B7C0000358C000000003000A5090000070000802D000000A202000000800000080000805363684772696400DE3F0000488A000074626C5F726F6C6500003000A5090000070000802E000000A20200000080000008000080536368477269647498D00000004B000074626C5F73697A6500003000A5090000070000802F000000A202000000800000080000805363684772696465DE3F0000F465000074626C5F7573657200007000A50900000700008030000000520000000180000045000080436F6E74726F6C0069490000337E000052656C6174696F6E736869702027464B5F74626C5F757365725F74626C5F726F6C6527206265747765656E202774626C5F726F6C652720616E64202774626C5F757365722765270000002800B50100000700008031000000310000005B00000002800000436F6E74726F6C00AF4B0000F184000000007000A50900000700008032000000620000000180000047000080436F6E74726F6C0096350000816B000052656C6174696F6E736869702027464B5F74626C5F6F726465725F74626C5F7573657227206265747765656E202774626C5F757365722720616E64202774626C5F6F72646572270000002800B50100000700008033000000310000005D00000002800000436F6E74726F6C00D93D0000496C000000007000A50900000700008034000000620000000180000048000080436F6E74726F6C0096350000BF69000052656C6174696F6E736869702027464B5F74626C5F6F726465725F74626C5F757365723127206265747765656E202774626C5F757365722720616E64202774626C5F6F726465722700002800B50100000700008035000000310000005F00000002800000436F6E74726F6C008D3E0000CA69000000007400A5090000070000803600000052000000018000004B000080436F6E74726F6C003A550000D771000052656C6174696F6E736869702027464B5F74626C5F636F6D6D656E745F74626C5F7573657227206265747765656E202774626C5F757365722720616E64202774626C5F636F6D6D656E74276500002800B50100000700008037000000310000006100000002800000436F6E74726F6C00435400001D74000000007000A50900000700008038000000520000000180000045000080436F6E74726F6C0069490000E959000052656C6174696F6E736869702027464B5F74626C5F706F73745F74626C5F7573657227206265747765656E202774626C5F757365722720616E64202774626C5F706F73742700000000002800B50100000700008039000000310000005B00000002800000436F6E74726F6C00AF4B00005F60000000003400A5090000070000803A000000A8020000008000000B00008053636847726964003A2000005EB0000074626C5F766F75636865727400008800A5090000070000803B00000052000000018000005D000080436F6E74726F6C7296350000E9B9000052656C6174696F6E736869702027464B5F74626C5F6F726465725F766F75636865725F74626C5F766F756368657227206265747765656E202774626C5F766F75636865722720616E64202774626C5F6F726465725F766F75636865722700000000002800B5010000070000803C000000310000007300000002800000436F6E74726F6C00963100002FBC000000003C00A5090000070000803D000000B802000000800000130000805363684772696400A41F000002D0000074626C5F766F75636865725F70726F647563740000008C00A5090000070000803E000000520000000180000061000080436F6E74726F6C00C5290000ABC3000052656C6174696F6E736869702027464B5F74626C5F766F75636865725F70726F647563745F74626C5F766F756368657227206265747765656E202774626C5F766F75636865722720616E64202774626C5F766F75636865725F70726F647563742700690000002800B5010000070000803F000000310000007700000002800000436F6E74726F6C004916000020CB000000008C00A50900000700008040000000620000000180000061000080436F6E74726F6C0024360000A17A000052656C6174696F6E736869702027464B5F74626C5F766F75636865725F70726F647563745F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F766F75636865725F70726F647563742700690000002800B50100000700008041000000310000007700000002800000436F6E74726F6C00C763000088C3000000008800A5090000070000804300000062000000018000005D000080436F6E74726F6C00D3930000C13B000052656C6174696F6E736869702027464B5F74626C5F70726F647563745F636F6C6F725F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F70726F647563745F636F6C6F722700000000002800B50100000700008044000000310000007300000002800000436F6E74726F6C00DA9800009757000000008400A5090000070000804600000062000000018000005B000080436F6E74726F6C0018950000195B000052656C6174696F6E736869702027464B5F74626C5F70726F647563745F73697A655F74626C5F70726F6475637427206265747765656E202774626C5F70726F647563742720616E64202774626C5F70726F647563745F73697A65270000002800B50100000700008047000000310000007100000002800000436F6E74726F6C0012A100004B64000000008400A50900000700008048000000520000000180000059000080436F6E74726F6C0014B700000139000052656C6174696F6E736869702027464B5F74626C5F70726F647563745F636F6C6F725F74626C5F636F6C6F7227206265747765656E202774626C5F636F6C6F722720616E64202774626C5F70726F647563745F636F6C6F72276C6F7200002800B50100000700008049000000310000006F00000002800000436F6E74726F6C6508BC00009138000000003400A5090000070000804D000000A6020000008000000A0000805363684772696400446100005A87000074626C5F67656E646572000000007400A5090000070000804E0000005A0000000180000049000080436F6E74726F6C0023510000337E000052656C6174696F6E736869702027464B5F74626C5F757365725F74626C5F67656E64657227206265747765656E202774626C5F67656E6465722720616E64202774626C5F757365722774276500002800B5010000070000804F000000310000005F00000002800000436F6E74726F6C004D530000E985000000008000A50900000700008052000000620000000180000055000080436F6E74726F6C00A5350000B13D000052656C6174696F6E736869702027464B5F74626C5F6F7264657264657461696C5F74626C5F636F6C6F7227206265747765656E202774626C5F636F6C6F722720616E64202774626C5F6F7264657264657461696C2733610000002800B50100000700008053000000310000006B00000002800000436F6E74726F6C0070780000413D0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000214334120800000097160000790E0000785634120700000014010000740062006C005F00630061007400650067006F007200790000002800640062006F002900000000000000000000000000D48A3D01D48A3D0154893D0154893D0160893D0160893D016C893D016C893D0178893D0178893D0184893D0184893D0190893D0190893D019C893D019C893D01A8893D01A8893D01B4893D01B4893D01C0893D01C0893D01CC893D01CC893D01D8893D01D8893D01E4893D01E4893D01F0893D01F0893D01FC893D01FC893D01088A3D01088A3D01148A3D01148A3D01208A3D01208A3D012C8A3D012C8A3D01388A3D01388A3D01448A3D01448A3D01508A3D01508A3D015C8A3D015C8A000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000097160000790E000000000000040000000400000002000000020000001C010000C80A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006200000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000D000000740062006C005F00630061007400650067006F007200790000002143341208000000881600009D090000785634120700000014010000740062006C005F0063006F006C006F00720000002800640062006F00290000000000000060000000600000002000FDFF1F002000000000270000000000020B06040305040402045940000000080000000100000000000000000000000008000008000000FEFFFFFF000000000600000003000000F9FFFFFF0B00000014000000FBFFFFFF0B000000FEFFFFFF00000000090000000800000007000000000000000200000008000000070000000000000005000000010000000400000001000000FFFFFFFFD8000000E6000000F4000000040100005400610068006F006D00610000005400610068006F006D006100000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000AA0A00000000000001000000391300003403000000000000000000000000000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000A000000740062006C005F0063006F006C006F00720000002143341208000000881600007F180000785634120700000014010000740062006C005F0063006F006D006D0065006E00740000002800640062006F00290000000000803FD0CF4F3FD7D6563FE6E5653F0000803F0000803F0000803FF3F2723F9E9D1D3F0000803F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000371C0000000000002D0100000A0000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600007F18000000000000080000000800000002000000020000001C010000AA0A00000000000001000000391300004D0C000000000000040000000400000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C000000740062006C005F0063006F006D006D0065006E007400000005000B00186000004C680000305C00004C680000305C000038630000446100003863000044610000206700000000000002000000F0F0F00000000000000000000000000000000000010000000700000000000000A3570000E763000072100000580100003E0000000100000200007210000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611A0046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F0063006F006D006D0065006E007400214334120800000088160000930E0000785634120700000014010000740062006C005F006400650061006C0000002800640062006F0029000000000098A23101FFFFFFFF0000160098A23101A057656800106468AD22000600000000000000000000000098A23101FFFFFFFF8B00000098A23101BC57656800106468AF22000600000000000000000000000098A23101FFFFFFFF1026000098A23101CC57656800106468B022000600000000000000000000000098A23101FFFFFFFF00006100EF486CD60001008000000000A000000098A23101B0566568001064689722000600000000000000000000000098A23101FFFFFFFF0000000098A23101C456656800106468992200060000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000C80A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000009000000740062006C005F006400650061006C000000214334120800000088160000930E0000785634120700000014010000740062006C005F0069006D0061006700650000002800640062006F002900000034003100AD482AD63C04008000000000A000000098A23101DC536568001064684F22000600000000000000000000000098A23101FFFFFFFFC8536F0F98A23101E8536568001064685022000600000000000000000000000098A23101FFFFFFFF20546F0F98A23101F4536568001064685122000600000000000000000000000098A23101FFFFFFFF0000000098A2310124546568001064685522000600000000000000000000000098A23101FFFFFFFF00000000874804D60005008000000000A000000098A23101805665680010000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000AA0A0000000000000100000039130000060A000000000000030000000300000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000A000000740062006C005F0069006D00610067006500000021433412080000008816000004160000785634120700000014010000740062006C005F006F00720064006500720000002800640062006F0029000000F458656800106468CA22000600000000000000000000000098A23101FFFFFFFF4B22000098A231010059656800106468CB22000600000000000000000000000098A23101FFFFFFFF00003500314896D64D0A008000000000A000000098A231016C59656800106468D422000600000000000000000000000098A23101FFFFFFFF3223000098A231017859656800106468D522000600000000000000000000000098A23101FFFFFFFF0000000198A231018459656800106468D622000600000000000000000000000098A23101FFFF000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600000416000000000000070000000700000002000000020000001C010000C80A0000000000000100000039130000930E000000000000050000000500000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000A000000740062006C005F006F00720064006500720000002143341208000000881600009D090000785634120700000014010000740062006C005F006F0072006400650072005F0073007400610074007500730000002800640062006F002900000064688222000600000000000000000000000098A23101FFFFFFFF480B470F98A23101C8556568001064688322000600000000000000000000000098A23101FFFFFFFF0100000098A23101FC556568001064688922000600000000000000000000000098A23101FFFFFFFF1854FB66C9494ED7000E008000000000A000000098A231010C536568001064683C22000600000000000000000000000098A23101FFFFFFFF0000000098A231011C536568001064683D22000600000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000AA0A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000011000000740062006C005F006F0072006400650072005F00730074006100740075007300000004000B00DE3F00004EA20000763C00004EA20000763C0000BE6E0000C2360000BE6E00000000000002000000F0F0F000000000000000000000000000000000000100000010000000000000001B2B0000CC880000AC1000005801000031000000010000020000AC10000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611D0046004B005F00740062006C005F006F0072006400650072005F00740062006C005F006F0072006400650072005F007300740061007400750073002143341208000000881600009D090000785634120700000014010000740062006C005F006F0072006400650072005F0076006F007500630068006500720000002800640062006F002900000098A23101FFFFFFFF0000000098A2310154536568001064684222000600000000000000000000000098A23101FFFFFFFFFFFFFFFF98A2310168536568001064684422000600000000000000000000000098A23101FFFFFFFF0000000098A2310174536568001064684522000600000000000000000000000098A23101FFFFFFFF00000000B54912D70010008000000000A000000098A2310184536568001064684622000600000000000000000000000098A23101FFFFFFFF0000000098A2000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000AA0A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000012000000740062006C005F006F0072006400650072005F0076006F0075006300680065007200000004000B00F22B000074780000F22B000037AE0000964B000037AE0000964B0000D0B600000000000002000000F0F0F000000000000000000000000000000000000100000013000000000000009419000070AE0000AF1100005801000039000000010000020000AF11000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F00740062006C005F006F0072006400650072005F0076006F00750063006800650072005F00740062006C005F006F0072006400650072002143341208000000971600008F150000785634120700000014010000740062006C005F006F007200640065007200640065007400610069006C0000002800640062006F00290000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000971600008F15000000000000030000000300000002000000020000001C010000C80A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000010000000740062006C005F006F007200640065007200640065007400610069006C00000002000B005C2B0000706200005C2B0000F15800000000000002000000F0F0F000000000000000000000000000000000000100000016000000000000000B2C0000525E00008B0F000058010000220000000100000200008B0F000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611C0046004B005F00740062006C005F006F007200640065007200640065007400610069006C005F00740062006C005F006F0072006400650072002143341208000000881600000E110000785634120700000014010000740062006C005F0070006F007300740000002800640062006F002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600000E11000000000000050000000500000002000000020000001C010000AA0A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000009000000740062006C005F0070006F0073007400000002000B00004B0000964B0000004B0000234200000000000002000000F0F0F00000000000000000000000000000000000010000001900000000000000AF4B000093450000470C0000580100003A000000010000020000470C000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61150046004B005F00740062006C005F0069006D006100670065005F00740062006C005F0070006F0073007400214334120800000088160000F01F0000785634120700000014010000740062006C005F00700072006F00640075006300740000002800640062006F00290000007403000000003D070000000000000000000000000000000000000000000000000000000061056406640600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000009230000000000002D0100000D0000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000F01F0000000000000B0000000B00000002000000020000001C010000C80A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C000000740062006C005F00700072006F006400750063007400000002000B00F69F0000E079000044960000E07900000000000002000000F0F0F00000000000000000000000000000000000010000001C0000000000000072930000D9770000C50F00005801000036000000010000020000C50F000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611B0046004B005F00740062006C005F00700072006F0064007500630074005F00740062006C005F00630061007400650067006F007200790004000B00BC7F0000767A0000A0780000767A0000A07800006E730000A07600006E7300000000000002000000F0F0F00000000000000000000000000000000000010000001E000000000000002C6800002F7A0000C50F00005801000032000000010000020000C50F000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611A0046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F00700072006F00640075006300740004000B00BC7F0000F2760000087A0000F2760000087A0000983A000066560000983A00000000000002000000F0F0F00000000000000000000000000000000000010000002000000000000000B77A0000C1400000140E00005801000039000000010000020000140E000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61180046004B005F00740062006C005F0069006D006100670065005F00740062006C005F00700072006F00640075006300740004000B00BC7F0000B478000054790000B4780000547900009E520000D13600009E5200000000000002000000F0F0F00000000000000000000000000000000000010000002200000000000000E46E000097500000C81000005801000032000000010000020000C810000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611E0046004B005F00740062006C005F006F007200640065007200640065007400610069006C005F00740062006C005F00700072006F006400750063007400214334120800000088160000180C0000785634120700000014010000740062006C005F00700072006F0064007500630074005F0063006F006C006F00720000002800640062006F00290000009E9D1D3F0000803F0000803F0000803FF3F2723F9E9D1D3F0000803F0000000001000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000F03F0000000000000000902DFB6600000000000000005830FB66BC54FB6600000000205A680F020000000300000000000000000000000000000000000000020000000000000000000040000000000000A841000098C10000004000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000180C000000000000030000000300000002000000020000001C010000C80A00000000000001000000391300003403000000000000000000000000000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000012000000740062006C005F00700072006F0064007500630074005F0063006F006C006F0072000000214334120800000088160000930E0000785634120700000014010000740062006C005F00700072006F0064007500630074005F006400650061006C0000002800640062006F0029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000930E000000000000040000000400000002000000020000001C010000C80A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000011000000740062006C005F00700072006F0064007500630074005F006400650061006C00000002000B00249000009222000072860000922200000000000002000000F0F0F00000000000000000000000000000000000010000002600000000000000818300008B2000001C10000058010000360000000100000200001C10000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611C0046004B005F00740062006C005F00700072006F0064007500630074005F006400650061006C005F00740062006C005F006400650061006C0004000B00DE8A00000E6A0000DE8A0000F52B00000C7B0000F52B00000C7B00001D2A00000000000002000000F0F0F000000000000000000000000000000000000100000028000000000000008D8B0000C24100000512000058010000300000000100000200000512000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611F0046004B005F00740062006C005F00700072006F0064007500630074005F006400650061006C005F00740062006C005F00700072006F006400750063007400214334120800000065160000A3130000785634120700000014010000740062006C005F00700072006F0064007500630074005F00730069007A00650000002800640062006F0029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000065160000A313000000000000030000000300000002000000020000001C010000AA0A00000000000001000000391300003403000000000000000000000000000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000011000000740062006C005F00700072006F0064007500630074005F00730069007A0065000000214334120800000088160000180C0000785634120700000014010000740062006C005F0072006100740069006E00670000002800640062006F0029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000180C000000000000030000000300000002000000020000001C010000C80A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000B000000740062006C005F0072006100740069006E006700000002000B00DE8A0000FE890000DE8A0000129300000000000002000000F0F0F00000000000000000000000000000000000010000002C000000000000001B7C0000358C0000140E0000580100001D000000010000020000140E000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61190046004B005F00740062006C005F0072006100740069006E0067005F00740062006C005F00700072006F0064007500630074002143341208000000881600009D090000785634120700000014010000740062006C005F0072006F006C00650000002800640062006F002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000AA0A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000009000000740062006C005F0072006F006C00650000002143341208000000881600009D090000785634120700000014010000740062006C005F00730069007A00650000002800640062006F00290000000000000000007100990100000602F302000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AB0077010000760292010000000000000000C40013000000000000002B009D01510200000000000000000000280066010000000000000204DF0200000000000000000000CF03000000000000000000000000000000007903000000000000000000000000000000000000000000000000000000009D00B101000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600009D09000000000000020000000200000002000000020000001C010000AA0A00000000000001000000391300003403000000000000000000000000000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000009000000740062006C005F00730069007A0065000000214334120800000088160000FA1A0000785634120700000014010000740062006C005F00750073006500720000002800640062006F00290000006700D30000019D035B00F5030000C9008B00A701000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001C0000004A000801000000000000700100000000000000000000000000000000000000000000000000000000000000000000190090010000000000000000000000004102000000000000000000000000000091008E000000000000000000000069000000000001000000000000006906000069066906690600006906000000000000000000000100000005000000540000002C0000002C0000002C000000340000000000000000000000222900007D1E0000000000002D0100000B0000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C0030000000000000100000088160000FA1A000000000000090000000900000002000000020000001C01000060090000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005A00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000009000000740062006C005F007500730065007200000002000B00004B0000488A0000004B0000EE8000000000000002000000F0F0F00000000000000000000000000000000000010000003100000000000000AF4B0000F1840000260B00005801000032000000010000020000260B000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61140046004B005F00740062006C005F0075007300650072005F00740062006C005F0072006F006C00650004000B00DE3F0000047400002A3D0000047400002A3D0000FC6C0000C2360000FC6C00000000000002000000F0F0F00000000000000000000000000000000000010000003300000000000000D93D0000496C00000D0C000058010000340000000100000200000D0C000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61150046004B005F00740062006C005F006F0072006400650072005F00740062006C005F00750073006500720004000B00DE3F000042720000DE3D000042720000DE3D00003A6B0000C23600003A6B00000000000002000000F0F0F000000000000000000000000000000000000100000035000000000000008D3E0000CA690000BB0C00005801000034000000010000020000BB0C000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61160046004B005F00740062006C005F006F0072006400650072005F00740062006C005F007500730065007200310002000B00665600006E730000186000006E7300000000000002000000F0F0F00000000000000000000000000000000000010000003700000000000000435400001D740000F80D00005801000032000000010000020000F80D000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D61170046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F00750073006500720002000B00004B0000F4650000004B0000A45C00000000000002000000F0F0F00000000000000000000000000000000000010000003900000000000000AF4B00005F6000007D0B000058010000350000000100000200007D0B000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61140046004B005F00740062006C005F0070006F00730074005F00740062006C005F00750073006500720021433412080000008816000004160000785634120700000014010000740062006C005F0076006F007500630068006500720000002800640062006F0029000000690073005F0063006F006C0075006D006E005F007300650074002C00200043004F004E00560045005200540028006200690074002C002000630061007300650020007700680065006E0020002800490053004E0055004C004C0028006600740063002E0073007400610074006900730074006900630061006C005F00730065006D0061006E0074006900630073002C0020003000290020003D0020003000290020007400680065006E0020003000200065006C007300650020003100200065006E006400290020006100000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000F1190000000000002D010000090000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000881600000416000000000000070000000700000002000000020000001C010000C80A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C000000740062006C005F0076006F0075006300680065007200000002000B00C236000080BB00007440000080BB00000000000002000000F0F0F00000000000000000000000000000000000010000003C00000000000000963100002FBC00002613000058010000370000000100000200002613000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61200046004B005F00740062006C005F006F0072006400650072005F0076006F00750063006800650072005F00740062006C005F0076006F00750063006800650072002143341208000000AC1700009D090000785634120700000014010000740062006C005F0076006F00750063006800650072005F00700072006F00640075006300740000002800640062006F0029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C010000060900006207000049020000DF020000FE010000EC04000056040000940200005604000073050000C00300000000000001000000AC1700009D09000000000000020000000200000002000000020000001C0100006D0B0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000007000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000014000000740062006C005F0076006F00750063006800650072005F00700072006F006400750063007400000002000B005C2B000062C600005C2B000002D000000000000002000000F0F0F00000000000000000000000000000000000010000003F000000000000004916000020CB00006414000058010000390000000100000200006414000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61220046004B005F00740062006C005F0076006F00750063006800650072005F00700072006F0064007500630074005F00740062006C005F0076006F007500630068006500720004000B00BC7F0000387C0000A0780000387C0000A0780000B2D4000050370000B2D400000000000002000000F0F0F00000000000000000000000000000000000010000004100000000000000C763000088C300002A14000058010000320000000100000200002A14000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61220046004B005F00740062006C005F0076006F00750063006800650072005F00700072006F0064007500630074005F00740062006C005F00700072006F00640075006300740004000B006A9500000E6A00006A950000E85600004EA20000E85600004EA200007C3E00000000000002000000F0F0F00000000000000000000000000000000000010000004400000000000000DA980000975700005D12000058010000270000000100000200005D12000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61200046004B005F00740062006C005F00700072006F0064007500630074005F0063006F006C006F0072005F00740062006C005F00700072006F00640075006300740004000B0044960000A46A000063A00000A46A000063A00000945C000082AA0000945C00000000000002000000F0F0F0000000000000000000000000000000000001000000470000000000000012A100004B640000CC1100005801000032000000010000020000CC11000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611F0046004B005F00740062006C005F00700072006F0064007500630074005F00730069007A0065005F00740062006C005F00700072006F00640075006300740002000B0098D00000983A000040B80000983A00000000000002000000F0F0F0000000000000000000000000000000000001000000490000000000000008BC000091380000C81000005801000032000000010000020000C810000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611E0046004B005F00740062006C005F00700072006F0064007500630074005F0063006F006C006F0072005F00740062006C005F0063006F006C006F007200214334120800000076120000120B0000785634120700000014010000740062006C005F00670065006E006400650072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C000000340000000000000000000000131E0000CF150000000000002D010000070000000C000000070000001C010000540600002805000049020000DF020000FE0100007503000056040000940200005604000073050000C0030000000000000100000076120000120B000000000000020000000200000002000000020000001C010000700800000000000001000000930E00009505000000000000010000000100000002000000020000001C010000540600000100000000000000930E00003403000000000000000000000000000002000000020000001C01000054060000000000000000000012240000A823000000000000000000000D00000004000000040000001C01000054060000710700009204000078563412040000005E00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000B000000740062006C005F00670065006E00640065007200000003000B0044610000F08700009E520000F08700009E520000EE8000000000000002000000F0F0F00000000000000000000000000000000000010000004F000000000000004D530000E9850000F40C00005801000044000000010000020000F40C000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61160046004B005F00740062006C005F0075007300650072005F00740062006C005F00670065006E0064006500720004000B0098D00000483F0000B5830000483F0000B5830000F8430000D1360000F84300000000000002000000F0F0F0000000000000000000000000000000000001000000530000000000000070780000413D0000350F0000580100002E000000010000020000350F000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D611C0046004B005F00740062006C005F006F007200640065007200640065007400610069006C005F00740062006C005F0063006F006C006F007200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000FEFFFFFFFEFFFFFF0400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F000000100000001100000012000000130000001400000015000000160000001700000018000000190000001A0000001B0000001C000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B271000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F573900000200000E32595EBFD301020200001048450000000000000000000000000000000000D60100004400610074006100200053006F0075007200630065003D004E0047004F0043004E00540053004500360032003200390032005C00530051004C0045005800500052004500530053003B0049006E0069007400690061006C00200043006100740061006C006F0067003D0073006E006B0072006B006F007200650061003B005000650072007300690073007400200053006500630075007200690074007900200049006E0066006F003D0054007200750065003B0055007300650072002000490044003D00730061003B004D0075006C007400690070006C00650041006300740069007600650052006500730075006C00740053006500740073003D00460061006C00730065003B000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000037000000773B00000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000020000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000003000000500600000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF0000000000000000000000000000000000000000000000000000000000000000000000001D00000012000000000000000C00000050700000E13300000100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000010000000100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000040000000400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000050000000500000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000600000006000000000000004600000001B7D16B01000000640062006F00000046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F0063006F006D006D0065006E00740000000000000000000000C40200000000070000000700000006000000080000000196FD0F6896FD0F0000000000000000AD070000000000080000000800000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000A0000000A00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000B0000000B00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000E0000000E00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000F0000000F000000000000004C000000011F941E01000000640062006F00000046004B005F00740062006C005F006F0072006400650072005F00740062006C005F006F0072006400650072005F0073007400610074007500730000000000000000000000C4020000000010000000100000000F000000080000000194FD0FA894FD0F0000000000000000AD070000000000110000001100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001200000012000000000000004E000000011F941E01000000640062006F00000046004B005F00740062006C005F006F0072006400650072005F0076006F00750063006800650072005F00740062006C005F006F00720064006500720000000000000000000000C40200000000130000001300000012000000080000000196FD0FA896FD0F0000000000000000AD070000000000140000001400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001500000015000000000000004A000000011F941E01000000640062006F00000046004B005F00740062006C005F006F007200640065007200640065007400610069006C005F00740062006C005F006F00720064006500720000000000000000000000C40200000000160000001600000015000000080000000196FD0FE896FD0F0000000000000000AD070000000000170000001700000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001800000018000000000000003C000000011F941E01000000640062006F00000046004B005F00740062006C005F0069006D006100670065005F00740062006C005F0070006F007300740000000000000000000000C40200000000190000001900000018000000080000000195FD0FA895FD0F0000000000000000AD0700000000001A0000001A00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000001B0000001B000000000000004800000001B7D16B01000000640062006F00000046004B005F00740062006C005F00700072006F0064007500630074005F00740062006C005F00630061007400650067006F007200790000000000000000000000C402000000001C0000001C0000001B000000080000000198FD0FA898FD0F0000000000000000AD0700000000001D0000001D000000000000004600000001B7D16B01000000640062006F00000046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F00700072006F00640075006300740000000000000000000000C402000000001E0000001E0000001D000000080000000194FD0F6894FD0F0000000000000000AD0700000000001F0000001F000000000000004200000001B7D16B01000000640062006F00000046004B005F00740062006C005F0069006D006100670065005F00740062006C005F00700072006F00640075006300740000000000000000000000C4020000000020000000200000001F000000080000000193FD0FE893FD0F0000000000000000AD0700000000002100000021000000000000004E000000011F941E01000000640062006F00000046004B005F00740062006C005F006F007200640065007200640065007400610069006C005F00740062006C005F00700072006F00640075006300740000000000000000000000C40200000000220000002200000021000000080000000193FD0F2893FD0F0000000000000000AD070000000000230000002300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000240000002400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000002500000025000000000000004A000000011F941E01000000640062006F00000046004B005F00740062006C005F00700072006F0064007500630074005F006400650061006C005F00740062006C005F006400650061006C0000000000000000000000C40200000000260000002600000025000000080000000195FD0F6895FD0F0000000000000000AD070000000000270000002700000000000000500000000100000001000000640062006F00000046004B005F00740062006C005F00700072006F0064007500630074005F006400650061006C005F00740062006C005F00700072006F00640075006300740000000000000000000000C40200000000280000002800000027000000080000000198FD0F6898FD0F0000000000000000AD070000000000290000002900000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000002A0000002A00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000002B0000002B00000000000000440000000100690001000000640062006F00000046004B005F00740062006C005F0072006100740069006E0067005F00740062006C005F00700072006F00640075006300740000000000000000000000C402000000002C0000002C0000002B000000080000000195FD0F2895FD0F0000000000000000AD0700000000002D0000002D00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000002E0000002E00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700330030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000002F0000002F00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003400300030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000003000000030000000000000003A000000011F941E01000000640062006F00000046004B005F00740062006C005F0075007300650072005F00740062006C005F0072006F006C00650000000000000000000000C402000000003100000031000000300000000800000001730110E07301100000000000000000AD0700000000003200000032000000000000003C000000011F941E01000000640062006F00000046004B005F00740062006C005F006F0072006400650072005F00740062006C005F00750073006500720000000000000000000000C402000000003300000033000000320000000800000001730110607301100000000000000000AD0700000000003400000034000000000000003E000000011F941E01000000640062006F00000046004B005F00740062006C005F006F0072006400650072005F00740062006C005F007500730065007200310000000000000000000000C402000000003500000035000000340000000800000001720110607201100000000000000000AD070000000000360000003600000000000000400000000100000001000000640062006F00000046004B005F00740062006C005F0063006F006D006D0065006E0074005F00740062006C005F00750073006500720000000000000000000000C402000000003700000037000000360000000800000001720110207201100000000000000000AD0700000000003800000038000000000000003A00000001618B1E01000000640062006F00000046004B005F00740062006C005F0070006F00730074005F00740062006C005F00750073006500720000000000000000000000C402000000003900000039000000380000000800000001710110E07101100000000000000000AD0700000000003A0000003A00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003700360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000003B0000003B0000000000000052000000012D986501000000640062006F00000046004B005F00740062006C005F006F0072006400650072005F0076006F00750063006800650072005F00740062006C005F0076006F007500630068006500720000000000000000000000C402000000003C0000003C0000003B0000000800000001730110A07301100000000000000000AD0700000000003D0000003D00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003900320035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000003E0000003E00000000000000560000000100690001000000640062006F00000046004B005F00740062006C005F0076006F00750063006800650072005F00700072006F0064007500630074005F00740062006C005F0076006F007500630068006500720000000000000000000000C402000000003F0000003F0000003E0000000800000001720110E07201100000000000000000AD07000000000040000000400000000000000056000000016E737401000000640062006F00000046004B005F00740062006C005F0076006F00750063006800650072005F00700072006F0064007500630074005F00740062006C005F00700072006F00640075006300740000000000000000000000C402000000004100000041000000400000000800000001730110207301100000000000000000AD07000000000043000000430000000000000052000000016E737401000000640062006F00000046004B005F00740062006C005F00700072006F0064007500630074005F0063006F006C006F0072005F00740062006C005F00700072006F00640075006300740000000000000000000000C402000000004400000044000000430000000800000001770110607701100000000000000000AD07000000000046000000460000000000000050000000011F941E01000000640062006F00000046004B005F00740062006C005F00700072006F0064007500630074005F00730069007A0065005F00740062006C005F00700072006F00640075006300740000000000000000000000C402000000004700000047000000460000000800000001770110207701100000000000000000AD0700000000004800000048000000000000004E000000011F941E01000000640062006F00000046004B005F00740062006C005F00700072006F0064007500630074005F0063006F006C006F0072005F00740062006C005F0063006F006C006F00720000000000000000000000C402000000004900000049000000480000000800000001750110607501100000000000000000AD0700000000004D0000004D00000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003800000034002C0030002C003200380034002C0030002C0031003600320030002C0031002C0031003300320030002C0035002C003800380035000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003100360030000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0031003600320030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0031003600320030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0031003600320030002C00310032002C0031003900300035002C00310031002C00310031003700300000004E0000004E000000000000003E000000011F941E01000000640062006F00000046004B005F00740062006C005F0075007300650072005F00740062006C005F00670065006E0064006500720000000000000000000000C402000000004F0000004F0000004E0000000800000001790110A07901100000000000000000AD0700000000005200000052000000000000004A000000011F941E01000000640062006F00000046004B005F00740062006C005F006F007200640065007200640065007400610069006C005F00740062006C005F0063006F006C006F00720000000000000000000000C402000000005300000053000000520000000800000001790110607901100000000000000000AD0700000000007D0000001B000000010000001A0000005A0000007F0000004800000004000000230000005600000065000000520000000400000014000000660000004B0000000600000005000000050000004C000000020000002500000008000000240000006000000061000000120000000B000000110000002700000024000000150000000B0000001400000024000000250000000F0000000E0000000B000000580000007300000018000000170000000A00000024000000250000001D0000001A0000000500000080000000730000001F0000001A0000000A0000007400000061000000210000001A000000140000007A0000007D000000270000001A0000002400000024000000250000002B0000001A0000002A0000002500000024000000400000001A0000003D000000860000005D000000430000001A000000230000004800000001000000460000001A000000290000004B00000088000000300000002D0000002F0000002400000025000000320000002F0000000B000000780000006D000000340000002F0000000B0000007200000067000000360000002F000000050000007700000072000000380000002F0000001700000024000000250000003B0000003A000000110000006F000000580000003E0000003A0000003D00000025000000260000004E0000004D0000002F0000003C0000003F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D0054007200750065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F002200000000800500140000004400690061006700720061006D005F00300000000002260016000000740062006C005F00670065006E00640065007200000008000000640062006F0000000002260028000000740062006C005F0076006F00750063006800650072005F00700072006F006400750063007400000008000000640062006F0000000002260018000000740062006C005F0076006F0075006300680065007200000008000000640062006F0000000002260012000000740062006C005F007500730065007200000008000000640062006F0000000002260012000000740062006C005F00730069007A006500000008000000640062006F0000000002260012000000740062006C005F0072006F006C006500000008000000640062006F0000000002260016000000740062006C005F0072006100740069006E006700000008000000640062006F0000000002260022000000740062006C005F00700072006F0064007500630074005F00730069007A006500000008000000640062006F0000000002260022000000740062006C005F00700072006F0064007500630074005F006400650061006C00000008000000640062006F0000000002260024000000740062006C005F00700072006F0064007500630074005F0063006F006C006F007200000008000000640062006F0000000002260018000000740062006C005F00700072006F006400750063007400000008000000640062006F0000000002260012000000740062006C005F0070006F0073007400000008000000640062006F0000000002260020000000740062006C005F006F007200640065007200640065007400610069006C00000008000000640062006F0000000002260024000000740062006C005F006F0072006400650072005F0076006F0075006300680065007200000008000000640062006F0000000002260022000000740062006C005F006F0072006400650072005F00730074006100740075007300000008000000640062006F0000000002260014000000740062006C005F006F007200640065007200000008000000640062006F0000000002260014000000740062006C005F0069006D00610067006500000008000000640062006F0000000002260012000000740062006C005F006400650061006C00000008000000640062006F0000000002260018000000740062006C005F0063006F006D006D0065006E007400000008000000640062006F0000000002260014000000740062006C005F0063006F006C006F007200000008000000640062006F000000000224001A000000740062006C005F00630061007400650067006F0072007900000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
SET IDENTITY_INSERT [dbo].[sysdiagrams] OFF
SET IDENTITY_INSERT [dbo].[tbl_category] ON 

INSERT [dbo].[tbl_category] ([id], [name], [description], [parentId]) VALUES (1, N'áo thun', N'áo thun', 0)
INSERT [dbo].[tbl_category] ([id], [name], [description], [parentId]) VALUES (3, N'áo dài', N'áo dài nhưng chỉ hơi dài nha', 0)
INSERT [dbo].[tbl_category] ([id], [name], [description], [parentId]) VALUES (5, N'quần', NULL, NULL)
INSERT [dbo].[tbl_category] ([id], [name], [description], [parentId]) VALUES (8, N'váy', NULL, NULL)
INSERT [dbo].[tbl_category] ([id], [name], [description], [parentId]) VALUES (14, N'áo len', N'', 0)
INSERT [dbo].[tbl_category] ([id], [name], [description], [parentId]) VALUES (15, N'special', NULL, 0)
SET IDENTITY_INSERT [dbo].[tbl_category] OFF
INSERT [dbo].[tbl_color] ([id], [name]) VALUES (N'1', N'Đỏ')
INSERT [dbo].[tbl_color] ([id], [name]) VALUES (N'2', N'Xanh dương')
INSERT [dbo].[tbl_color] ([id], [name]) VALUES (N'3', N'Vàng')
INSERT [dbo].[tbl_color] ([id], [name]) VALUES (N'4', N'Tím')
INSERT [dbo].[tbl_color] ([id], [name]) VALUES (N'5', N'Cam')
INSERT [dbo].[tbl_color] ([id], [name]) VALUES (N'6', N'Trắng')
INSERT [dbo].[tbl_color] ([id], [name]) VALUES (N'7', N'Đen')
SET IDENTITY_INSERT [dbo].[tbl_comment] ON 

INSERT [dbo].[tbl_comment] ([id], [title], [commentContent], [time], [parentId], [productId], [postId], [authorId]) VALUES (104, N'adfadf', N'afadfdaf', CAST(N'2018-02-28T09:59:22.960' AS DateTime), NULL, NULL, 1, N'ngoc')
INSERT [dbo].[tbl_comment] ([id], [title], [commentContent], [time], [parentId], [productId], [postId], [authorId]) VALUES (106, N'cmm1', N'sản phẩm chua gao', CAST(N'2018-03-15T10:00:01.600' AS DateTime), NULL, 99999, NULL, N'ngoc')
INSERT [dbo].[tbl_comment] ([id], [title], [commentContent], [time], [parentId], [productId], [postId], [authorId]) VALUES (107, N'cmm2', N'khá hài lòng với sản phẩm', CAST(N'2018-03-15T10:00:19.043' AS DateTime), NULL, 99999, NULL, N'ngoc')
INSERT [dbo].[tbl_comment] ([id], [title], [commentContent], [time], [parentId], [productId], [postId], [authorId]) VALUES (108, N'cmm3', N'sản phẩm khá đẹp và rất giống hình', CAST(N'2018-03-15T10:00:42.160' AS DateTime), NULL, 99999, NULL, N'ngoc')
INSERT [dbo].[tbl_comment] ([id], [title], [commentContent], [time], [parentId], [productId], [postId], [authorId]) VALUES (110, N'cmm5', N'chất lượng rất tốt vừa mới nhân được hôm qua', CAST(N'2018-03-15T10:16:44.897' AS DateTime), NULL, 100004, NULL, N'ngoc')
INSERT [dbo].[tbl_comment] ([id], [title], [commentContent], [time], [parentId], [productId], [postId], [authorId]) VALUES (113, N'cmm6', N'hàng mang thoải mái vừa vặn', CAST(N'2018-03-15T10:17:28.807' AS DateTime), NULL, 100005, NULL, N'ngoc')
INSERT [dbo].[tbl_comment] ([id], [title], [commentContent], [time], [parentId], [productId], [postId], [authorId]) VALUES (122, N'', N'comment somthing here...', CAST(N'2018-03-23T21:27:42.017' AS DateTime), NULL, 100001, NULL, N'ngoc')
INSERT [dbo].[tbl_comment] ([id], [title], [commentContent], [time], [parentId], [productId], [postId], [authorId]) VALUES (123, N'', N'Sao không có hình vậy?', CAST(N'2018-03-25T09:04:11.040' AS DateTime), NULL, 100018, NULL, N'ngoc')
SET IDENTITY_INSERT [dbo].[tbl_comment] OFF
SET IDENTITY_INSERT [dbo].[tbl_deal] ON 

INSERT [dbo].[tbl_deal] ([id], [dealContent], [startTime], [duration]) VALUES (1, N'Sale Tet Holliday', CAST(N'2018-03-22T07:30:00.000' AS DateTime), 72)
INSERT [dbo].[tbl_deal] ([id], [dealContent], [startTime], [duration]) VALUES (4, N'Quoc Te Lao Dong', CAST(N'2018-05-01T00:00:00.000' AS DateTime), 24)
INSERT [dbo].[tbl_deal] ([id], [dealContent], [startTime], [duration]) VALUES (5, N'Giảm giá Cá tháng Tư', CAST(N'2018-04-01T00:00:00.000' AS DateTime), 24)
INSERT [dbo].[tbl_deal] ([id], [dealContent], [startTime], [duration]) VALUES (8, N'Giảm giá trong 1 ngày', CAST(N'2018-03-25T11:34:00.000' AS DateTime), 24)
SET IDENTITY_INSERT [dbo].[tbl_deal] OFF
SET IDENTITY_INSERT [dbo].[tbl_gender] ON 

INSERT [dbo].[tbl_gender] ([id], [gender]) VALUES (1, N'Male')
INSERT [dbo].[tbl_gender] ([id], [gender]) VALUES (2, N'Female')
SET IDENTITY_INSERT [dbo].[tbl_gender] OFF
SET IDENTITY_INSERT [dbo].[tbl_image] ON 

INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (8, 99999, NULL, N'img/u35.jpeg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (10, 99999, NULL, N'img/u35.jpeg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (13, 100004, NULL, N'img/u35.jpeg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (18, 100001, NULL, N'https://dillystore.com/wp-content/uploads/2016/04/V%C3%A1y-x%C3%B2e-c%E1%BB%95-%C4%91i%E1%BB%83n-cao-c%E1%BA%A5pff.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (21, NULL, 9, N'https://html5box.com/html5lightbox/images/lakeandballoon.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (24, 100016, NULL, N'https://media.snkrs.com/39394-thickbox/ms574-doa-black.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (25, 100019, NULL, N'http://heavenaodai.com/wp-content/uploads/2015/05/T923i.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (26, 100007, NULL, N'https://media3.snkrs.com/39615-thickbox/ultra-boost-40-greyblue.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (27, NULL, 13, N'http://www.travel365.md/wp-content/uploads/2017/08/mare.5.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (28, NULL, 9, N'http://www.carenstyle.com/wp-content/uploads/Summer-Fashion-Tips-For-Kids-tt.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (29, NULL, 12, N'https://i.pinimg.com/originals/8e/bb/73/8ebb73accef425c9d6919d36eadf8cc9.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (30, 100008, NULL, N'https://media.snkrs.com/40245-thickbox/om576-ogg-grey.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (31, 100008, NULL, N'https://media.snkrs.com/40246-thickbox/om576-ogg-grey.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (32, 100008, NULL, N'https://media3.snkrs.com/40247-thickbox/om576-ogg-grey.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (33, 100009, NULL, N'https://media.snkrs.com/39394-thickbox/ms574-doa-black.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (34, 100009, NULL, N'https://media3.snkrs.com/39395-thickbox/ms574-doa-black.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (35, 100009, NULL, N'https://media.snkrs.com/39396-thickbox/ms574-doa-black.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (36, 100009, NULL, N'https://media3.snkrs.com/39397-thickbox/ms574-doa-black.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (37, 100009, NULL, N'https://media3.snkrs.com/39398-thickbox/ms574-doa-black.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (38, 100010, NULL, N'https://media2.snkrs.com/40619-thickbox/ultra-boost-clima-carbon.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (39, 100010, NULL, N'https://media2.snkrs.com/40620-thickbox/ultra-boost-clima-carbon.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (40, 100010, NULL, N'https://media2.snkrs.com/40621-thickbox/ultra-boost-clima-carbon.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (41, 100010, NULL, N'https://media.snkrs.com/40622-thickbox/ultra-boost-clima-carbon.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (42, 100010, NULL, N'https://media2.snkrs.com/40623-thickbox/ultra-boost-clima-carbon.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (43, 100011, NULL, N'https://snkrs.com/img/cms/carrousel-nike-air-max-plus-paris-1.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (44, 100011, NULL, N'https://snkrs.com/img/cms/carrousel-nike-air-max-plus-paris-2.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (45, 100011, NULL, N'https://snkrs.com/img/cms/carrousel-nike-air-max-plus-paris-3.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (46, 100011, NULL, N'https://snkrs.com/img/cms/carrousel-nike-air-max-plus-paris-5.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (47, 100012, NULL, N'https://media.snkrs.com/40566-thickbox/prevail-og-whiteocean.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (48, 100012, NULL, N'https://media2.snkrs.com/40567-thickbox/prevail-og-whiteocean.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (49, 100012, NULL, N'https://media2.snkrs.com/40568-thickbox/prevail-og-whiteocean.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (50, 100012, NULL, N'https://media2.snkrs.com/40569-thickbox/prevail-og-whiteocean.jpg')
INSERT [dbo].[tbl_image] ([imageId], [productId], [postId], [url]) VALUES (51, 100012, NULL, N'https://media3.snkrs.com/40570-thickbox/prevail-og-whiteocean.jpg')
SET IDENTITY_INSERT [dbo].[tbl_image] OFF
SET IDENTITY_INSERT [dbo].[tbl_order] ON 

INSERT [dbo].[tbl_order] ([id], [date], [totalPrice], [status], [userId], [approveder_id], [description], [fullname], [address], [phone]) VALUES (99999, CAST(N'2018-03-12T11:35:32.740' AS DateTime), 100000, 5, N'ngoc', N'admin', NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_order] ([id], [date], [totalPrice], [status], [userId], [approveder_id], [description], [fullname], [address], [phone]) VALUES (100000, CAST(N'2018-03-12T11:35:53.790' AS DateTime), 270000, 2, N'ngoc', N'admin', NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_order] ([id], [date], [totalPrice], [status], [userId], [approveder_id], [description], [fullname], [address], [phone]) VALUES (100001, CAST(N'2018-03-12T11:36:11.357' AS DateTime), 150000, 4, N'ngoc', N'admin', NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_order] ([id], [date], [totalPrice], [status], [userId], [approveder_id], [description], [fullname], [address], [phone]) VALUES (100002, CAST(N'2018-03-18T09:11:00.527' AS DateTime), 780000, 1, N'ngoc', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_order] ([id], [date], [totalPrice], [status], [userId], [approveder_id], [description], [fullname], [address], [phone]) VALUES (100003, CAST(N'2018-03-18T09:15:36.687' AS DateTime), 780000, 1, N'ngoc', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_order] ([id], [date], [totalPrice], [status], [userId], [approveder_id], [description], [fullname], [address], [phone]) VALUES (100004, CAST(N'2018-03-18T09:19:51.550' AS DateTime), 780000, 5, N'ngoc', NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[tbl_order] ([id], [date], [totalPrice], [status], [userId], [approveder_id], [description], [fullname], [address], [phone]) VALUES (100007, CAST(N'2018-03-25T09:16:48.220' AS DateTime), 527000, 2, N'ngoc', NULL, NULL, N'ngoc nguyen', N'132acv                                                                                                                                                                                                                                                    ', N'123456')
INSERT [dbo].[tbl_order] ([id], [date], [totalPrice], [status], [userId], [approveder_id], [description], [fullname], [address], [phone]) VALUES (100008, CAST(N'2018-03-25T09:17:52.930' AS DateTime), 527000, 3, N'ngoc', NULL, NULL, N'ngoc nguyen', N'132acv                                                                                                                                                                                                                                                    ', N'123456')
SET IDENTITY_INSERT [dbo].[tbl_order] OFF
SET IDENTITY_INSERT [dbo].[tbl_order_status] ON 

INSERT [dbo].[tbl_order_status] ([order_statusId], [name]) VALUES (1, N'not approve')
INSERT [dbo].[tbl_order_status] ([order_statusId], [name]) VALUES (2, N'approved')
INSERT [dbo].[tbl_order_status] ([order_statusId], [name]) VALUES (3, N'shipping')
INSERT [dbo].[tbl_order_status] ([order_statusId], [name]) VALUES (4, N'received')
INSERT [dbo].[tbl_order_status] ([order_statusId], [name]) VALUES (5, N'cancel')
SET IDENTITY_INSERT [dbo].[tbl_order_status] OFF
INSERT [dbo].[tbl_order_voucher] ([voucherId], [orderId]) VALUES (N'DAN001', 99999)
INSERT [dbo].[tbl_order_voucher] ([voucherId], [orderId]) VALUES (N'DAN001', 100001)
INSERT [dbo].[tbl_order_voucher] ([voucherId], [orderId]) VALUES (N'DAN1111', 100007)
INSERT [dbo].[tbl_order_voucher] ([voucherId], [orderId]) VALUES (N'DAN1111', 100008)
INSERT [dbo].[tbl_orderdetail] ([orderId], [productId], [quantity], [size], [color]) VALUES (100004, 100001, 2, NULL, NULL)
INSERT [dbo].[tbl_orderdetail] ([orderId], [productId], [quantity], [size], [color]) VALUES (100004, 100004, 3, NULL, NULL)
INSERT [dbo].[tbl_orderdetail] ([orderId], [productId], [quantity], [size], [color]) VALUES (100007, 100005, 1, N'', NULL)
INSERT [dbo].[tbl_orderdetail] ([orderId], [productId], [quantity], [size], [color]) VALUES (100007, 100018, 3, N'', NULL)
INSERT [dbo].[tbl_orderdetail] ([orderId], [productId], [quantity], [size], [color]) VALUES (100008, 100005, 1, N'', NULL)
INSERT [dbo].[tbl_orderdetail] ([orderId], [productId], [quantity], [size], [color]) VALUES (100008, 100018, 3, N'', NULL)
SET IDENTITY_INSERT [dbo].[tbl_post] ON 

INSERT [dbo].[tbl_post] ([postId], [title], [postContent], [timePost], [userId]) VALUES (9, N'Summer Collection', N'<p style="text-align: center;"><font color="#000000">Summer Collection</font></p><p style="text-align: center;"><font color="#000000"><b>FOR KID</b></font></p><p style="text-align: center;"><img src="https://ae01.alicdn.com/kf/HTB1X95VKpXXXXbraXXXq6xXFXXXh/baby-girl-dress-european-style-girls-cotton-frock-designs-fancy-infant-girl-dresses-summer-princess-wedding.jpg" style="width: 800px;"><font color="#000000"><b><br></b></font></p><p style="text-align: center;"><img src="https://www.dhresource.com/0x0s/f2-albu-g4-M01-67-79-rBVaEFdzU0GAWAAhAAladCFbBq8518.jpg/flower-girls-dresses-summer-2016-floral-print.jpg" style="width: 1000px;"><font color="#000000"><b><br></b></font></p><p style="text-align: center;"><img src="https://ae01.alicdn.com/kf/HTB1elxLRXXXXXXbXVXXq6xXFXXXI/Tomilee-Girls-Party-Fashion-Dresses-2017-Baby-Girl-Summer-Princess-Cute-Dress-Little-Girl-Red-White.jpg" alt="Related image"><font color="#000000"><b><br></b></font></p><p style="text-align: center;"><img src="https://ae01.alicdn.com/kf/HTB1p4rKRXXXXXcgaFXXq6xXFXXXo/Kid-Little-Girls-Dresses-2017-New-Brand-Summer-Holiday-Wear-White-Children-Sports-Clothing-Princess-Dress.jpg_640x640.jpg" alt="Related image"><font color="#000000"><b><br></b></font></p><p style="text-align: center;"><font color="#000000"><b><br></b></font></p><p>&nbsp; &nbsp;&nbsp;</p><p><font color="#000000"><br></font></p><p><font color="#000000"><br></font></p><p><font color="#000000"><br></font></p><p style="text-align: center; margin-left: 25px;"><br></p><p><font color="#000000"><br></font></p>', CAST(N'2018-03-25T20:30:45.760' AS DateTime), N'admin')
INSERT [dbo].[tbl_post] ([postId], [title], [postContent], [timePost], [userId]) VALUES (12, N'Nice Shoes For You', N'<p style="text-align: center; "><b><span style="font-size: 24px; color: rgb(0, 0, 0);">Nice Shoes For You</span></b><br></p><p style="text-align: center; ">Comfortable with you choices<img src="https://sneakernews.com/wp-content/uploads/2015/12/best-shoe-2015-chicago.jpg" style="width: 940px;"></p><p style="text-align: center; "><img src="https://www.runnersworld.com/sites/runnersworld.com/files/styles/listicle_slide_custom_user_phone_1x/public/brooks_ravenna_m_400.jpg?itok=0-T4-LRj" style="width: 400px;"></p><p style="text-align: center; "><img src="data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxMSEhUQEhIVFRUVFRUVFRUVGBUVFRUVFRUWFhUVFRUYHSggGBolHRUVITEhJSkrLi4uFx8zODMtNygtLisBCgoKDg0OFQ8QFysdHR0tLSstLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0rKy0tLS0tLSstLSsrLS0tLS0tLf/AABEIAKoBKQMBIgACEQEDEQH/xAAcAAACAgMBAQAAAAAAAAAAAAACAwEEAAUGBwj/xABCEAACAQIDBQMIBwcCBwAAAAABAgADEQQhUQUSMUFhBhNxBxQiMoGRobEVQlJicoLwIzOissHR4dLxFhc0Q0Rzkv/EABgBAQEBAQEAAAAAAAAAAAAAAAABAgME/8QAHxEBAQEBAQACAgMAAAAAAAAAABEBAiEDMRJBEyJR/9oADAMBAAIRAxEAPwDz5ZIMG8i08z0GXkgxN7wghkahwMmLVDCAkIYJN4AhCFgg0LegAQwkgwNJDTCky0Knfhb0gLMCSKLfgsbwxTGszcgJsZm8Y0iSLaQFBzCFQxmWkEoIRKvCtEkWmCpKQwwCYQN5BWAp84smOKmQUgVmggRzLFkQGIMphiOEkVTLUhpgkSZBMrJRQaRdSnlcRxgM+glC0iWXOWLWEURCBIyid3rHFuUCxlFpTDkAQ7TKh3YaQgISyKGFYSdy8IUpFCEjFpw0QwhTMKgJCCQwh1jBTgI3RCCCO7qEKMgSKYhCnHinCFOFVu7kd2Zb7qSKchVPujMFEy6acjcgqoaMHclzuzBNIwKZWLalpLpowO5MoqBSIwVNY40zBNM6QB70TN9dZHdwe6hIkqIvuRCNPpBFOUQaIizQEcafSC1OEI7oayCojTTEWxWVCzaAzaQmI0MG+glAFYttB745osmVC2W0zehGDu9JUXQsICDvTN+QNCwgkUHMIN1kaPUQxK4jFEhDQ4k98IsU4xaQ0kWJ78aSRWJ5SQg0jlEilio2kMO2kYFhhYCQWhgGNCwt2FIIOsgX6yzuSQkgSoPWYSZY3Zm7Ar7zaRdbE7gu1h48/AQto4xaK7zceQ5k/wBus4TEY561ZWYnNgAOQFxkBOnHH5euffecu4SsWF1sR0kd42gnK4baTUahZc1J9JDwPhoes63CV1qqHQ3B94PMHrJ3xvK8d50X3jaSDUbSWjTgmnMtqprHSR3nSWTTg7kIQX6RbFpZKQSsIpsG1gbp53l0iLIlKrbkgpHOYh5ULcgRRfpGkRbShRF4siWSsWVhCOEneksIO7KiwAYxRMAjFEioAjFWYBDUSKJUh7khTDEiiVYxRAAjFgGIYEEQxICAhgQQIQEKILJtIAMMLIF1C2SopZmYKijMsxyAA5zS4rG1qbsrXVlYqym1wwNiCDOx7Mgs1Z6NjXpFFRTYbqMG7yqC2WR3V6C+s53tttahia6vSXNUVKta9hXZeNQJawXjZuYtllPTxxk9cO+9vgMHtlGyf0T9r6v+JYxW0qaIX3g2gUgknTpOIr1t9t31Vz00JAzyzIAudYpzuEgNcDmOB6XGRj+LKfy7BbY2g1RiWOenIDQRGBW37U8rhera+A+dpG+pN90H9aCZUqE/If2AnWOdQWvNjsfGPRJcA93cLUyO7nfdz5NkbazXWy6zcbF2nTWm9CsoINyjEXCMw3WuOeVrHOx8ZOs8M2eusVwRcHI5iAx6xeycGwwtKqwIDtU7oN65oqV3KhtyJYr13csobJ0nj65mx6+duUJeCGk1FiwJGjwbwWEWDaZvmVlJi2Iks0TuypAuRFmMaLaADQIRkASoAxbRrRTTSFFbmFMHGTCDWpDDxIQwxI0crRgMSkYBIp14aRSRotIGqY1W6xCxigQpu91hBusWFkhZA8PDDRAWGohTwYvGVyiM4t6IvnkLSZpdt4jebcClk3fStfjyAA9bj85rjLrPezGqfbzbzd2Su+GVmuVDK2TLlyI5GVsZXZQLBTfiLWt8Y8VHY/uyByuoJ92VvdKwr1FYEiw0C7twDmOHDlPU8qrvBh6tmvla9rWN7562+MubW2YaCpvsN5hcpzW+vw8IOGxBpOKiqpZTvBT6txw4Hl8x0lTEYh6rmpUN2b4DkB0lQsAaQzaCYVOmzlURSzMQqqoLMzHIAAcT0gLqNOy2H2WFIpVxlMvVcb1DA8He/CpiT/2qI0ObfA7js72Y81YEqtbHZWGT0MGx4FzwqYgcd0ZLxPK/ebH2DTw96jMalZvSqVnN2ZuZJP6Aga1NgVHp1Kldw1d0FyBuou5nTpov1aa5gD7xJzM5DeM6/bm3t4GlS9Xgz6jmF6dZyOIxlEGzOoOgNz7lvPN8k63x6Pj/AK56FzlnFgyzR7txdWDDob28dIwIJzjrVI0zANM6S+wimEJVJkOkFqZlposypVVkMW2UtNKr8ZQswZLSIEGJaNaJeaZCBnJkLJhDwIPddYQhgQBFLrCCHWGBCBEi0sG0YtWA7iCpk1rFpW6RyGU1JlimZFPDQgYsGFIHLGAdYhRGKYUdepuozHMBWNtbAm04FVfMl2F72G8TYcs7zs9q47uqZPNrhR8zbQf2nHO87/FnmuHy76UCeDG4PPgQY8GwAuMr2va9za5PMnh7oi95ii3CdXE0kch7/wDP9hBYnlb4/wB5F5uNhbBqYkNU3lo0KZ/a4mqd2jT6A8XfRFzOXDjKNbs7AVcRUWjQpmpUc+ii3v1JN7ADmxyHOeq9jeyy0Tu0WDVs1rYxcwt8moYIkceIav4hc77ux7N9lx3fd0qb0MOwBqNUG7i8aBwNW2dDD8xSFi3Pib9gtSjhaZZhuqg+qCTlkFRFzJ5BRAT9G0sNSuAFCjT4AcST7zOI2k21sYxTDbPZKN7B67LTDfeZSRl0BM7T/jHD0B3uJqAVGzSglnakvIMVveofrEXA4DgS3M7R8rTZ91SyB4my/wCr5CY665+tb556+8UF8kOOri+Jx9NL8aVOm9SmOVs2S8Kr5FawFkx1Mjkpoug+FRre6K/5r4i/qDX1ly8T3eXumxwPlbOXeUmz03W6fcjO+V3jpzWI8le1MO3e0RSqkcqdZrkdVqqo9mck4esgtXoVKDjIiopUX+6xyYdQTPTNl+UTCVrAvuHhn6Pu37X9l50tLFU6osGDAjNTzHVTyk65zo53eXhTRTT1jbHYnC1bsg7l9afqX60zl/8ANp59t7s7WwubqGS+VRc16X5qfH2XnHrjcdc7zWkaLaMMWxmVVqzGJMdWMURKpbRbWhssFhKhbRTRjRRlRgmWgrJlRIqmGHOsWrQgZAYvrJ3ZCmMBhWKsYqTFaGGki0SiMUGLV41akkWjUmMBMAVYYqSFELzKtXcBZsgMzC73K85za20d87o9UcOp1muefy1OupiptLFmqxY8OAGglEw2MC1/l7dJ6cyPNvrI3DUGqOtNFZ3Y2VVBLMdAozM7bsp5LcXirVKw81onPeqD9qw+5S4+1re2ew9nezmD2am7h6fpkWaq9mrP4t9UfdWwlR5/2Q8kh9GttE2GRGGQ+kf/AHVB6v4V9/KekVVpqi0adNFSnbcRVARLcCq6jWMrVi057b/aSjhbqTv1Lfu1zI/GeC/PpJVja7R2zTw9JqtZgAOfN2NzYDmeOU8g7T9pcTiqha5SmMlpoxG6D9sg5txB5aalO2Ns1cTU7x213FzC01tyGtweOfuEpU24WvYWCj2escssuRyuttZx773Xo44zPVEEn2/LqOeXykgcPh/U8PA+zpL5oqfhmPrNfw4XsbjW8U+GI05XOWXGy+PEW9ms511iqQOZy552LGxvnfMc5hQ36/Wy4DIEWz5W4dBG24W/KPYcyL+Pu6QSotqBzz9I2BHUZZf7xUhIuOF9ABzIHErlf9aTabK2/Xw/7uod0G5sbpzt6HLha4tNey+w6nLdFju5gZadOHOAbezkDxNyAeedj/aWpuPW+zHlHWpaniBYmwDctOeY8D7zOyxGIVlzsysDxzBB4ggz5xsb9eLHgRw3hwsf68J6B2L7RM6Gg5JKi6k8So4jxGXs8DOvPf61x74/eB7U7JWi+/S/dseHHcb7N9NPdOfYzqdt4wMjJxuP8icmzTHfM3xedueheJZYxmiyZlosmKYxlRsohmlAtAJkloDNCBaRvSHMDelG6XZPjDGyeh987BNm9JYp7JhHFLsnxhjZPjO7p7G6S3S2IIHni7I8Y1djnrPSE2IJYp7CWFeZjYp6/r2Ri7DPWeoU9iLpLCbGXQRErysbBbrD/wCH26z1ddjrpGrshdIhXgPag9ye5BO9YFugPAf19052jTeowRFZ3PBEUs58FW5M+idqditnPVOIq4UvUNr3qVQh3VCj0A27wA5S3gO5w67mHo06K6UkVL+JAufbO2TMctu68k7O+SfGV7PiCuFpnP0/TrEdKQPo/mIPSeodneyGB2fZqVLeqjjWq2er+XKyflAmxOKJ6TEpFjzJlpDq2NZuHv8A8xD+iN5j7sz7BL6YGwuxA/WsrYnGYWn+8xFFfxOl/nM7q5jmtu4jE1KVRaIan6N1I9drcQSOFxfhztnnPJKjnhkWzPpG13uOGWed8xnbxnuGI7TbPTjiEP4AzfITzntdQweIqmphahps194OAtMk2zUqxIJ8PaJz310z6jjqjC17i17GxXPK9hqOB/QhK+edgcrnkuXqjO4N8rdbay4Ni1fWG7YcDv07DqT3lr+PTSDTwtBLd7iaQt9VG797gaIdz3vH41rOsxOHN7W0FhoM8+PG18xpfSWFHDmMrfePM8cxwP8AuZNLa2DThSq1OrVaVL+EU3+csJt3BH1qFVOq1aVX+EpT/mmN41vPkxWahfj03jnkTfIDlmOI+QlWphTkQM7XA+yCLg7xHIg8fGbinTw1UgUMTTJyApVbUWucst/0WPDIVGOQy1RjMG9MlKqMptd7j0muLEWKi4vY3sL8dBMTcbzrNaV6dug58iczfLQE/Hrms3v15gfVtbeFr5G2fTxm1c3PK/G31UFxvXzups178r3zJzqMgte+QsLm532AUixuSARr4nMgFTcUguXQWtzBYAWPC4BEubHrmlWRxe4INuW7kCvTLeFusjzQ8bZ2HHLdHFcyMyJ1XZXsdVqOtR0KoCGO8LF+BsBxC3GbH2X5bxjrxdxOz/TfmATb+gmpbYp0Pvnp9PYwFy2bE3Og6CC+yhpNa5PLW2R0MU2yOh989OqbMGkrVNmDSB5q2yuh98U2yuk9GqbL6StU2YNIHnp2UPs/OAdmDSd5U2f0lWrgBpA4o7NH2YP0cPszrnwXSK80ijsqVMdJcpIJokxvWWqWM8PbIreUkH6Et0gs0VLGDWW6W0RKjd0wI9QJpV2j1Hvjk2iJakbhVEYoE1K4+MXHdZaNssNRNUMZ1hrjBrLUicZiTvFe5qWH1gu+p8Ny5HttOa2vtenSz7rEufs08NXa/wCbcC+8zqVxo1jFxkUeV4/tjizcUMDWT71SjWZvYoWwPiWmobau1qmVsYOiU6yfyKJ7eMd1hDG9YHg9TYu0a2b4bFOdXp1T/MI6j2L2ieGEceO4v8zCe6eeCZ56ImF14vR8nu0m40Av4qlL+jGX6Hksxx9Z8Oo6u5PwT+s9Z88Ew4wRMLrznC+SRr3q4xR0SmSfYzMPlN5g/Jjgk/eNWq/ifdHupgfOdT56NRBbGDWPE9ayn2J2eosMJS/NvMfexJlfEdgNnN/4yj8L1V+Aa03Bxi6wTjV1jxfXMYnyX7PbICovgwP8ymTR7ArTXu6eKrd2LWpVlp1qYtwCqwG5+W06JscusWccNTIOWxHk7Rr+kt/uqyeyzM+gmvreTx1zRadQ6PXemP4KF/jO389GsWcd1jxbv+vPqvZjatP/AKahgqWjo/eVRrapXXL2AR+GxO36Is1CjVHPe7q59tJ1z9k7VtodYlto9YPXP0O020b2qbJY9Uq/6kt/FN9gMc1QXqYapQOlRqTX8O7dvjaKfaHURD7QGokqthUYfo/4lV3EpPjxqJXfGDWQXKrCVKrDT5yu2MGsr1MWNYDKrDQypUI0P69sCpiOsq1K/WRRVfA/r2xNvu/GLesdYvvjrAGni/GPTFdZoBixDXGdZqM10K4wxy44zmxixrDGJ6xCulTaB5GNTaR1nMLjLQxtCIOpXaJjV2kdZygxnWEMfbnA65dpHWNXafWcimPjBjohXXrtPrGLtOcYcedZK7ROsDtRtPxhjafWcYu04wbT6wOw+lJn0t1M5EbT6yfpL70qV1v0r1kNtQfa+M5P6R6yDj+sRa6dtq9fjA+lzOYbH9YBxvWSFdQdrmA22DOXOPgnHwOmba51kfSx1+M5c4+AcdIrp22r1gHafWcwcdBOMMDpW2lFHaE5xsWYs4qB0Zx56xbY4znWxRgnFyxK6BsaYlsYZpPO4BxcQrdNi4o4rrNOcR4xZxHjEK274rrFNius1JxMBsTEK2jYnrA866zUtiYPnMsSkCvDFeUQYYM0lXhXkHFSjeEZCryYkQxidJrZgMDZDFQxjBNcphXgbEYzrC87Os1JmAwNsMWYXnZmsBhgwVsRizC86M1t5hMQrZed9ZHnc1d5hMRW0GMmeeTWAybxCtj55IOMmtJg3hGzOLg+dzXgyLwNl50NZnnA1mskiBsDiOszzmUDJEqVe84gnEGU7yIFw4iCcRKZMAmBcNeCa8qRV5FXzXgmtKQMgmBcNWLNUSsDIMosGoIPeCImQj//2Q==" style="width: 297px;"><img src="https://ugc.nikeid.com/is/image/nike/ugc/355736258.tif?$DESKTOP_ID_PREBUILD$" style="width: 1000px;"><br></p><p style="text-align: center; "><br></p><p style="text-align: center; "></p><p style="text-align: center; "><br></p><p style="text-align: center; "><br></p>', CAST(N'2018-03-25T20:30:15.383' AS DateTime), N'admin')
INSERT [dbo].[tbl_post] ([postId], [title], [postContent], [timePost], [userId]) VALUES (13, N'Summer Clothe for Vacation', N'<div style="text-align: center;"><b><span style="font-size: 24px;">You have a vacation on beach this summer?</span></b></div><div style="text-align: center;"><span style="font-size: 24px;">Choose some suitable clothe yourself</span></div><div style="text-align: center;"><img src="http://fashioninbox.com/wp-content/uploads/2015/07/Latest-Printed-Summer-Clothing-For-Beach-Wear-2015-14.jpg" style="width: 821px;"><span style="font-size: 24px;"><br></span></div><div style="text-align: center;"><img src="https://cdn.shopify.com/s/files/1/1131/7472/products/Screen_Shot_2016-05-21_at_8.36.46_PM_1024x1024.png?v=1501819970" style="width: 518px;"><span style="font-size: 24px;"><br></span></div><div style="text-align: center;"><img src="https://swimwear365.scene7.com/is/image/OttoUK/466w/black-&amp;-white-printed-beach-dress-by-bpc-selection~921295FRSP.jpg" style="width: 466px;"><span style="font-size: 24px;"><br></span></div><div style="text-align: center;"><img src="https://www.dhresource.com/0x0s/f2-albu-g3-M00-2A-33-rBVaHFU2-76AUJjSAANGi6k-bHQ093.jpg/2015-summer-korean-chiffon-dress-summer-beach.jpg" style="width: 790px;"><span style="font-size: 24px;"><br></span></div><div style="text-align: center;"><span style="font-size: 24px;"><br></span></div>', CAST(N'2018-03-25T20:30:28.940' AS DateTime), N'admin')
SET IDENTITY_INSERT [dbo].[tbl_post] OFF
SET IDENTITY_INSERT [dbo].[tbl_product] ON 

INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (99999, N'áo thun', N'yame', 70000, N'Việt Nam', N'áo làm bằng thun', N'thun', 1, 5, CAST(N'2018-02-28T00:00:00.000' AS DateTime), N'áo thun ngắn T-shirt ao thun ngan', 1)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100001, N'váy', N'yame', 120000, N'Việt Nam', N'váy dài dài', N'vải', 3, 8, CAST(N'2018-03-01T00:00:00.000' AS DateTime), N'váy skirt vay', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100004, N'quần dài', N'hihi', 180000, N'America', N'quần tây', N'kaki', 5, 2, CAST(N'2018-03-02T00:00:00.000' AS DateTime), N'quần tây quan tay ', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100005, N'áo voan', N'blue', 200000, N'Korean', N'áo', N'voan', 1, 3, CAST(N'2018-03-02T10:55:53.547' AS DateTime), N'áo ao ', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100006, N'áo sơ mi', N'white', 300000, N'Việt Nam', N'áo sơ mi', N'sơ mi', 1, 0, CAST(N'2018-03-09T22:25:48.410' AS DateTime), N'áo sơ mi ao so mi viet tien Việt Tiến', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100007, N'ADIDAS ULTRA BOOST 4.0 - GREY/BLUE', N'ADIDAS', 179000, N'Vietnam', N'payment

Reference  CP9249

- adidas Ultra Boost 4.0

- Chalk White/Chalk Pearl-Carbon

- Style Code SKU: CP9249

- Spring/Summer 2018', N'', 15, 99, CAST(N'2018-03-24T18:36:40.967' AS DateTime), N'ADIDAS, ULTRA, BOOST , ADIDAS ULTRA BOOST ', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100008, N'NEW BALANCE OM576 OGG - 30TH ANNIVERSARY', N'NEW BALANCE ', 149000, N'England', N'payment

Reference  617181-60-12

- New Balance OM576 OGG

- 30th Anniversary

- Made in England

- Grey/Navy

- Spring/Summer 2018', N'', 15, 99, CAST(N'2018-03-24T19:17:18.567' AS DateTime), N'NEW, BALANCE, OM576, OGG, 30TH ,ANNIVERSARY, NEW BALANCE OM576 OGG - 30TH ANNIVERSARY', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100009, N'NEW BALANCE MS574 DOA - BLACK', N'NEW BALANCE', 129000, N'Brazil', N'payment

Reference  633871-60-8

- New Balance MS574 DOA

- Black

- Spring/Summer 2018', N'', 15, 99, CAST(N'2018-03-24T19:24:14.977' AS DateTime), N'NEW, BALANCE, MS574, DOA, BLACK, NEW BALANCE MS574 DOA - BLACK', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100010, N'ADIDAS ULTRA BOOST CLIMA - CARBON', N'ADIDAS', 219000, N'Vietnam', N'Reference  CQ0022

- adidas Ultra Boost Clima

- Carbon/Carbon-Orchid Tint

- Style Code SKU: CQ0022

- Spring/Summer 2018', N'', 15, 99, CAST(N'2018-03-24T19:27:43.143' AS DateTime), N'ADIDAS ULTRA BOOST CLIMA - CARBON, ADIDAS, ULTRA, BOOST, CLIMA,CARBON', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100011, N'NIKE AIR MAX PLUS PARIS - HYPER BLUE/TOTAL ORANGE', N'NIKE', 170000, N'Vietnam', N'Reference  AJ6301-400

Nike is celebrating the Air Max Day in France with a release of an exclusive Nike TN. This Nike Air Max Plus PARIS will only release through a raffle. Enter the draw before Saturday. Winners will be reached by email on March 24th.', N'', 15, 99, CAST(N'2018-03-24T19:32:38.800' AS DateTime), N'NIKE AIR MAX PLUS PARIS - HYPER BLUE/TOTAL ORANGE,NIKE, AIR, MAX ,PLUS ,PARIS,HYPER ,BLUE,ORANGE', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100012, N'PUMA PREVAIL OG - WHITE/OCEAN', N'PUMA', 109000, N'US', N'Reference  364106-03

- Puma Prevail OG 

- Puma Black/Puma White-Ocean

- Style Code SKU: 364106-03

- Spring/Summer 2018', N'', 15, 99, CAST(N'2018-03-24T19:35:42.507' AS DateTime), N'PUMA PREVAIL OG - WHITE/OCEAN,PUMA, PREVAIL, OG ,WHITE,OCEAN', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100015, N'NEW BALANCE OM576 OGG - 30TH ANNIVERSARY', N'NEW BALANCE ', 149000, N'England', N'payment

Reference  617181-60-12

- New Balance OM576 OGG

- 30th Anniversary

- Made in England

- Grey/Navy

- Spring/Summer 2018', N'', 15, 99, CAST(N'2018-03-24T19:17:18.567' AS DateTime), N'NEW, BALANCE, OM576, OGG, 30TH ,ANNIVERSARY, NEW BALANCE OM576 OGG - 30TH ANNIVERSARY', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100016, N'NEW BALANCE MS574 DOA - BLACK', N'NEW BALANCE', 129000, N'Brazil', N'payment

Reference  633871-60-8

- New Balance MS574 DOA

- Black

- Spring/Summer 2018', N'', 15, 99, CAST(N'2018-03-24T19:24:14.977' AS DateTime), N'NEW, BALANCE, MS574, DOA, BLACK, NEW BALANCE MS574 DOA - BLACK', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100017, N'NIKE AIR MAX PLUS PARIS - HYPER BLUE/TOTAL ORANGE', N'NIKE', 170000, N'Vietnam', N'Reference  AJ6301-400

Nike is celebrating the Air Max Day in France with a release of an exclusive Nike TN. This Nike Air Max Plus PARIS will only release through a raffle. Enter the draw before Saturday. Winners will be reached by email on March 24th.', N'', 15, 99, CAST(N'2018-03-24T19:32:38.800' AS DateTime), N'NIKE AIR MAX PLUS PARIS - HYPER BLUE/TOTAL ORANGE,NIKE, AIR, MAX ,PLUS ,PARIS,HYPER ,BLUE,ORANGE', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100018, N'PUMA PREVAIL OG - WHITE/OCEAN', N'PUMA', 109000, N'US', N'Reference  364106-03

- Puma Prevail OG 

- Puma Black/Puma White-Ocean

- Style Code SKU: 364106-03

- Spring/Summer 2018', N'', 15, 93, CAST(N'2018-03-24T19:35:42.507' AS DateTime), N'PUMA PREVAIL OG - WHITE/OCEAN,PUMA, PREVAIL, OG ,WHITE,OCEAN', 0)
INSERT [dbo].[tbl_product] ([productId], [name], [brand], [price], [country], [description], [material], [categoryID], [quantity], [lastModified], [tag], [deleted]) VALUES (100019, N'Áo dài hoa sen', N'Haven', 350000, N'Việt Name', N'', N'', 3, 5, CAST(N'2018-03-25T10:16:44.767' AS DateTime), N'áo,dài,ao,dai,viet,việt,nam,thanh,nha,nhã,hoa,sen,xanh,trang,trắng', 0)
SET IDENTITY_INSERT [dbo].[tbl_product] OFF
SET IDENTITY_INSERT [dbo].[tbl_product_color] ON 

INSERT [dbo].[tbl_product_color] ([id], [productId], [color]) VALUES (1, 99999, N'1')
INSERT [dbo].[tbl_product_color] ([id], [productId], [color]) VALUES (2, 99999, N'2')
INSERT [dbo].[tbl_product_color] ([id], [productId], [color]) VALUES (3, 99999, N'4')
INSERT [dbo].[tbl_product_color] ([id], [productId], [color]) VALUES (4, 99999, N'5')
INSERT [dbo].[tbl_product_color] ([id], [productId], [color]) VALUES (5, 100001, N'5')
INSERT [dbo].[tbl_product_color] ([id], [productId], [color]) VALUES (6, 100001, N'6')
INSERT [dbo].[tbl_product_color] ([id], [productId], [color]) VALUES (7, 100001, N'7')
SET IDENTITY_INSERT [dbo].[tbl_product_color] OFF
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (1, 99999, 50000, 1)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (1, 100001, 20, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (1, 100004, 15, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (1, 100015, 10, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (4, 99999, 30, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (4, 100001, 50, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (4, 100007, 2, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (4, 100010, 0, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (5, 100015, 20, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (5, 100016, 20, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (5, 100017, 20, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (8, 100004, 20, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (8, 100015, 10, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (8, 100017, 10, 0)
INSERT [dbo].[tbl_product_deal] ([dealId], [productId], [discount], [type]) VALUES (8, 100019, 100000, 1)
SET IDENTITY_INSERT [dbo].[tbl_product_size] ON 

INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (1, 99999, N'S')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (2, 99999, N'M')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (3, 99999, N'L')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (4, 99999, N'XL')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (8, 100001, N'38')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (9, 100001, N'39')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (10, 100001, N'40')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (11, 100007, N'41')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (12, 100007, N'42')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (13, 100007, N'43')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (14, 100007, N'45')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (15, 100008, N'42')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (16, 100008, N'43')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (17, 100008, N'44')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (18, 100008, N'45')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (19, 100009, N'42')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (20, 100009, N'43')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (21, 100009, N'44')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (22, 100009, N'45')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (23, 100010, N'40')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (24, 100010, N'41')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (25, 100010, N'42')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (26, 100010, N'43')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (27, 100010, N'44')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (28, 100010, N'456')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (29, 100010, N'46')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (30, 100011, N'41')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (31, 100011, N'42')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (32, 100011, N'43')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (33, 100011, N'44')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (34, 100011, N'45')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (35, 100012, N'41')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (36, 100012, N'42')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (37, 100012, N'43')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (38, 100012, N'44')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (39, 100012, N'45')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (40, 100016, N'38')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (41, 100016, N'39')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (42, 100016, N'40')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (43, 100016, N'41')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (44, 100016, N'42')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (45, 100019, N'S')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (46, 100019, N'M')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (47, 100019, N'L')
INSERT [dbo].[tbl_product_size] ([id], [productId], [size]) VALUES (48, 100019, N'XL')
SET IDENTITY_INSERT [dbo].[tbl_product_size] OFF
SET IDENTITY_INSERT [dbo].[tbl_role] ON 

INSERT [dbo].[tbl_role] ([roleid], [name]) VALUES (1, N'admin')
INSERT [dbo].[tbl_role] ([roleid], [name]) VALUES (2, N'staff')
INSERT [dbo].[tbl_role] ([roleid], [name]) VALUES (3, N'user')
SET IDENTITY_INSERT [dbo].[tbl_role] OFF
INSERT [dbo].[tbl_size] ([id], [name]) VALUES (N'1', N'S')
INSERT [dbo].[tbl_size] ([id], [name]) VALUES (N'10', N'41')
INSERT [dbo].[tbl_size] ([id], [name]) VALUES (N'11', N'X')
INSERT [dbo].[tbl_size] ([id], [name]) VALUES (N'2', N'M')
INSERT [dbo].[tbl_size] ([id], [name]) VALUES (N'3', N'L')
INSERT [dbo].[tbl_size] ([id], [name]) VALUES (N'4', N'XL')
INSERT [dbo].[tbl_size] ([id], [name]) VALUES (N'5', N'XXL')
INSERT [dbo].[tbl_size] ([id], [name]) VALUES (N'6', N'XXXL')
INSERT [dbo].[tbl_size] ([id], [name]) VALUES (N'7', N'38')
INSERT [dbo].[tbl_size] ([id], [name]) VALUES (N'8', N'39')
INSERT [dbo].[tbl_size] ([id], [name]) VALUES (N'9', N'40')
INSERT [dbo].[tbl_user] ([userId], [password], [email], [fullname], [address], [phone], [gender], [role], [date_reg], [expired]) VALUES (N'admin', N'123', N'admin@admin', N'the admin', N'abc                                                                                                                                                                                                                                                       ', N'132465798', 1, 1, CAST(N'2018-02-05T00:00:00.000' AS DateTime), 0)
INSERT [dbo].[tbl_user] ([userId], [password], [email], [fullname], [address], [phone], [gender], [role], [date_reg], [expired]) VALUES (N'dan', N'12345678', N'', N'', NULL, N'', NULL, 2, CAST(N'2018-03-25T12:33:26.530' AS DateTime), 0)
INSERT [dbo].[tbl_user] ([userId], [password], [email], [fullname], [address], [phone], [gender], [role], [date_reg], [expired]) VALUES (N'dat', N'12345678', N'', N'', NULL, N'', NULL, 2, CAST(N'2018-03-23T22:56:30.033' AS DateTime), 0)
INSERT [dbo].[tbl_user] ([userId], [password], [email], [fullname], [address], [phone], [gender], [role], [date_reg], [expired]) VALUES (N'ngoc', N'123', N'ngoc@com', N'ngoc nguyen', N'132acv                                                                                                                                                                                                                                                    ', N'123456', 2, 3, CAST(N'2018-02-15T06:48:50.240' AS DateTime), 0)
INSERT [dbo].[tbl_user] ([userId], [password], [email], [fullname], [address], [phone], [gender], [role], [date_reg], [expired]) VALUES (N'nn1', N'12345678', N'', N'', NULL, N'', NULL, 2, CAST(N'2018-03-25T12:35:18.967' AS DateTime), 0)
INSERT [dbo].[tbl_user] ([userId], [password], [email], [fullname], [address], [phone], [gender], [role], [date_reg], [expired]) VALUES (N'nn2', N'12345678', N'', N'', NULL, N'', NULL, 2, CAST(N'2018-03-25T12:35:43.910' AS DateTime), 0)
INSERT [dbo].[tbl_user] ([userId], [password], [email], [fullname], [address], [phone], [gender], [role], [date_reg], [expired]) VALUES (N'nng', N'12345678', N'', N'', NULL, N'', NULL, 2, CAST(N'2018-03-25T12:34:40.033' AS DateTime), 0)
INSERT [dbo].[tbl_user] ([userId], [password], [email], [fullname], [address], [phone], [gender], [role], [date_reg], [expired]) VALUES (N'teststaff1', N'Teststaff1234', N'staff1@staff', N'the staff one', N'adfdsf                                                                                                                                                                                                                                                    ', N'21231321', 1, 2, CAST(N'2018-02-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tbl_user] ([userId], [password], [email], [fullname], [address], [phone], [gender], [role], [date_reg], [expired]) VALUES (N'testuser', N'Testuser1234', N'user@user', N'the test user', N'adfafdadfda                                                                                                                                                                                                                                               ', N'2121213', 2, 3, CAST(N'2018-02-05T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[tbl_user] ([userId], [password], [email], [fullname], [address], [phone], [gender], [role], [date_reg], [expired]) VALUES (N'vyn', N'12345678', N'', N'', NULL, N'', NULL, 2, CAST(N'2018-03-25T12:32:45.487' AS DateTime), 0)
INSERT [dbo].[tbl_voucher] ([voucherId], [type], [discount], [description], [startTime], [duration], [quantity]) VALUES (N'D11A11N', 1, 10000, N'Giảm giá nhân dịp 1/4', CAST(N'2018-03-25' AS Date), 48, 10)
INSERT [dbo].[tbl_voucher] ([voucherId], [type], [discount], [description], [startTime], [duration], [quantity]) VALUES (N'DAN001', 1, 100000, N'Giảm giá trên cái loại áo thun', CAST(N'2018-03-14' AS Date), 72, 10)
INSERT [dbo].[tbl_voucher] ([voucherId], [type], [discount], [description], [startTime], [duration], [quantity]) VALUES (N'DAN002', 0, 50, N'Giảm giá nhân ngày quoc te phu nu', CAST(N'2018-03-16' AS Date), 72, 5)
INSERT [dbo].[tbl_voucher] ([voucherId], [type], [discount], [description], [startTime], [duration], [quantity]) VALUES (N'DAN1111', 1, 20, N'Giảm giá nhân dịp sinh nhật cửa hàng', CAST(N'2018-03-18' AS Date), 48, 8)
INSERT [dbo].[tbl_voucher_product] ([voucherId], [productId]) VALUES (N'DAN001', 99999)
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_principal_name]    Script Date: 3/25/2018 9:46:49 PM ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_comment] ADD  CONSTRAINT [DF_tbl_comment_time]  DEFAULT (getdate()) FOR [time]
GO
ALTER TABLE [dbo].[tbl_order] ADD  CONSTRAINT [DF_tbl_order_date]  DEFAULT (getdate()) FOR [date]
GO
ALTER TABLE [dbo].[tbl_post] ADD  CONSTRAINT [DF_tbl_post_timePost]  DEFAULT (getdate()) FOR [timePost]
GO
ALTER TABLE [dbo].[tbl_product] ADD  CONSTRAINT [DF_tbl_product_lastModified]  DEFAULT (getdate()) FOR [lastModified]
GO
ALTER TABLE [dbo].[tbl_product] ADD  CONSTRAINT [DF_tbl_product_deleted]  DEFAULT ((0)) FOR [deleted]
GO
ALTER TABLE [dbo].[tbl_user] ADD  CONSTRAINT [DF_tbl_user_date_reg]  DEFAULT (getdate()) FOR [date_reg]
GO
ALTER TABLE [dbo].[tbl_user] ADD  CONSTRAINT [DF_tbl_user_expired]  DEFAULT ((0)) FOR [expired]
GO
ALTER TABLE [dbo].[tbl_comment]  WITH CHECK ADD  CONSTRAINT [FK_tbl_comment_tbl_comment] FOREIGN KEY([parentId])
REFERENCES [dbo].[tbl_comment] ([id])
GO
ALTER TABLE [dbo].[tbl_comment] CHECK CONSTRAINT [FK_tbl_comment_tbl_comment]
GO
ALTER TABLE [dbo].[tbl_comment]  WITH CHECK ADD  CONSTRAINT [FK_tbl_comment_tbl_product] FOREIGN KEY([productId])
REFERENCES [dbo].[tbl_product] ([productId])
GO
ALTER TABLE [dbo].[tbl_comment] CHECK CONSTRAINT [FK_tbl_comment_tbl_product]
GO
ALTER TABLE [dbo].[tbl_comment]  WITH CHECK ADD  CONSTRAINT [FK_tbl_comment_tbl_user] FOREIGN KEY([authorId])
REFERENCES [dbo].[tbl_user] ([userId])
GO
ALTER TABLE [dbo].[tbl_comment] CHECK CONSTRAINT [FK_tbl_comment_tbl_user]
GO
ALTER TABLE [dbo].[tbl_image]  WITH CHECK ADD  CONSTRAINT [FK_tbl_image_tbl_post] FOREIGN KEY([postId])
REFERENCES [dbo].[tbl_post] ([postId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_image] CHECK CONSTRAINT [FK_tbl_image_tbl_post]
GO
ALTER TABLE [dbo].[tbl_image]  WITH CHECK ADD  CONSTRAINT [FK_tbl_image_tbl_product] FOREIGN KEY([productId])
REFERENCES [dbo].[tbl_product] ([productId])
GO
ALTER TABLE [dbo].[tbl_image] CHECK CONSTRAINT [FK_tbl_image_tbl_product]
GO
ALTER TABLE [dbo].[tbl_order]  WITH CHECK ADD  CONSTRAINT [FK_tbl_order_tbl_order_status] FOREIGN KEY([status])
REFERENCES [dbo].[tbl_order_status] ([order_statusId])
GO
ALTER TABLE [dbo].[tbl_order] CHECK CONSTRAINT [FK_tbl_order_tbl_order_status]
GO
ALTER TABLE [dbo].[tbl_order]  WITH CHECK ADD  CONSTRAINT [FK_tbl_order_tbl_user] FOREIGN KEY([userId])
REFERENCES [dbo].[tbl_user] ([userId])
GO
ALTER TABLE [dbo].[tbl_order] CHECK CONSTRAINT [FK_tbl_order_tbl_user]
GO
ALTER TABLE [dbo].[tbl_order]  WITH CHECK ADD  CONSTRAINT [FK_tbl_order_tbl_user1] FOREIGN KEY([approveder_id])
REFERENCES [dbo].[tbl_user] ([userId])
GO
ALTER TABLE [dbo].[tbl_order] CHECK CONSTRAINT [FK_tbl_order_tbl_user1]
GO
ALTER TABLE [dbo].[tbl_order_voucher]  WITH CHECK ADD  CONSTRAINT [FK_tbl_order_voucher_tbl_order] FOREIGN KEY([orderId])
REFERENCES [dbo].[tbl_order] ([id])
GO
ALTER TABLE [dbo].[tbl_order_voucher] CHECK CONSTRAINT [FK_tbl_order_voucher_tbl_order]
GO
ALTER TABLE [dbo].[tbl_order_voucher]  WITH CHECK ADD  CONSTRAINT [FK_tbl_order_voucher_tbl_voucher] FOREIGN KEY([voucherId])
REFERENCES [dbo].[tbl_voucher] ([voucherId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_order_voucher] CHECK CONSTRAINT [FK_tbl_order_voucher_tbl_voucher]
GO
ALTER TABLE [dbo].[tbl_orderdetail]  WITH CHECK ADD  CONSTRAINT [FK_tbl_orderdetail_tbl_color] FOREIGN KEY([color])
REFERENCES [dbo].[tbl_color] ([id])
GO
ALTER TABLE [dbo].[tbl_orderdetail] CHECK CONSTRAINT [FK_tbl_orderdetail_tbl_color]
GO
ALTER TABLE [dbo].[tbl_orderdetail]  WITH CHECK ADD  CONSTRAINT [FK_tbl_orderdetail_tbl_order] FOREIGN KEY([orderId])
REFERENCES [dbo].[tbl_order] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_orderdetail] CHECK CONSTRAINT [FK_tbl_orderdetail_tbl_order]
GO
ALTER TABLE [dbo].[tbl_orderdetail]  WITH CHECK ADD  CONSTRAINT [FK_tbl_orderdetail_tbl_product] FOREIGN KEY([productId])
REFERENCES [dbo].[tbl_product] ([productId])
GO
ALTER TABLE [dbo].[tbl_orderdetail] CHECK CONSTRAINT [FK_tbl_orderdetail_tbl_product]
GO
ALTER TABLE [dbo].[tbl_post]  WITH CHECK ADD  CONSTRAINT [FK_tbl_post_tbl_user] FOREIGN KEY([userId])
REFERENCES [dbo].[tbl_user] ([userId])
GO
ALTER TABLE [dbo].[tbl_post] CHECK CONSTRAINT [FK_tbl_post_tbl_user]
GO
ALTER TABLE [dbo].[tbl_product]  WITH CHECK ADD  CONSTRAINT [FK_tbl_product_tbl_category] FOREIGN KEY([categoryID])
REFERENCES [dbo].[tbl_category] ([id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[tbl_product] CHECK CONSTRAINT [FK_tbl_product_tbl_category]
GO
ALTER TABLE [dbo].[tbl_product_color]  WITH CHECK ADD  CONSTRAINT [FK_tbl_product_color_tbl_color] FOREIGN KEY([color])
REFERENCES [dbo].[tbl_color] ([id])
GO
ALTER TABLE [dbo].[tbl_product_color] CHECK CONSTRAINT [FK_tbl_product_color_tbl_color]
GO
ALTER TABLE [dbo].[tbl_product_color]  WITH CHECK ADD  CONSTRAINT [FK_tbl_product_color_tbl_product] FOREIGN KEY([productId])
REFERENCES [dbo].[tbl_product] ([productId])
GO
ALTER TABLE [dbo].[tbl_product_color] CHECK CONSTRAINT [FK_tbl_product_color_tbl_product]
GO
ALTER TABLE [dbo].[tbl_product_deal]  WITH CHECK ADD  CONSTRAINT [FK_tbl_product_deal_tbl_deal] FOREIGN KEY([dealId])
REFERENCES [dbo].[tbl_deal] ([id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_product_deal] CHECK CONSTRAINT [FK_tbl_product_deal_tbl_deal]
GO
ALTER TABLE [dbo].[tbl_product_deal]  WITH CHECK ADD  CONSTRAINT [FK_tbl_product_deal_tbl_product] FOREIGN KEY([productId])
REFERENCES [dbo].[tbl_product] ([productId])
GO
ALTER TABLE [dbo].[tbl_product_deal] CHECK CONSTRAINT [FK_tbl_product_deal_tbl_product]
GO
ALTER TABLE [dbo].[tbl_product_size]  WITH CHECK ADD  CONSTRAINT [FK_tbl_product_size_tbl_product] FOREIGN KEY([productId])
REFERENCES [dbo].[tbl_product] ([productId])
GO
ALTER TABLE [dbo].[tbl_product_size] CHECK CONSTRAINT [FK_tbl_product_size_tbl_product]
GO
ALTER TABLE [dbo].[tbl_rating]  WITH CHECK ADD  CONSTRAINT [FK_tbl_rating_tbl_product] FOREIGN KEY([productId])
REFERENCES [dbo].[tbl_product] ([productId])
GO
ALTER TABLE [dbo].[tbl_rating] CHECK CONSTRAINT [FK_tbl_rating_tbl_product]
GO
ALTER TABLE [dbo].[tbl_user]  WITH CHECK ADD  CONSTRAINT [FK_tbl_user_tbl_gender] FOREIGN KEY([gender])
REFERENCES [dbo].[tbl_gender] ([id])
GO
ALTER TABLE [dbo].[tbl_user] CHECK CONSTRAINT [FK_tbl_user_tbl_gender]
GO
ALTER TABLE [dbo].[tbl_user]  WITH CHECK ADD  CONSTRAINT [FK_tbl_user_tbl_role] FOREIGN KEY([role])
REFERENCES [dbo].[tbl_role] ([roleid])
GO
ALTER TABLE [dbo].[tbl_user] CHECK CONSTRAINT [FK_tbl_user_tbl_role]
GO
ALTER TABLE [dbo].[tbl_voucher_product]  WITH CHECK ADD  CONSTRAINT [FK_tbl_voucher_product_tbl_product] FOREIGN KEY([productId])
REFERENCES [dbo].[tbl_product] ([productId])
GO
ALTER TABLE [dbo].[tbl_voucher_product] CHECK CONSTRAINT [FK_tbl_voucher_product_tbl_product]
GO
ALTER TABLE [dbo].[tbl_voucher_product]  WITH CHECK ADD  CONSTRAINT [FK_tbl_voucher_product_tbl_voucher] FOREIGN KEY([voucherId])
REFERENCES [dbo].[tbl_voucher] ([voucherId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[tbl_voucher_product] CHECK CONSTRAINT [FK_tbl_voucher_product_tbl_voucher]
GO
/****** Object:  StoredProcedure [dbo].[AddCategory]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddCategory]
@Name nvarchar(50), @Description nvarchar(150), @ParentId int
AS
	INSERT INTO tbl_category(name,description,parentId)
	VALUES (@Name,@Description,@ParentId)

GO
/****** Object:  StoredProcedure [dbo].[AddCommentOFPost]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddCommentOFPost]
@Title nvarchar(50),
@Content nvarchar(MAX),
@PostId int, 
@AuthorId varchar(50)
AS
	INSERT INTO tbl_comment(title, commentContent, postId, time, authorId)
	VALUES (@Title, @Content, @PostId, GETDATE(), @AuthorId)

GO
/****** Object:  StoredProcedure [dbo].[AddCommentOFProduct]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddCommentOFProduct]
@Title nvarchar(50),
@Content nvarchar(MAX),
@ProductId int, 
@AuthorId varchar(50)
AS
	INSERT INTO tbl_comment(title, commentContent, productId, time, authorId)
	VALUES (@Title, @Content, @ProductId, GETDATE(), @AuthorId)

GO
/****** Object:  StoredProcedure [dbo].[AddDeal]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddDeal]
@DealContent nvarchar(50), @StartTime datetime, @Duration int,
@DealId int OUTPUT
AS
	INSERT INTO tbl_deal(dealContent,startTime,duration)
	VALUES (@DealContent,@StartTime,@Duration)
	SELECT @DealId = SCOPE_IDENTITY()
    SELECT @DealId AS id

GO
/****** Object:  StoredProcedure [dbo].[AddDealForProduct]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddDealForProduct]
@DealId int,
@ProductId int,
@Discount int,
@Type bit
AS
	INSERT INTO tbl_product_deal(dealId,productId, discount, type)
	VALUES (@DealId,@ProductId, @Discount, @Type)

GO
/****** Object:  StoredProcedure [dbo].[AddFacebookUser]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddFacebookUser]
@UserId varchar(50),
@Token varchar(50),
@Fullname nvarchar(50)
as
	insert into tbl_user(userId,password,fullname,role)
	values (@UserId,@Token,@Fullname,3)

GO
/****** Object:  StoredProcedure [dbo].[AddImageOfPost]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddImageOfPost]
@Url varchar(255),
@PostId int
AS
	INSERT INTO tbl_image(url, postId)
	VALUES (@Url, @PostId)
	SELECT @PostId = SCOPE_IDENTITY()
    SELECT @PostId AS id
GO
/****** Object:  StoredProcedure [dbo].[AddImageOfProduct]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddImageOfProduct]
@Url varchar(255),
@ProductId int
AS
	INSERT INTO tbl_image(url, productId)
	VALUES (@Url, @ProductId)

GO
/****** Object:  StoredProcedure [dbo].[AddOrder]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddOrder]
@TotalPrice money, 
@UserId varchar(50), 
@Fullname nvarchar(50),
@Address nvarchar(250),
@Phone varchar(20),
@OrderId int OUTPUT
AS
	INSERT INTO tbl_order(totalPrice,userId,fullname,address,phone,status)
	VALUES (@TotalPrice, @UserId,@Fullname,@Address,@Phone,2) --------not approve --------------
	SELECT @OrderId = SCOPE_IDENTITY()
    SELECT @OrderId AS id

GO
/****** Object:  StoredProcedure [dbo].[AddOrderProduct]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddOrderProduct]
@OrderId int,
@ProductId int,
@Quantity int,
@Size nvarchar(20)
AS
	INSERT INTO tbl_orderDetail(orderId,productId,quantity,size)
	VALUES (@OrderId, @ProductId, @Quantity, @Size)
	--- reduce quantity of product
	UPDATE tbl_product
	SET quantity = quantity - @Quantity
	WHERE productId = @ProductId

GO
/****** Object:  StoredProcedure [dbo].[AddPost]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddPost]
@Title nvarchar(50),
@Content nvarchar(MAX),
@UserId varchar(50),
@PostId int OUTPUT
AS
	INSERT INTO tbl_post(title, postContent, userId)
	VALUES(@Title, @Content, @UserId)
	SELECT @PostId = SCOPE_IDENTITY()
    SELECT @PostId AS postId

GO
/****** Object:  StoredProcedure [dbo].[AddProduct]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddProduct]
@Name nvarchar(50), 
@Brand nvarchar(50), 
@Price money, 
@Country nvarchar(50), 
@Description nvarchar(MAX),
@Material nvarchar(50), 
@CategoryId int, 
@Quantity int,
@Tag nvarchar(250),
@ProductId int OUTPUT
AS
	INSERT INTO tbl_product(name,brand,price,country,description,material,categoryID,quantity,tag)
	VALUES (@Name,@Brand,@Price,@Country,@Description,@Material,@CategoryId,@Quantity, @Tag)
	SELECT @ProductId = SCOPE_IDENTITY()
    SELECT @ProductId AS id

GO
/****** Object:  StoredProcedure [dbo].[AddProductOfVoucher]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddProductOfVoucher]
@Voucher varchar(50),
@ProductId int
AS
	INSERT INTO tbl_voucher_product(voucherId, productId)
	VALUES(@Voucher, @ProductId)

GO
/****** Object:  StoredProcedure [dbo].[AddProductSize]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddProductSize]
@ProductId int,
@Size nvarchar(20)
as
	insert tbl_product_size(productId,size)
	values(@ProductId,@Size)

GO
/****** Object:  StoredProcedure [dbo].[AddProductVoucher]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddProductVoucher]
@VoucherId varchar(50), @ProductId int
AS
	INSERT INTO tbl_voucher_product(voucherId,productId)
	VALUES (@VoucherId,@ProductId)

GO
/****** Object:  StoredProcedure [dbo].[AddStaff]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddStaff]
@Username varchar(50),
@Password varchar(50),
@Fullname nvarchar(50),
@Phone varchar(15),
@Email varchar(250)
AS
	INSERT INTO tbl_user(userId, password, fullname, email, phone, role)
	VALUES (@Username, @Password, @Fullname, @Email, @Phone, 2)
GO
/****** Object:  StoredProcedure [dbo].[AddUser]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddUser]
@Username varchar(50),
@Password varchar(50),
@Fullname nvarchar(50),
@Phone varchar(15),
@Email varchar(250),
@Address nvarchar(250)
AS
	INSERT INTO tbl_user(userId, password, fullname, email, phone, address, role)
	VALUES (@Username, @Password, @Fullname, @Email, @Phone, @Address, 3)


GO
/****** Object:  StoredProcedure [dbo].[AddVoucher]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[AddVoucher]
@VoucherId varchar(50),@Type bit, @Discount int,@Description nvarchar(150),@StartTime Date, @Duration int, @Quantity int 
AS
	insert tbl_voucher(voucherId,type,discount,description,startTime,duration,quantity)
	values (@VoucherId,@Type,@Discount,@Description,@StartTime,@Duration,@Quantity)

GO
/****** Object:  StoredProcedure [dbo].[AddVoucherOrder]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[AddVoucherOrder]
@VoucherId varchar(50),
@OrderId int
AS
	INSERT INTO tbl_order_voucher
	VALUES(@VoucherId, @OrderId)
	--reduce quantity of voucher
	UPDATE tbl_voucher
	SET quantity = quantity - 1
	WHERE voucherId = @VoucherId


GO
/****** Object:  StoredProcedure [dbo].[CancelOrder]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[CancelOrder]
@OrderId int
AS
	UPDATE tbl_order
	SET status =  5 --status Cancel -----
	WHERE id = @OrderId

GO
/****** Object:  StoredProcedure [dbo].[ChangePassword]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ChangePassword]
@UserId varchar(50), @NewPass varchar(50),@OldPass varchar(50)
AS
	UPDATE [tbl_user]
	SET	[tbl_user].password = @NewPass
	WHERE userId = @UserId and password = @OldPass

GO
/****** Object:  StoredProcedure [dbo].[ChangeProductDiscount]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ChangeProductDiscount]
@DealId int,
@ProductId int,
@Discount int,
@Type bit
AS
	UPDATE tbl_product_deal
	SET discount = @Discount, type = @Type
	WHERE productId = @ProductId AND dealId = @DealId

GO
/****** Object:  StoredProcedure [dbo].[ChangeRole]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ChangeRole]
@UserId varchar(50),
@Role int
AS
	UPDATE tbl_user
	SET role = @Role
	WHERE role = @Role

GO
/****** Object:  StoredProcedure [dbo].[CheckLogin]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CheckLogin]
@Role int OUTPUT,
@UserName varchar(50), @Password varchar(50)
AS
	BEGIN
		IF EXISTS (		SELECT *	FROM [tbl_user] WHERE tbl_user.userId = @UserName AND tbl_user.password=@Password	)
			SET @Role =  (		SELECT role	FROM [tbl_user] WHERE tbl_user.userId = @UserName AND tbl_user.password=@Password	);
		ELSE
			SET @Role = 0;
	END
GO
/****** Object:  StoredProcedure [dbo].[DeleteCategory]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteCategory]
@CategoryId int
AS
	DELETE 
	FROM tbl_category
	WHERE id = @CategoryId

GO
/****** Object:  StoredProcedure [dbo].[DeleteComment]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteComment]
@CoId int
AS
	DELETE
	FROM tbl_comment
	WHERE parentId = @CoId

	DELETE
	FROM [tbl_comment]
	WHERE id = @CoId

GO
/****** Object:  StoredProcedure [dbo].[DeleteDeal]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteDeal]
@Id int
AS
	DELETE
	FROM [tbl_deal]
	WHERE tbl_deal.id = @Id

GO
/****** Object:  StoredProcedure [dbo].[DeleteImage]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteImage]
@ImageId int
AS
	DELETE 
	FROM [tbl_image]
	WHERE imageId = @ImageId

GO
/****** Object:  StoredProcedure [dbo].[DeleteOrder]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteOrder]
@Id int
AS
	select *
	FROM tbl_order
	WHERE id = @Id

GO
/****** Object:  StoredProcedure [dbo].[DeletePost]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeletePost]
@Id int
AS
	DELETE 
	FROM [tbl_post]
	WHERE postId = @Id

GO
/****** Object:  StoredProcedure [dbo].[DeletePostImage]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeletePostImage]
@PostId int
as
	Delete 
	from tbl_image
	where postId = @PostId


GO
/****** Object:  StoredProcedure [dbo].[DeleteProduct]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[DeleteProduct]
@ProductId int
AS
	UPDATE tbl_product
	SET deleted = 1
	WHERE productId = @ProductId and deleted=0

GO
/****** Object:  StoredProcedure [dbo].[DeleteProductDeal]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteProductDeal]
@Id int, @ProductId int
AS
	DELETE
	FROM tbl_product_deal
	WHERE tbl_product_deal.dealId = @Id AND tbl_product_deal.productId = @ProductId

GO
/****** Object:  StoredProcedure [dbo].[DeleteProductSize]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DeleteProductSize]
@ProductId int
as
	Delete tbl_product_size
	where productId = @ProductId

GO
/****** Object:  StoredProcedure [dbo].[DeleteVoucher]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[DeleteVoucher]
@VoucherId varchar(50)
AS
	DELETE 
	FROM tbl_voucher
	WHERE voucherId = @VoucherId
GO
/****** Object:  StoredProcedure [dbo].[ExpiredUser]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ExpiredUser]
@UserId varchar(50)
AS
	UPDATE tbl_user
	SET expired = 1
	WHERE userId = @UserId AND expired = 0

GO
/****** Object:  StoredProcedure [dbo].[GetAllCategory]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAllCategory]
AS
	SELECT *
	FROM tbl_category
	ORDER BY name ASC

GO
/****** Object:  StoredProcedure [dbo].[GetAllDeal]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllDeal]
AS
	Select *
	From tbl_deal

G
GO
/****** Object:  StoredProcedure [dbo].[GetAllOrder]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAllOrder]
as
	Select *
	from View_AllOrder
	order by status asc


GO
/****** Object:  StoredProcedure [dbo].[GetAllPost]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAllPost]
AS
	Select postId, title, timePost, fullname,postContent,url
	from ListAllPost

GO
/****** Object:  StoredProcedure [dbo].[GetAllProductDealing]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllProductDealing]
	AS
	select *
	from ListProductItem
	WHERE deleted = 0 and discount > 0 

GO
/****** Object:  StoredProcedure [dbo].[GetAllProductForAdmin]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAllProductForAdmin]
as
	select *
	from View_AllProduct
	where deleted = 0
	order by productId


GO
/****** Object:  StoredProcedure [dbo].[GetAllProductForUser]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAllProductForUser]
AS
	 select *
 from ListProductItem
 where deleted = 0
 order by lastModified desc

GO
/****** Object:  StoredProcedure [dbo].[GetAllUser]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetAllUser]
as
	Select userId,email,fullname,address,phone,gender,role,date_reg
	From View_User
	
GO
/****** Object:  StoredProcedure [dbo].[GetAllVoucher]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetAllVoucher]
AS
	SELECT *
	FROM tbl_voucher

GO
/****** Object:  StoredProcedure [dbo].[GetCategoryById]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetCategoryById]
@CategoryId int
as
	select *
	from tbl_category
	where id = @CategoryId

GO
/****** Object:  StoredProcedure [dbo].[GetCommentOfComment]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCommentOfComment]
@CoId int
AS
	SELECT *
	FROM [tbl_comment]
	WHERE parentId = @CoId

GO
/****** Object:  StoredProcedure [dbo].[GetDealDetail]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetDealDetail]
	@DealId int
	AS
		select *
		from tbl_deal
		where id = @DealId

GO
/****** Object:  StoredProcedure [dbo].[GetDetailOfOrder]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetDetailOfOrder]
@OrderId int,
@Username varchar(50)
AS
	SELECT *
	FROM ListOrderWithVoucher
	WHERE id = @OrderId AND userId = @Username

GO
/****** Object:  StoredProcedure [dbo].[GetDetailOrderForAdmin]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--step 3
CREATE procedure [dbo].[GetDetailOrderForAdmin]
@OrderId int
AS
	select id,userId,date,totalPrice,voucherId,approveder_id,description,status,fullname,address,phone
	from ListOrderWithVoucher
	where id = @OrderId

GO
/****** Object:  StoredProcedure [dbo].[GetFirstImageOfProduct]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetFirstImageOfProduct]
@ProductId int
AS
	SELECT TOP 1 url
	FROM tbl_image
	WHERE productId = @ProductId

GO
/****** Object:  StoredProcedure [dbo].[GetHistoryOrderOfUser]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetHistoryOrderOfUser]
@Username varchar(50)
AS
	SELECT *
	FROM ListOrderWithVoucher
	WHERE userId = @Username
	ORDER BY date DESC

GO
/****** Object:  StoredProcedure [dbo].[GetImageOfPost]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetImageOfPost]
@postId int
AS
	SELECT url
	FROM [tbl_image]
	WHERE postId = @postId

GO
/****** Object:  StoredProcedure [dbo].[GetImageOfProduct]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetImageOfProduct]
@ProductId int
AS
		SELECT imageId, url
		FROM tbl_image
		WHERE productId = @ProductId

GO
/****** Object:  StoredProcedure [dbo].[GetListProductInOrder]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetListProductInOrder]
@OderId int
AS
	SELECT *
	FROM ProductInOrder
	WHERE orderId = @OderId

GO
/****** Object:  StoredProcedure [dbo].[GetPasswrodUser]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetPasswrodUser]
@UserId varchar(50)
AS
	select password
	from tbl_user
	where userId = @UserId

GO
/****** Object:  StoredProcedure [dbo].[GetPostById]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPostById]
@Id int
AS
	SELECT * 
	FROM ListAllPost
	WHERE postId = @Id

GO
/****** Object:  StoredProcedure [dbo].[GetPostComment]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPostComment]
@PostId int
AS
	SELECT *
	FROM [tbl_comment]
	WHERE postId = @PostId

GO
/****** Object:  StoredProcedure [dbo].[GetProductColor]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetProductColor]
@ProductId int
AS
	SELECT *
	FROM ProductColor
	WHERE productId = @ProductId

GO
/****** Object:  StoredProcedure [dbo].[GetProductComment]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetProductComment]
@ProductId int
AS
	SELECT *
	FROM ListAllComment
	WHERE productId = @ProductId

GO
/****** Object:  StoredProcedure [dbo].[GetProductDetail]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetProductDetail]
@ProductId int
AS
	SELECT *
	FROM ProductDetail
	WHERE productId = @ProductId and deleted=0

GO
/****** Object:  StoredProcedure [dbo].[GetProductDetailForAdmin]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetProductDetailForAdmin]
@ProductId int
as
	select productId,name,brand,price,country,description,material,quantity,lastModified,tag,categoryName,categoryID
	from View_AllProduct
	where productId = @ProductId and deleted=0

GO
/****** Object:  StoredProcedure [dbo].[GetProductOfDeal]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetProductOfDeal]
@DealId int
AS
	SELECT pd.*,p.name
	FROM [tbl_product_deal] pd inner join tbl_product p on pd.productId = p.productId
	WHERE pd.dealId = @DealId
GO
/****** Object:  StoredProcedure [dbo].[GetProductOrderForAdmin]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetProductOrderForAdmin]
@OrderId int
AS
	select productId,size,quantity
	from tbl_orderdetail
	where orderId = @OrderId

GO
/****** Object:  StoredProcedure [dbo].[GetProductSize]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetProductSize]
@ProductId int
AS
	SELECT size
	FROM tbl_product_size
	WHERE productId = @ProductId

GO
/****** Object:  StoredProcedure [dbo].[GetProductsSortByDiscount]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetProductsSortByDiscount]
AS
	SELECT *
	FROM ListProductWithDeal
	ORDER BY discount DESC

GO
/****** Object:  StoredProcedure [dbo].[GetProductUpComingDeal]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetProductUpComingDeal]
	AS
	select v.productId, v.name, pd.discount, v.url, pd.type, v.price
	from tbl_deal d inner join tbl_product_deal pd on d.id = pd.dealId inner join ListProductWithFirstImage v on pd.productId = v.productId
	where startTime > GETDATE()

GO
/****** Object:  StoredProcedure [dbo].[GetProductWithEndTimeDeal]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetProductWithEndTimeDeal]
@CategoryId int
AS
select a.productId, a.name, MAX(a.endTime) as endTime
from (select p.productId, p.name,DATEADD(hour,d.duration,d.startTime) as endTime,p.categoryID
		from tbl_product p left outer join tbl_product_deal pd on p.productId = pd.productId
		left outer join tbl_deal d on pd.dealId = d.id) a
		where a.categoryID = @CategoryId
group by a.productId, a.name

GO
/****** Object:  StoredProcedure [dbo].[GetUserByName]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserByName]
@FullName nvarchar(50)
AS
	SELECT *
	FROM [tbl_user]
	WHERE tbl_user.fullname like @FullName

GO
/****** Object:  StoredProcedure [dbo].[GetUserByRole]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetUserByRole]
@Role int
AS
	SELECT *
	FROM tbl_user
	WHERE role = @Role

GO
/****** Object:  StoredProcedure [dbo].[GetUserByUsername]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[GetUserByUsername]
@Username varchar(50)
AS
	SELECT *
	FROM View_User
	WHERE userId = @Username

GO
/****** Object:  StoredProcedure [dbo].[GetVoucherById]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[GetVoucherById]
@VoucherId varchar(50)
as
	select *
	from tbl_voucher
	where voucherId = @VoucherId

GO
/****** Object:  StoredProcedure [dbo].[IsDealAlive]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IsDealAlive]
@IsLive int OUTPUT,
@Id int
AS
	BEGIN
		IF EXISTS (		SELECT *	FROM [tbl_deal] WHERE tbl_deal.id = @Id	)
			SET @IsLive =  (		SELECT DATEDIFF(hour, DATEADD(hour, tbl_deal.duration, tbl_deal.startTime), GETDATE())
									FROM [tbl_deal] WHERE tbl_deal.id = @Id );
		ELSE
			SET @IsLive = -999;
	END

GO
/****** Object:  StoredProcedure [dbo].[IsExistVoucher]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[IsExistVoucher]
@Voucher varchar(50)
AS
	select discount,type
	from tbl_voucher
	where voucherId = @Voucher and quantity > 0 and startTime <= GETDATE() and DATEADD(hour,duration,startTime) >= GETDATE()

	
GO
/****** Object:  StoredProcedure [dbo].[LoginAdmin]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[LoginAdmin]
@Role int OUTPUT,
@UserName varchar(50), @Password varchar(50)
AS
	BEGIN
		IF EXISTS (		SELECT *	FROM [tbl_user] WHERE tbl_user.userId = @UserName AND tbl_user.password=@Password AND (tbl_user.role = 1 OR tbl_user.role = 2)	)
			SET @Role =  (		SELECT role	FROM [tbl_user] WHERE tbl_user.userId = @UserName AND tbl_user.password=@Password	);
		ELSE
			SET @Role = 0;
	END
GO
/****** Object:  StoredProcedure [dbo].[ProductListByCategory]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ProductListByCategory]
@CategoryId int
AS
SELECT *
FROM ListProductItem
WHERE categoryId = @CategoryId and deleted = 0

GO
/****** Object:  StoredProcedure [dbo].[ReplyComment]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ReplyComment] --Reply ko có title
@Content nvarchar(MAX), 
@ParentId int,
@AuthorId varchar(50)
AS
	INSERT INTO tbl_comment(commentContent, parentId, time, authorId)
	VALUES ( @Content, @ParentId, GETDATE(), @AuthorId)

GO
/****** Object:  StoredProcedure [dbo].[SearchProductByName]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SearchProductByName]
@SearchValue nvarchar(250)
AS
	SELECT *
	FROM ListProductItem
	WHERE ListProductItem.tag like @SearchValue and deleted=0

	
GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	

GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	

GO
/****** Object:  StoredProcedure [dbo].[UpdateCategory]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCategory]
@Id int, @Name nvarchar(50), @Description nvarchar(150), @ParentId int
AS
	UPDATE dbo.tbl_category
	SET dbo.tbl_category.name=@Name,
		dbo.tbl_category.description=@Description,
		dbo.tbl_category.parentId=@ParentId
	WHERE dbo.tbl_category.id=@Id
GO
/****** Object:  StoredProcedure [dbo].[UpdateComment]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateComment]
@CoId int, @Title nvarchar(50), @Content nvarchar(MAX)
AS
	UPDATE [tbl_comment]
	SET	tbl_comment.title = @Title, tbl_comment.commentContent = @Content ,  tbl_comment.time=GETDATE()
	WHERE id = @CoId

GO
/****** Object:  StoredProcedure [dbo].[UpdateDealInformation]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateDealInformation]
@DealId int,
@Content nvarchar(50),
@StartTime datetime,
@Duration int
AS
	UPDATE tbl_deal
	SET dealContent = @Content, startTime = @StartTime, duration = @Duration
	WHERE id = @DealId

GO
/****** Object:  StoredProcedure [dbo].[UpdateOrderStatus]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOrderStatus]
@Status int, @Id int
AS
	UPDATE [tbl_order]
	SET	tbl_order.status = @Status
	WHERE tbl_order.id = @Id AND status <> @Status

GO
/****** Object:  StoredProcedure [dbo].[UpdatePost]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdatePost]
@Title nvarchar(50),
@Content nvarchar(MAX),
@PostId int
AS
	UPDATE tbl_post
	SET title = @Title, postContent = @Content, timePost = GETDATE()
	WHERE postId = @PostId

GO
/****** Object:  StoredProcedure [dbo].[UpdateProduct]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateProduct]
@Id int, @Name nvarchar(50), @Brand nvarchar(50), @Price money, @Country nvarchar(50), @Description nvarchar(MAX),
@Material nvarchar(50), @CategoryId int, @Quantity int, @Tag nvarchar(250)
AS
	UPDATE [tbl_product]
	SET	tbl_product.name = @Name, tbl_product.brand = @Brand, tbl_product.country = @Country, tbl_product.price = @Price, 
		tbl_product.description = @Description, tbl_product.material = @Material, tbl_product.categoryID = @CategoryId, tbl_product.quantity = @Quantity,tag=@Tag
	WHERE tbl_product.productId = @Id

GO
/****** Object:  StoredProcedure [dbo].[UpdateProfile]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[UpdateProfile]
@UserId varchar(50),
@Email varchar(250),
@Fullname varchar(50),
@Address nvarchar(250),
@Phone varchar(15),
@Gender int
AS
	UPDATE tbl_user
	SET email = @Email, 
		phone = @Phone, 
		fullname = @Fullname, 
		address = @Address, 
		gender = @Gender
	WHERE userId = @UserId

GO
/****** Object:  StoredProcedure [dbo].[UpdateQuantityProduct]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[UpdateQuantityProduct]
@ProductId int,
@Quantity int
AS
	UPDATE tbl_product
	SET quantity = @Quantity
	WHERE productId = @ProductId

GO
/****** Object:  StoredProcedure [dbo].[UpdateVoucher]    Script Date: 3/25/2018 9:46:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateVoucher]
@Id varchar(50), @type bit, @discount int, @description nvarchar(250), 
@startTime datetime, @duration int, @amount int
AS
	UPDATE dbo.tbl_voucher
	SET	dbo.tbl_voucher.type = @type, dbo.tbl_voucher.discount = @discount, dbo.tbl_voucher.description = @description,
		dbo.tbl_voucher.startTime = @startTime, dbo.tbl_voucher.duration = @duration, dbo.tbl_voucher.quantity =@amount
	WHERE dbo.tbl_voucher.voucherId = @Id

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[14] 2[4] 3) )"
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
         Begin Table = "tbl_comment"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 222
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "tbl_user"
            Begin Extent = 
               Top = 6
               Left = 260
               Bottom = 136
               Right = 430
            End
            DisplayFlags = 280
            TopColumn = 6
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListAllComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListAllComment'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[15] 2[13] 3) )"
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
         Begin Table = "tbl_user"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_post"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_image"
            Begin Extent = 
               Top = 193
               Left = 263
               Bottom = 323
               Right = 433
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListAllPost'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListAllPost'
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
         Begin Table = "tbl_role"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_user"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 5
         End
         Begin Table = "tbl_gender"
            Begin Extent = 
               Top = 128
               Left = 55
               Bottom = 224
               Right = 225
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListAllUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListAllUser'
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
         Begin Table = "tbl_voucher"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "tbl_order_voucher"
            Begin Extent = 
               Top = 102
               Left = 246
               Bottom = 198
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_order"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 6
         End
         Begin Table = "tbl_order_status"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
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
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListOrderWithVoucher'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListOrderWithVoucher'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListOrderWithVoucher'
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
         Begin Table = "ListProductWithImage"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 176
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_deal"
            Begin Extent = 
               Top = 15
               Left = 495
               Bottom = 145
               Right = 665
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_product_deal"
            Begin Extent = 
               Top = 32
               Left = 274
               Bottom = 162
               Right = 444
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListProductDealUpComing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListProductDealUpComing'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[34] 4[11] 2[25] 3) )"
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
         Begin Table = "v1"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "t3"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
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
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListProductItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListProductItem'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[26] 4[24] 2[26] 3) )"
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
         Begin Table = "tbl_product"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_product_deal"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_deal"
            Begin Extent = 
               Top = 138
               Left = 246
               Bottom = 268
               Right = 416
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListProductWithDeal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListProductWithDeal'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[32] 2[19] 3) )"
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
         Begin Table = "ListProductWithImage"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListProductWithFirstImage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListProductWithFirstImage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[32] 4[20] 2[17] 3) )"
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
         Begin Table = "tbl_image"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_product"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListProductWithImage'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ListProductWithImage'
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
         Begin Table = "tbl_color"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_product_color"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 119
               Right = 416
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductColor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductColor'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[31] 4[12] 2[13] 3) )"
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
         Begin Table = "ProductDetail_Left"
            Begin Extent = 
               Top = 11
               Left = 34
               Bottom = 141
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "tbl_product"
            Begin Extent = 
               Top = 7
               Left = 268
               Bottom = 137
               Right = 438
            End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[39] 4[9] 2[21] 3) )"
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
         Begin Table = "tbl_deal"
            Begin Extent = 
               Top = 147
               Left = 245
               Bottom = 277
               Right = 415
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_product_deal"
            Begin Extent = 
               Top = 43
               Left = 19
               Bottom = 173
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_product_1"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 15
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductDetail_Left'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductDetail_Left'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[38] 4[22] 2[19] 3) )"
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
         Left = -1
      End
      Begin Tables = 
         Begin Table = "tbl_product"
            Begin Extent = 
               Top = 26
               Left = 515
               Bottom = 156
               Right = 685
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_orderdetail"
            Begin Extent = 
               Top = 27
               Left = 231
               Bottom = 140
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
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductInOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductInOrder'
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
         Begin Table = "tbl_product_size"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_size"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductSize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ProductSize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[20] 2[7] 3) )"
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
         Begin Table = "tbl_order"
            Begin Extent = 
               Top = 9
               Left = 333
               Bottom = 201
               Right = 503
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "tbl_order_voucher"
            Begin Extent = 
               Top = 3
               Left = 38
               Bottom = 102
               Right = 208
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_AllOrder'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_AllOrder'
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
         Begin Table = "tbl_category"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_product"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 8
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 13
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_AllProduct'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_AllProduct'
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
         Begin Table = "tbl_order"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 2
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_OrderNotApproved'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_OrderNotApproved'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[42] 4[21] 2[12] 3) )"
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
         Begin Table = "tbl_user"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 199
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "tbl_role"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tbl_gender"
            Begin Extent = 
               Top = 133
               Left = 371
               Bottom = 229
               Right = 541
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_User'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_User'
GO
USE [master]
GO
ALTER DATABASE [snkrkorea] SET  READ_WRITE 
GO
