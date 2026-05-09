/* Creación de la base de datos parcial*/
CREATE DATABASE parcial;

/* Selección de la base de datos parcial para comenzar a trabajar */
USE parcial;

/* Creación de las tablas */
/* Creación de la tabla producto */
CREATE TABLE producto (
    id_producto 	INT AUTO_INCREMENT,
    nombre_producto VARCHAR(50) NOT NULL,
    precio_producto DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_producto)
);

/* Creación de la tabla cliente */
CREATE TABLE cliente (
    id_cliente 	   INT AUTO_INCREMENT,
    nombre_cliente VARCHAR(50)  NOT NULL,
    ciudad_cliente VARCHAR(50)  NOT NULL,
    PRIMARY KEY (id_cliente)
);

/* Creación de la tabla pedido */
CREATE TABLE pedido (
    id_pedido    INT AUTO_INCREMENT,
    fecha_pedido DATE NOT NULL,
    id_cliente   INT  NOT NULL,
    PRIMARY KEY (id_pedido),
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

/* Creación de la tabla pedido_producto */
CREATE TABLE pedido_producto (
    id_pedido   INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_pedido_producto INT NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT fk_pp_pedido
        FOREIGN KEY (id_pedido)   REFERENCES pedido(id_pedido),
    CONSTRAINT fk_pp_producto
        FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);