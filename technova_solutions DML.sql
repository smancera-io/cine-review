/* Inserción de los valores a la tabla de tipo_cliente */
INSERT INTO tipo_cliente (nombre_tipo_cliente) 
VALUES 
	('Persona natural'),
	('Persona jurídica');
    
/* Inserción de los valores a la tabla de ciudad_cliente */
INSERT INTO ciudad_cliente (nombre_ciudad_cliente)
VALUES
	('Bogotá'),
    ('Medellín'),
    ('Cali'),
    ('Bucaramanga'),
    ('Barranquilla');
 
/* Inserción de los valores a la tabla de estado_proyecto */
INSERT INTO estado_proyecto (nombre_estado_proyecto) 
VALUES
	('En proceso'),
	('Finalizado'),
	('Cancelado');
 
/* Inserción de los valores a la tabla de especialidad_desarrollador */
INSERT INTO especialidad_desarrollador (nombre_especialidad_desarrollador) 
VALUES
	('Backend'),
	('Frontend'),
	('Fullstack'),
	('QA'),
	('DevOps');
 
/* Inserción de los valores a la tabla de nivel_desarrollador */
INSERT INTO nivel_desarrollador (nombre_nivel_desarrollador) 
VALUES
	('Junior'),
	('SemiSenior'),
	('Senior');
 
/* Inserción de los valores a la tabla de rol_proyecto */
INSERT INTO rol_proyecto (nombre_rol_proyecto) 
VALUES
	('Líder Técnico'),
	('Desarrollador'),
	('QA Tester'),
	('Arquitecto');
 
/* Inserción de los valores a la tabla de estado_tarea */
INSERT INTO estado_tarea (nombre_estado_tarea) 
VALUES
	('Pendiente'),
	('En progreso'),
	('Completada');
 
/* Inserción de los valores a la tabla de prioridad_tarea */
INSERT INTO prioridad_tarea (nombre_prioridad_tarea) 
VALUES
	('Alta'),
	('Media'),
	('Baja');

/* Inserción de los valores a la tabla de cliente */
INSERT INTO cliente 
	(tipo_cliente, nombre_cliente, apellido_cliente, email_cliente, telefono_cliente, ciudad_cliente, fecha_registro_cliente) 
VALUES
	(1, 'Daniel', 'Cepeda', 'danicepeda@gmail.com', '3001234567', 1, '2025-09-15'),
	(2, 'ShopExpress', 'SA','admin@tiendaexpress.com', '3109876543', 2, '2026-03-20'),
	(2, 'InnovateTech', 'SAS', 'hola@innovatetech.com', '3205551234', 3, '2026-02-10'),
	(1, 'Juan', 'Molina', 'molinajuan@gmail.com', '3154447890', 4, '2025-11-01'),
	(2, 'EduSoft', 'Ldta', 'contacto@edusoft.co', '3012223344', 5, '2025-01-08');
 
/* Inserción de los valores a la tabla de proyecto */
INSERT INTO proyecto 
	(nombre_proyecto, descripcion_proyecto, fecha_inicio_proyecto, fecha_fin_estimada_proyecto, estado_proyecto, cliente_proyecto) 
VALUES
	('Landing Page', 'Desarrollo de una página web para visibilidad como contador independiente', '2025-09-20', '2025-09-30', 2, 1),
	('App Inventario', 'Aplicación movil para gestión de inventario en tiempo real', '2026-04-01', '2026-05-01', 3, 2),
	('Plataforma E-learning', 'Sistema de aprendizaje en línea con módulos interactivos', '2025-01-20', '2025-04-01', 2, 5),
	('Asistente personal', 'Desarrollo de un asistente personal virtual vía WhatsApp', '2025-11-12', '2026-01-15', 2, 4),
	('CRM Empresarial', 'Gestion de relaciones con clientes y pipeline de ventas', '2026-02-25', '2026-04-25', 1, 3),
	('Tienda Online', 'E-commerce con carrito, pagos y gestión de pedidos', '2026-04-07', '2026-05-20', 1, 2),
	('App MVP', 'Producto mínimo viable para validación de mercado de cámaras', '2026-03-10', '2026-05-10', 1, 3),
	('Dashboard Analytics', 'Panel de análisis de datos con KPIs y visualizaciones avanzadas', '2026-04-01', '2026-05-01', 1, 5);
 
