/* Inserción de valores de la tabla producto */
INSERT INTO producto (nombre_producto, precio_producto) 
VALUES
	('Samsung Book 4', 2500000.00),
	('Mouse Inalámbrico', 45000.00),
	('Teclado Mecánico', 150000.00),
	('Monitor 24"', 850000.00),
	('Auriculares Bluetooth', 95000.00);

/* Inserción de valores de la tabla cliente */
INSERT INTO cliente (nombre_cliente, ciudad_cliente) 
VALUES
	('Daniel Cepeda', 'Bogotá'),
	('Juan Molina', 'Medellín'),
	('Sofía Herrera', 'Cali'),
	('Carlos Quintero', 'Barranquilla');

/* Inserción de valores de la tabla pedido */
INSERT INTO pedido (fecha_pedido, id_cliente) 
VALUES
	('2026-02-01', 1),
	('2026-04-05', 2),
	('2026-04-10', 3),
	('2026-03-15', 1),
	('2026-01-20', 4);

/* Inserción de valores de la tabla pedido_producto */
INSERT INTO pedido_producto (id_pedido, id_producto, cantidad_pedido_producto) 
VALUES
	(1, 1, 1),
	(1, 2, 2),
	(2, 3, 1),
	(2, 4, 1),
	(3, 2, 3),
	(3, 5, 1),
	(4, 1, 1),
	(5, 3, 2),
	(5, 5, 1);
    
/* Consultas JOIN */
/* Consulta JOIN entre el cliente y pedido*/
SELECT
    c.id_cliente,
    c.nombre_cliente AS Cliente,
    c.ciudad_cliente AS Ciudad,
    p.id_pedido,
    p.fecha_pedido
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente;

/* Consulta JOIN entre producto y pedido */
SELECT
    p.id_pedido,
    p.fecha_pedido AS Fecha,
    pr.id_producto,
    pr.nombre_producto AS Producto,
    pr.precio_producto AS Precio,
    pp.cantidad_pedido_producto AS Cantidad,
    (pr.precio_producto * pp.cantidad_pedido_producto) AS Subtotal
FROM pedido p
JOIN pedido_producto pp ON p.id_pedido = pp.id_pedido
JOIN producto pr ON pp.id_producto = pr.id_producto;

/* Consulta JOIN entre cliente y producto */
SELECT
    c.id_cliente,
    c.nombre_cliente AS Cliente,
    c.ciudad_cliente AS Ciudad,
    pr.id_producto,
    pr.nombre_producto AS Producto,
    pr.precio_producto AS Precio,
    pp.cantidad_pedido_producto AS Cantidad,
    p.fecha_pedido AS Fecha_pedido
FROM cliente c
JOIN pedido p ON c.id_cliente = p.id_cliente
JOIN pedido_producto pp ON p.id_pedido = pp.id_pedido
JOIN producto pr ON pp.id_producto = pr.id_producto;

