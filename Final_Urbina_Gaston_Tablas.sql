
DROP DATABASE IF EXISTS desafio_coder;
CREATE DATABASE desafio_coder;
USE desafio_coder;

CREATE TABLE alumnos (
id_matricula INT NOT NULL PRIMARY KEY,
nombre_alumno VARCHAR(45) NOT NULL,
apellido_alumno VARCHAR(45) NOT NULL,
genero_alumno CHAR(1) NULL,
tipo_documento VARCHAR(45) NOT NULL, 
documento_numero INT NOT NULL,    
profesion_alumno VARCHAR(45) NULL,  
mail_alumno VARCHAR(45) NOT NULL
);

CREATE TABLE cursos (
id_codigo_curso INT NOT NULL PRIMARY KEY,
nombre_curso VARCHAR(45) NOT NULL,
contenido_curso VARCHAR(45) NOT NULL,
precio_curso INT NOT NULL,
inicio_curso DATE NOT NULL, 
final_curso DATE NOT NULL 
);

CREATE TABLE docentes (
id_legajo_docente INT NOT NULL PRIMARY KEY,
nombre_docente VARCHAR(45) NOT NULL,
apellido_docente VARCHAR(45) NOT NULL,
tipo_documento VARCHAR(45) NOT NULL, 
documento_numero INT NOT NULL,    
profesion_docente VARCHAR(45) NULL,  
mail_docente VARCHAR(45) NOT NULL
);

CREATE TABLE soportes (
id_legajo_soporte INT NOT NULL PRIMARY KEY,
nombre_soporte VARCHAR(45) NOT NULL,
apellido_soporte VARCHAR(45) NOT NULL,
tipo_documento VARCHAR(45) NOT NULL, 
documento_numero INT NOT NULL,    
mail_soporte VARCHAR(45) NOT NULL
);

CREATE TABLE comisiones (
id_comision INT NOT NULL PRIMARY KEY,
id_legajo_docente INT NOT NULL,
id_codigo_curso INT NOT NULL,
turno INT NOT NULL,
FOREIGN KEY (id_legajo_docente) REFERENCES docentes(id_legajo_docente) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (id_codigo_curso) REFERENCES cursos(id_codigo_curso) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE alumnos_comisiones(
	id_matricula INT,
    id_comision INT,
    nota TINYINT NULL,
    estado VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_matricula, id_comision),
    FOREIGN KEY (id_matricula) REFERENCES alumnos(id_matricula) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_comision) REFERENCES comisiones(id_comision) ON UPDATE CASCADE ON DELETE CASCADE
    );
    
CREATE TABLE docentes_comisiones(
	id_legajo_docente INT,
    id_comision INT,
    PRIMARY KEY (id_legajo_docente, id_comision),
    FOREIGN KEY (id_legajo_docente) REFERENCES docentes(id_legajo_docente) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_comision) REFERENCES comisiones(id_comision) ON UPDATE CASCADE ON DELETE CASCADE
    );
    
    
CREATE TABLE cursos_soportes(
	id_codigo_curso INT,
    id_legajo_soporte INT,
    detalle_cursos_soportes VARCHAR(330) NULL,
    PRIMARY KEY (id_codigo_curso, id_legajo_soporte),
    FOREIGN KEY (id_codigo_curso) REFERENCES cursos(id_codigo_curso) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_legajo_soporte) REFERENCES soportes(id_legajo_soporte) ON UPDATE CASCADE ON DELETE CASCADE
    );
    
-- ---------------------------------------------------------------------------------
-- Ejemplo de Posible caso usando autoincrement en Tabla intermedia (relación N:N)

/*CREATE TABLE comisiones_alumnos (
id_Alu_Com INT AUTO_INCREMENT,
id_comisiones INT NOT NULL,
FOREIGN KEY (id_comisiones)
	REFERENCES comisiones(id_comisiones),
id_matricula INT NOT NULL,
FOREIGN KEY (id_matricula)
	REFERENCES alumnos(id_matricula),
nota TINYINT NOT NULL,
CONSTRAINT PK_comisiones_alumnos PRIMARY KEY (id_Alu_Com),
UNIQUE (id_comisiones, id_matricula)
);*/



