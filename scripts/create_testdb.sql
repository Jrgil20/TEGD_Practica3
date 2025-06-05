-- ======================================================
-- Script para crear base de datos de prueba
-- TEGD - Práctica 3: Backup y Restore PostgreSQL
-- ======================================================

-- Crear nueva base de datos
CREATE DATABASE testdb_practica3
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Spain.1252'
    LC_CTYPE = 'Spanish_Spain.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

-- Conectar a la nueva base de datos
\c testdb_practica3;

-- ======================================================
-- Crear tablas de ejemplo
-- ======================================================

-- Tabla de departamentos
CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(100),
    presupuesto DECIMAL(12,2)
);

-- Tabla de empleados
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    telefono VARCHAR(20),
    departamento_id INTEGER REFERENCES departamentos(id),
    salario DECIMAL(10,2),
    fecha_ingreso DATE DEFAULT CURRENT_DATE,
    activo BOOLEAN DEFAULT TRUE
);

-- Tabla de proyectos
CREATE TABLE proyectos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    presupuesto DECIMAL(15,2),
    departamento_id INTEGER REFERENCES departamentos(id)
);

-- Tabla de asignaciones (relación empleados-proyectos)
CREATE TABLE asignaciones (
    id SERIAL PRIMARY KEY,
    empleado_id INTEGER REFERENCES empleados(id),
    proyecto_id INTEGER REFERENCES proyectos(id),
    fecha_asignacion DATE DEFAULT CURRENT_DATE,
    horas_asignadas INTEGER
);

-- ======================================================
-- Insertar datos de prueba
-- ======================================================

-- Insertar departamentos
INSERT INTO departamentos (nombre, ubicacion, presupuesto) VALUES
    ('Tecnología de la Información', 'Planta 3 - Edificio A', 250000.00),
    ('Recursos Humanos', 'Planta 2 - Edificio A', 120000.00),
    ('Ventas', 'Planta 1 - Edificio B', 180000.00),
    ('Marketing', 'Planta 1 - Edificio B', 95000.00),
    ('Finanzas', 'Planta 4 - Edificio A', 200000.00);

-- Insertar empleados
INSERT INTO empleados (nombre, apellido, email, telefono, departamento_id, salario, fecha_ingreso) VALUES
    ('Juan', 'Pérez García', 'juan.perez@empresa.com', '555-0101', 1, 45000.00, '2023-01-15'),
    ('María', 'García López', 'maria.garcia@empresa.com', '555-0102', 2, 38000.00, '2023-03-10'),
    ('Carlos', 'López Martín', 'carlos.lopez@empresa.com', '555-0103', 3, 42000.00, '2023-02-20'),
    ('Ana', 'Martínez Ruiz', 'ana.martinez@empresa.com', '555-0104', 1, 48000.00, '2023-01-05'),
    ('Luis', 'Rodríguez Sánchez', 'luis.rodriguez@empresa.com', '555-0105', 4, 35000.00, '2023-04-12'),
    ('Elena', 'Sánchez Torres', 'elena.sanchez@empresa.com', '555-0106', 5, 52000.00, '2023-02-28'),
    ('Miguel', 'Torres Fernández', 'miguel.torres@empresa.com', '555-0107', 3, 39000.00, '2023-03-15'),
    ('Laura', 'Fernández Díaz', 'laura.fernandez@empresa.com', '555-0108', 1, 46000.00, '2023-01-20');

-- Insertar proyectos
INSERT INTO proyectos (nombre, descripcion, fecha_inicio, fecha_fin, presupuesto, departamento_id) VALUES
    ('Sistema de Gestión ERP', 'Implementación de sistema ERP corporativo', '2023-01-01', '2023-12-31', 500000.00, 1),
    ('Campaña Marketing Digital', 'Campaña publicitaria en redes sociales', '2023-03-01', '2023-06-30', 75000.00, 4),
    ('Expansión Mercado Nacional', 'Apertura de nuevas sucursales', '2023-02-15', '2023-11-30', 300000.00, 3),
    ('Modernización Infraestructura', 'Actualización de servidores y redes', '2023-04-01', '2023-08-31', 150000.00, 1),
    ('Programa Capacitación', 'Capacitación del personal en nuevas tecnologías', '2023-01-10', '2023-12-20', 80000.00, 2);

-- Insertar asignaciones
INSERT INTO asignaciones (empleado_id, proyecto_id, horas_asignadas) VALUES
    (1, 1, 40), -- Juan en Sistema ERP
    (4, 1, 35), -- Ana en Sistema ERP
    (8, 1, 30), -- Laura en Sistema ERP
    (5, 2, 25), -- Luis en Campaña Marketing
    (3, 3, 40), -- Carlos en Expansión Mercado
    (7, 3, 35), -- Miguel en Expansión Mercado
    (1, 4, 20), -- Juan en Modernización
    (4, 4, 25), -- Ana en Modernización
    (2, 5, 30), -- María en Programa Capacitación
    (6, 5, 20); -- Elena en Programa Capacitación

-- ======================================================
-- Crear índices para mejorar rendimiento
-- ======================================================

CREATE INDEX idx_empleados_departamento ON empleados(departamento_id);
CREATE INDEX idx_empleados_email ON empleados(email);
CREATE INDEX idx_proyectos_departamento ON proyectos(departamento_id);
CREATE INDEX idx_asignaciones_empleado ON asignaciones(empleado_id);
CREATE INDEX idx_asignaciones_proyecto ON asignaciones(proyecto_id);

-- ======================================================
-- Crear vistas para consultas comunes
-- ======================================================

-- Vista de empleados con información del departamento
CREATE VIEW v_empleados_completo AS
SELECT 
    e.id,
    e.nombre || ' ' || e.apellido AS nombre_completo,
    e.email,
    e.telefono,
    d.nombre AS departamento,
    e.salario,
    e.fecha_ingreso,
    e.activo
FROM empleados e
JOIN departamentos d ON e.departamento_id = d.id;

-- Vista de proyectos con información del departamento
CREATE VIEW v_proyectos_completo AS
SELECT 
    p.id,
    p.nombre,
    p.descripcion,
    p.fecha_inicio,
    p.fecha_fin,
    p.presupuesto,
    d.nombre AS departamento
FROM proyectos p
JOIN departamentos d ON p.departamento_id = d.id;

-- ======================================================
-- Mostrar estadísticas de la base de datos creada
-- ======================================================

SELECT 'Departamentos creados: ' || COUNT(*) FROM departamentos;
SELECT 'Empleados creados: ' || COUNT(*) FROM empleados;
SELECT 'Proyectos creados: ' || COUNT(*) FROM proyectos;
SELECT 'Asignaciones creadas: ' || COUNT(*) FROM asignaciones;

-- ======================================================
-- Script completado exitosamente
-- ======================================================
\echo 'Base de datos testdb_practica3 creada exitosamente con datos de prueba' 