/*  Inserción de los valores a la tabla de desarrollador */
INSERT INTO desarrollador 
	(nombre_desarrollador, apellido_desarrollador, email_desarrollador, años_experiencia_desarrollador, especialidad_desarrollador, nivel_desarrollador) 
VALUES
	('Carlos', 'Méndez', 'carlos.mendez@technova.com', 7, 1, 3),   
	('Laura',  'Sánchez', 'laura.sanchez@technova.com', 4, 2, 2),   
	('Andrés', 'Gómez', 'andres.gomez@technova.com', 1, 3, 1),   
	('María', 'Torres', 'maria.torres@technova.com', 9, 1, 3),   
	('Julián', 'Reyes', 'julian.reyes@technova.com', 2, 4, 1),   
	('Valentina', 'Cruz', 'valentina.cruz@technova.com', 5, 2, 2),   
	('Diego' , 'Herrera', 'diego.herrera@technova.com', 8, 3, 3),  
	('Sofía', 'Vargas', 'sofia.vargas@technova.com', 3, 5, 2),  
	('Pablo', 'Ortiz', 'pablo.ortiz@technova.com', 1, 4, 1),   
	('Camila' , 'Ruiz', 'camila.ruiz@technova.com', 6, 1, 3);   

/* Inserción de los valores a la tabla de asignación */
INSERT INTO asignacion (id_proyecto, id_desarrollador, id_rol, fecha_asignacion) 
VALUES
	(1, 1, 1, '2025-09-25'),  
	(1, 2, 2, '2025-09-27'),   
	(2, 5, 3, '2026-04-15'),   
	(2, 3, 2, '2026-04-03'),   
	(2, 6, 2, '2026-04-04'),   
	(3, 9, 3, '2025-02-01'),   
	(3, 7, 1, '2025-01-22'),   
	(3, 10, 2, '2025-01-25'),   
	(4, 3, 2, '2025-11-15'),   
	(4, 4, 4, '2025-11-14'),   
	(5, 8, 2, '2026-03-01'),   
	(5, 1, 1, '2026-02-25'),   
	(6, 7, 2, '2026-04-10'),   
	(7, 6, 2, '2026-03-11'),   
	(8, 10, 1, '2026-04-05');
 
/* Inserción de los valores a la tabla de tarea */
INSERT INTO tarea 
	(descripcion_tarea, estado_tarea, prioridad_tarea, fecha_inicio_tarea, fecha_entrega_tarea, proyecto_tarea, desarrollador_tarea)
