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
