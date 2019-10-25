create database taller;

use taller;

create table Cliente (
	ID_Cliente int IDENTITY(0,1) primary key,
	nombre nvarchar(40) not null,
	apellido nvarchar(40) not null,
	tipo_cliente varchar(10) constraint CHK_Cliente_tipo check (tipo_cliente IN ('persona', 'empresa')) not null,
	fecha_registro date default getdate()
);

create table Telefono (
	ID_Cliente int not null,
	telefono varchar(15) not null,

	constraint PK_Telefono primary key (ID_cliente, telefono),
	constraint FK_Telefono_cliente foreign key (ID_Cliente ) 
		references Cliente (ID_cliente) on delete cascade
);

create table Tipo (
	ID_Tipo int IDENTITY(0,1) primary key,
	nombre varchar(25) not null,
);

create table Marca (
	ID_Marca int IDENTITY(0,1) primary key,
	nombre varchar(25) not null,
);

create table Auto (
	ID_Auto int IDENTITY(0,1) primary key,
	matricula varchar(10) not null,
	ID_Cliente int not null,
	ID_Marca int not null,
	ID_Tipo int not null,

	constraint FK_Auto_Cliente foreign key (ID_Cliente) 
		references Cliente (ID_cliente) on delete cascade,
	constraint FK_Auto_Tipo foreign key (ID_Tipo) 
		references Tipo (ID_Tipo),
	constraint FK_Auto_Marca foreign key (ID_Marca)
		references Marca (ID_Marca), 



);


INSERT INTO [dbo].[Cliente]
           ([nombre]
           ,[apellido]
           ,[tipo_cliente])
     VALUES
           ('Fulanio',
			'Uwu'
           ,'persona')
GO

INSERT INTO [dbo].[Cliente]
           ([nombre]
           ,[apellido]
           ,[tipo_cliente])
     VALUES
           ('Jose',
			'Owo'
           ,'persona')
GO

USE [taller]
GO

INSERT INTO [dbo].[Tipo]
           ([nombre])
     VALUES
           ('Liviano'),
		   ('Pesado')
GO


USE [taller]
GO

INSERT INTO [dbo].[Marca]
           ([nombre])
     VALUES
           ('Toyota'),
		   ('Ford')
GO

USE [taller]
GO

INSERT INTO [dbo].[Auto]
           ([matricula]
           ,[ID_Cliente]
           ,[ID_Marca]
           ,[ID_Tipo])
     VALUES
           ('264263'
           ,1
           ,0
           ,1)
GO

create view ClienteAuto as
select cliente.nombre as cliente, tipo.nombre as tipo, matricula, Marca.nombre from cliente 
join Auto on cliente.ID_Cliente = Auto.ID_Cliente 
join Marca on Marca.ID_Marca = Auto.ID_Marca
join Tipo on Auto.ID_Tipo = Tipo.ID_Tipo;

select * from dbo.ClienteAuto;