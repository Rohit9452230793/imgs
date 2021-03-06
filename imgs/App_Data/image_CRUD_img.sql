USE [ImUp]
GO
-- table create here

USE [ImUp]
GO

/****** Object:  Table [dbo].[imgs]    Script Date: 02/14/2022 17:04:52 ******/
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




-- end here 
/****** Object:  StoredProcedure [dbo].[Sp_imgs]    Script Date: 02/14/2022 17:04:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[Sp_imgs]
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