/* Inserción de valores a la tabla de género */
INSERT INTO genero (nombre_genero) 
VALUES
  ('Masculino'),
  ('Femenino'),
  ('No binario'),
  ('Prefiere no decir'),
  ('Otro');

/* Inserción de valores a la tabla de especialidad */
INSERT INTO especialidad (nombre_especialidad) 
VALUES
  ('Ortodoncia'),
  ('Endodoncia'),
  ('Periodoncia'),
  ('Odontopediatría'),
  ('Cirugía oral'),
  ('Estética dental');

/* Inserción de valores a la tabla de estado_cita */
INSERT INTO estado_cita (nombre_estado) 
VALUES
  ('Programada'),
  ('Cancelada'),
  ('Finalizada');

/* Inserción de valores a la tabla de paciente */
INSERT INTO paciente
  (nombre_paciente, apellido_paciente, telefono_paciente, correo_paciente, fecha_nacimiento_paciente, genero_paciente)
VALUES
  ('Carlos', 'Ramirez', '3004567890', 'carlos@email.com', '1995-04-12', 1),
  ('Laura', 'Gomez', '3109876543', 'laura@email.com', '2000-09-20', 2),
  ('Andres', 'Lopez', '3201112233', 'andres@email.com', '1988-11-03', 1),
  ('Maria', 'Fernandez', '3015556677', 'maria@email.com', '1992-06-15', 2),
  ('Ramiro', 'Pelaez', '7890300456', 'ramiro@email.com', '1995-04-12', 1),
  ('Diana', 'Almanza', '9876310543', 'diana@email.com', '2000-09-20', 2),
  ('Diego', 'Petro', '2011132233', 'diego@email.com', '1988-11-03', 1),
  ('Carla', 'Lopez', '5556673017', 'carla@email.com', '1992-06-15', 2),
  ('Luis', 'Diaz', '5556673017', 'luis@email.com', '1992-06-15', 1),
  ('Valentina', 'Rincon', '9876531043', 'radamel@email.com', '2000-09-20', 2);

/* Inserción de valores a la tabla de odontólogo */
INSERT INTO odontologo
  (nombre_odontologo, apellido_odontologo, especialidad_odontologo, telefono_odontologo, correo_odontologo)
VALUES
  ('Jorge', 'Martinez', 1, '3112223344', 'jorge@clinica.com'),
  ('Ana', 'Torres', 2, '3123334455', 'ana@clinica.com'),
  ('Luis', 'Morales', 3, '3134445566', 'luis@clinica.com'),
  ('Diana', 'Castro', 4, '3145556677', 'diana@clinica.com'),
  ('Emmanuel', 'Montana', 1, '2233443112', 'emmanuel@clinica.com');

/* Inserción de valores a la tabla de tratamiento */
INSERT INTO tratamiento (nombre_tratamiento, precio_tratamiento) 
VALUES
  ('Limpieza dental', 80000),
  ('Blanqueamiento dental', 250000),
  ('Ortodoncia', 3500000),
  ('Endodoncia', 3500000),
  ('Extracción dental', 120000),
  ('Tratamiento de conducto', 400000),
  ('Reemplazo de coronas', 1500000),
  ('Diseño de sonrisa', 2000000);

/* Creación e inserción de citas en la tabla de cita */
INSERT INTO cita
  (paciente_cita, odontologo_cita, tratamiento_cita, fecha_cita, hora_cita, estado_cita)
VALUES
  (1, 1, 1, '2026-03-10', '09:00:00', 3),
  (2, 2, 2, '2026-03-11', '10:30:00', 2),
  (3, 3, 5, '2026-03-12', '14:00:00', 1),
  (4, 4, 4, '2026-03-13', '16:00:00', 2),
  (5, 5, 1, '2026-03-15', '09:00:00', 1),
  (9, 1, 1, '2026-03-10', '11:00:00', 1),
  (6, 2, 2, '2026-03-11', '14:30:00', 2),
  (7, 3, 5, '2026-03-12', '08:00:00', 1),
  (8, 4, 4, '2026-03-13', '14:00:00', 2),
  (10,5, 2, '2026-03-15', '11:30:00', 2),
  (3, 1, 1, '2026-03-10', '13:00:00', 1),
  (4, 2, 2, '2026-03-11', '16:00:00', 2),
  (5, 3, 5, '2026-03-12', '10:00:00', 1),
  (2, 4, 4, '2026-03-13', '12:30:00', 2),
  (1, 5, 5, '2026-03-14', '13:00:00', 1);

