CREATE DATABASE BDDataVerse;
USE BDDataVerse;
-- 2 Crea las siguientes tablas y sus respectivas relaciones según el modelamiento

CREATE TABLE Sensores(
id_sensor INT PRIMARY KEY AUTO_INCREMENT, 
tipo VARCHAR(40) NOT NULL,
ubicacion VARCHAR(40) NOT NULL,
fecha_instalacion DATE NOT NULL
);

CREATE TABLE Registros_Sensores(
id_registro INT PRIMARY KEY AUTO_INCREMENT, 
id_sensorFK INT NOT NULL,
valor INT NOT NULL,
ubicacion VARCHAR(40) NOT NULL,
fecha_registro TIMESTAMP DEFAULT (CURRENT_TIMESTAMP),
FOREIGN KEY(id_sensorFK) REFERENCES sensores(id_sensor)
);

CREATE TABLE Transporte(
id_transporte INT PRIMARY KEY AUTO_INCREMENT, 
tipo VARCHAR(40) NOT NULL,
capacidad INT NOT NULL
);

CREATE TABLE Usuarios(
id_usuario INT PRIMARY KEY AUTO_INCREMENT, 
nombre VARCHAR(20) NOT NULL,
email VARCHAR(20) NOT NULL,
id_transporteFK INT NOT NULL,
id_registroFK INT NOT NULL,
id_sensorFK INT NOT NULL,
FOREIGN KEY(id_transporteFK) REFERENCES Transporte (id_transporte),
FOREIGN KEY(id_registroFK) REFERENCES Registros_Sensores (id_registro),
FOREIGN KEY(id_sensorFK) REFERENCES sensores (id_sensor)
);

CREATE TABLE Consumo_Energetico(
id_registroFK INT NOT NULL, 
zona VARCHAR(20) NOT NULL,
consumo_kw INT NOT NULL,
fecha_consumo DATE NOT NULL,
FOREIGN KEY (id_registroFK) REFERENCES Registros_Sensores (id_registro)
);

CREATE TABLE Seguridad (
id_evento INT PRIMARY KEY AUTO_INCREMENT, 
tipo_evento VARCHAR(20) NOT NULL,
descripcion VARCHAR(40) NOT NULL,
fecha_hora DATE NOT NULL,
ubicacion VARCHAR(30) NOT NULL
);

-- 4 Modifique la tabla Usuario y cree un campo teléfono.

ALTER TABLE Usuarios
ADD COLUMN telefono VARCHAR (15);

-- 5 Genere el modelo Físico de la Base de datos implementada.
-- Se encuentra ya en el pdf

-- INSERCIONES
DESCRIBE sensores; 
INSERT INTO sensores (tipo, ubicacion, fecha_instalacion) VALUES
("Lot", "Colombia", "2023-02-23"),
("red transporte","Colombia","2023-05-03"),
("consumo energetico","Colombia", "2022-04-05"),
("seguridad", "Colombia", "2024-03-06"),
("redes sociales", "Colombia", "2024-12-07");
SELECT * FROM sensores;

DESCRIBE registros_sensores;
INSERT INTO registros_sensores (id_sensorFK, valor, ubicacion, fecha_registro) VALUES
(1, 2, "Colombia", "2024-12-02"),
(1, 4, "Colombia", "2024-05-04"),
(2, 3 , "Colombia", "2023-12-24"),
(3, 7 , "Colombia", "2023-01-04"),
(4, 6, "Colombia", "2025-02-01"),
(5, 2, "Colombia", "2025-02-04");
SELECT * FROM registros_sensores;

DESCRIBE registros_sensores;
INSERT INTO registros_sensores (id_sensorFK, valor, ubicacion, fecha_registro) VALUES
(1, 2, "Colombia", "2024-12-02"),
(1, 4, "Colombia", "2024-05-04"),
(2, 3 , "Colombia", "2023-12-24"),
(3, 7 , "Colombia", "2023-01-04"),
(4, 6, "Colombia", "2025-02-01"),
(5, 2, "Colombia", "2025-02-04");
SELECT * FROM registros_sensores;

DESCRIBE Transporte;
INSERT INTO Transporte (tipo, capacidad) values
('Terrestre', '40'),
('Acuatico', '20'),
('Aereo', '50'),
('Terrestre', '80'),
('Aereo', '70');
SELECT * FROM Transporte;

DESCRIBE Usuarios;
INSERT INTO Usuarios (nombre, email) values
('Lina', 'linapena@hotmail.com'),
('Ana', 'anacherry@hotmail.com'),
('Samuel', 'samuelfke@hotmail.com'),
('Naty', 'natoto@hotmail.com'),
('Papo', 'papomc@hotmail.com');
SELECT * FROM Usuarios;

Describe seguridad;
insert into seguridad (tipo_evento,descripcion,fecha_hora, ubicacion) values
('1', 'Terremoto','2022-02-04','ciudadela'),
('2', 'Tsunami','2021-02-04','Costa Norte'),
('3', 'Ruptura','2023-02-04','Centro de la ciudad'),
('4', 'Derrumbe','2024-02-04','Afueras de la ciudad'),
('5', 'Inundacion','2019-02-04','Nor-occidente de la ciudad');
SELECT * FROM Seguridad;

describe Consumo_Energetico;
insert into Consumo_Energetico (zona, consumo_kw, fecha_consumo) values
('Central', '10000','2019-02-04'),
('Occidental', '12000','2019-02-04'),
('Norte', '7000','2019-02-04'),
('Sur', '8000','2019-02-04'),
('Periferia', '5000','2019-02-04');
select * from Consumo_Energetico;

-- TRIGGERS
-- 1

DELIMITER //
CREATE TRIGGER Verificar_Consumo_Maximo
BEFORE INSERT ON Consumo_Energetico
FOR EACH ROW
BEGIN
INSERT INTO consumo_energetico(consumo_kw) VALUES(CHECK (NEW.consumo_kw < 10000);
END //

DELIMITER ;

-- 2

DELIMITER //

CREATE TRIGGER Actualizar_Timestamp_Sensores
AFTER INSERT ON Registro_sensores
FOR EACH ROW
BEGIN
INSERT INTO fecha_registro ()
END //
DELIMITER ;