
-- VISTAS 
USE desafio_coder;
DROP VIEW IF EXISTS nota_alumnos, alumnos_destacados, docentes_asignados, inscriptos, performance_alumnos_por_genero;

-- 1 Cuáles fueron las notas de todos los alumnos?

CREATE VIEW nota_alumnos AS
(SELECT a.id_matricula, a.nombre_alumno, a.apellido_alumno, ac.nota, ac.id_comision  
FROM alumnos AS a
INNER JOIN alumnos_comisiones AS ac 
ON (a.id_matricula = ac.id_matricula));

-- 2 Quiénes alumnos sacaron una nota mayor o igual a 8 ?

CREATE VIEW alumnos_destacados AS
(SELECT a.id_matricula, a.nombre_alumno, a.apellido_alumno, ac.nota, ac.id_comision  
FROM alumnos AS a
INNER JOIN alumnos_comisiones AS ac 
ON (a.id_matricula = ac.id_matricula)
WHERE ac.nota > 8);

-- 3 Detalle de los cursos, comisiones, con
-- sus docentes respectivos  

CREATE VIEW docentes_asignados AS
(SELECT c.id_comision, c.id_codigo_curso, d.nombre_docente, d.apellido_docente 
FROM comisiones AS c
LEFT JOIN docentes AS d 
ON (c.id_legajo_docente = d.id_legajo_docente));

-- 4 Detalle de la cantidad de inscriptos x comisión

CREATE VIEW inscriptos AS
(SELECT id_comision, COUNT(id_matricula) AS inscriptos
FROM alumnos_comisiones
GROUP BY id_comision
ORDER BY inscriptos DESC);

-- 5 Perfomance de los alumnos por género,

CREATE VIEW performance_alumnos_por_genero AS
(SELECT a.genero_alumno, AVG(ac.nota)
FROM alumnos AS a
LEFT JOIN alumnos_comisiones AS ac
ON (a.id_matricula = ac.id_matricula)
WHERE a.genero_alumno = 'M'
UNION
SELECT a.genero_alumno, AVG(ac.nota)
FROM alumnos AS a
LEFT JOIN alumnos_comisiones AS ac
ON (a.id_matricula = ac.id_matricula)
WHERE a.genero_alumno = 'F');

#********************************************************************************************************************#
-- FUNCIONES
USE desafio_coder;
DROP FUNCTION IF EXISTS cant_inscripciones;
DROP FUNCTION IF EXISTS cant_cursos;
DROP FUNCTION IF EXISTS performance;
DROP FUNCTION IF EXISTS cant_alumnos;
-- A) FUNCIONES --
-- Habiendo distintas comisiones, 
-- deseo saber la cantidad de inscriptos en cada Comisión, ej: Comisión Número: 300 

DELIMITER //
CREATE FUNCTION cant_inscripciones(param_id_comision INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE inscripciones INT;
    SET inscripciones = (SELECT COUNT(id_matricula) FROM alumnos_comisiones WHERE param_id_comision = id_comision);
    RETURN inscripciones;
END //
DELIMITER ; 

SELECT cant_inscripciones(300)

-- B) FUNCIONES --
-- Habiendo distintas comisiones, 
-- deseo saber la cantidad de cursos vigentes ej: Código 200, son en total 3 cursos de Python 

DELIMITER //
CREATE FUNCTION cant_cursos(param_id_curso INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE inscripciones INT;
    SET inscripciones = (SELECT COUNT(c.id_codigo_curso) 
FROM comisiones AS c
WHERE c.id_codigo_curso = param_id_curso);
    RETURN inscripciones; 
END //
DELIMITER ; 

SELECT cant_cursos(200); 

-- C) FUNCIONES - notas 
-- Habiendo distintas comisiones, 
-- deseo saber la nota promedio de cada comisión ej: Comisión 300 - nota : **,

DELIMITER //
CREATE FUNCTION performance(nota_id_comision INT) 
RETURNS DECIMAL(4,2)
DETERMINISTIC
BEGIN
    DECLARE performance DECIMAL(4,2);
    SET performance = (SELECT AVG(nota)
FROM alumnos_comisiones
WHERE id_comision = nota_id_comision);
    RETURN performance; 
END //
DELIMITER ; 

SELECT performance(301); 

-- D) FUNCIONES - Alumnos 
-- Habiendo distintos cursos en cada comisión
-- deseo saber la cantidad de alumnos que tienen los cursos por ej : Python (Código 200)

