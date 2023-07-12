CREATE DATABASE telecomunicaciones;
USE telecomunicaciones;

# 1) Datos: Penetración de Internet fijo (accesos por cada 100 hogares)
# (Número de accesos al servicio de Internet fijo por cada 100 hogares por provincia)

# Creación de tabla internet_penetracion_hogares
drop table internet_penetracion;

CREATE TABLE IF NOT EXISTS internet_penetracion(
anio 	  		year,
trimestre 		tinyint(1),
provincia 		varchar(100),
accesos_hogares text 
);

# Para localizar donde se debe guardar los archivos a cargar ejecutamos: SHOW VARIABLES LIKE 'secure_file_priv';
SHOW VARIABLES LIKE 'secure_file_priv';

# En mi caso es C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\  -- entonces muevo ahi todos mis archivos.csv

# Hago la injesta de datos internet_penetracion
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/internet_penetracion_accesosporcada100hogares.csv' 
INTO TABLE `internet_penetracion`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

select * from internet_penetracion;
# 840 registros insertados

# 2) Datos: Penetración por hogares nacional de Internet fijo
# Serie trimestral de la penetración del Internet fijo en la métrica por cada 100 hogares

drop table internet_penetracion_periodo;

CREATE TABLE IF NOT EXISTS internet_penetracion_periodo(
anio 	  			year,
trimestre 			tinyint(1),
accesos_hogares 	text,
accesos_habitantes 	text,
periodo 			text
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/internet_penetracion_porhogarnacional.csv' 
INTO TABLE `internet_penetracion_periodo`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

select * from internet_penetracion_periodo;
# 35 registros insertados

# 3) Datos: Total nacional de accesos a Internet fijo por banda ancha y banda angosta
# Número total de accesos al servicio de Internet fijo por banda ancha y banda angosta (trimestral)

drop table accesos_baf_trimestre;

CREATE TABLE IF NOT EXISTS accesos_baf_trimestre(
anio 	  		year,
trimestre 		tinyint(1),
banda_ancha 	integer(11),
banda_angosta 	integer(11),
total 			integer(11),
periodo			text
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Internet_BAF.csv' 
INTO TABLE `accesos_baf_trimestre`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

select * from accesos_baf_trimestre;
# 35 registros insertados

# 4) Datos: Accesos a banda ancha y banda angosta por provincia
# Número de accesos al servicio de Internet fijo por banda ancha y banda angosta en cada provincia (trimestral)

drop table accesos_baf_trimestre_provincia;

CREATE TABLE IF NOT EXISTS accesos_baf_trimestre_provincia(
anio 	  		year,
trimestre 		tinyint(1),
provincia		varchar(100),
banda_ancha 	integer(11),
banda_angosta 	text,
total 			integer(11)
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Internet_BAF_porprovincia.csv' 
INTO TABLE `accesos_baf_trimestre_provincia`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

select * from accesos_baf_trimestre_provincia;
# 840 registros insertados

# 5) Serie trimestral de accesos a Internet fijo por tecnología
# Número de accesos al servicio de Internet fijo por tipo de tecnología. Total nacional (trimestral)

drop table internet_accesos_portecnologia;

CREATE TABLE IF NOT EXISTS internet_accesos_portecnologia(
anio 	  		year,
trimestre 		tinyint(1),
adsl			integer(11),
cablemodem 		integer(11),
fibraoptica 	integer(11),
wireless 		integer(11),
otros			integer(11),
total			integer(11),
periodo			varchar(100)
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Internet_Accesos-por-tecnologia.csv' 
INTO TABLE `internet_accesos_portecnologia`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

select * from internet_accesos_portecnologia;
# 35 registros insertados
maximo = df['Fibra óptica'].mean() + 3 * df['Fibra óptica'].std()
print(maximo)

select avg(fibraoptica) + 3 * std(fibraoptica) as maximo from internet_accesos_portecnologia;

select * from internet_accesos_portecnologia where fibraoptica > 3063656.8182951887
3063656.8182951887

# 6) Datos: Acceso a Internet fijo por tecnología y provincia
#Número de accesos al servicio de Internet fijo por tipo de tecnología en cada provincia (trimestral)

drop table internet_accesos_portecnologia_porprovincia;

CREATE TABLE IF NOT EXISTS internet_accesos_portecnologia_porprovincia(
anio 	  		varchar(100),
trimestre 		varchar(100),
provincia		varchar(100),
adsl			integer(11),
cablemodem 		integer(11),
fibraoptica 	integer(11),
wireless 		integer(11),
otros			integer(11),
total			integer(11)
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Internet_Accesos-por-tecnologiayporprovincia.csv' 
INTO TABLE `internet_accesos_portecnologia_porprovincia`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

select * from internet_accesos_portecnologia_porprovincia;
# 840 registros insertados



# 7) Datos: Listado de las provincias/ departamentos/ localidades con acceso a intenetç
drop table localidades_accesointernet;
CREATE TABLE IF NOT EXISTS localidades_accesointernet(
provincia 	  	varchar(100),
partido 		varchar(100),
localidad		varchar(100),
adsl			varchar(100),
cablemodem 		varchar(100),
dialup			varchar(100),
fibraoptica 	varchar(100),
t_4g			varchar(100),
t_3g			varchar(100),
telefoniafija	varchar(100),
wireless 		varchar(100),
satelital		varchar(100)
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Listadodelocalidadesconconectividadainternet.csv' 
INTO TABLE `localidades_accesointernet`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

select * from localidades_accesointernet;
# 4312 registros insertados


# 8) Datos: Conectividad al servicio de Internet
# Consulta las tecnologías disponibles en tu localidad para acceder al servicio de Internet fijo y móvil

drop table localidades_accesointernet_latylon;
CREATE TABLE IF NOT EXISTS localidades_accesointernet_latylon(
provincia 	  	varchar(100),
partido 		varchar(100),
localidad		varchar(100),
poblacion		int(11),
adsl			varchar(100),
cablemodem 		varchar(100),
dialup			varchar(100),
fibraoptica 	varchar(100),
satelital		varchar(100),
wireless 		varchar(100),
telefoniafija	varchar(100),
t_4g			varchar(100),
t_3g			varchar(100),
link			varchar(100) default NULL,
latitud		    varchar(100),
longitud		varchar(100)
);

# Hago la injesta de datos en internet_penetracion_periodo
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ConectividadalserviciodeInternet.csv' 
INTO TABLE `localidades_accesointernet_latylon`
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES; 

select * from localidades_accesointernet_latylon;
# 4312 registros insertados

# NORMALIZACION DE LOS DATOS
# ENTIDADES DE PROVINCIAS, PARTIDOS, LOCALIDADES
use telecomunicaciones;
-- Para el caso de PROVINCIAS usaremos un dataset adicional brindado
-- por la pagina de datos.gob.ar,  el cual posee los datos de longitud y latitud
-- Fuente: https://datos.gob.ar/dataset/jgm-servicio-normalizacion-datos-geograficos/archivo/jgm_8.26
DROP TABLE provincias;
CREATE TABLE IF NOT EXISTS provincias(
id_provincia 	int(11) auto_increment,
nombre 	  		varchar(100),
centroide_lat	varchar(100),
centroide_lon	varchar(100),
primary key(id_provincia)
);

# Hago la injesta de datos en provincias
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/provincias.csv' 
INTO TABLE provincias
FIELDS TERMINATED BY ';' ENCLOSED BY '' 
LINES TERMINATED BY '\n' IGNORE 1 LINES
(nombre, centroide_lat, centroide_lon);

select * from provincias;

ALTER TABLE provincias CHANGE `centroide_lat` `latitud` varchar(100);
ALTER TABLE provincias CHANGE `centroide_lon` `longitud` varchar(100);

select * from provincias;

-- Se tiene tablas con datos similares: localidades_accesointernet y localidades_accesointernet_latylon
-- Se elije localidades_accesointernet_latylon para trabajar ya que adiciona latitud lingitud, link y poblacion. 
SET SQL_SAFE_UPDATES = 0;
update localidades_accesointernet_latylon as l
set l.provincia = ifnull((select p.id_provincia from provincias as p where upper(p.nombre) =  l.provincia), l.provincia);

select * from localidades_accesointernet_latylon; 
-- Se observa registros que tiene CABA y en provincias tenemos Ciudad Autónoma de Buenos Aires
-- Entonces imputamos esos valores
update localidades_accesointernet_latylon set provincia = 22 where provincia = 'CABA';

select distinct provincia from localidades_accesointernet_latylon; 
-- se cambia el tipo de dato para provincia a  id_provincia en localidades_accesointernet_latylon
ALTER TABLE localidades_accesointernet_latylon CHANGE `provincia` `id_provincia` int(11);

select distinct id_provincia from localidades_accesointernet_latylon order by 1 asc;
-- Se han imputado bien las provincias para esta tabla

-- Creacion de Entidad Partidos:
-- La denominación partidos de usan en Buenos Aires, para las demas provincias se usa departamentos.
DROP TABLE partidos;
CREATE TABLE IF NOT EXISTS partidos(
id_partido 		int(11) auto_increment,
nombre 	  		varchar(100),
primary key(id_partido)
);

insert into partidos(nombre) (select distinct partido from localidades_accesointernet);

select * from partidos;
-- se actualiza las referencias de los partidos en localidades_accesointernet
update localidades_accesointernet_latylon as l set l.partido = (select p.id_partido from partidos as p where l.partido = p.nombre);

select * from localidades_accesointernet_latylon;

-- Creacion de la tabla localidades con sus datos:
DROP TABLE localidades;
CREATE TABLE IF NOT EXISTS localidades(
id_localidad 		int(11) auto_increment,
nombre 	  			varchar(100) not null,
id_provincia		int(11) not null,
id_partido			int(11) not null,
latitud				varchar(100),
longitud			varchar(100),
primary key(id_localidad)
);

insert into localidades(nombre,id_provincia,id_partido,latitud,longitud) 
select localidad, id_provincia, partido, latitud, longitud from localidades_accesointernet_latylon;

select * from localidades;

