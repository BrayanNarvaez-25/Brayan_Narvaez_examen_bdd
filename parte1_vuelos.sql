-- Eliminar tabla
DROP TABLE vuelos,proyectos,tecnologias,proyectos_tecnologias;

--Crear tabla
CREATE TABLE vuelos (
  id                  SERIAL PRIMARY KEY,
  codigo              VARCHAR(10) NOT NULL UNIQUE,
  precio_boleto       NUMERIC(10,2) NOT NULL CHECK (precio_boleto >= 0),
  asientos_disponibles INTEGER NOT NULL CHECK (asientos_disponibles >= 0)
);

-- Crear vuelvos (inserts)
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('AA-101', 250.00, 45);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('AA-204', 310.50, 0);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('LA-305', 189.99, 120);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('LA-456', 540.00, 3);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('UA-112', 875.00, 0);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('UA-330', 95.00, 78);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('DL-221', 420.75, 2);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('DL-447', 130.00, 55);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('IB-502', 699.00, 0);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('IB-618', 215.00, 90);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('AM-733', 88.50, 4);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('AM-819', 360.00, 140);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('CM-101', 475.25, 33);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('CM-267', 80.00, 1);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('AV-384', 155.00, 175);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('AV-491', 900.00, 18);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('G3-552', 112.00, 60);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('G3-670', 290.00, 3);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('KL-784', 780.50, 22);
INSERT INTO vuelos (codigo, precio_boleto, asientos_disponibles) VALUES ('KL-893', 445.00, 110);

-- 1. Alerta: vuelos con menos de 5 asientos
SELECT * FROM vuelos
WHERE asientos_disponibles < 5;

-- 2. Incrementar precio 15% a un vuelo por ID
UPDATE vuelos
SET precio_boleto = precio_boleto * 1.15
WHERE id = 1;

-- 3. Eliminar vuelos con 0 asientos disponibles
DELETE FROM vuelos
WHERE asientos_disponibles = 0;

ALTER TABLE vuelos ADD COLUMN destino VARCHAR(100);

--Crear nuevas tablas
CREATE TABLE proyectos (
  id             SERIAL PRIMARY KEY,
  nombre         VARCHAR(100) NOT NULL,
  dias_estimados INTEGER NOT NULL CHECK (dias_estimados > 0)
);

CREATE TABLE tecnologias (
  id        SERIAL PRIMARY KEY,
  nombre    VARCHAR(50) NOT NULL,
  categoria VARCHAR(30) NOT NULL
);

--Tabla de rompimiento
CREATE TABLE proyectos_tecnologias (
  id_proyecto   INTEGER NOT NULL,
  id_tecnologia INTEGER NOT NULL,
  PRIMARY KEY (id_proyecto, id_tecnologia),
  CONSTRAINT fk_proyecto
    FOREIGN KEY (id_proyecto)
    REFERENCES proyectos(id)
    ON DELETE CASCADE,
  CONSTRAINT fk_tecnologia
    FOREIGN KEY (id_tecnologia)
    REFERENCES tecnologias(id)
    ON DELETE CASCADE
);

--Insertar nuevos datos
INSERT INTO proyectos (nombre, dias_estimados) VALUES
('App Bancaria', 120),
('Portal E-Commerce', 90),
('Sistema de Inventario', 60);

INSERT INTO tecnologias (nombre, categoria) VALUES
('Java', 'Backend'),
('React', 'Frontend'),
('PostgreSQL', 'Base de Datos'),
('Spring Boot', 'Backend');

INSERT INTO proyectos_tecnologias (id_proyecto, id_tecnologia) VALUES
(1, 1), (1, 3), (1, 4),
(2, 2), (2, 3),
(3, 1), (3, 3), (3, 4);

-- 1. Tecnologías usadas en un proyecto específico (por nombre del proyecto)
SELECT t.nombre, t.categoria
FROM tecnologias t
JOIN proyectos_tecnologias pt ON t.id = pt.id_tecnologia
JOIN proyectos p ON pt.id_proyecto = p.id
WHERE p.nombre = 'App Bancaria';

-- 2. Proyectos que usan una tecnología específica (por id de tecnología)
SELECT p.nombre, p.dias_estimados
FROM proyectos p
JOIN proyectos_tecnologias pt ON p.id = pt.id_proyecto
WHERE pt.id_tecnologia = 1;

-- 3. Reporte de uso tecnológico (mayor a menor)
SELECT t.nombre, COUNT(pt.id_proyecto) AS total_proyectos
FROM tecnologias t
JOIN proyectos_tecnologias pt ON t.id = pt.id_tecnologia
GROUP BY t.nombre
ORDER BY total_proyectos DESC;