DELIMITER //
CREATE FUNCTION cant_alumnos(param_id_curso INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE inscripciones INT;
    SET inscripciones = (SELECT COUNT(id_codigo_curso)   
FROM comisiones AS c
LEFT JOIN alumnos_comisiones AS ac 
ON (c.id_comision = ac.id_comision)
WHERE id_codigo_curso = param_id_curso);
    RETURN inscripciones; 
END //
DELIMITER ; 

SELECT cant_alumnos(202);

#********************************************************************************************************************#

-- STORED PROCEDURES
-- 1) Objetivo del SP : Ordernar Ascendente o desc los campos seleccionados

DROP PROCEDURE IF EXISTS sp_cursos_field_order;
DELIMITER /
CREATE PROCEDURE `sp_cursos_field_order`(IN field CHAR(25), IN asc_desc VARCHAR(45))
BEGIN
	IF field != ''
		THEN
		SET @field_sorted  = CONCAT('ORDER BY ', field, ' ',asc_desc);
	ELSE       
		SET @field_sorted  = '';	
    END IF;    
        SET @field_sorted_added = CONCAT('SELECT * FROM cursos ' , @field_sorted);
          -- Ordenamos en una sentencia de código el campo ingresado 
		  -- field, a través del SELECT * FROM Table ORDER BY -- ASCENDENTE o bien DESCENDENTE
      
PREPARE querySQL FROM @field_sorted_added; 
EXECUTE querySQL;
DEALLOCATE PREPARE querySQL;
        
END //
DELIMITER ;

CALL sp_cursos_field_order('id_codigo_curso','DESC');

/*---------------------------------------------------------------------------------------------*/

-- 2 ) Objetivo del SP: Se actualizan los precios de los cursos veigentes

DROP PROCEDURE IF EXISTS update_prices;
DELIMITER //
CREATE PROCEDURE `update_prices`(id_codigo INT, new_precio_curso INT)
BEGIN
	UPDATE cursos 
    SET precio_curso = new_precio_curso 
    WHERE id_codigo_curso = id_codigo;
END //
DELIMITER ;

CALL update_prices(201,45000);

/*---------------------------------------------------------------------------------------------*/
-- 3) Obejtivo del SP : Se crea un SP de inserción de un nuevo alumno --

DROP PROCEDURE IF EXISTS insert_alumnos;
DELIMITER //

CREATE PROCEDURE `insert_alumnos`(id_mat INT,nombre VARCHAR(45)
	,apellido VARCHAR(45),genero VARCHAR(45),tipo_doc VARCHAR(45) 
	,doc_num INT, profesion VARCHAR(45), mail VARCHAR(45)) 
BEGIN
	INSERT INTO alumnos(id_matricula,nombre_alumno,apellido_alumno
    ,genero_alumno,tipo_documento,documento_numero
    ,profesion_alumno,mail_alumno) 
    VALUES (id_mat,nombre,apellido,genero,tipo_doc,doc_num
    ,profesion,mail); 
    
END //
DELIMITER ;

CALL insert_alumnos(130,'Romualdo','Perez','M','DNI',22699999,'Arquitecto','romua@gmail.com');

-- checking de que funciona bien el SP (Store Porcedure)    

SELECT id_matricula, nombre_alumno, apellido_alumno
FROM alumnos
ORDER BY id_matricula
LIMIT 25;

/*---------------------------------------------------------------------------------------------*/
-- 4) Se crea un SP de elimancion de un registro de alumno --

DROP PROCEDURE IF EXISTS eliminar_alumnos;
DELIMITER //
/*
CREATE PROCEDURE `eliminar_alumnos`(id_mat INT,nombre VARCHAR(45)
	,apellido VARCHAR(45),genero VARCHAR(45),tipo_doc VARCHAR(45) 
	,doc_num INT, profesion VARCHAR(45), mail VARCHAR(45)) */

CREATE PROCEDURE `eliminar_alumnos`(id_mat INT) 
BEGIN
	DELETE 
    FROM alumnos
    WHERE id_mat = id_matricula;
END //
DELIMITER ;

CALL eliminar_alumnos(115);

-- checking de que funciona bien el SP (Store Porcedure),
-- se corrobo la no existencia del registro insertado anteriormente.

SELECT id_matricula, nombre_alumno, apellido_alumno
FROM alumnos
ORDER BY id_matricula
LIMIT 25;