VALUES
	('Diseño de la estructura y maquetado HTML', 3, 1, '2025-09-20', '2025-09-23', 1,  2),
	('Implementación de estilos CSS y responsividad', 3, 1, '2025-09-23', '2025-09-27', 1,  2),
	('Revisión final y despliegue en servidor', 3, 2, '2025-09-27', '2025-09-30', 1,  1),
	('Diseño del modelo de datos de inventario', 3, 1, '2026-04-01', '2026-04-10', 2,  3),
	('Desarrollo de API REST para consulta de stock', 3, 1, '2026-04-10', '2026-04-25', 2,  3),
	('Pruebas funcionales de endpoints', 3, 2, '2026-04-25', '2026-05-01', 2,  5),
	('Creación del módulo de cursos y lecciones', 3, 1, '2025-01-22', '2025-02-15', 3,  7),
	('Integración de pasarela de pagos', 3, 1, '2025-02-15', '2025-03-15', 3, 10),
	('Diseño de UI/UX de la plataforma', 3, 2, '2025-03-15', '2025-04-01', 3,  2),
	('Configuración del bot de WhatsApp Business API', 3, 1, '2025-11-12', '2025-12-01', 4,  3),
	('Desarrollo del flujo conversacional con NLP', 3, 1, '2025-12-01', '2026-01-10', 4,  4),
	('Pruebas de usuario y ajustes finales', 3, 2, '2026-01-10', '2026-01-15', 4,  3),
	('Módulo de gestión de contactos y empresas', 2, 1, '2026-02-25', '2026-03-20', 5,  1),
	('Pipeline de ventas y etapas negociación', 2, 1, '2026-03-20', '2026-04-15', 5,  8),
	('Integración con cliente de correo electrónico', 1, 3, '2026-04-15', '2026-04-25', 5, 1),
	('Catálogo de productos con filtros y búsqueda', 2, 1, '2026-04-07', '2026-04-25', 6,  7),
	('Integración con pasarela de pago PSE/tarjeta', 1, 1, '2026-04-25', '2026-05-10', 6,  7),
	('Panel de administración de pedidos', 1, 2, '2026-05-10', '2026-05-20', 6, 7),
	('Definición y documentación de requerimientos', 3, 2, '2026-03-10', '2026-03-20', 7,  6),
	('Desarrollo del prototipo funcional', 2, 1, '2026-03-20', '2026-05-10', 7,  6),
	('Conexión y adición de fuentes de datos externas',   2, 1, '2026-04-01', '2026-04-20', 8, 10),
	('Construcción de visualizaciones y KPIs en panel',   1, 2, '2026-04-20', '2026-05-01', 8, 10);
 
/* Consultas JOIN con ALIAS */
/* Consulta JOIN para listar proyectos junto con el nombre del cliente */
SELECT
    p.id_proyecto,
    p.nombre_proyecto,
    CONCAT(c.nombre_cliente, ' ', c.apellido_cliente) AS cliente,
    ep.nombre_estado_proyecto AS estado
FROM proyecto p
JOIN cliente c ON p.cliente_proyecto = c.id_cliente
JOIN estado_proyecto ep ON p.estado_proyecto = ep.id_estado_proyecto;
 
/* Consulta JOIN para mostrar desarrolladores asignados a cada proyecto */
SELECT
    p.nombre_proyecto,
    CONCAT(d.nombre_desarrollador, ' ', d.apellido_desarrollador) AS desarrollador,
    a.fecha_asignacion
FROM asignacion a
JOIN proyecto p ON a.id_proyecto = p.id_proyecto
JOIN desarrollador d ON a.id_desarrollador = d.id_desarrollador
ORDER BY p.nombre_proyecto;
 
/* Consulta JOIN para listar tareas junto con el proyecto al que pertenecen */
SELECT
    t.id_tarea,
    t.descripcion_tarea,
    et.nombre_estado_tarea AS estado,
    pt.nombre_prioridad_tarea AS prioridad,
    p.nombre_proyecto
FROM tarea t
JOIN proyecto p ON t.proyecto_tarea = p.id_proyecto
JOIN estado_tarea et ON t.estado_tarea = et.id_estado_tarea
JOIN prioridad_tarea pt ON t.prioridad_tarea = pt.id_prioridad_tarea
ORDER BY p.nombre_proyecto;
 
/* Consulta JOIN para mostrar proyectos con desarrolladores y roles */
SELECT
    p.nombre_proyecto,
    CONCAT(d.nombre_desarrollador, ' ', d.apellido_desarrollador) AS desarrollador,
    rp.nombre_rol_proyecto AS rol,
    a.fecha_asignacion
FROM asignacion a
JOIN proyecto p ON a.id_proyecto = p.id_proyecto
JOIN desarrollador d ON a.id_desarrollador = d.id_desarrollador
JOIN rol_proyecto rp ON a.id_rol = rp.id_rol_proyecto
ORDER BY p.nombre_proyecto, rp.nombre_rol_proyecto;
 
