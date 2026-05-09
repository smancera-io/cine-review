/* Creación de la base de datos consultorio_odontologico */
CREATE DATABASE consultorio_odontologico;

/* Selección de la base de datos consultorio_odontologico para comenzar a trabajar */
USE consultorio_odontologico;

/* Creación de las tablas */
/* Creación de la tabla de género */
CREATE TABLE genero(
	id_genero     	INT AUTO_INCREMENT,
	nombre_genero 	VARCHAR(100) NOT NULL UNIQUE,
	PRIMARY KEY (id_genero)
);

/* Creación de la tabla de paciente */
CREATE TABLE paciente(
	id_paciente     		  INT AUTO_INCREMENT,
	nombre_paciente 		  VARCHAR(100) NOT NULL,
	apellido_paciente 		  VARCHAR(100) NOT NULL,
	telefono_paciente 		  VARCHAR(20)  NOT NULL,
	correo_paciente 		  VARCHAR(100) NOT NULL,
	fecha_nacimiento_paciente DATE NOT NULL,
	genero_paciente 		  INT  NOT NULL,
	PRIMARY KEY(id_paciente),
	FOREIGN KEY(genero_paciente) REFERENCES genero(id_genero),
    CHECK (YEAR(fecha_nacimiento_paciente) <= 2026 AND YEAR(fecha_nacimiento_paciente) >= 1926)
);

/* Creación de la tabla de especialidad */
CREATE TABLE especialidad(
	id_especialidad 	INT AUTO_INCREMENT,
	nombre_especialidad VARCHAR(150) NOT NULL UNIQUE,
	PRIMARY KEY (id_especialidad)
);

/* Creación de la tabla de odontólogo */
CREATE TABLE odontologo(
	id_odontologo 			INT AUTO_INCREMENT,
	nombre_odontologo 		VARCHAR(100) NOT NULL,
	apellido_odontologo 	VARCHAR(100) NOT NULL,
	especialidad_odontologo INT NOT NULL,
	telefono_odontologo 	VARCHAR(20)  NOT NULL,
	correo_odontologo 		VARCHAR(100) NOT NULL,
	PRIMARY KEY(id_odontologo),
	FOREIGN KEY(especialidad_odontologo) REFERENCES especialidad(id_especialidad)
);

/* Creación de la tabla de tratamiento */
CREATE TABLE tratamiento(
	id_tratamiento 		INT AUTO_INCREMENT,
	nombre_tratamiento 	VARCHAR(150)  NOT NULL UNIQUE,
	precio_tratamiento 	DECIMAL(10,2) NOT NULL,
	PRIMARY KEY(id_tratamiento),
    CHECK(precio_tratamiento > 0)
);

/* Creación de la tabla de estado_cita */
CREATE TABLE estado_cita(
	id_estado 		INT AUTO_INCREMENT,
	nombre_estado 	VARCHAR(100) NOT NULL UNIQUE,
	PRIMARY KEY(id_estado)
);

/* Creación de la tabla de cita */
CREATE TABLE cita(
	id_cita 		 INT  AUTO_INCREMENT,
	paciente_cita 	 INT  NOT NULL,
	odontologo_cita  INT  NOT NULL,
	tratamiento_cita INT  NOT NULL,
	fecha_cita 		 DATE NOT NULL,
	hora_cita 		 TIME NOT NULL,
	estado_cita 	 INT  NOT NULL,
	PRIMARY KEY(id_cita),
	FOREIGN KEY(paciente_cita)    REFERENCES paciente(id_paciente),
	FOREIGN KEY(odontologo_cita)  REFERENCES odontologo(id_odontologo),
	FOREIGN KEY(tratamiento_cita) REFERENCES tratamiento(id_tratamiento),
	FOREIGN KEY(estado_cita)      REFERENCES estado_cita(id_estado),
    CHECK(YEAR(fecha_cita) >= 2026),
    CHECK(hora_cita BETWEEN '07:00:00' AND '17:00:00'),
    UNIQUE (odontologo_cita, fecha_cita, hora_cita),
    UNIQUE (paciente_cita,   fecha_cita, hora_cita)
);