/*Sentencias de DDL*/
/*Creacion de base de datos*/
create database TiendaMascota;
/*Habilitar la base de datos*/
use TiendaMascota;
/*Creacion de tablas*/
create table Mascota(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);
create table Cliente(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);
create table Producto(
codigoProducto int primary key,
nombreProducto varchar (15),
marca varchar (15),
precio float,
cedulaClienteFK int
);
create table Vacuna(
codigoVacuna int primary key,
nombreVacuna varchar (15),
dosisVacuna int (10),
enfermedad varchar (15)
);
create table Mascota_Vacuna(
codigoVacunaFK int,
idMascotaFK int,
enfermedad varchar (15)
);

/*crear las relaciones*/
alter table Cliente
add constraint FClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);

alter table Mascota_Vacuna
add constraint FKMV
foreign key (idMascotaFK)
references Mascota(idMascota );

alter table Mascota_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

/*Registros*/

insert into Mascota values (5, 'Murcielago','Hembra','Pomenaria',3),(3, 'Marco','Macho','Pastor Alemán',3);
insert into Cliente values (1028483288, 'Maria','Herrera','Cra 67 A # 45 F 32',3203304601, 8),(72741364, 'Sara','Garcia','Cra 45 B # 67 G 89',3124465925, 2);
insert into Prodcuto values (23, 'Silla','Ikea',3500,1028483288),(24, 'Mesa','Ikea',3000,1028483288);
insert into Vacuna values ('1022','Polivalente',3,'VIH'), ('1023','Polivalente',3,'Sifilis');
insert into Mascota_Vacuna values (1314, 34, 'Laringitis');
/*Consultar multitabla*/
select m.*, c.nombreCliente from Mascota m left join cliente c on m.idMascota=c.idMascotaFK;
select m.*, c.nombreCliente from Mascota m right join cliente c on m.idMascota=c.idMascotaFK group by m.nombreMascota;

select m.*, c.nombreCliente, p.nombreProducto from Mascota m join cliente c on m.idMascota=c.idMascotaFK
join producto p on p.cedulaClienteFK=c.cedulaCliente;

/*Eliminacion*/

delete from producto where codigoProducto=11;
describe producto;

/*Procedimiento almacenado*/

select * from Mascota;
DELIMITER //
create procedure InsertarMascota(in idMascota int, nombreMascota varchar(15),generoMascota varchar (15),razaMascota varchar (15),cantidad int (10) )
begin
	-- Instrucciones de SQL 
	insert into mascota values (idMascota, nombreMascota, generoMascota, razaMascota, cantidad);
end //
DELIMITER;
select * from mascota;
call InsertarMascota(5, 'Richard','Macho','Retriever',1)

select * from Producto;
describe Producto;
DELIMITER //
create procedure ConsultarPrecio(out total float)
begin
	-- Instrucciones de SQL 
	select count(*) into precio from Prodcuto;
end //
DELIMITER;

call consultarPrecio(@resultado);
select @resultado;

-- crear un procedimiento para insertar registros en tabla débil
 -- crear procedimiento consultar las vacunas que se le ha aplicado a una mascota
 -- y que enfermedad esta atacando
 
 DELIMITER  // 
CREATE PROCEDURE InsertarTablaDebil(in codigoVacunaFK int (15), idMascotaFK int (15), enfermedad varchar (15))
BEGIN
insert into mascota_vacuna values (codigoVacunaFK, idMascotaFK, enfermedad);

END //
DELIMITER ;
call InsertarTablaDebil('', '', '');

-- CONSULTAR VACUNAS QUE LE HAN APLICADO A UNA MASCOTA Y QUE ENFERMEDAD ESTA ATACANDO--
DELIMITER //
create procedure ConsultarVacunas2(IN mascotaNombre VARCHAR(15))
BEGIN
    SELECT M.nombreMascota, V.nombreVacuna, V.enfermedad
    FROM Mascota M
    INNER JOIN Mascota_Vacuna MV ON MV.idMascotaFK = M.idMascota
    INNER JOIN Vacuna V ON V.codigoVacuna = MV.codigoVacunaFK
    WHERE M.nombreMascota = mascotaNombre;
end //
DELIMITER ;

call ConsultarVacunas2('Ricahrd');

/*  27/03/2025
 Vista Views, es un caonsulta almacenada que genera un tabla virtual
 SINTAXIS:
 create view nombreVista as
 select valoresConsultar from nombreTabla where condiciones
 Para ejecutar se realiza una consulta de la vista.
 */


describe cliente;
create view VistaCliente as
select * from cliente where cedulaCliente = 1028483288;

select * from VistaCliente;

/*Modificar una vista
alter view nombreVista as
 select valoresConsultar from nombreTabla where condiciones
 
 Eliminar una v
 drop view nombreVista
 */

alter view VistaTEL467 as
select * from cliente where telefono like '%4%'and telefono like '%6%'and telefono like '%7%';
select * from VistaTEL467;

/*Disparadores trigger
tipos de disparadores: before insert, before update, before delete
todos se ejecutan antes de la operacion
afer insert, after update, after delete: se ejecutan despues de la operacion

DELIMITER //
create trigger nombreTrigger
after insert on nombreTabla for each row
begin
--INstrucciones SQL

end //
DELIMITER;

crear trigger para registrar en una tabla consulidado cada vez que se registre una mascota
*/

create table consolidado(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);
DELIMITER //
create trigger registrarConsolidadoMascota
after insert on mascota for each row
begin
insert into consolidado values('insert',new.idMascota);
end //
DELIMITER ;
insert into mascota values(8, 'Mimoso','Macho','Boston Terrier',3);
select * from mascota;
describe mascota;
select * from consolidado;



create table TablaEliminados(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (15),
idMascotaFK int
);
DELIMITER //
create trigger CrearTablaEliminados
before delete on cliente for each row
begin
insert into TablaEliminados values(old.cedulaCliente, old.nombreCliente, old.apellidoCliente, old.direccionCliente, old.telefono, old.idMascotaFK);
end //
DELIMITER ;

select * from cliente;
describe cliente;
insert into cliente values(1028483285, 'Kgon','Herrera','Cra 67 A # 45 F 32',3203304601, 8); 
delete from cliente where cedulaCliente = 1028483285;
select * from TablaEliminados;



