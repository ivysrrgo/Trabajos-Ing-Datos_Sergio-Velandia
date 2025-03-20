create database TechCorp;
use TechCorp;
CREATE TABLE empleados (
    idEmpleado INT PRIMARY KEY AUTO_INCREMENT not null,
    nombreEmpleado VARCHAR(100) not null,
    edadEmpleado INT not null,
    ingresosEmpleado DECIMAL(10,2)not null,
    fContratacion DATE not null,
    departamento varchar(20) not null,
    idDepartamentoFk int not null,
    idCargoFK varchar(30) not null,
	foreign key(idDepartamentoFk) references departamento (idDepartamento) on delete cascade on update cascade,
	foreign key(idCargoFK) references cargo (idCargo) on delete cascade on update cascade
);

CREATE TABLE departamento (
    idDepartamento INT PRIMARY KEY AUTO_INCREMENT not null,
    nombreDepartamento VARCHAR(100) not null
);
create table cargo(
	idCargo varchar(30) primary key not null,
    nombreCargo varchar (50) not null,
    rangoCargo varchar (100) not null,
    descCargo varchar(100) not null
);

insert into empleados values (' ','Sergio Velandia', 20, 3500.50, '2024-03-17', 'Analístas',1,2),
(' ', 'Gumball Waterson', 35, 4200.00, '2018-03-22', 'Programación',3,4),
(' ', 'Paola Quintero', 24, 5000.75, '2024-11-10', 'Ventas',3,2),
(' ','Lyla Ordoñez', 23, 3800.00, '2022-09-05', 'QF',4,5),
(' ','Tatiana Carvajal', 33, 3100.25, '2020-01-20', 'Finanzas',6,5),
(' ','Daniel Moreno', 45, 6000.00, '2010-07-01', 'Marketing',5,3),
(' ','Paula Triviño', 26, 2700.00, '2023-02-12', 'Analístas',2,5),
(' ','Richard Waterson', 40, 4800.50, '2023-05-30', 'Finanzas',1,5),
(' ','Porky John', 33, 4100.00, '2017-08-25', 'Ventas',1,2),
(' ','Jordan Carter', 42, 5500.00, '2014-04-18', 'Ventas',4,2),
(' ','Carry Hernández', 20, 3500.50, '2024-03-17', 'Analístas'),
(' ','Anuel Gómez', 20, 3500.50, '2024-03-17', 'Programación');
select * from empleados;
insert into departamento values (' ', 'Programación'),(' ', 'Ventas'),(' ','QF'),(' ', 'Finanzas'),(' ','Marketing'),
(' ', 'Analístas');
select * from departamento;
insert into cargo values (1, 'Analista', 3, 'Analista'),
(2, 'Vendedor', 2, 'Vendedor'),(3,'Director QF', 6, 'Director de QF'),(4, 'Innovador',1, 'Innovador'),
(5,'Gerente',5,'Gerente'),(6, 'Director Financiero', 6,'Director financiero');

/*Empleados de TechCorp.*/
select nombreEmpleado as 'nombres', edadEmpleado as 'edades', ingresosEmpleado as 'salarios' from empleados;

/*¿Quiénes son los empleados que ganan más de $4,000?*/
select idEmpleado, nombreEmpleado as 'nombres', ingresosEmpleado as 'salarios' from empleados where ingresosEmpleado >4000.00;

/*Extrae la lista de empleados que trabajan en el departamento de Ventas.*/
select*from empleados where departamento='Ventas';

/*Encuentra a los empleados que tienen entre 30 y 40 años.*/
select*from empleados where edadEmpleado>=30 and edadEmpleado<=40;

/*¿Quiénes han sido contratados después del año 2020?*/
select * from empleados where year(fContratacion) > 2020;

/*¿Cuántos empleados hay en cada departamento?*/
select departamento, COUNT(*) as tOTAL from empleados group by departamento;

/*Promedio de salario de los empleados*/
select avg(ingresosEmpleado) as promedioSalario from empleados;

/*Muestra los empleados cuyos nombres comienzan con "A" o "C".*/
select * from empleados where nombreEmpleado like 'A%' or nombreEmpleado like 'C%' ; 

/*El mejor pagado: ¿Quién es el empleado con el salario más alto?*/
select nombreEmpleado as 'El mas asalariado', ingresosEmpleado as 'salario' from empleados where ingresosEmpleado = (select MAX(ingresosEmpleado) from empleados);

/*Funciones agregadas: Permiten hacer procesos sin tener que modificiarlos*/
/*Consultar rangos between*/
 select*from empleados where idEmpleado  between 1 and 4;
 
/*Consultar un valor que esté dentro de una lista de valores: in*/
select*from empleados where idEmpleado in (1,5);
 
/*Si un campo es nulo is null*/
select*from empleados where nombreEmpleado is null;


select*from empleados where departamento is null;
select*from empleados order by ingresosEmpleado desc;
select*, (2025-year(fContratacion)) as 'Años trabajados' from empleados;
select*from empleados order by ingresosEmpleado desc limit 3;

update empleados set nombreEmpleado = 'Gumball' where idEmpleado=1;

/*Mostrar los nombres de los empleados y los nombres de los departamentos a los que pertencen*/
select nombreEmpleado, departamento from empleados inner join departamento 
on empleados.idDepartamentoFK = departamento.idDepartamento;

select nombreEmpleado, departamento from empleados left join departamento 
on empleados.idDepartamentoFK = departamento.idDepartamento;

select nombreEmpleado, departamento from empleados right join departamento 
on departamento.idDepartamento = empleados.idDepartamentoFK;

/*Consulta todos los empleados con un rango especigico: Los que el id son menores o iguales a 3*/
select * from empleados left join cargo on cargo.rangoCargo=3;

/*Hacer consulta de todos los cargos que tengan rango especifico.*/
select*from cargo where rangoCargo = 2;

/*Mostrar en pantalla los empleados que tengan un cargo especifico.*/
select nombreEmpleado, idCargoFK, nombreCargo from empleados inner join cargo on empleados.idCargoFK = cargo.idCargo where idCargo=3;

/*Mostrar todos los empleados que sean mas antiguos que 3 años y que departamento pertenece, salario y cargo.*/
select nombreEmpleado, nombreDepartamento, ingresosEmpleado, nombreCargo
from empleados inner join cargo on empleados.idCargoFK = cargo.idCargo inner join 
departamento on empleados.idDepartamentoFK = departamento.idDepartamento where
(2025-year(fContratacion)) >3;

/*Mostrar toda la informacion del empleado: nombre, fecha contratrado, departamento, años de antiguedad, cargo actual y rango de cargo que tiene.*/
select nombreEmpleado, fContratacion, nombreDepartamento, nombreCargo, rangoCargo, 
(2025-year(fContratacion)) as 'Años trabajados'
from empleados inner join cargo on empleados.idCargoFK = cargo.idCargo inner join 
departamento on empleados.idDepartamentoFK = departamento.idDepartamento;

/*Mostrar todos los departamentos que no tengan empleados asignados.*/
select nombreEmpleado, nombreDepartamento from departamento inner join empleados on empleados.idDepartamentoFK = departamento.idDepartamento
where idDepartamentoFK is null;

/*Mostrar todos los cargos que no tengan empleados asignados*/
select * from cargo inner join empleados on empleados.idCargoFK = cargo.idCargo
where idCargoFK is null;