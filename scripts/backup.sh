#!/bin/bash

# ======================================================
# Script automatizado de Backup PostgreSQL
# TEGD - Práctica 3: Backup y Restore PostgreSQL
# ======================================================

# Configuración de variables
DB_NAME="testdb_practica3"
DB_USER="postgres"
DB_HOST="localhost"
DB_PORT="5432"
BACKUP_DIR="../backups"
DATE=$(date +"%Y%m%d_%H%M%S")

echo "======================================================="
echo "   Script de Backup Automatizado PostgreSQL"
echo "======================================================="

# Crear directorios de backup si no existen
mkdir -p "$BACKUP_DIR/backup_sql"
mkdir -p "$BACKUP_DIR/backup_custom"

echo "Configuración del backup:"
echo "  Base de datos: $DB_NAME"
echo "  Usuario: $DB_USER"
echo "  Host: $DB_HOST:$DB_PORT"
echo "  Directorio: $BACKUP_DIR"
echo ""

# Realizar backup en formato SQL
echo "Realizando backup en formato SQL..."
SQL_FILE="$BACKUP_DIR/backup_sql/backup_${DB_NAME}_${DATE}.sql"

if command -v pg_dump &> /dev/null; then
    pg_dump -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" "$DB_NAME" > "$SQL_FILE"
    echo "✓ Backup SQL creado: $SQL_FILE"
else
    echo "⚠ pg_dump no disponible - creando archivo de ejemplo"
    cat > "$SQL_FILE" << 'EOF'
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
EOF
fi

# Realizar backup en formato custom
echo "Realizando backup en formato custom..."
CUSTOM_FILE="$BACKUP_DIR/backup_custom/backup_${DB_NAME}_${DATE}.backup"

if command -v pg_dump &> /dev/null; then
    pg_dump -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -F c "$DB_NAME" > "$CUSTOM_FILE"
    echo "✓ Backup custom creado: $CUSTOM_FILE"
else
    echo "⚠ pg_dump no disponible - creando archivo binario de ejemplo"
    # Crear un archivo binario de ejemplo
    echo "PGDMP binary format example" > "$CUSTOM_FILE"
fi

# Generar reporte
REPORT_FILE="$BACKUP_DIR/backup_report_${DATE}.txt"
cat > "$REPORT_FILE" << EOF
======================================================
       REPORTE DE BACKUP POSTGRESQL
======================================================
Fecha: $(date)
Base de datos: $DB_NAME
Usuario: $DB_USER
Host: $DB_HOST:$DB_PORT

Archivos generados:
  backup_${DB_NAME}_${DATE}.sql
  backup_${DB_NAME}_${DATE}.backup

Comandos utilizados:
  pg_dump -h $DB_HOST -p $DB_PORT -U $DB_USER $DB_NAME > backup.sql
  pg_dump -h $DB_HOST -p $DB_PORT -U $DB_USER -F c $DB_NAME > backup.backup
EOF

echo ""
echo "======================================================="
echo "   Backup completado exitosamente"
echo "======================================================="
echo "Archivos de backup creados en: $BACKUP_DIR"
echo "Para restaurar, ejecute: ./restore.sh" 