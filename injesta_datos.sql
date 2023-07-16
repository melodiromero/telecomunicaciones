CREATE DATABASE telecomunicaciones;
USE telecomunicaciones;

# 1) Datos: Penetración de Internet fijo (accesos por cada 100 hogares)
# (Número de accesos al servicio de Internet fijo por cada 100 hogares por provincia)

# Creación de tabla internet_penetracion_hogares
DROP TABLE internet_penetracion;

CREATE TABLE IF NOT EXISTS internet_penetracion(
anio 	  		YEAR,
trimestre 		TINYINT(1),
provincia 		VARCHAR(100),
accesos_hogares TEXT 
);

# Para localizar donde se debe guardar los archivos a cargar ejecutamos: SHOW VARIABLES LIKE 'secure_file_priv';
SHOW VARIABLES LIKE 'secure_file_priv';

# En mi caso es C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\  -- entonces muevo ahi todos mis archivos.csv

# Hago la injesta de datos internet_penetracion
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/internet_penetracion_accesosporcada100hogares.csv' 
INTO TABLE `internet_penetracion`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

SELECT * FROM internet_penetracion;
# 840 registros insertados

# 2) Datos: Penetración por hogares nacional de Internet fijo
# Serie trimestral de la penetración del Internet fijo en la métrica por cada 100 hogares

DROP TABLE internet_penetracion_periodo;

