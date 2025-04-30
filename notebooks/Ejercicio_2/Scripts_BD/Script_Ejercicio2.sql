-- Eliminar las tablas si existen 
DROP TABLE IF EXISTS hecho_ventas;
DROP TABLE IF EXISTS dim_tiempo;
DROP TABLE IF EXISTS dim_corresponsal;
DROP TABLE IF EXISTS dim_cliente;
DROP TABLE IF EXISTS dim_producto;

-- Crear dimensión producto
CREATE TABLE dim_producto (
  id_producto          INT PRIMARY KEY,
  nombre_producto      VARCHAR(150),
  descripcion          TEXT
);

-- Crear dimensión cliente
CREATE TABLE dim_cliente (
  id_cliente           INT PRIMARY KEY,
  nombres              VARCHAR(100),
  apellidos            VARCHAR(100),
  cedula               VARCHAR(20),
  correo_electronico   VARCHAR(150)
);

-- Crear dimensión corresponsal
CREATE TABLE dim_corresponsal (
  id_corresponsal      INT PRIMARY KEY,
  nombre_corresponsal  VARCHAR(100),
  ubicacion            VARCHAR(255)
);

-- Crear dimensión tiempo
CREATE TABLE dim_tiempo (
  id_fecha             INT PRIMARY KEY,
  fecha                DATE,
  dia                  INT,
  mes                  INT,
  anio                 INT,
  nombre_mes           VARCHAR(20)
);

-- Crear tabla de hechos
CREATE TABLE hecho_ventas (
  id_hecho             SERIAL PRIMARY KEY,
  id_fecha             INT NOT NULL,
  id_producto          INT NOT NULL,
  id_cliente           INT NOT NULL,
  id_corresponsal      INT NOT NULL,
  cantidad             INT NOT NULL,
  total_pagado         DECIMAL(14,5) NOT NULL
);