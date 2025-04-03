create database OnlineBD;
use OnlineBD;
create table Clientes(
  cedulaCliente int primary key,
  nomCliente varchar(50) not null,
  apellidoCliente varchar(50) not null,
  direccionCliente varchar(50) not null
);
create table Libros(
  idLibro int primary key,
  nomLibro varchar(50) not null,
  estadoLibro bool not null,
  precioLibro float not null,
  stockLibros int not null,
  librosVendidos int not null
);
create table Pedidos(
  idPedido int primary key,
  fechaPedido date not null,
  estadoPedido bool not null,
  cantidadLibros int not null,
  precioPedido float not null,
  cedulaClienteFK int
);

create table LibrosPedidos(
idClienteFK is not null,
idLibroFK is not null
);

create table Usuario(
idUsuario int primary key,
estadoUsuario bool not null,



);


alter table Cliente
add constraint FKPD
foreign key (pedidosFK)
references Cliente(pedidosFK);

alter table Pedidos
add constraint FKPD
foreign key (pedidosFK)
references Cliente(pedidosFK)










/*------------------------------------CONSULTAS-------------------------------------------------------*/