CREATE TABLE IF NOT EXISTS internet_penetracion_periodo(
anio 	  			YEAR,
trimestre 			TINYINT(1),
accesos_hogares 	TEXT,
accesos_habitantes 	TEXT,
periodo 			TEXT
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/internet_penetracion_porhogarnacional.csv' 
INTO TABLE `internet_penetracion_periodo`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

SELECT * FROM internet_penetracion_periodo;
# 35 registros insertados

# 3) Datos: Total nacional de accesos a Internet fijo por banda ancha y banda angosta
# Número total de accesos al servicio de Internet fijo por banda ancha y banda angosta (trimestral)

DROP TABLE accesos_baf_trimestre;

CREATE TABLE IF NOT EXISTS accesos_baf_trimestre(
anio 	  		YEAR,
trimestre 		TINYINT(1),
banda_ancha 	INTEGER(11),
banda_angosta 	INTEGER(11),
total 			INTEGER(11),
periodo			TEXT
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Internet_BAF.csv' 
INTO TABLE `accesos_baf_trimestre`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

SELECT * FROM accesos_baf_trimestre;
# 35 registros insertados

# 4) Datos: Accesos a banda ancha y banda angosta por provincia
# Número de accesos al servicio de Internet fijo por banda ancha y banda angosta en cada provincia (trimestral)

DROP TABLE accesos_baf_trimestre_provincia;

CREATE TABLE IF NOT EXISTS accesos_baf_trimestre_provincia(
anio 	  		YEAR,
trimestre 		TINYINT(1),
provincia		VARCHAR(100),
banda_ancha 	INTEGER(11),
banda_angosta 	TEXT,
total 			INTEGER(11)
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Internet_BAF_porprovincia.csv' 
INTO TABLE `accesos_baf_trimestre_provincia`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

SELECT * FROM accesos_baf_trimestre_provincia;
# 840 registros insertados

# 5) Serie trimestral de accesos a Internet fijo por tecnología
# Número de accesos al servicio de Internet fijo por tipo de tecnología. Total nacional (trimestral)

DROP TABLE internet_accesos_portecnologia;

CREATE TABLE IF NOT EXISTS internet_accesos_portecnologia(
anio 	  		YEAR,
trimestre 		TINYINT(1),
adsl			INTEGER(11),
cablemodem 		INTEGER(11),
fibraoptica 	INTEGER(11),
wireless 		INTEGER(11),
otros			INTEGER(11),
total			INTEGER(11),
periodo			VARCHAR(100)
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Internet_Accesos-por-tecnologia.csv' 
INTO TABLE `internet_accesos_portecnologia`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

SELECT * FROM internet_accesos_portecnologia;
# 35 registros insertados

# Detectos outliers -necesito comparar mi eda

SELECT AVG(fibraoptica) + 3 * STD(fibraoptica) AS maximo FROM internet_accesos_portecnologia;

SELECT * FROM internet_accesos_portecnologia WHERE fibraoptica > 3063656.8182951887
# 3063656.8182951887

# 6) Datos: Acceso a Internet fijo por tecnología y provincia
#Número de accesos al servicio de Internet fijo por tipo de tecnología en cada provincia (trimestral)

DROP TABLE internet_accesos_portecnologia_porprovincia;

CREATE TABLE IF NOT EXISTS internet_accesos_portecnologia_porprovincia(
anio 	  		VARCHAR(100),
trimestre 		VARCHAR(100),
provincia		VARCHAR(100),
adsl			INTEGER(11),
cablemodem 		INTEGER(11),
fibraoptica 	INTEGER(11),
wireless 		INTEGER(11),
otros			INTEGER(11),
total			INTEGER(11)
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Internet_Accesos-por-tecnologiayporprovincia_limpio.csv' 
INTO TABLE `internet_accesos_portecnologia_porprovincia`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

SELECT * FROM internet_accesos_portecnologia_porprovincia;
# 840 registros insertados


# 7) Datos: Listado de las provincias/ departamentos/ localidades con acceso a intenetç
DROP TABLE localidades_accesointernet;
CREATE TABLE IF NOT EXISTS localidades_accesointernet(
provincia 	  	VARCHAR(100),
partido 		VARCHAR(100),
localidad		VARCHAR(100),
adsl			VARCHAR(100),
cablemodem 		VARCHAR(100),
dialup			VARCHAR(100),
fibraoptica 	VARCHAR(100),
t_4g			VARCHAR(100),
t_3g			VARCHAR(100),
telefoniafija	VARCHAR(100),
wireless 		VARCHAR(100),
satelital		VARCHAR(100)
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Listadodelocalidadesconconectividadainternet.csv' 
INTO TABLE `localidades_accesointernet`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

SELECT * FROM localidades_accesointernet;
# 4312 registros insertados

# 8) Datos: Conectividad al servicio de Internet
# Consulta las tecnologías disponibles en tu localidad para acceder al servicio de Internet fijo y móvil

DROP TABLE localidades_accesointernet_latylon;
CREATE TABLE IF NOT EXISTS localidades_accesointernet_latylon(
provincia 	  	VARCHAR(100),
partido 		VARCHAR(100),
localidad		VARCHAR(100),
poblacion		INT(11),
adsl			VARCHAR(100),
cablemodem 		VARCHAR(100),
dialup			VARCHAR(100),
fibraoptica 	VARCHAR(100),
satelital		VARCHAR(100),
wireless 		VARCHAR(100),
telefoniafija	VARCHAR(100),
t_4g			VARCHAR(100),
t_3g			VARCHAR(100),
link			VARCHAR(100) DEFAULT NULL,
latitud		    VARCHAR(100),
longitud		VARCHAR(100)
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ConectividadalserviciodeInternet_limpiado.csv' 
INTO TABLE `localidades_accesointernet_latylon`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

SELECT * FROM localidades_accesointernet_latylon;
# 4307 registros insertados, en el eda se elimino 5.

# NORMALIZACION DE LOS DATOS
# ENTIDADES DE PROVINCIAS, PARTIDOS, LOCALIDADES
USE telecomunicaciones;
-- Para el caso de PROVINCIAS usaremos un dataset adicional brindado
-- por la pagina de datos.gob.ar,  el cual posee los datos de longitud y latitud
-- Fuente: https://datos.gob.ar/dataset/jgm-servicio-normalizacion-datos-geograficos/archivo/jgm_8.26
DROP TABLE provincias;
CREATE TABLE IF NOT EXISTS provincias(
id_provincia 	INT(11) AUTO_INCREMENT,
nombre 	  		VARCHAR(100),
centroide_lat	VARCHAR(100),
centroide_lon	VARCHAR(100),
PRIMARY KEY(id_provincia)
);

# Hago la injesta de datos en provincias
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/provincias.csv' 
INTO TABLE provincias
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES
(nombre, centroide_lat, centroide_lon);

SELECT * FROM provincias;

ALTER TABLE provincias CHANGE `centroide_lat` `latitud` VARCHAR(100);
ALTER TABLE provincias CHANGE `centroide_lon` `longitud` VARCHAR(100);

SELECT * FROM provincias;

-- Se tiene tablas con datos similares: localidades_accesointernet y localidades_accesointernet_latylon
-- Se elije localidades_accesointernet_latylon para trabajar ya que adiciona latitud lingitud, link y poblacion. 
SET SQL_SAFE_UPDATES = 0;
UPDATE localidades_accesointernet_latylon AS l
SET l.provincia = IFNULL((SELECT p.id_provincia FROM provincias AS p WHERE UPPER(p.nombre) =  l.provincia), l.provincia);

SELECT * FROM localidades_accesointernet_latylon; 
-- Se observa registros que tiene CABA y en provincias tenemos Ciudad Autónoma de Buenos Aires
-- Entonces imputamos esos valores
UPDATE localidades_accesointernet_latylon SET provincia = 22 WHERE provincia = 'CABA';

SELECT DISTINCT provincia FROM localidades_accesointernet_latylon; 
-- se cambia el tipo de dato para provincia a  id_provincia en localidades_accesointernet_latylon
ALTER TABLE localidades_accesointernet_latylon CHANGE `provincia` `id_provincia` INT(11);

SELECT DISTINCT id_provincia FROM localidades_accesointernet_latylon ORDER BY 1 ASC;
-- Se han imputado bien las provincias para esta tabla

-- Creacion de Entidad Partidos:
-- La denominación partidos de usan en Buenos Aires, para las demas provincias se usa departamentos.
DROP TABLE partidos;
CREATE TABLE IF NOT EXISTS partidos(
id_partido 		INT(11) AUTO_INCREMENT,
nombre 	  		VARCHAR(100),
PRIMARY KEY(id_partido)
);

INSERT INTO partidos(nombre) (SELECT DISTINCT partido FROM localidades_accesointernet_latylon);

SELECT * FROM partidos;
-- se actualiza las referencias de los partidos en localidades_accesointernet_latylon
UPDATE localidades_accesointernet_latylon AS l SET l.partido = (SELECT p.id_partido FROM partidos AS p WHERE l.partido = p.nombre);

SELECT * FROM localidades_accesointernet_latylon;

-- Creacion de la tabla localidades con sus datos:
DROP TABLE localidades;
CREATE TABLE IF NOT EXISTS localidades(
id_localidad 		INT(11) AUTO_INCREMENT,
nombre 	  			VARCHAR(100) NOT NULL,
id_provincia		INT(11) NOT NULL,
id_partido			INT(11) NOT NULL,
latitud				VARCHAR(100),
longitud			VARCHAR(100),
PRIMARY KEY(id_localidad)
);

INSERT INTO localidades(nombre,id_provincia,id_partido,latitud,longitud) 
SELECT DISTINCT localidad, id_provincia, partido, latitud, longitud FROM localidades_accesointernet_latylon;

SELECT * FROM localidades;
-- ver si no se insertaron registros duplicados 
SELECT COUNT(*), nombre, id_provincia, id_partido FROM localidades
GROUP BY nombre, id_provincia, id_partido
HAVING COUNT(*)>1;
-- No hay duplicados insertados.

SELECT COUNT(*), localidad, id_provincia, partido FROM localidades_accesointernet_latylon
GROUP BY localidad, id_provincia, partido
HAVING COUNT(*)>1;

SELECT *  FROM localidades_accesointernet_latylon 
WHERE localidad =  'COLONIA SEGOVIA' AND id_provincia=9 AND partido = 241;
-- registro que difiere en las tecnologias tildadas con poblacion 0 y poblacion 4271

SELECT *  FROM localidades_accesointernet_latylon 
WHERE localidad =  'Villa Sanagasta' AND id_provincia=10 AND partido = 427;
-- registro que difiere en las tecnologias tildadas con poblacion 0 y poblacion 2275

-- imputo localidad por su id en localidades_accesointernet_latylon
UPDATE localidades_accesointernet_latylon AS l SET l.localidad =
IFNULL((SELECT l1.id_localidad FROM localidades AS l1 
 WHERE l1.nombre = l.localidad AND l1.id_provincia = l.id_provincia AND l1.id_partido = l.partido), l.localidad);

SET SQL_SAFE_UPDATES = 0;
SET @@local.net_read_timeout=360;
SELECT * FROM localidades_accesointernet_latylon;

-- Se puede borrar los campos latitud y longitud ya que estan en la tabla de localidades
-- Se renombra partido y localidad 
ALTER TABLE localidades_accesointernet_latylon CHANGE `partido` `id_partido` INT(11);
ALTER TABLE localidades_accesointernet_latylon CHANGE `localidad` `id_localidad` INT(11);

ALTER TABLE localidades_accesointernet_latylon DROP COLUMN latitud;
ALTER TABLE localidades_accesointernet_latylon DROP COLUMN longitud;
SELECT * FROM localidades_accesointernet_latylon;
-- Se puede normalizar las columnas de las tecnolgias por una tabla de relacion de tecnologias con las localidades
-- pero hay casos como el de'COLONIA SEGOVIA y 'Villa Sanagasta' que tienen dos registro poblacion con cero y un numero mayor a cero, pero tildan distintas tecnologias
-- entonces, dejamos asi esta tabla. Renombramos como mapeo_localidades_tecnologias
	
RENAME TABLE localidades_accesointernet_latylon TO mapeo_localidades_tecnologias;


-- Entidad Tecnologias de Acceso a Internet
DROP TABLE tecnologiasAcceso;
CREATE TABLE IF NOT EXISTS tecnologiasAcceso(
id_tecnologiaacceso INT(11) AUTO_INCREMENT,
nombre 	  			VARCHAR(100) NOT NULL,
PRIMARY KEY(id_tecnologiaacceso)
);

SELECT * FROM tecnologiasAcceso;
-- se cargan los datos de acuerdo a las tecnologias visualizadas como columnas en localidades_accesointernet_latylon
INSERT INTO tecnologiasAcceso(nombre) VALUES('ADSL');
INSERT INTO tecnologiasAcceso(nombre) VALUES('Cablemodem');
INSERT INTO tecnologiasAcceso(nombre) VALUES('Dial-Up');
INSERT INTO tecnologiasAcceso(nombre) VALUES('Fibra óptica');
INSERT INTO tecnologiasAcceso(nombre) VALUES('Satelital');
INSERT INTO tecnologiasAcceso(nombre) VALUES('Wireless');
INSERT INTO tecnologiasAcceso(nombre) VALUES('Telefonia fija');
INSERT INTO tecnologiasAcceso(nombre) VALUES('4G');
INSERT INTO tecnologiasAcceso(nombre) VALUES('3G');

# Ahora se ve internet_accesos_portecnologia y internet_accesos_portecnologia_porprovincia
SELECT * FROM internet_accesos_portecnologia;
SELECT * FROM internet_accesos_portecnologia_porprovincia;

-- Se reemplaza provincia por id_provincia 

UPDATE internet_accesos_portecnologia_porprovincia AS i SET i.provincia =
IFNULL((SELECT p.id_provincia FROM provincias AS p 
 WHERE p.nombre = i.provincia), i.provincia);

SELECT * FROM internet_accesos_portecnologia_porprovincia;
-- Se observa capital federal y en provincias tenemos Ciudad Autonoma de Buenos Aires, imputamos por 22

UPDATE internet_accesos_portecnologia_porprovincia AS i SET i.provincia = 22 WHERE i.provincia = 'Capital Federal'
SELECT * FROM internet_accesos_portecnologia_porprovincia;

ALTER TABLE internet_accesos_portecnologia_porprovincia CHANGE `provincia` `id_provincia` INT(11);


# ENTIDADES DE AÑOS Y PERIODOS
-- Entidad Años
DROP TABLE anios;
CREATE TABLE IF NOT EXISTS anios(
id_anio INT(11) AUTO_INCREMENT,
anio	YEAR NOT NULL,
PRIMARY KEY(id_anio)
);

INSERT INTO anios(anio)
SELECT DISTINCT TRIM(i.anio) FROM internet_accesos_portecnologia_porprovincia AS i ORDER BY 1 ASC ;

SELECT * FROM anios;

-- Entidad Trimestres
DROP TABLE trimestres;
CREATE TABLE IF NOT EXISTS trimestres(
id_trimestre 	INT(11) AUTO_INCREMENT,
numero		TINYINT(1) NOT NULL,
descripcion	VARCHAR(50) NOT NULL,
PRIMARY KEY(id_trimestre)
);

INSERT INTO trimestres(numero, descripcion) VALUES(1, 'Enero-Marzo');
INSERT INTO trimestres(numero, descripcion) VALUES(2, 'Abril-Junio');
INSERT INTO trimestres(numero, descripcion) VALUES(3, 'Julio-Septiembre');
INSERT INTO trimestres(numero, descripcion) VALUES(4, 'Octubre-Diciembre');

SELECT * FROM trimestres;

-- Ahora se reemplaza en donde corresponda:
-- se edita el tipo de dato year a intero
ALTER TABLE internet_accesos_portecnologia CHANGE `anio` `id_anio` INT(11);

UPDATE internet_accesos_portecnologia AS i SET i.id_anio = (SELECT a.id_anio FROM anios AS a WHERE i.id_anio = a.anio)

-- En cuanto al trimestre coincide el valor del id con el de internet_accesos_portecnologia (y mismo caso sera con internet_accesos_portecnologia_porprovincia), solo se renombra
ALTER TABLE internet_accesos_portecnologia CHANGE `trimestre` `id_trimestre` TINYINT(1) NOT NULL;

-- se borra periodo
ALTER TABLE internet_accesos_portecnologia DROP COLUMN periodo;

SELECT * FROM internet_accesos_portecnologia;

-- Ahora se ve la tabla `internet_accesos_portecnologia_porprovincia`
ALTER TABLE internet_accesos_portecnologia_porprovincia CHANGE `anio` `id_anio` INT(11) NOT NULL;

ALTER TABLE internet_accesos_portecnologia_porprovincia CHANGE `trimestre` `id_trimestre` TINYINT(1) NOT NULL;

UPDATE internet_accesos_portecnologia_porprovincia AS i SET i.id_anio = (SELECT a.id_anio FROM anios AS a WHERE i.id_anio = a.anio)

-- QUEDA NORMALIZAR LAS TECNOLOGIAS
SELECT SUM(fibraoptica) FROM `internet_accesos_portecnologia_porprovincia`


SELECT * FROM `localidades_accesointernet` WHERE localidad = 'Ciudad Autónoma de Buenos Aires';


SELECT SUM(total) FROM `internet_accesos_portecnologia` WHERE 


SELECT * FROM `mapeo_localidades_tecnologias` WHERE poblacion = 0`accesos_baf_trimestre`

-- se mejora la calidad de los datos en `mapeo_localidades_tecnologias`, ya que repite los campos id_provincia y id_partido, 
-- con id_localidad es suficiente, que que se joinea con localidades y se obtienen esos datos del id_provincia y id_partido

ALTER TABLE mapeo_localidades_tecnologias DROP COLUMN id_provincia;

ALTER TABLE mapeo_localidades_tecnologias DROP COLUMN id_partido;

SELECT * FROM mapeo_localidades_tecnologias WHERE poblacion = 0 AND fibraoptica = '--'