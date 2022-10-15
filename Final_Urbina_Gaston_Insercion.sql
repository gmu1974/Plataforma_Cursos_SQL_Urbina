
USE desafio_coder;

/*-- Practicando delete antes del insert, 
set nombre_cursoSQL_SAFE_UPDATES=0;
delete from usuarios;*/

INSERT INTO alumnos (id_matricula, nombre_alumno, apellido_alumno, genero_alumno, tipo_documento, 
documento_numero, profesion_alumno, mail_alumno) 
VALUES 
(100, 'Javier', 'Gomez','M','DNI',25560685,'Contador','jgomez@gmail.com'),
(101, 'Juan', 'Lopez','M','DNI',22585685,'Contador','jlopez@gmail.com'),
(102, 'Roma', 'Uriburi','F','DNI',21560980,'Ingeniero','roma@gmail.com'),
(103,'Ernesto', 'Shaw','M','DNI',19560685,'Estudiante','e1234@gmail.com'),
(104, 'Jose', 'Liberti','M','CI',94560685,'Contador','libe@gmail.com'),
(105, 'Juan', 'Oro','M','DNI',26560850,'Contador','juan@gmail.com'),
(106, 'Oscar', 'Delafuente','M','DNI',29562368,'Estudiante','delafuente@gmail.com'),
(107, 'Lisa', 'Simpson', 'F','DNI',35560685,'Estudiante','lisa@gmail.com'),
(108, 'Noelia', 'Benitez','F','CPI',98560685,'Estudiante','noe@gmail.com'),
(109, 'Maria', 'Lagos','F','DNI',38560685,'Marketing','mlagos@gmail.com'),
(110, 'Analia', 'Plank','F','DNI',25859785,'Administracion','anaf@gmail.com'),
(111, 'Pablo', 'Molaro','M','DNI',21859995,'Economía','pablo@gmail.com'),
(112, 'Javier', 'Plana','M','DNI',25859755,'Administracion','anafo@gmail.com'),
(113, 'Ana', 'Pitoro','F','DNI',45859785,'Administracion','ana@gmail.com'),
(114, 'Julia', 'Lopez','F','DNI',30859785,'Actuario','julial@gmail.com'),
(115, 'Jose', 'Kolio','M','DNI',18859785,'Administracion','joselo@gmail.com'),
(116, 'Paula', 'Yuri','F','DNI',58859785,'Ingenieria','paualita@gmail.com'),
(117, 'Elvira', 'Polanskiy','F','DNI',27759785,'Sistemas','elvirap@gmail.com'),
(118, 'Josefa', 'Hortiva','F','CI',56859785,'Sistemas','josefa@gmail.com'),
(119, 'Fernando', 'Rios','M','DNI',29858785,'Sistemas','fer@gmail.com'),
(120, 'Xavier', 'Juno','M','DNI',45859788,'Sistemas','xavi@gmail.com'),
(121, 'Xavier', 'Munixi','M','DNI',48859788,'Sistemas','xavim@gmail.com');

INSERT INTO cursos (id_codigo_curso, nombre_curso, contenido_curso, precio_curso, inicio_curso, final_curso) 
VALUES 
(200,'Python', 'Introducción al lenguaje de programación',19500,'2020-03-25','2020-09-25'),
(201,'DB SQL', 'Introducción al manejo de DB',12000,'2020-04-25','2020-06-25'),
(202,'Data Science', 'Carrera de Ciencia de datos',36000,'2022-05-25','2022-09-25'),
(203,'Marketing digital', 'Carrera de marketing digital',18000,'2022-06-25','2022-08-25'),
(204,'Emprendimiento', 'Manejo de herramientas de caso',15000,'2021-09-25','2021-12-25'),
(205,'UX', 'Diseño y experiencia de usuario',17500,'2022-03-25','2020-08-25');


INSERT INTO docentes (id_legajo_docente, nombre_docente, apellido_docente, tipo_documento, documento_numero, profesion_docente, mail_docente) 
VALUES 
(400, 'Matias', 'Menphis', 'CPA',899285,'Contador','cpa@gmail.com'),
(401, 'Oscar', 'Lamas', 'DNI',31125569,'Ingeniero','olamas@gmail.com'),
(402, 'Pepe', 'Mujica', 'CI',28888689,'Contador','pepe@gmail.com'),
(403, 'Horacio', 'Lagos', 'DNI',19888685,'Administración','horaciolagos@gmail.com'),
(404, 'Lorena', 'Llanos', 'DNI',27714685,'Diseñadora','lore@gmail.com'),
(405, 'Willian', 'Wallace', 'DNI',27714685,'Emprendedor','willy@gmail.com'),
(406, 'Alberto', 'Massa', 'DNI',78714685,'Sistemas','alber@gmail.com');

INSERT INTO soportes (id_legajo_soporte, nombre_soporte, apellido_soporte, tipo_documento, documento_numero, mail_soporte) 
VALUES
(500, 'Javier', 'Benitez', 'DNI',22560685,'benitez@gmail.com'),
(501, 'Pablo', 'Neruda', 'DNI',19214685, 'neruda@gmail.com'),
(502, 'Ezequiel', 'Moni', 'DNI',25589685, 'moni@gmail.com');

INSERT INTO comisiones (id_comision, id_legajo_docente, id_codigo_curso, turno) 
VALUES
(300,400,200,1),
(301,400,200,2),
(302,400,200,3),
(303,401,201,1),
(304,402,201,2),
(305,403,201,3),
(306,404,203,1),
(307,404,203,2),
(308,405,205,3),
(309,406,202,3);

-- Formato de fecha (YYYY, MM, DD)

INSERT INTO alumnos_comisiones(id_matricula, id_comision, nota, estado)
VALUES
(100, 300, 8,'finalizado'),
(100, 307, 9,'finalizado'),
(101, 300, 5,'finalizado'),
(102, 300, 5,'finalizado'),
(102, 303, 4,'finalizado'),
(103, 300, 2,'finalizado'),
(104, 304, 6,'finalizado'),
(105, 300, 8,'finalizado'),
(105, 305, 4,'finalizado'),
(106, 300, 4,'finalizado'),
(106, 305, 5,'finalizado'),
(107, 300, 10,'finalizado'),
(107, 307, 7,'finalizado'),
(108, 307, 9,'finalizado'),
(109, 308, 8,'finalizado'),
(110, 308, 6,'finalizado'),
(111, 309, 7,'finalizado'),
(112, 309, 7,'finalizado'),
(113, 300, 7,'finalizado'),
(113, 305, 8,'finalizado'),
(114, 300, 8,'finalizado'),
(114, 305, 9,'finalizado'),
(115, 301, 6,'finalizado'),
(116, 302, 6,'finalizado'),
(117, 308, 9,'finalizado'),
(117, 309, 8,'finalizado'),
(118, 308, 9,'finalizado'),
(118, 309, 7,'finalizado'),
(119, 300, 6,'finalizado'),
(119, 307, 7,'finalizado'),
(120, 307, 8,'finalizado');


INSERT INTO docentes_comisiones(id_legajo_docente, id_comision)
VALUES
(400, 300),
(400, 301),
(400, 302),
(401, 303),
(402, 304),
(403, 305),
(404, 306),
(404, 307),
(405, 308),
(406, 309);

INSERT INTO cursos_soportes(id_legajo_soporte, id_codigo_curso)
VALUES
(500, 200),
(500, 201),
(500, 202),
(501, 203),
(502, 204),
(502, 205);

