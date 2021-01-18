USE [HanaShop]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Product_Category]
GO
/****** Object:  Table [dbo].[Registration]    Script Date: 1/9/2021 5:49:18 PM ******/
DROP TABLE [dbo].[Registration]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 1/9/2021 5:49:18 PM ******/
DROP TABLE [dbo].[Product]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 1/9/2021 5:49:18 PM ******/
DROP TABLE [dbo].[Category]
GO
USE [master]
GO
/****** Object:  Database [HanaShop]    Script Date: 1/9/2021 5:49:18 PM ******/
DROP DATABASE [HanaShop]
GO
/****** Object:  Database [HanaShop]    Script Date: 1/9/2021 5:49:18 PM ******/
CREATE DATABASE [HanaShop]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'HanaShop', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\HanaShop.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'HanaShop_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\HanaShop_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [HanaShop] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [HanaShop].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [HanaShop] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [HanaShop] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [HanaShop] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [HanaShop] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [HanaShop] SET ARITHABORT OFF 
GO
ALTER DATABASE [HanaShop] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [HanaShop] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [HanaShop] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [HanaShop] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [HanaShop] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [HanaShop] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [HanaShop] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [HanaShop] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [HanaShop] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [HanaShop] SET  DISABLE_BROKER 
GO
ALTER DATABASE [HanaShop] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [HanaShop] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [HanaShop] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [HanaShop] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [HanaShop] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [HanaShop] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [HanaShop] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [HanaShop] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [HanaShop] SET  MULTI_USER 
GO
ALTER DATABASE [HanaShop] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [HanaShop] SET DB_CHAINING OFF 
GO
ALTER DATABASE [HanaShop] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [HanaShop] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [HanaShop] SET DELAYED_DURABILITY = DISABLED 
GO
USE [HanaShop]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 1/9/2021 5:49:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[categoryID] [nvarchar](50) NOT NULL,
	[categoryName] [nvarchar](250) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[categoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product]    Script Date: 1/9/2021 5:49:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[productID] [nvarchar](50) NOT NULL,
	[productName] [nvarchar](250) NULL,
	[image] [nvarchar](50) NULL,
	[description] [nvarchar](250) NULL,
	[price] [float] NULL,
	[createDate] [date] NULL,
	[categoryID] [nvarchar](50) NULL,
	[status] [bit] NULL,
	[quantity] [int] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[productID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Registration]    Script Date: 1/9/2021 5:49:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Registration](
	[userID] [nvarchar](50) NOT NULL,
	[password] [varchar](30) NULL,
	[fullname] [nvarchar](250) NULL,
	[isAdmin] [bit] NULL,
 CONSTRAINT [PK_Registration] PRIMARY KEY CLUSTERED 
(
	[userID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[Category] ([categoryID], [categoryName]) VALUES (N'C0001', N'Rice')
INSERT [dbo].[Category] ([categoryID], [categoryName]) VALUES (N'C0003', N'Snack')
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00001', N'Chicken Rice', N'images/com-ga.jpg', NULL, 11, CAST(N'2020-12-12' AS Date), N'C0001', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00002', N'Teriyaki Rice', N'images/teriyaki-rice.jpg', NULL, 12, CAST(N'2021-01-05' AS Date), N'C0001', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00003', N'Toridon Rice', N'images/toridon-rice.jpg', NULL, 13, CAST(N'2020-01-05' AS Date), N'C0001', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00004', N'Pepsi', N'images/Pepsi.png', NULL, 14, CAST(N'2021-01-05' AS Date), N'C0001', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00005', N'Coke', N'images/teriyaki-rice.jpg', NULL, 15, CAST(N'2021-01-05' AS Date), N'C0001', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00006', N'Cola', N'images/teriyaki-rice.jpg', NULL, 16, CAST(N'2021-01-05' AS Date), N'C0001', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00007', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00008', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00009', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00010', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00011', N'Pepsi Lime Zero Calories Can', N'images/Pepsi-Lime-Zero-Calories-Can.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00012', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00013', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00014', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00015', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00016', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00017', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00018', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00019', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Product] ([productID], [productName], [image], [description], [price], [createDate], [categoryID], [status], [quantity]) VALUES (N'P00020', N'Kolakem', N'images/kolakem.png', NULL, 17, CAST(N'2020-01-05' AS Date), N'C0003', 1, 50)
INSERT [dbo].[Registration] ([userID], [password], [fullname], [isAdmin]) VALUES (N'admin', N'admin', N'Admin', 1)
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([categoryID])
REFERENCES [dbo].[Category] ([categoryID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category]
GO
USE [master]
GO
ALTER DATABASE [HanaShop] SET  READ_WRITE 
GO