#********************************************************************************************************************#
-- TRIGGERS
USE desafio_coder;
DROP TABLE IF EXISTS tabla_control_new_cursos, tabla_control_precios_cursos
, tabla_baja_alumnos, tabla_control_verif_alumnos;

-- Tablas de control: CURSOS : tienen por objetivo, detallar los nuevos cursos ingresados a la DB,
-- y a su vez llevar un control con la  actualización de nuevos precios. (detalle, usuario, fecha, hora)

-- Tablas de control: ALUMNOS :
-- Cotrolar las bajas de los alumnos y por otro lado considerar la posibilidad de activar el genero_alumno : X, 
-- M: masculino , F: femenino.

CREATE TABLE tabla_control_new_cursos (
id_codigo_curso INT NOT NULL,
nombre_curso VARCHAR(45) NOT NULL,
usuario VARCHAR(20) NOT NULL,
fecha_alta VARCHAR(10) NOT NULL,
hora VARCHAR(10) NOT NULL
);

CREATE TABLE tabla_control_precios_cursos (
id_codigo_curso INT NOT NULL,
nombre_curso VARCHAR(45) NOT NULL,
precio_anterior_curso INT NOT NULL, 
precio_actual INT NOT NULL,
usuario VARCHAR(20) NOT NULL,
fecha VARCHAR(10) NOT NULL,
hora VARCHAR(10) NOT NULL
);

CREATE TABLE tabla_baja_alumnos (
id_matricula INT NOT NULL,
nombre_alumno VARCHAR(45) NOT NULL,
apellido_alumno VARCHAR(45) NOT NULL,
tipo_documento VARCHAR(45) NOT NULL,
documento_numero INT NOT NULL,
usuario VARCHAR(20) NOT NULL,
fecha_baja VARCHAR(10) NOT NULL,
hora VARCHAR(10) NOT NULL
);

CREATE TABLE tabla_control_verif_alumnos (
id_matricula INT NOT NULL,
nombre_alumno VARCHAR(45) NOT NULL,
apellido_alumno VARCHAR(45) NOT NULL,
genero_alumno CHAR(1),
usuario VARCHAR(20) NOT NULL,
fecha VARCHAR(10) NOT NULL,
hora VARCHAR(10) NOT NULL
);

-- Implementacion de TRIGGERS --
-- Los mismos se ejecutan en la tablas_control
DROP TRIGGER IF EXISTS alta_nuevos_cursos; 
-- 1. Tabla con el alta de nuevos cursos, con registro de usuario y momento efectuado

DELIMITER //
CREATE TRIGGER `alta_nuevos_cursos` AFTER INSERT ON `cursos`
FOR EACH ROW
BEGIN
	INSERT INTO `tabla_control_new_cursos` (id_codigo_curso, nombre_curso, usuario, fecha_alta, hora)
	VALUES (NEW.id_codigo_curso, NEW.nombre_curso, CURRENT_USER(), CURRENT_DATE, CURRENT_TIME());

END //
DELIMITER ;
-- Probamos el Trigger con una instrucción, debemos cargar un nuevo registro
INSERT INTO cursos (id_codigo_curso, nombre_curso, contenido_curso, precio_curso, inicio_curso, final_curso) 
VALUES 
(225,'Python', 'Introducción al lenguaje de programación',19500,'2020-03-25','2020-09-25');

-- Checking 
SELECT *
FROM cursos;

SELECT *
FROM tabla_control_new_cursos;

-- #----------------------------------------------------------------------------------------------------------
-- 2. Tabla con la actualización de los precios de los cursos (precio actual, anterior).
-- con registro de usuario, fecha y hora.

DROP TRIGGER IF EXISTS actual_precio_cursos; 

DELIMITER //
CREATE TRIGGER `actual_precio_cursos` BEFORE UPDATE ON `cursos`
FOR EACH ROW
BEGIN
	INSERT INTO tabla_control_precios_cursos (id_codigo_curso, nombre_curso, precio_anterior_curso, precio_actual
    , usuario, fecha, hora) 
	VALUES (OLD.id_codigo_curso, OLD.nombre_curso, OLD.precio_curso, NEW.precio_curso,
    CURRENT_USER(), CURRENT_DATE, CURRENT_TIME());

END //
DELIMITER ;
-- Probamos el Trigger con una instrucción, cargando una nueva actualización
UPDATE cursos SET precio_curso = 18000 WHERE id_codigo_curso = '200';
UPDATE cursos SET precio_curso = 43000 WHERE id_codigo_curso = '201';

-- Checking--
SELECT *
FROM cursos;