/* Consulta JOIN para listar tareas junto con el desarrollador asignado */
SELECT
    t.descripcion_tarea,
    p.nombre_proyecto,
    COALESCE(
        CONCAT(d.nombre_desarrollador, ' ', d.apellido_desarrollador),
        'Sin asignar'
    ) AS desarrollador,
    et.nombre_estado_tarea AS estado_tarea,
    pt.nombre_prioridad_tarea AS prioridad
FROM tarea t
JOIN proyecto p  ON t.proyecto_tarea = p.id_proyecto
LEFT  JOIN desarrollador d  ON t.desarrollador_tarea = d.id_desarrollador
JOIN estado_tarea et ON t.estado_tarea = et.id_estado_tarea
JOIN prioridad_tarea pt ON t.prioridad_tarea = pt.id_prioridad_tarea
ORDER BY p.nombre_proyecto;
 
/* Consultas con CONDICIONES y OPERADORES LÓGICOS */
/* Consulta con condición de los proyecto en proceso después del 2026-03-01 */
SELECT
    p.nombre_proyecto,
    p.fecha_inicio_proyecto,
    ep.nombre_estado_proyecto
FROM proyecto p
JOIN estado_proyecto ep ON p.estado_proyecto = ep.id_estado_proyecto
WHERE ep.nombre_estado_proyecto = 'En proceso'
  AND p.fecha_inicio_proyecto > '2026-03-01';
 
/* Consulta con condición de las tareas con prioridad alta o pendientes */
SELECT
    t.descripcion_tarea,
    et.nombre_estado_tarea   AS estado,
    pt.nombre_prioridad_tarea AS prioridad
FROM tarea t
JOIN estado_tarea et ON t.estado_tarea = et.id_estado_tarea
JOIN prioridad_tarea pt ON t.prioridad_tarea = pt.id_prioridad_tarea
WHERE pt.nombre_prioridad_tarea = 'Alta'
   OR et.nombre_estado_tarea = 'Pendiente';
 
/* Consulta con condición de los desarrolladores que no son Junior */
SELECT
    CONCAT(d.nombre_desarrollador, ' ', d.apellido_desarrollador) AS desarrollador,
    nd.nombre_nivel_desarrollador AS nivel,
    ed.nombre_especialidad_desarrollador AS especialidad,
    d.años_experiencia_desarrollador
FROM desarrollador d
JOIN nivel_desarrollador nd ON d.nivel_desarrollador = nd.id_nivel_desarrollador
JOIN especialidad_desarrollador ed ON d.especialidad_desarrollador = ed.id_especialidad_desarrollador
WHERE nd.nombre_nivel_desarrollador <> 'Junior';
 
/* Consultas con ordenación ORDER BY */
/* Consulta con ORDER BY de proyectos ordenados por fecha de inicio, la más reciente primero */
SELECT
    p.nombre_proyecto,
    p.fecha_inicio_proyecto,
    p.fecha_fin_estimada_proyecto,
    ep.nombre_estado_proyecto
FROM proyecto p
JOIN estado_proyecto ep ON p.estado_proyecto = ep.id_estado_proyecto
ORDER BY p.fecha_inicio_proyecto DESC;
 
/* Consulta con ORDER BY de desarrolladores por su experiencia de mayor a menor */
SELECT
    CONCAT(d.nombre_desarrollador, ' ', d.apellido_desarrollador) AS desarrollador,
    d.años_experiencia_desarrollador,
    nd.nombre_nivel_desarrollador  AS nivel,
    ed.nombre_especialidad_desarrollador AS especialidad
FROM desarrollador d
JOIN nivel_desarrollador nd ON d.nivel_desarrollador = nd.id_nivel_desarrollador
JOIN especialidad_desarrollador ed ON d.especialidad_desarrollador = ed.id_especialidad_desarrollador
ORDER BY d.años_experiencia_desarrollador DESC;
 
/* Consulta con ORDER BY de tareas ordenadas por prioridad, alta, media, baja */
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
 
