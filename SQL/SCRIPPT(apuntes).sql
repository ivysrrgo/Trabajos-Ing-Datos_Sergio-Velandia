/*CONSULTAS 000-00-00*/

create database EjercicioClase;
use EjercicioClase;

create table Cliente(
codigoCliente int AUTO_INCREMENT primary key not null,
nombreCliente varchar (20) not null,
domicilioCliente varchar (20) not null,
ciudadCliente varchar (20) not null,
provinciaCliente varchar (20) not null,
telefonoCliente varchar (20) not null
);

insert into Cliente values('', 'Sergio', 'Cra 70', 'Bogotá', 'Salitre', '3203304671'),  ('', 'Hetol', 'Cra 20', 'Neiva', 'Nocaima', '32456935401'),  
('', 'Daniel', 'Cra 68', 'Bogotá', 'Kennedy', '3115811510'),  ('', 'Mariana', 'Cra 3', 'Bogotá', 'Usme', '3103578246'),  
('', 'Lina', 'Cra 40', 'Bogotá', 'Rafael Uribe', '3228714607');

/*Consulta General*/

select * from Cliente;

/*Consulta especifica*/

select nombreCliente from Cliente; 

/*Clausula where conidicones de operadores logicos (or, and, not), aritmeticos (+-*) comparacion(=, <>, <, >, >0*)*/

select nombreCliente from Cliente where nombre='Lina' and codigoCliente=1;

select * from Cliente where nombre = 'Sergio';

/*Alias*/

select nombreCliente as 'Clientes', domicilioCliente as 'Direccion';

/*Ordenar order by asc desc* select camposaConsultar from nombreTabla order by campoOrdenar tipoOrden*/

select * from Cliente order by telefonoCliente asc;

/*Consultas agrupadas group by*/
/*like not like select campos from tabla condicion like campos*/
select * from Cliente where nombreCliente like '%a&';

/*Funciones agregadas*/
/*Comultar rangos between ... and ...*/
select * from Cliente where codigoCliente in (1,6);
select * from Cliente where codigo between 1 and 5;

/*Si un campo es null*/
select * from Cliente where domicilioCliente is null
