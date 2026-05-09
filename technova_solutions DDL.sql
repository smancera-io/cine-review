/* Creación de la base de datos technova_solutions */
CREATE DATABASE technova_solutions;

/* Selección de la base de datos technova_solutions para comenzar a trabajar */
USE technova_solutions;

/* Creación de las tablas */
/* Creación de la tabla tipo_cliente */
CREATE TABLE tipo_cliente (
    id_tipo_cliente  	INT AUTO_INCREMENT,
    nombre_tipo_cliente VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (id_tipo_cliente)
);

/* Creación de la tabla ciudad_cliente */
CREATE TABLE ciudad_cliente (
	id_ciudad_cliente	  INT AUTO_INCREMENT,
    nombre_ciudad_cliente VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_ciudad_cliente)
);

/* Creación de la tabla cliente */
CREATE TABLE cliente (
    id_cliente 	           INT AUTO_INCREMENT,
    tipo_cliente           INT NOT NULL,
    nombre_cliente		   VARCHAR(100) NOT NULL,
    apellido_cliente	   VARCHAR(100) NOT NULL,
    email_cliente 		   VARCHAR(100) NOT NULL UNIQUE,
    telefono_cliente       VARCHAR(20)  NOT NULL,
    ciudad_cliente         INT NOT NULL,
    fecha_registro_cliente DATE NOT NULL,
	PRIMARY KEY (id_cliente),
    CONSTRAINT  fk_tipo_cliente
        FOREIGN KEY (tipo_cliente) REFERENCES tipo_cliente(id_tipo_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
	CONSTRAINT fk_ciudad_cliente
		FOREIGN KEY (ciudad_cliente) REFERENCES ciudad_cliente(id_ciudad_cliente)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

/* Creación de la tabla estado_proyecto */
CREATE TABLE estado_proyecto (
    id_estado_proyecto	   INT AUTO_INCREMENT,
    nombre_estado_proyecto VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (id_estado_proyecto)
);

/* Creación de la tabla proyecto */
CREATE TABLE proyecto (
    id_proyecto 	            INT AUTO_INCREMENT,
    nombre_proyecto		        VARCHAR(100) NOT NULL,
    descripcion_proyecto	    TEXT NOT NULL,
    fecha_inicio_proyecto	    DATE NOT NULL,
    fecha_fin_estimada_proyecto DATE,
    estado_proyecto             INT NOT NULL,
    cliente_proyecto            INT NOT NULL,
    PRIMARY KEY (id_proyecto),
    CONSTRAINT  fk_cliente
        FOREIGN KEY (cliente_proyecto) REFERENCES cliente(id_cliente)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_estado_proyecto
        FOREIGN KEY (estado_proyecto) REFERENCES estado_proyecto(id_estado_proyecto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_fecha
        CHECK (fecha_fin_estimada_proyecto IS NULL OR fecha_fin_estimada_proyecto >= fecha_inicio_proyecto)
);

/* Creación de la tabla especialidad_desarrollador */
CREATE TABLE especialidad_desarrollador (
    id_especialidad_desarrollador     INT AUTO_INCREMENT,
    nombre_especialidad_desarrollador VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (id_especialidad_desarrollador)
);

/* Creación de la tabla nivel_desarrollador */
CREATE TABLE nivel_desarrollador (
    id_nivel_desarrollador     INT AUTO_INCREMENT,
    nombre_nivel_desarrollador VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (id_nivel_desarrollador)
);

/* Creación de la tabla desarrollador */
CREATE TABLE desarrollador(
    id_desarrollador               INT AUTO_INCREMENT,
    nombre_desarrollador	       VARCHAR(100) NOT NULL,
	apellido_desarrollador	       VARCHAR(100) NOT NULL,
    email_desarrollador 	       VARCHAR(100) NOT NULL UNIQUE,
    años_experiencia_desarrollador INT NOT NULL,
    especialidad_desarrollador     INT NOT NULL,
    nivel_desarrollador            INT NOT NULL,
    PRIMARY KEY (id_desarrollador),
    CONSTRAINT  fk_especialidad_desarrollador
        FOREIGN KEY (especialidad_desarrollador) REFERENCES especialidad_desarrollador(id_especialidad_desarrollador)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_nivel
        FOREIGN KEY (nivel_desarrollador) REFERENCES nivel_desarrollador(id_nivel_desarrollador)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_experiencia_desarrollador
        CHECK (años_experiencia_desarrollador >= 0)
);

/* Creación de la tabla de rol */
CREATE TABLE rol_proyecto (
    id_rol_proyecto     INT AUTO_INCREMENT,
    nombre_rol_proyecto VARCHAR(30) NOT NULL UNIQUE,
    PRIMARY KEY (id_rol_proyecto)
);

/* Creación de la tabla asignacion */
CREATE TABLE asignacion (
    id_asignacion 	 INT AUTO_INCREMENT,
    id_proyecto 	 INT NOT NULL,
    id_desarrollador INT NOT NULL,
    id_rol			 INT NOT NULL,
    fecha_asignacion DATE NOT NULL,
	PRIMARY KEY (id_asignacion),
    CONSTRAINT  fk_proyecto_asig
        FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_dev_asig
        FOREIGN KEY (id_desarrollador) REFERENCES desarrollador(id_desarrollador)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_rol
        FOREIGN KEY (id_rol) REFERENCES rol_proyecto(id_rol_proyecto)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT unique_asignacion
        UNIQUE (id_proyecto, id_desarrollador, id_rol)
);

/* Creación de la tabla estado_tarea */
CREATE TABLE estado_tarea (
    id_estado_tarea     INT AUTO_INCREMENT,
    nombre_estado_tarea VARCHAR(20) NOT NULL UNIQUE,
    PRIMARY KEY (id_estado_tarea)
);

/* Creación de la tabla prioridad_tarea */
CREATE TABLE prioridad_tarea (
    id_prioridad_tarea     INT AUTO_INCREMENT,
    nombre_prioridad_tarea VARCHAR(20) NOT NULL UNIQUE,
     PRIMARY KEY (id_prioridad_tarea)
);

/*Creación de la tabla tarea */
CREATE TABLE tarea (
    id_tarea 		    INT AUTO_INCREMENT,
    descripcion_tarea	VARCHAR(200) NOT NULL,
    estado_tarea 		INT NOT NULL,
    prioridad_tarea	    INT NOT NULL,
    fecha_inicio_tarea  DATE NOT NULL,
    fecha_entrega_tarea DATE,
    proyecto_tarea	    INT NOT NULL,
    desarrollador_tarea INT,
	PRIMARY KEY (id_tarea),
    CONSTRAINT fk_proyecto_tarea
        FOREIGN KEY (proyecto_tarea) REFERENCES proyecto(id_proyecto)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_dev_tarea
        FOREIGN KEY (desarrollador_tarea) REFERENCES desarrollador(id_desarrollador)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    CONSTRAINT fk_estado_tarea
        FOREIGN KEY (estado_tarea) REFERENCES estado_tarea(id_estado_tarea)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_prioridad
        FOREIGN KEY (prioridad_tarea) REFERENCES prioridad_tarea(id_prioridad_tarea)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT chk_fecha_tarea
        CHECK (fecha_entrega_tarea IS NULL OR fecha_entrega_tarea >= fecha_inicio_tarea)
);

/* Creación del procedimiento almacenado de inserción de datos en la tabla ciudad_cliente */
DELIMITER $$
CREATE PROCEDURE insercion_ciudad_cliente (
	IN city VARCHAR(50)
	) 
	BEGIN 
		INSERT INTO ciudad_cliente (nombre_ciudad_cliente)
		VALUES (city);
        SELECT * FROM ciudad_cliente;
	END $$
DELIMITER ;         

/* Creación del procedimineto almacenado de inserción de datos en la tabla de cliente */
DELIMITER $$
CREATE PROCEDURE insercion_cliente (
	IN tipo        INT, 
    IN nombre      VARCHAR(100), 
    IN apellido    VARCHAR(100), 
    IN email       VARCHAR(100), 
    IN telefono    VARCHAR(20), 
    IN ciudad      INT, 
    fecha_registro DATE
    )
    BEGIN
		INSERT INTO cliente (tipo_cliente, nombre_cliente, apellido_cliente, email_cliente, telefono_cliente, ciudad_cliente, fecha_registro_cliente)
		VALUES (tipo, nombre, apellido, email, telefono, ciudad, fecha_registro);
        SELECT * FROM cliente;
	END $$
DELIMITER ;

/* Creación del procedimiento almacenado de actualización de datos en la tabla de cliente */
DELIMITER $$
CREATE PROCEDURE actualizacion_cliente (
	IN id		INT,
    IN telefono VARCHAR (20),
    IN email	VARCHAR (100)
	)
    BEGIN
		UPDATE cliente
			SET telefono_cliente = telefono, email_cliente = email
            WHERE id_cliente = id;
		SELECT * FROM cliente;
    END $$
DELIMITER ;

/* Creación del procedimiento almacenado de actualización de datos en la tabla proyecto */
DELIMITER $$
CREATE PROCEDURE actualizacion_proyecto (
	IN id 					INT,
	IN P_fecha_fin_estimada DATE,
    IN P_estado_proyecto 	INT
	)
    BEGIN
		UPDATE proyecto
			SET fecha_fin_estimada_proyecto = P_fecha_fin_estimada, estado_proyecto =  P_estado_proyecto 
            WHERE id_proyecto = id;
		SELECT * FROM proyecto;
    END $$
DELIMITER ;

/* Creación del procedimiento almacenado de eliminación de datos en la tabla desarrollador */
DELIMITER $$
CREATE PROCEDURE eliminacion_desarrollador (
	IN P_id INT
	)
    BEGIN
		DELETE FROM desarrollador
			WHERE id_desarrollador = P_id;
		SELECT * FROM desarrollador;
    END $$
DELIMITER ;

/* Creación del procedimiento almacenado de eliminación de datos en la tabla tarea */
DELIMITER $$
CREATE PROCEDURE eliminacion_tarea (
	IN P_id_tarea INT
    )
    BEGIN
		DELETE FROM tarea
			WHERE id_tarea = P_id_tarea;
		SELECT * FROM tarea;
	END $$
DELIMITER ;

/* Creación del procedimiento almacenado de JOIN de los desarrolladores que no son Junior */
DELIMITER $$
CREATE PROCEDURE join_desarrollador_no_junior (
	)
    BEGIN 
		SELECT
			CONCAT(d.nombre_desarrollador, ' ', d.apellido_desarrollador) AS desarrollador,
			nd.nombre_nivel_desarrollador AS nivel,
			ed.nombre_especialidad_desarrollador AS especialidad,
			d.años_experiencia_desarrollador
		FROM desarrollador d
		JOIN nivel_desarrollador nd ON d.nivel_desarrollador = nd.id_nivel_desarrollador
		JOIN especialidad_desarrollador ed ON d.especialidad_desarrollador = ed.id_especialidad_desarrollador
			WHERE nd.nombre_nivel_desarrollador <> 'Junior';
	END $$
DELIMITER ;

/* Creación de vistas */
/* Creación de la vista  */
CREATE VIEW tareas_ordenadas AS
SELECT
    t.descripcion_tarea,
    pt.nombre_prioridad_tarea AS prioridad,
    et.nombre_estado_tarea AS estado,
    p.nombre_proyecto
FROM tarea t
JOIN prioridad_tarea pt ON t.prioridad_tarea = pt.id_prioridad_tarea
JOIN estado_tarea et ON t.estado_tarea = et.id_estado_tarea
JOIN proyecto p  ON t.proyecto_tarea = p.id_proyecto
ORDER BY pt.id_prioridad_tarea ASC;