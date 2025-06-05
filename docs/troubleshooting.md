# Solución de Problemas Comunes

## Problemas de Autenticación

### Error: "password authentication failed for user"

**Solución:**
```bash
# Configurar variable de entorno para password
export PGPASSWORD=tu_password

# O usar archivo .pgpass
echo "localhost:5432:*:postgres:tu_password" > ~/.pgpass
chmod 600 ~/.pgpass
```

### Error: "could not connect to server"

**Solución:**
1. Verificar que el servicio PostgreSQL está corriendo:
```bash
# En Windows
net start postgresql

# En Linux
sudo systemctl status postgresql
```

2. Verificar la configuración de pg_hba.conf:
```bash
# Localizar el archivo
find / -name pg_hba.conf

# Editar para permitir conexiones locales
# host    all             all             127.0.0.1/32            md5
```

## Problemas de Permisos

### Error: "permission denied for database"

**Solución:**
```sql
-- Otorgar permisos necesarios
GRANT ALL PRIVILEGES ON DATABASE testdb_restored TO postgres;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO postgres;
```

### Error: "could not open file for reading"

**Solución:**
1. Verificar permisos del archivo:
```bash
ls -l backup_file.sql
chmod 644 backup_file.sql
```

2. Verificar espacio en disco:
```bash
df -h
```

## Problemas de Restore

### Error: "relation already exists"

**Solución:**
```bash
# Usar la opción -c para limpiar antes de restaurar
pg_restore -c -d testdb_restored backup.backup
```

### Error: "invalid input syntax for type"

**Solución:**
1. Verificar la codificación de caracteres:
```sql
-- Verificar codificación actual
SHOW server_encoding;
SHOW client_encoding;

-- Cambiar codificación si es necesario
SET client_encoding TO 'UTF8';
```

2. Verificar el formato de los datos en el archivo de backup.

## Problemas de Backup

### Error: "out of memory"

**Solución:**
1. Reducir el tamaño del backup:
```bash
# Backup solo del esquema
pg_dump -s testdb > schema.sql

# Backup solo de datos
pg_dump -a testdb > data.sql
```

2. Aumentar la memoria disponible:
```bash
# En postgresql.conf
shared_buffers = 256MB
work_mem = 16MB
```

### Error: "could not write to output file"

**Solución:**
1. Verificar permisos de escritura:
```bash
# Verificar espacio en disco
df -h

# Verificar permisos del directorio
ls -ld /ruta/al/directorio
```

2. Usar un directorio temporal:
```bash
pg_dump testdb > /tmp/backup.sql
```

## Verificación de Conectividad

### Probar Conexión Básica
```bash
# Probar conexión
psql -U postgres -h localhost -p 5432 -c "SELECT version();"

# Verificar variables de entorno
echo $PGPASSWORD
echo $PGHOST
echo $PGPORT
```

### Verificar Logs
```bash
# En Windows
type "C:\Program Files\PostgreSQL\data\log\postgresql-*.log"

# En Linux
tail -f /var/log/postgresql/postgresql-*.log
```

## Recuperación de Errores

### Restaurar desde Backup Parcial
```bash
# Listar contenido del backup
pg_restore -l backup.backup

# Restaurar objetos específicos
pg_restore -L objetos.txt -d testdb_restored backup.backup
```

### Verificar Integridad del Backup
```bash
# Verificar archivo SQL
pg_restore -l backup.backup

# Verificar archivo custom
pg_restore -l backup.backup
``` 