/* Consulta básica de mostrar todos los pacientes registrados */
SELECT * FROM paciente;

/* Consulta básica de mostrar el nombre y teléfono de todos los odontologos */
SELECT nombre_odontologo, telefono_odontologo FROM odontologo;

/* Consulta básica de mostrar todos los tratamientos cuyo costo sea mayor a $1.000.000 */
SELECT * FROM tratamiento
WHERE precio_tratamiento > 1000000;

/* Consulta básica de mostrar todos los pacientes nacidos después de 1995 */
SELECT * FROM paciente
WHERE YEAR(fecha_nacimiento_paciente) > 1995;

/* Consulta básica de mostrar todas las citas de la fecha específica '2026-03-12' */
SELECT * FROM cita
WHERE fecha_cita = '2026-03-12';

/* Consulta básica de mostrar todas las citas cuyo estado sea programada */
SELECT * FROM cita
WHERE estado_cita = 1;

/* Consulta básica de mostrar las citas programadas entre '2026-03-11' y '2026-03-13' */
SELECT * FROM cita
WHERE fecha_cita BETWEEN '2026-03-11' AND '2026-03-13';

/* Consulta básica de mostrar todos los pacientes cuyo apellido sea 'Gomez' */
SELECT * FROM paciente
WHERE apellido_paciente = 'Gomez';

/* Consulta con condición de mostrar todos los pacientes cuyo nombre empiece con la letra 'A' */
SELECT * FROM paciente
WHERE nombre_paciente LIKE 'A%';

/* Consulta con condición de mostrar todos los tratamientos cuyo costo este entre $500.000 y $10.000.000 */
SELECT * FROM tratamiento
WHERE precio_tratamiento BETWEEN 500000 AND 10000000;

/* Consulta con condición de mostrar todos las citas cuyo estado sea programada o finalizada */
SELECT * FROM cita
WHERE estado_cita = 1 OR estado_cita = 3;

/* Consulta con condición de mostrar todos los pacientes nacidos antes del año 2000 y de género femenino */
SELECT * FROM paciente
WHERE YEAR(fecha_nacimiento_paciente) < 2000 AND genero_paciente = 2;

/* Consulta con condición de mostrar todos los tratamientos cuyo nombre contengan la palabra 'dental' */
SELECT * FROM tratamiento
WHERE nombre_tratamiento LIKE '%dental%';

/*Consulta para conocer ¿Cuántos pacientes hay registrados? */
SELECT COUNT(*) FROM paciente;

/*Consulta para conocer ¿Cuántos tratamientos tiene un costo mayor a $2.000.000? */
SELECT COUNT(*) FROM tratamiento
WHERE precio_tratamiento > 2000000;

/*Consulta para conocer ¿Cuántas citas están canceladas? */
SELECT COUNT(*) FROM cita
WHERE estado_cita = 2;

/*Consulta para conocer ¿Cuántos odontólogos trabajan en el consultorio? */
SELECT COUNT(*) FROM odontologo;

/*Consulta para conocer ¿Cuántas citas se programaron en marzo? */
SELECT COUNT(*) FROM cita
WHERE MONTH(fecha_cita) = 3;

/*Consulta informativa para identificar el contenido de los ID de género*/
SELECT * FROM genero;

/*Consulta informativa para identificar el contenido de los ID de los estados de cita*/
SELECT * FROM estado_cita;

/*Consulta informativa para identificar el contenido de los ID de las especialidades de odontólogos*/
SELECT * FROM especialidad;