/* Consultas de AGRUPACIÓN y FUNCIONES DE CÁLCULO */
/* Consulta de cálculo de cantidad de proyectos por cliente */
SELECT
    CONCAT(c.nombre_cliente, ' ', c.apellido_cliente) AS cliente,
    COUNT(p.id_proyecto) AS total_proyectos
FROM cliente c
LEFT JOIN proyecto p ON p.cliente_proyecto = c.id_cliente
GROUP BY c.id_cliente, c.nombre_cliente, c.apellido_cliente
ORDER BY total_proyectos DESC;
 
/* Consulta de cálculo de número de tareas por proyecto */
SELECT
    p.nombre_proyecto,
    COUNT(t.id_tarea) AS total_tareas
FROM proyecto p
LEFT JOIN tarea t ON t.proyecto_tarea = p.id_proyecto
GROUP BY p.id_proyecto, p.nombre_proyecto
ORDER BY total_tareas DESC;
 
/* Consulta de cálculo de promedio de años de experiencia de todos los desarrolladores */
SELECT
    ROUND(AVG(d.años_experiencia_desarrollador), 2) AS promedio_experiencia,
    MIN(d.años_experiencia_desarrollador) AS min_experiencia,
    MAX(d.años_experiencia_desarrollador) AS max_experiencia
FROM desarrollador d;
 
/* Consulta de cálculo de fechas máxima y mínima de inicio de proyectos */
SELECT
    MIN(fecha_inicio_proyecto) AS proyecto_mas_antiguo,
    MAX(fecha_inicio_proyecto) AS proyecto_mas_reciente,
    MIN(fecha_fin_estimada_proyecto) AS primera_entrega_estimada,
    MAX(fecha_fin_estimada_proyecto) AS ultima_entrega_estimada
FROM proyecto;
 
/* Operaciones UPDATE */
/* Operación update de actualizar estado del proyecto id=7, App MVP a estado finalizado id=2 */
UPDATE proyecto
SET estado_proyecto = 2
WHERE id_proyecto = 7;
 
/* Operación update de actualizar especialidad del desarrollador id=3, Andrés Gómez a backend id=1 */
UPDATE desarrollador
SET especialidad_desarrollador = 1
WHERE id_desarrollador = 3;
 
/* Operación update de actualizar a prioridad alta id=1, las tareas pendientes del proyecto id=5, CRM */
UPDATE tarea
SET prioridad_tarea = 1
WHERE proyecto_tarea = 5
  AND estado_tarea = 1;  
 
/* Operaciones DELETE */
/* Operación DELETE de eliminar la tarea id=18, panel de administración de pedidos */
DELETE FROM tarea
WHERE id_tarea = 18;
 
/* Operación DELETE de eliminar la asignación de Valentina Cruz id=6, en el proyecto id=7, App MVP */
DELETE FROM asignacion
WHERE id_proyecto = 7
  AND id_desarrollador = 6;
  
/* LLamar al prodecimiento almacenado insercion_ciudad_cliente */
CALL insercion_ciudad_cliente ('Villavicencio');

/* Llamar al procedimiento almacenado insercion_cliente */
CALL insercion_cliente (1, 'Laura', 'Sofía', 'sofia16@gmail.com', '3147833992', 1, '2026-04-12');

/* Llamar al procedimiento almacenado actualizacion_cliente */
CALL actualizacion_cliente (4, '3132515789', 'juanitoproxd07insano@gmail.com');

/* Llamar al procedimiento almacenado actualizacion_proyecto */
CALL actualizacion_proyecto (6, '2026-04-20', 2);

/* Llamar al procedimiento almacenado eliminacion_desarrollador */
CALL eliminacion_desarrollador (3);

/* Llamar al procedimiento almacenado eliminacion_tarea */
CALL eliminacion_tarea (5);

/* Llamar al procedimiento almacenado join_desarrollador_no_junior */
CALL join_desarrollador_no_junior ();

SELECT * FROM tareas_ordenadas;