SELECT *
FROM tabla_control_precios_cursos;

-- #----------------------------------------------------------------------------------------------------------
-- 3. Tabla con el registro de la baja de alumnos,
-- (figuran usuario, fecha y hora).

DROP TRIGGER IF EXISTS baja_alumnos; 

DELIMITER //

CREATE TRIGGER `baja_alumnos` AFTER DELETE ON `alumnos`
FOR EACH ROW
BEGIN
	INSERT INTO `tabla_baja_alumnos` (id_matricula, nombre_alumno, apellido_alumno, tipo_documento
    , documento_numero, usuario, fecha_baja, hora)
	VALUES (OLD.id_matricula, OLD.nombre_alumno, OLD.apellido_alumno, OLD.tipo_documento
    , OLD.documento_numero, CURRENT_USER(), CURRENT_DATE, CURRENT_TIME());
                 
END //
DELIMITER ;
 -- Checking--
 -- Probamos el Trigger con una baja de alumno

SELECT max(id_matricula)
FROM
alumnos; 
 
DELETE 
FROM alumnos 
WHERE id_matricula = 118; 

SELECT *
FROM
tabla_baja_alumnos;

-- #----------------------------------------------------------------------------------------------------------
-- 4. Tabla con el registro de la baja de alumnos,
-- (figuran usuario, fecha y hora).

DROP TRIGGER IF EXISTS tabla_control_verif_alumnos;

DELIMITER //

CREATE TRIGGER `tabla_control_verif_alumnos` BEFORE UPDATE ON `alumnos`
FOR EACH ROW
BEGIN
	IF NEW.genero_alumno = ''
    THEN
    SET NEW.genero_alumno = 'X';
    END IF;
    INSERT INTO tabla_control_verif_alumnos (id_matricula, nombre_alumno, apellido_alumno, genero_alumno
    , usuario, fecha, hora) 
	VALUES (OLD.id_matricula, OLD.nombre_alumno, OLD.apellido_alumno, NEW.genero_alumno
    , CURRENT_USER(), CURRENT_DATE, CURRENT_TIME());

END //
DELIMITER ;

UPDATE alumnos SET genero_alumno = '' WHERE id_matricula = '116';

SELECT *
FROM
alumnos
WHERE id_matricula = 116;

SELECT *
FROM
tabla_control_verif_alumnos;

#********************************************************************************************************************#
-- BONUSTRACK
-- STORED PROCEDURE  - DASHBOARD 
-- Tiene por objetivo conocer la facturación del negocio en el período selecciodado, 
-- tanto por curso específico, incluso viendo la facruración por alumno.

DROP PROCEDURE IF EXISTS sp_dashboard;
DELIMITER //
CREATE PROCEDURE `sp_dashboard`(inicio DATE, final DATE)     /*--(inicio DATE, final DATE)*/
	BEGIN
	SELECT curs.nombre_curso, SUM(precio_curso) as Ingresos_totales
	, COUNT(al.id_matricula) as cant_alumnos
	, round(SUM(precio_curso)/count(al.id_matricula),0) as Ingreso_por_alumno 
	FROM alumnos as al
	INNER JOIN 
	alumnos_comisiones as ac
	ON al.id_matricula = ac.id_matricula
	INNER JOIN
	comisiones AS comi
	ON comi.id_comision = ac.id_comision
	INNER JOIN cursos AS curs
	ON comi.id_codigo_curso = curs.id_codigo_curso
	WHERE curs.inicio_curso >= inicio
	AND curs.final_curso <= final
	GROUP BY precio_curso;
	    
	END //
DELIMITER ;

CALL sp_dashboard('2022-01-01', '2022-12-31');

-- Preparación de CTE. objetivo es conocer los datos de las comisión especifica de Python que 
-- tuvo una performnace superior a 8 puntos (las notas de los cursos van de 1 a 10)

USE desafio_coder;

WITH 
CTE AS (SELECT c.id_codigo_curso, c.nombre_curso, com.id_comision 
	FROM cursos AS c 
	JOIN comisiones AS com 
	ON c.id_codigo_curso = com.id_codigo_curso
	WHERE c.nombre_curso = 'Python'),
CTE2 AS (SELECT id_matricula, nota, id_comision
	FROM alumnos_comisiones)

SELECT id_matricula, c.id_comision, a.nota
FROM CTE AS c
JOIN CTE2 AS a 
ON c.id_comision = a.id_comision
WHERE nota >= 8;


