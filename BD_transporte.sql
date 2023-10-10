----------- Creacion de las tablas ----------------
-- Estructura de tabla para la tabla `Pasajeros` --
CREATE TABLE pasajeros(
IdPasajeros INT,
Nombre VARCHAR(125),
DireccionResidencia VARCHAR(125),
FechaNacimiento DATE,
CONSTRAINT id_pasajeros_pk PRIMARY KEY(IdPasajeros));
	
-- Estructura de tabla para la tabla `Trenes` --
CREATE TABLE trenes(
IdTrenes INT,
Modelo VARCHAR(125),
Capacidad VARCHAR(125),
CONSTRAINT id_trenes_pk PRIMARY KEY(IdTrenes));
	
-- Estructura de tabla para la tabla `Estaciones` --
CREATE TABLE estaciones(
IdEstaciones INT,
Nombre VARCHAR(125),
Direccion VARCHAR(125),
CONSTRAINT id_estaciones_pk PRIMARY KEY(IdEstaciones));
	
-- Estructura de tabla para la tabla `Trayectos` --
CREATE TABLE trayectos(
IdTrayectos INT,
IdEstacion INT,
IdTren INT,
CONSTRAINT id_trayectos_pk PRIMARY KEY(IdTrayectos),
CONSTRAINT id_estacion_fk FOREIGN KEY(IdEstacion) REFERENCES estaciones(IdEstaciones) ,
CONSTRAINT id_tren_fk FOREIGN KEY(IdTren) REFERENCES trenes(IdTrenes));

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

----------- Creacion de ROLES ----------------
CREATE ROLE usuario_consulta WITH
	LOGIN
	INHERIT
	PASSWORD 'etc123';