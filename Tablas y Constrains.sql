drop database if exists currier_ventas;
create database if not exists currier_ventas ;
use currier_ventas;

-- Creacion de las tablas

create table if not exists Cliente(
	IdCliente int not null auto_increment,
    Nombre varchar(80),
    Ciudad varchar(80),
    Telefono char(10),
    primary key (IdCliente)
);

create table if not exists Precio(
	IdPrecio int not null auto_increment,
    monto decimal(5,2) not null,
    check (monto>=0),
    primary key (IdPrecio)
);

create table if not exists Producto(
	IdProducto int not null auto_increment,
    Nombre varchar(80) not null,
    IdPrecio int not null,
    foreign key (IdPrecio) References Precio(IdPrecio),
    primary key (IdProducto)
);

create table if not exists Currier(
	IdCurrier int not null auto_increment,
    Nombre varchar(50),
    Telefono char(10),
    primary key (IdCurrier)
);

create table if not exists Seguimiento(
	IdSeguimiento int not null auto_increment,
    Fecha_pedido date,
    Fecha_entrega_USA date,
    Fecha_entrega_ECU date,
	Fecha_venta date,
    primary key (IdSeguimiento)
);
create table if not exists Inconveniente(
	IdInconveniente int not null auto_increment,
    Descripcion varchar(200),
    IdSeguimiento int,
    primary key (IdInconveniente),
    foreign key (IdSeguimiento) References Seguimiento(IdSeguimiento)
);

create table if not exists Estado(
	IdEstado int not null auto_increment,
    Nombre varchar(20) not null,
    primary key (IdEstado)
);

create table if not exists Pedidos(
	IdPedidos int not null auto_increment,
    Numero_Pedido varchar(20),
    Pagina_compra varchar(30),
    Precio_venta decimal(5,2),
    IdEstado int not null, #En Reparto, Disponible, Vendido
    IdCliente int not null,
    IdProducto int not null,
    IdSeguimiento int not null,
    primary key (IdPedidos),
    foreign key (IdCliente) References Cliente(IdCliente),
    foreign key (IdProducto) References Producto(IdProducto),
    foreign key (IdSeguimiento) References Seguimiento(IdSeguimiento),
    foreign key (IdEstado) References Estado(IdEstado),
    check (Precio_venta >0)
);

create table if not exists Envio(
	IdEnvio int not null auto_increment,
    Peso decimal(4,2),
    Precio decimal(5,2),
    IdCurrier int,
    IdPedidos int,
    primary key (IdEnvio),
    foreign key (IdPedidos) References Pedidos(IdPedidos),
    foreign key (IdCurrier) References Currier(IdCurrier)
);





