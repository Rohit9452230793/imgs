USE [master]
GO
/****** Object:  Database [ImUp]    Script Date: 02/28/2022 13:41:24 ******/
CREATE DATABASE [ImUp] ON  PRIMARY 
( NAME = N'ImUp', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\ImUp.mdf' , SIZE = 2304KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ImUp_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\ImUp_log.LDF' , SIZE = 504KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ImUp] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ImUp].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ImUp] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [ImUp] SET ANSI_NULLS OFF
GO
ALTER DATABASE [ImUp] SET ANSI_PADDING OFF
GO
ALTER DATABASE [ImUp] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [ImUp] SET ARITHABORT OFF
GO
ALTER DATABASE [ImUp] SET AUTO_CLOSE ON
GO
ALTER DATABASE [ImUp] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [ImUp] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [ImUp] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [ImUp] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [ImUp] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [ImUp] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [ImUp] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [ImUp] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [ImUp] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [ImUp] SET  ENABLE_BROKER
GO
ALTER DATABASE [ImUp] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [ImUp] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [ImUp] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [ImUp] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [ImUp] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [ImUp] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [ImUp] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [ImUp] SET  READ_WRITE
GO
ALTER DATABASE [ImUp] SET RECOVERY SIMPLE
GO
ALTER DATABASE [ImUp] SET  MULTI_USER
GO
ALTER DATABASE [ImUp] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [ImUp] SET DB_CHAINING OFF
GO
USE [ImUp]
GO
/****** Object:  Table [dbo].[imgs]    Script Date: 02/28/2022 13:41:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[imgs](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[ImagePath] [varchar](400) NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[imgs] ON
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (1, N'Rohit ', N'', 1)
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (2, N'Rohit ', N'', 1)
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (3, N'wsqd', N'', 1)
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (4, N'yukj', N'~/Content/Uploads/637804494815557764_R.jpg', 1)
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (5, N' Deepak', N'../Content/Uploads/637804495081268681_R.jpg', 1)
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (6, N'ala', N'../Content/Uploads/637804496078945465_R.jpg', 1)
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (7, N'mt Rohit 45', N'../Content/Uploads/637804553300069322_R.jpg', NULL)
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (8, N'kllknlknl', N'~/Content/Uploads/637804516230862160_R.jpg', 1)
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (9, N'ljh', N'', 1)
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (10, N' DeepakGHJ', N'~/Content/Uploads/637804572624305009_R.jpg', 1)
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (11, N'Rohit pal 45', N'../Content/Uploads/637804573108425572_R.jpg', NULL)
INSERT [dbo].[imgs] ([id], [name], [ImagePath], [IsDeleted]) VALUES (12, N'kjhk', N'~/Content/Uploads/637815615476114904_R.jpg', NULL)
SET IDENTITY_INSERT [dbo].[imgs] OFF
/****** Object:  StoredProcedure [dbo].[Sp_imgs]    Script Date: 02/28/2022 13:41:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Sp_imgs]
@id int=0,
@name varchar(50),
@ImagePath varchar(400),
@procId int =0

as begin
if(@procId=1)
if not exists(select 1 from imgs where name =@name and ISNULL(IsDeleted,0)=1)
begin
insert into imgs(name,ImagePath) values(@name,@ImagePath)
select'success'msg, id,name,REPLACE(ImagePath,'~/','../')ImagePath from imgs d where ISNULL(IsDeleted,0)=0
end 
else
begin
select'Exists'msg,id,name,REPLACE(ImagePath,'~/','../')ImagePath from imgs d where ISNULL(IsDeleted,0)=0

end 
end
if(@procId =2)
begin
update imgs set 
name =@name,
ImagePath=@ImagePath
where id =@id
select 'Update' msg ,id ,name, REPLACE(ImagePath,'~/','../')ImagePath from imgs d where ISNULL(IsDeleted,0)=0
end
if(@procId=3)
begin
select id ,name,REPLACE(ImagePath,'~/','../')ImagePath from imgs d where id=@id and ISNULL(IsDeleted,0)=0
end
if(@procId=4)
begin
select id,name ,REPLACE(ImagePath,'~/','../')ImagePath from imgs d where ISNULL (IsDeleted,0)=0
end 
if(@procId=5)
begin
update imgs set IsDeleted =1 where id=@id
end
GO
