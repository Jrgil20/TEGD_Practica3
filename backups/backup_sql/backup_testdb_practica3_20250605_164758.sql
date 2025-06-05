-- Backup de ejemplo para testdb_practica3
-- Generado por script automatizado

CREATE DATABASE testdb_practica3;
\c testdb_practica3;

CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(100),
    presupuesto DECIMAL(12,2)
);

INSERT INTO departamentos VALUES (1, 'IT', 'Planta 3', 250000.00);
INSERT INTO departamentos VALUES (2, 'RRHH', 'Planta 2', 120000.00);

-- Más datos...
