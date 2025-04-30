-- Eliminar las tablas si existen
DROP TABLE IF EXISTS detalle_orden;
DROP TABLE IF EXISTS orden_compra;
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS corresponsal;
DROP TABLE IF EXISTS cliente;

-- Crear tabla cliente
CREATE TABLE cliente (
  id_cliente          SERIAL PRIMARY KEY,
  nombres             VARCHAR(100)    NOT NULL,
  apellidos           VARCHAR(100)    NOT NULL,
  cedula              VARCHAR(20)     NOT NULL UNIQUE,
  correo_electronico  VARCHAR(150)    NOT NULL UNIQUE,
  direccion           VARCHAR(255),
  telefono            VARCHAR(20),
  creado_en           TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla producto
CREATE TABLE producto (
  id_producto    SERIAL PRIMARY KEY,
  nombre         VARCHAR(150)  NOT NULL,
  descripcion    TEXT,
  precio_unit    NUMERIC(12,5) NOT NULL,
  disponible     BOOLEAN       NOT NULL DEFAULT TRUE,
  creado_en      TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  actualizado_en TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla corresponsal
CREATE TABLE corresponsal (
  id_corresponsal SERIAL PRIMARY KEY,
  nombre          VARCHAR(100)  NOT NULL,
  ubicacion       VARCHAR(255),
  telefono        VARCHAR(20),
  creado_en       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Crear tabla orden_compra
CREATE TABLE orden_compra (
  id_orden        SERIAL PRIMARY KEY,
  id_cliente      INT        NOT NULL,
  fecha_orden     TIMESTAMP  NOT NULL DEFAULT CURRENT_TIMESTAMP,
  numero_pago     VARCHAR(50) NOT NULL UNIQUE,
  id_corresponsal INT,
  estado          VARCHAR(10) CHECK (estado IN ('PENDIENTE','PAGADA')) NOT NULL DEFAULT 'PENDIENTE',
  fecha_pago      TIMESTAMP DEFAULT NULL,
  comentario      TEXT,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_corresponsal) REFERENCES corresponsal(id_corresponsal)
);

-- Crear tabla detalle_orden
CREATE TABLE detalle_orden (
  id_detalle      SERIAL PRIMARY KEY,
  id_orden        INT NOT NULL,
  id_producto     INT NOT NULL,
  cantidad        INT NOT NULL CHECK (cantidad > 0),
  precio_unitario NUMERIC(12,5) NOT NULL,
  subtotal        NUMERIC(14,5) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
  FOREIGN KEY (id_orden) REFERENCES orden_compra(id_orden),
  FOREIGN KEY (id_producto) REFERENCES producto(id_producto),
  CONSTRAINT ux_orden_producto UNIQUE (id_orden, id_producto)
);

-- Inserciones en la tabla cliente
INSERT INTO cliente (nombres, apellidos, cedula, correo_electronico, direccion, telefono)
VALUES 
('José_Andrés', 'Muñoz-Pérez', '0912345671', 'jose.munoz@example.com', 'Av. Siempre Viva 123', '0987654321'),
('María-Julia', 'Gómez_Núñez', '0912345672', 'maria.gomez@example.com', 'Calle 5 de Junio', '0987654322'),
('Carlos', 'Ramírez', '0912345673', 'carlos.ramirez@example.com', 'Av. 10 de Agosto', '0987654323'),
('Ana_Lucía', 'Zambrano', '0912345674', 'ana.zambrano@example.com', 'Cdla. Las Orquídeas', '0987654324'),
('Luis-Miguel', 'Torres Ñahui', '0912345675', 'luis.torres@example.com', 'Calle Bolívar y Sucre', '0987654325'),
('Fernanda', 'Pérez-López', '0912345676', 'fernanda.perez@example.com', 'Barrio San Juan', '0987654326'),
('Diego', 'Álvarez', '0912345677', 'diego.alvarez@example.com', 'Av. del Ejército', '0987654327'),
('Paúl', 'Reinoso-García', '0912345678', 'paul.reinoso@example.com', 'La Floresta N3-45', '0987654328'),
('Verónica', 'Guamán', '0912345679', 'veronica.guaman@example.com', 'Cdla. El Paraíso', '0987654329'),
('René', 'Pazmiño', '0912345680', 'rene.pazmino@example.com', 'Calle Larga 24', '0987654330'),
('Édgar', 'Vásquez', '0912345681', 'edgar.vasquez@example.com', 'Via a Baños', '0987654331'),
('Tatiana', 'Moreno-Sánchez', '0912345682', 'tatiana.moreno@example.com', 'La Armenia 2', '0987654332'),
('Juan_Pablo', 'Chávez', '0912345683', 'juan.chavez@example.com', 'Cdla. La Primavera', '0987654333'),
('Diana', 'Yánez', '0912345684', 'diana.yanez@example.com', 'Av. Solano', '0987654334'),
('Cristian', 'Ñacato-Paredes', '0912345685', 'cristian.nacato@example.com', 'Calle Las Palmas', '0987654335');

-- Inserciones en la tabla producto
INSERT INTO producto (nombre, descripcion, precio_unit, disponible)
VALUES
('Televisor LED 50" 4K', 'Televisor inteligente con resolución Ultra HD y conexión Wi-Fi.', 549.99123, TRUE),
('Laptop HP Envy 13', 'Portátil ultradelgada con procesador Intel i7 y 16GB RAM.', 899.50984, TRUE),
('Auriculares inalámbricos ñTune', 'Auriculares Bluetooth con cancelación de ruido activa.', 129.99876, TRUE),
('Altavoz_Sony XB33', 'Parlante portátil resistente al agua con bajos potentes.', 149.12345, TRUE),
('Radio de auto Pioneer-DEH', 'Reproductor de música para automóvil con USB y Bluetooth.', 89.99456, TRUE),
('Pantalla táctil 7" - Auto', 'Pantalla multimedia para vehículos con soporte para cámara trasera.', 199.99987, TRUE),
('Cámara de reversa ÑTech', 'Cámara trasera para automóvil con visión nocturna.', 59.98123, TRUE),
('Sensor de parqueo - 4 puntos', 'Kit de sensores ultrasónicos para estacionamiento.', 39.99444, TRUE),
('Sistema de sonido JBL-Car', 'Audio para vehículo con subwoofer y amplificador.', 399.50001, TRUE),
('Tablet Lenovo_Tab M10', 'Tablet de 10.1" con Android 12, 4GB RAM y 64GB almacenamiento.', 179.98765, TRUE),
('Soporte magnético - celular', 'Soporte para auto con imán fuerte y base giratoria.', 15.54321, TRUE),
('Cargador USB rápido - coche', 'Cargador doble puerto QC3.0 para encendedor de autos.', 12.98675, TRUE),
('Luces LED interiores – auto', 'Kit de luces LED RGB controladas por app móvil.', 24.99119, TRUE),
('Micrófono USB-C ÑSound', 'Micrófono condensador para grabación de podcasts.', 89.99777, TRUE),
('Smartwatch_Xiaomi Mi Band 7', 'Reloj inteligente con monitor de salud y pantalla AMOLED.', 55.51234, TRUE);

-- Inserciones en la tabla corresponsal
INSERT INTO corresponsal (nombre, ubicacion, telefono)
VALUES
('Tecnología Ñaña', 'Av. Bolívar E4-27 y García Moreno, Quito', '0998765432'),
('Audio-Mundo', 'Calle 10 de Agosto y Tarqui – Cuenca', '0987654321'),
('Electro_Hogar', 'Av. de los Shyris y Portugal, Quito', '0967123456'),
('Auto-Zona', 'Panamericana Norte Km 15.5, Ibarra', '0976543210'),
('Multiservicios López-Pérez', 'Av. La Prensa y Ramírez Dávalos, Quito', '0954321098');

-- Inserciones en la tabla orden_compra
INSERT INTO orden_compra (id_cliente, fecha_orden, numero_pago, id_corresponsal, estado, fecha_pago, comentario)
VALUES
(1, '2025-04-29 10:30:00', 'ORD0001', 1, 'PAGADA', '2025-04-29 11:00:00', 'Compra de productos electrónicos para la casa'),
(1, '2025-04-29 12:15:00', 'ORD0002', 2, 'PAGADA', '2025-04-29 13:00:00', 'Compra para regalo de cumpleaños'),
(2, '2025-04-29 14:00:00', 'ORD0003', 3, 'PAGADA', '2025-04-29 14:30:00', 'Productos para oficina'),
(2, '2025-04-29 16:10:00', 'ORD0004', 4, 'PAGADA', '2025-04-29 16:45:00', 'Artículos de audio para vehículos'),
(3, '2025-04-29 17:20:00', 'ORD0005', 5, 'PAGADA', '2025-04-29 18:00:00', 'Compra de gadgets electrónicos para el hogar'),
(3, '2025-04-29 19:30:00', 'ORD0006', 1, 'PAGADA', '2025-04-29 20:00:00', 'Compra de equipos de sonido'),
(4, '2025-04-29 20:45:00', 'ORD0007', 2, 'PAGADA', '2025-04-29 21:15:00', 'Compra de un televisor y accesorios'),
(5, '2025-04-30 08:00:00', 'ORD0008', 3, 'PAGADA', '2025-04-30 08:30:00', 'Sistema de sonido y pantallas'),
(6, '2025-04-30 09:00:00', 'ORD0009', 4, 'PAGADA', '2025-04-30 09:30:00', 'Repuestos de automóviles y audio'),
(6, '2025-04-30 11:20:00', 'ORD0010', 5, 'PAGADA', '2025-04-30 12:00:00', 'Compra de computadoras y accesorios'),
(7, '2025-04-30 12:30:00', 'ORD0011', 1, 'PAGADA', '2025-04-30 13:00:00', 'Compra de cámaras para el hogar'),
(7, '2025-04-30 13:40:00', 'ORD0012', 2, 'PAGADA', '2025-04-30 14:00:00', 'Productos para oficina y audio'),
(8, '2025-04-30 15:00:00', 'ORD0013', 3, 'PAGADA', '2025-04-30 15:30:00', 'Productos electrónicos para la cocina'),
(8, '2025-04-30 16:20:00', 'ORD0014', 4, 'PAGADA', '2025-04-30 16:50:00', 'Productos para auto y equipos de sonido'),
(9, '2025-04-30 17:30:00', 'ORD0015', 5, 'PAGADA', '2025-04-30 18:00:00', 'Cámaras de reversa y altavoces'),
(9, '2025-04-30 18:40:00', 'ORD0016', 1, 'PAGADA', '2025-04-30 19:10:00', 'Compra de artículos electrónicos para la casa'),
(10, '2025-04-30 19:50:00', 'ORD0017', 2, 'PAGADA', '2025-04-30 20:20:00', 'Compra para oficina y gadgets electrónicos'),
(10, '2025-04-30 21:00:00', 'ORD0018', 3, 'PAGADA', '2025-04-30 21:30:00', 'Compra de accesorios para computadoras y audio'),
(10, '2025-04-30 22:00:00', 'ORD0019', 4, 'PAGADA', '2025-04-30 22:30:00', 'Repuestos de automóviles y accesorios de audio');


-- Inserciones en la tabla detalle_orden
INSERT INTO detalle_orden (id_orden, id_producto, cantidad, precio_unitario)
VALUES
(1, 1, 1, 549.99123),
(1, 2, 2, 899.50984),
(2, 3, 1, 129.99876),
(2, 4, 2, 149.12345),
(3, 5, 1, 89.99456),
(3, 6, 1, 199.99987),
(4, 7, 1, 59.98123),
(4, 8, 1, 39.99444),
(5, 9, 1, 399.50001),
(5, 10, 1, 179.98765),
(6, 11, 2, 179.98765),
(6, 12, 3, 15.54321),
(7, 13, 2, 89.99777),
(7, 14, 1, 129.99876),
(8, 15, 2, 149.12345),
(8, 1, 1, 549.99123),
(9, 3, 3, 129.99876),
(9, 5, 1, 89.99456),
(10, 6, 2, 199.99987),
(10, 7, 1, 59.98123);