USE [master]
GO
/****** Object:  Database [YunDB]    Script Date: 08/17/2015 21:59:06 ******/
CREATE DATABASE [YunDB] ON  PRIMARY 
( NAME = N'YunDB', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\YunDB.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'YunDB_log', FILENAME = N'c:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLEXPRESS\MSSQL\DATA\YunDB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [YunDB] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [YunDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [YunDB] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [YunDB] SET ANSI_NULLS OFF
GO
ALTER DATABASE [YunDB] SET ANSI_PADDING OFF
GO
ALTER DATABASE [YunDB] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [YunDB] SET ARITHABORT OFF
GO
ALTER DATABASE [YunDB] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [YunDB] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [YunDB] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [YunDB] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [YunDB] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [YunDB] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [YunDB] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [YunDB] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [YunDB] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [YunDB] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [YunDB] SET  DISABLE_BROKER
GO
ALTER DATABASE [YunDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [YunDB] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [YunDB] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [YunDB] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [YunDB] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [YunDB] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [YunDB] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [YunDB] SET  READ_WRITE
GO
ALTER DATABASE [YunDB] SET RECOVERY SIMPLE
GO
ALTER DATABASE [YunDB] SET  MULTI_USER
GO
ALTER DATABASE [YunDB] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [YunDB] SET DB_CHAINING OFF
GO
USE [YunDB]
GO
/****** Object:  Table [dbo].[Empleados_Busqueda]    Script Date: 08/17/2015 21:59:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleados_Busqueda](
	[ebs_cod] [int] IDENTITY(1,1) NOT NULL,
	[ebs_parametro] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Empleados_Busqueda] PRIMARY KEY CLUSTERED 
(
	[ebs_cod] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Departamentos_mstr]    Script Date: 08/17/2015 21:59:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Departamentos_mstr](
	[dept_id] [int] IDENTITY(1,1) NOT NULL,
	[dept_desc] [varchar](50) NOT NULL,
	[emp_id] [int] NULL,
 CONSTRAINT [PK_Departamentos_mstr] PRIMARY KEY CLUSTERED 
(
	[dept_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[spActDept]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spActDept] @dept_id int, @dept_desc varchar(50), @emp_id int
AS
BEGIN
UPDATE Departamentos_mstr
SET dept_desc = @dept_desc,
	emp_id = @emp_id
WHERE dept_id = @dept_id
END
GO
/****** Object:  Table [dbo].[Empleados_mstr]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Empleados_mstr](
	[emp_id] [int] IDENTITY(1,1) NOT NULL,
	[emp_nombre] [varchar](50) NULL,
	[emp_apellido] [varchar](50) NULL,
	[emp_cedula] [varchar](11) NULL,
	[dept_id] [int] NULL,
	[emp_ext] [varchar](50) NULL,
	[emp_flota] [varchar](10) NULL,
 CONSTRAINT [PK_Empleados_mstr_1] PRIMARY KEY CLUSTERED 
(
	[emp_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[spEliminarDepartamento]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spEliminarDepartamento] @dept_id int

AS

BEGIN
DELETE FROM Departamentos_mstr WHERE dept_id = @dept_id
END
GO
/****** Object:  StoredProcedure [dbo].[spConsultaDepartamentos]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultaDepartamentos]

AS

BEGIN
SELECT Departamentos_mstr.dept_desc AS Departamentos FROM Departamentos_mstr
END
GO
/****** Object:  StoredProcedure [dbo].[spBusquedaClienteDDL]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spBusquedaClienteDDL]
AS
BEGIN
	SELECT ebs_parametro as Parametros FROM Empleados_Busqueda
END
GO
/****** Object:  StoredProcedure [dbo].[spNuevoDepartamento]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spNuevoDepartamento] @dept_desc varchar(50), @emp_id int

AS

SET NOCOUNT ON
BEGIN
INSERT INTO dbo.Departamentos_mstr
           (dept_desc,
			emp_id)
     VALUES
           (@dept_desc,
			@emp_id)
END
GO
/****** Object:  StoredProcedure [dbo].[spNuevoEmpleado]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spNuevoEmpleado] @emp_nombre varchar(50), @emp_apellido varchar(50),
								@emp_cedula varchar(11), @dept_id varchar(3), @emp_ext varchar(4),
								@emp_flota varchar(10)

AS

SET NOCOUNT ON

INSERT INTO dbo.Empleados_mstr
           (emp_nombre,
           emp_apellido,
           emp_cedula,
           dept_id,
           emp_ext,
           emp_flota)
     VALUES
           (@emp_nombre,
			@emp_apellido,
			@emp_cedula,
			@dept_id,
			@emp_ext,
			@emp_flota)
GO
/****** Object:  StoredProcedure [dbo].[spEliminarEmpleado]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spEliminarEmpleado] @emp_id int

AS

BEGIN
DELETE FROM Empleados_mstr WHERE emp_id = @emp_id
END
GO
/****** Object:  StoredProcedure [dbo].[spActEmpleado]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spActEmpleado] @emp_nombre varchar(50), @emp_apellido varchar(50),
								@emp_cedula varchar(11), @dept_id int, @emp_ext varchar(4),
								@emp_flota varchar(10), @emp_id int

AS

UPDATE Empleados_mstr
SET emp_nombre = @emp_nombre, emp_apellido = @emp_apellido,
	emp_cedula = @emp_cedula, dept_id = @dept_id,
	emp_ext = @emp_ext, emp_flota = @emp_flota
WHERE emp_id = @emp_id
GO
/****** Object:  StoredProcedure [dbo].[spCsonultaDeptID]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spCsonultaDeptID] @dept_id int
AS
BEGIN
SELECT Departamentos_mstr.dept_id AS DeptCod, Departamentos_mstr.dept_desc AS
 Departamento, Empleados_mstr.emp_nombre + ' ' + Empleados_mstr.emp_apellido AS Gerente,
Empleados_mstr.emp_id AS Codigo, Empleados_mstr.emp_ext AS Extension
FROM Departamentos_mstr LEFT JOIN Empleados_mstr
 ON Departamentos_mstr.emp_id = Empleados_mstr.emp_id
 WHERE Departamentos_mstr.dept_id = @dept_id
END
GO
/****** Object:  StoredProcedure [dbo].[spConsultaTodosDept]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultaTodosDept]
AS
BEGIN
SELECT Departamentos_mstr.dept_id AS 'Codigo Dept', Departamentos_mstr.dept_desc AS
 Departamento, Empleados_mstr.emp_nombre + ' ' + Empleados_mstr.emp_apellido AS Gerente,
Empleados_mstr.emp_id AS Codigo, Empleados_mstr.emp_ext AS Extension
FROM Departamentos_mstr LEFT JOIN Empleados_mstr
 ON Departamentos_mstr.emp_id = Empleados_mstr.emp_id
END
GO
/****** Object:  StoredProcedure [dbo].[spConsultaEmpleadoGeneral]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultaEmpleadoGeneral] @parametro varchar(50)
AS
SELECT
	Empleados_mstr.emp_id AS Codigo, 
	Empleados_mstr.emp_nombre AS Nombre,
	Empleados_mstr.emp_apellido AS Apellido,
	Empleados_mstr.emp_cedula AS Cedula,
	Empleados_mstr.emp_ext AS Extension,
	Empleados_mstr.emp_flota AS Flota,
	Departamentos_mstr.dept_desc AS Departamento FROM Empleados_mstr
	INNER JOIN Departamentos_mstr
	ON Empleados_mstr.dept_id = Departamentos_mstr.dept_id
	WHERE Empleados_mstr.emp_nombre LIKE '%' + @parametro + '%'
	OR
	Empleados_mstr.emp_apellido LIKE '%' + @parametro + '%'
	OR
	Empleados_mstr.emp_cedula LIKE '%' + @parametro + '%'
	OR
	Empleados_mstr.emp_ext LIKE '%' + @parametro + '%'
	OR
	Empleados_mstr.emp_flota LIKE '%' + @parametro + '%' 
	OR
	Empleados_mstr.emp_id LIKE '%' + @parametro + '%'
	OR Departamentos_mstr.dept_desc LIKE '%' + @parametro + '%'
GO
/****** Object:  StoredProcedure [dbo].[spConsultaEmpleado]    Script Date: 08/17/2015 21:59:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spConsultaEmpleado] @emp_nombre varchar(50), @emp_apellido varchar(50),
								@emp_cedula varchar(11), @dept_id varchar(3), @emp_ext varchar(4),
								@emp_flota varchar(10), @emp_id int
AS

SET NOCOUNT ON

SELECT
	Empleados_mstr.emp_id AS Codigo, 
	Empleados_mstr.emp_nombre AS Nombre,
	Empleados_mstr.emp_apellido AS Apellido,
	Empleados_mstr.emp_cedula AS Cedula,
	Empleados_mstr.emp_ext AS Extension,
	Empleados_mstr.emp_flota AS Flota,
	Departamentos_mstr.dept_desc AS Departamento FROM Empleados_mstr
	INNER JOIN Departamentos_mstr
	ON Empleados_mstr.dept_id = Departamentos_mstr.dept_id
	WHERE Empleados_mstr.emp_nombre = @emp_nombre 
	OR
	Empleados_mstr.emp_apellido = @emp_apellido
	OR
	Empleados_mstr.emp_cedula = @emp_cedula
	OR
	Empleados_mstr.emp_ext = @emp_ext
	OR
	Empleados_mstr.emp_flota = @emp_flota
	OR
	Empleados_mstr.emp_id = @emp_id
	OR
	Empleados_mstr.dept_id = @dept_id
GO
/****** Object:  ForeignKey [FK_Empleados_mstr_Departamentos_mstr_ID]    Script Date: 08/17/2015 21:59:09 ******/
ALTER TABLE [dbo].[Empleados_mstr]  WITH CHECK ADD  CONSTRAINT [FK_Empleados_mstr_Departamentos_mstr_ID] FOREIGN KEY([dept_id])
REFERENCES [dbo].[Departamentos_mstr] ([dept_id])
GO
ALTER TABLE [dbo].[Empleados_mstr] CHECK CONSTRAINT [FK_Empleados_mstr_Departamentos_mstr_ID]
GO
