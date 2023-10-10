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
	
----------- JOINS ----------------
SELECT * FROM pasajeros
JOIN viajes ON (viajes.IdPasajero = pasajeros.IdPasajeros);

SELECT * FROM pasajeros
LEFT JOIN viajes ON (viajes.IdPasajero = pasajeros.IdPasajeros)
WHERE viajes.IdViajes IS NULL; 

SELECT * FROM trenes
RIGHT JOIN trayectos ON (trayectos.IdTren = trenes.IdTrenes);

------------ Consulta CASE de Mayor y Menor ------------
SELECT IdPasajeros, DireccionResidencia, FechaNacimiento,
CASE 
WHEN FechaNacimiento > '2015-01-01' 
THEN
	'Menor'
ELSE 
	'Mayor'
END
FROM pasajeros;

------------ Consulta CASE de Nombres que comienzan con (a,e,i,o,u) y Mayores de Edad ------------
SELECT Nombre, FechaNacimiento,
CASE 
WHEN Nombre ILIKE 'a%' 
THEN 
	'Vocal A'
WHEN Nombre ILIKE 'e%' 
THEN 
	'Vocal E'
WHEN Nombre ILIKE 'i%' 
THEN 
	'Vocal I'
WHEN Nombre ILIKE 'o%' 
THEN 
	'Vocal O'
WHEN Nombre ILIKE 'u%' 
THEN 
	'Vocal U'
ELSE
	CONCAT('Abecedario',' ',SUBSTRING(Nombre,1,1))
END AS "Nombres Vocales",
CASE
WHEN FechaNacimiento < '2005-01-01'
THEN 
	'Mayor de Edad'
ELSE
	'Menor de Edad'
END AS "EDAD"
FROM pasajeros;

------------ Creación de View ------------
CREATE VIEW rango_view
 AS
SELECT Nombre, FechaNacimiento,
CASE 
WHEN Nombre ILIKE 'a%' 
THEN 
	'Vocal A'
WHEN Nombre ILIKE 'e%' 
THEN 
	'Vocal E'
WHEN Nombre ILIKE 'i%' 
THEN 
	'Vocal I'
WHEN Nombre ILIKE 'o%' 
THEN 
	'Vocal O'
WHEN Nombre ILIKE 'u%' 
THEN 
	'Vocal U'
ELSE
	CONCAT('Abecedario',' ',SUBSTRING(Nombre,1,1))
END AS "Nombres Vocales",
CASE
WHEN FechaNacimiento < '2005-01-01'
THEN 
	'Mayor de Edad'
ELSE
	'Menor de Edad'
END AS "EDAD"
FROM pasajeros;
;

------------ PL/SQL ------------
DO $$
DECLARE 
	rec record;
	cont int := 0;
BEGIN 
	FOR rec IN SELECT * FROM pasajeros LOOP
		RAISE NOTICE 'El pasajero se llama %' , rec.nombre;
		cont = cont + 1;
	END LOOP;
	RAISE NOTICE 'El Conteo es: %' , cont;
END
$$

---------------------------------
CREATE FUNCTION FuncionPL()
	RETURNS void
	AS $$
DECLARE 
	rec record;
	cont int := 0;
BEGIN 
	FOR rec IN SELECT * FROM pasajeros LOOP
		RAISE NOTICE 'El pasajero se llama %' , rec.nombre;
		cont = cont + 1;
	END LOOP;
	RAISE NOTICE 'El Conteo es: %' , cont;
END
$$
LANGUAGE PLPGSQL;

SELECT FuncionPL();

---------------------------------
CREATE FUNCTION impl()
    RETURNS integer
    LANGUAGE 'plpgsql'
    
AS $BODY$
DECLARE 
	rec record;
	cont int := 0;
BEGIN 
	FOR rec IN SELECT * FROM pasajeros LOOP
		RAISE NOTICE 'El pasajero se llama %' , rec.nombre;
		cont := cont + 1;
	END LOOP;
	RAISE NOTICE 'El Conteo es: %' , cont;
	RETURN cont;
END
$BODY$;

SELECT impl();

-------------- TRIGGERS -------------------
CREATE OR REPLACE FUNCTION impl()
    RETURNS TRIGGER
    LANGUAGE 'plpgsql'
AS $BODY$
DECLARE 
	rec record;
	cont int := 0;
BEGIN 
	FOR rec IN SELECT * FROM pasajeros LOOP
		cont := cont + 1;
	END LOOP;
	INSERT INTO cont_pasajeros(total,tiempo)
	VALUES (cont,now());
END
$BODY$;

CREATE TRIGGER mitrigger
AFTER INSERT
ON pasajeros
FOR EACH ROW
EXECUTE PROCEDURE impl();

SELECT impl();
SELECT * FROM cont_pasajeros;
SELECT * FROM pasajeros;

INSERT INTO pasajeros(IdPasajeros,Nombre,DireccionResidencia,FechaNacimiento)
VALUES(102,'Nombre Trigger','Dir Acá','2000-01-01');
