-- Estructura de tabla para la tabla `Pasajeros` --
CREATE TABLE pasajeros(
IdPasajeros INT,
Nombre VARCHAR(125),
DireccionResidencia VARCHAR(125),
FechaNacimiento DATE,
CONSTRAINT id_pasajeros_pk PRIMARY KEY(IdPasajeros));

-- Llenado de datos para la tabla `Pasajeros`
INSERT INTO pasajeros(IdPasajeros, Nombre, DireccionResidencia, FechaNacimiento)
	VALUES (1,'Primer Pasajero', 'Direccion X', '1985-06-10'),
	(2,'Segundo Pasajero', 'Direccion Y', '1990-07-23'),
	(3,'Tercer Pasajero','Direccion Z','1994-11-30');
	
-- Estructura de tabla para la tabla `Trenes` --
CREATE TABLE trenes(
IdTrenes INT,
Modelo VARCHAR(125),
Capacidad VARCHAR(125),
CONSTRAINT id_trenes_pk PRIMARY KEY(IdTrenes));

-- Llenado de datos para la tabla `Trenes`
INSERT INTO trenes(IdTrenes, Modelo, Capacidad)
	VALUES (1,'Primer Modelo', '123 KG'),
	(2,'Segundo Modelo', '205 KG'),
	(3,'Tercer Modelo','506 KG');
	
-- Estructura de tabla para la tabla `Estaciones` --
CREATE TABLE estaciones(
IdEstaciones INT,
Nombre VARCHAR(125),
Direccion VARCHAR(125),
CONSTRAINT id_estaciones_pk PRIMARY KEY(IdEstaciones));

-- Llenado de datos para la tabla `Estaciones`
INSERT INTO estaciones(IdEstaciones, Nombre, Direccion)
	VALUES (1,'Primer Nombre', 'Calle 123'),
	(2,'Segundo Nombre', 'Calle 345'),
	(3,'Tercer Nombre', 'Calle 567');
	
-- Estructura de tabla para la tabla `Trayectos` --
CREATE TABLE trayectos(
IdTrayectos INT,
IdEstacion INT,
IdTren INT,
CONSTRAINT id_trayectos_pk PRIMARY KEY(IdTrayectos),
CONSTRAINT id_estacion_fk FOREIGN KEY(IdEstacion) REFERENCES estaciones(IdEstaciones) ,
CONSTRAINT id_tren_fk FOREIGN KEY(IdTren) REFERENCES trenes(IdTrenes));

-- Llenado de datos para la tabla `Trayectos`
INSERT INTO trayectos(IdTrayectos, IdEstacion, IdTren)
	VALUES (1,1,1),
	(2,2,2),
	(3,3,3);

-- Estructura de tabla para la tabla `Viajes` --
CREATE TABLE viajes(
IdViajes INT,
IdPasajero INT,
IdTrayecto INT,
Inicio TIME,
Fin TIME,
CONSTRAINT id_viajes_pk PRIMARY KEY(IdViajes),
CONSTRAINT id_pasajero_fk FOREIGN KEY(IdPasajero) REFERENCES pasajeros(IdPasajeros),
CONSTRAINT id_trayecto_fk FOREIGN KEY(IdTrayecto) REFERENCES trayectos(IdTrayectos));

-- Llenado de datos para la tabla `Trayectos`
INSERT INTO viajes(IdViajes, IdPasajero, IdTrayecto, Inicio, Fin)
	VALUES (1,1,1,'07:33','09:00'),
	(2,2,2,'09:20','13:00'),
	(3,3,3,'08:15','09:33');
	
