# Referencia de Comandos

## Opciones de pg_dump

| Opción | Descripción |
|--------|-------------|
| `-F c` | Formato custom (binario) |
| `-F p` | Formato plain (SQL) |
| `-F t` | Formato tar |
| `-Z 1-9` | Nivel de compresión |
| `-b` | Incluir objetos grandes |
| `-v` | Modo verbose |
| `-s` | Solo esquema |
| `-a` | Solo datos |
| `-h` | Host del servidor |
| `-p` | Puerto del servidor |
| `-U` | Usuario |
| `-W` | Forzar solicitud de contraseña |

## Opciones de pg_restore

| Opción | Descripción |
|--------|-------------|
| `-d` | Base de datos destino |
| `-c` | Limpiar antes de restaurar |
| `-C` | Crear base de datos |
| `-v` | Modo verbose |
| `-1` | Ejecutar en una sola transacción |
| `-j` | Número de trabajos paralelos |
| `-l` | Listar contenido del archivo |
| `-L` | Restaurar solo objetos listados |
| `-n` | Restaurar solo el esquema especificado |
| `-t` | Restaurar solo la tabla especificada |

## Comandos psql Útiles

| Comando | Descripción |
|---------|-------------|
| `\l` | Listar todas las bases de datos |
| `\c dbname` | Conectar a una base de datos |
| `\dt` | Listar todas las tablas |
| `\d tablename` | Describir una tabla |
| `\du` | Listar usuarios y roles |
| `\dn` | Listar esquemas |
| `\q` | Salir de psql |

## Variables de Entorno

| Variable | Descripción |
|----------|-------------|
| `PGPASSWORD` | Contraseña para autenticación |
| `PGHOST` | Host del servidor |
| `PGPORT` | Puerto del servidor |
| `PGUSER` | Usuario |
| `PGDATABASE` | Base de datos por defecto |

## Ejemplos de Uso

### Backup con Variables de Entorno
```bash
export PGPASSWORD=tu_password
pg_dump -h localhost -p 5432 -U postgres testdb > backup.sql
```

### Restore con Opciones Avanzadas
```bash
pg_restore -d testdb_restored -v -c -j 4 backup.backup
```

### Verificar Contenido de Backup
```bash
pg_restore -l backup.backup
```

### Backup Selectivo
```bash
pg_dump -t 'public.empleados' -t 'public.departamentos' testdb > backup_selectivo.sql
``` 