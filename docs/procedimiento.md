# Procedimiento Detallado de Backup y Restore

## 0. Instalación de PostgreSQL

### En Windows

1. **Descargar PostgreSQL**:
   - Ir a https://www.postgresql.org/download/windows/
   - Descargar el instalador para Windows
   - Ejecutar el instalador y seguir las instrucciones

2. **Configurar Variables de Entorno**:
   ```cmd
   # Agregar al PATH (ejemplo para PostgreSQL 15)
   set PATH=%PATH%;C:\Program Files\PostgreSQL\15\bin
   
   # Para hacerlo permanente, agregar en Variables de Entorno del Sistema
   ```

3. **Verificar Instalación**:
   ```cmd
   psql --version
   pg_dump --version
   ```

### En Linux (Ubuntu/Debian)

```bash
# Actualizar repositorios
sudo apt update

# Instalar PostgreSQL
sudo apt install postgresql postgresql-contrib

# Verificar instalación
psql --version
```

### En macOS

```bash
# Usando Homebrew
brew install postgresql

# Iniciar servicio
brew services start postgresql
```

## 1. Preparación del Entorno

### Verificar Instalación de PostgreSQL
```bash
# Verificar versión de PostgreSQL
psql --version
pg_dump --version
```

### Crear Base de Datos de Prueba
```sql
-- Conectar a PostgreSQL
psql -U postgres

-- Crear nueva base de datos
CREATE DATABASE testdb_practica3;

-- Conectar a la nueva base de datos
\c testdb_practica3;

-- Crear tablas de ejemplo con datos
CREATE TABLE empleados (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    departamento VARCHAR(50),
    salario DECIMAL(10,2),
    fecha_ingreso DATE
);

-- Insertar datos de prueba
INSERT INTO empleados (nombre, departamento, salario, fecha_ingreso) VALUES
    ('Juan Pérez', 'IT', 45000.00, '2023-01-15'),
    ('María García', 'RRHH', 38000.00, '2023-03-10'),
    ('Carlos López', 'Ventas', 42000.00, '2023-02-20');
```

## 2. Backup de la Base de Datos

### Usando pg_dump (Línea de Comandos)

#### Backup en formato SQL
```bash
# Backup completo en formato SQL
pg_dump -U postgres -h localhost -p 5432 testdb_practica3 > backup_testdb.sql

# Backup con compresión
pg_dump -U postgres -h localhost -p 5432 -Z 9 testdb_practica3 > backup_testdb_compressed.sql
```

#### Backup en formato personalizado
```bash
# Backup en formato custom (recomendado para restore selectivo)
pg_dump -U postgres -h localhost -p 5432 -F c testdb_practica3 > backup_testdb.backup

# Backup con opciones adicionales
pg_dump -U postgres -h localhost -p 5432 -F c -b -v testdb_practica3 > backup_testdb_complete.backup
```

### Usando pgAdmin (Interfaz Gráfica)

1. **Conectar al servidor PostgreSQL**
2. **Seleccionar la base de datos** → `testdb_practica3`
3. **Click derecho** → `Backup...`
4. **Configurar opciones de backup:**
   - Filename: `backup_testdb_pgadmin.backup`
   - Format: `Custom`
   - Compression: `6`
5. **Ejecutar backup**

## 3. Restauración de la Base de Datos

### Preparación para Restore
```sql
-- Crear nueva base de datos destino
CREATE DATABASE testdb_restored;
```

### Usando pg_restore y psql (Línea de Comandos)

#### Restore desde archivo SQL
```bash
# Restore desde backup SQL
psql -U postgres -h localhost -p 5432 testdb_restored < backup_testdb.sql
```

#### Restore desde archivo custom
```bash
# Restore desde backup custom
pg_restore -U postgres -h localhost -p 5432 -d testdb_restored backup_testdb.backup

# Restore con opciones adicionales
pg_restore -U postgres -h localhost -p 5432 -d testdb_restored -v -c backup_testdb.backup
```

### Usando pgAdmin (Interfaz Gráfica)

1. **Seleccionar base de datos destino** → `testdb_restored`
2. **Click derecho** → `Restore...`
3. **Seleccionar archivo de backup**
4. **Configurar opciones de restore**
5. **Ejecutar restore**

## 4. Verificación de Datos

### Verificar Restauración Exitosa
```sql
-- Conectar a la base de datos restaurada
\c testdb_restored;

-- Verificar tablas
\dt

-- Verificar datos
SELECT * FROM empleados;

-- Comparar conteos
SELECT COUNT(*) as total_empleados FROM empleados;
```

### Comparación de Bases de Datos
```bash
# Comparar esquemas
pg_dump -U postgres -s testdb_practica3 > schema_original.sql
pg_dump -U postgres -s testdb_restored > schema_restored.sql
diff schema_original.sql schema_restored.sql
``` 