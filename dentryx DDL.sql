CREATE DATABASE IF NOT EXISTS dentryx;
USE dentryx;
CREATE TABLE IF NOT EXISTS especialidades (
    id     INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

INSERT IGNORE INTO especialidades (nombre) VALUES
('Odontología general'),
('Ortodoncia'),
('Odontología pediátrica'),
('Endodoncia'),
('Otra');

CREATE TABLE IF NOT EXISTS ciudades (
    id     INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE
);

INSERT IGNORE INTO ciudades (nombre) VALUES
('Bogotá'),
('Medellín'),
('Cali'),
('Barranquilla'),
('Cartagena'),
('Bucaramanga'),
('Pereira'),
('Manizales'),
('Otra');

CREATE TABLE contactos (
    id                  INT AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL,
    apellido            VARCHAR(100),
    email               VARCHAR(150) NOT NULL,
    telefono            VARCHAR(20),
    nombre_consultorio  VARCHAR(150),
    id_especialidad     INT,
    id_ciudad           INT,
    cantidad_empleados  INT,
    sistema_actual      VARCHAR(150),
    comentarios         TEXT,
    fecha_registro      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_especialidad) REFERENCES especialidades(id),
    FOREIGN KEY (id_ciudad)       REFERENCES ciudades(id)
);