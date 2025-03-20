/* PRUEBA BASES DE DATOS */

/* Lenguaje solo para estructura*/

/* crear BD: create (tablas, procedimientos, listas, etc.. */
/* CREAR BD*/

create database viajeURosario;


/* HABILITAR BD */

use viajeURosario;

 /* Crear Tablas*/
 
 
 create table Camionero (
 idCamionero int AUTO_INCREMENT primary key,
 nombreCamionero varchar (30) not null,
 telefonoCamionero varchar (30) not null,
 direccionCamionero varchar (30) not null
 );
 
 create table Paquete (
 codigoPaquete int AUTO_INCREMENT primary key,
 descripcionPaquete varchar (30) not null,
 destinatarioPaquete varchar (30) not null,
 direccionEntrega varchar (30) not null,
 foreign key (codigoCiudadFK) references Ciudad(codigoCiudad) on delete cascade on update cascade
 );
 
 create table Camion (
 placaCamion int AUTO_INCREMENT primary key,
 modeloCamion varchar (30) not null,
 potenciaCamion varchar (30) not null,
 tipoCamion varchar (30) not null
 );

 create table Ciudad (
 codigoCiudad int AUTO_INCREMENT primary key,
 nombreciudad varchar (30) not null
 );

 create table DetalleConduce (
 idDetalleC int AUTO_INCREMENT primary key,
 nombreciudad varchar (30) not null
 );
 
 
 
 
 /* CONSULTAR ESTRUCTURAS DE LAS TABLAS */
 
 describe Camionero;
 describe Paquete;
 describe Ciudad;
 describe DetalleConduce;
 
 
 /*Modificar estructura */
 
alter table Paquete add column estadoPaquete enum( "entregado", "No entregado") default "No entregado"; 
 
describe Paquete;

 
 /* modificar tipo de datos de una tabla */
 
 alter table Camionero modify column telefonoCamionero bigint;
 
 /* eliminar tabla 
 DROP TABLE Paquete;
 */
 DROP TABLE Paquete;

/* eliminar BD
DROP database ViajeURosario;
*/

/*Eliminar todos los registros de una tabla 
Truncate table Paquete;
*/


/* RELACIONES */



 