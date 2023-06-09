USE [master]
GO
/****** Object:  Database [PROYECTO_TIENDA]    Script Date: 08/03/2023 22:11:18 ******/
CREATE DATABASE [PROYECTO_TIENDA]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'PROYECTO_TIENDA', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PROYECTO_TIENDA.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'PROYECTO_TIENDA_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\PROYECTO_TIENDA_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [PROYECTO_TIENDA] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [PROYECTO_TIENDA].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [PROYECTO_TIENDA] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET ARITHABORT OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET  DISABLE_BROKER 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET  MULTI_USER 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [PROYECTO_TIENDA] SET DB_CHAINING OFF 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [PROYECTO_TIENDA] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [PROYECTO_TIENDA] SET QUERY_STORE = OFF
GO
USE [PROYECTO_TIENDA]
GO
/****** Object:  Table [dbo].[Artista]    Script Date: 08/03/2023 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artista](
	[IdArtista] [int] NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Apellidos] [varchar](50) NULL,
	[Nick] [nvarchar](50) NULL,
	[Descripcion] [nvarchar](700) NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Imagen] [nvarchar](50) NULL,
 CONSTRAINT [PK_Artista] PRIMARY KEY CLUSTERED 
(
	[IdArtista] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Chat]    Script Date: 08/03/2023 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Chat](
	[IdChat] [int] NOT NULL,
	[Mensajes] [nvarchar](500) NULL,
	[IdReceptor] [int] NULL,
	[IdSubscriptor] [int] NULL,
	[Fecha_Hora] [date] NULL,
	[IdArtista] [int] NULL,
	[IdCliente] [int] NULL,
 CONSTRAINT [PK_Chat] PRIMARY KEY CLUSTERED 
(
	[IdChat] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 08/03/2023 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[IdCliente] [int] NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Apellidos] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Imagen] [nvarchar](50) NULL,
 CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED 
(
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Info_Arte]    Script Date: 08/03/2023 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Info_Arte](
	[IdInfoArte] [int] NOT NULL,
	[Titulo] [nvarchar](50) NULL,
	[Precio] [int] NULL,
	[Descripcion] [nvarchar](100) NULL,
	[Imagen] [nvarchar](700) NULL,
	[IdArtista] [int] NULL,
 CONSTRAINT [PK_Info_Arte] PRIMARY KEY CLUSTERED 
(
	[IdInfoArte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaccion]    Script Date: 08/03/2023 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaccion](
	[IdTransaccion] [int] NOT NULL,
	[Fecha_Transaccion] [date] NULL,
	[Precio_Compra] [int] NULL,
	[Precio_Venta] [int] NULL,
	[IdCliente] [int] NULL,
	[IdInfoArte] [int] NULL,
 CONSTRAINT [PK_Transaccion] PRIMARY KEY CLUSTERED 
(
	[IdTransaccion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Valoraciones]    Script Date: 08/03/2023 22:11:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Valoraciones](
	[IdValoraciones] [int] NOT NULL,
	[Puntuacion] [int] NULL,
	[IdCliente] [int] NULL,
	[IdArtista] [int] NULL,
 CONSTRAINT [PK_Valoraciones] PRIMARY KEY CLUSTERED 
(
	[IdValoraciones] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Artista] ([IdArtista], [Nombre], [Apellidos], [Nick], [Descripcion], [Email], [Password], [Imagen]) VALUES (1, N'Gabriel', N'Picolo', N'_picolo', N'Artista
• 🇧🇷 brazilian comic artist', N'gabrielpicolo@gmail.com', N'12345', NULL)
INSERT [dbo].[Artista] ([IdArtista], [Nombre], [Apellidos], [Nick], [Descripcion], [Email], [Password], [Imagen]) VALUES (2, N'Laia', N'Lopez', N'itslopez', N'Artista
Barcelona, Spain
• illustration, ch.design
• inquiries: 📩 itslopezillustrations@gmail.com
• Rep’d by Britt Siess Creative Management', N'itslopezillustrations@gmail.com', N'12345', NULL)
GO
INSERT [dbo].[Info_Arte] ([IdInfoArte], [Titulo], [Precio], [Descripcion], [Imagen], [IdArtista]) VALUES (1, N'Summer 1999', 35, N'Giclee print

16 x 15 inches

﻿Hand-numbered limited edition of 100

Ships in 2 - 3 weeks', N'https://cdn.shopify.com/s/files/1/0230/6428/1166/products/digi-2_540x.jpg?v=1564779773', 1)
INSERT [dbo].[Info_Arte] ([IdInfoArte], [Titulo], [Precio], [Descripcion], [Imagen], [IdArtista]) VALUES (2, N'Get Jinx', 6, N'Jinx de Arcane', N'https://scontent-mad2-1.cdninstagram.com/v/t51.2885-15/266266121_1255459641531154_8340696004362073972_n.jpg?stp=dst-jpg_e35_p480x480&_nc_ht=scontent-mad2-1.cdninstagram.com&_nc_cat=110&_nc_ohc=tvxeVmXpBIAAX-ZSPGl&edm=ABmJApABAAAA&ccb=7-5&ig_cache_key=MjcyNjYyNzg0MTA0NDIyNTM3NQ%3D%3D.2-ccb7-5&oh=00_AfA7Fq4jUn7OhtpFdDMsjI9FIqqMT7HW2lpE8-8IluGa-A&oe=640E7F78&_nc_sid=6136e7', 2)
GO
ALTER TABLE [dbo].[Chat]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Artista] FOREIGN KEY([IdArtista])
REFERENCES [dbo].[Artista] ([IdArtista])
GO
ALTER TABLE [dbo].[Chat] CHECK CONSTRAINT [FK_Chat_Artista]
GO
ALTER TABLE [dbo].[Chat]  WITH CHECK ADD  CONSTRAINT [FK_Chat_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[Chat] CHECK CONSTRAINT [FK_Chat_Cliente]
GO
ALTER TABLE [dbo].[Info_Arte]  WITH CHECK ADD  CONSTRAINT [FK_Info_Arte_Artista] FOREIGN KEY([IdArtista])
REFERENCES [dbo].[Artista] ([IdArtista])
GO
ALTER TABLE [dbo].[Info_Arte] CHECK CONSTRAINT [FK_Info_Arte_Artista]
GO
ALTER TABLE [dbo].[Transaccion]  WITH CHECK ADD  CONSTRAINT [FK_Transaccion_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[Transaccion] CHECK CONSTRAINT [FK_Transaccion_Cliente]
GO
ALTER TABLE [dbo].[Transaccion]  WITH CHECK ADD  CONSTRAINT [FK_Transaccion_Info_Arte] FOREIGN KEY([IdInfoArte])
REFERENCES [dbo].[Info_Arte] ([IdInfoArte])
GO
ALTER TABLE [dbo].[Transaccion] CHECK CONSTRAINT [FK_Transaccion_Info_Arte]
GO
ALTER TABLE [dbo].[Valoraciones]  WITH CHECK ADD  CONSTRAINT [FK_Valoraciones_Artista] FOREIGN KEY([IdArtista])
REFERENCES [dbo].[Artista] ([IdArtista])
GO
ALTER TABLE [dbo].[Valoraciones] CHECK CONSTRAINT [FK_Valoraciones_Artista]
GO
ALTER TABLE [dbo].[Valoraciones]  WITH CHECK ADD  CONSTRAINT [FK_Valoraciones_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Cliente] ([IdCliente])
GO
ALTER TABLE [dbo].[Valoraciones] CHECK CONSTRAINT [FK_Valoraciones_Cliente]
GO
USE [master]
GO
ALTER DATABASE [PROYECTO_TIENDA] SET  READ_WRITE 
GO
