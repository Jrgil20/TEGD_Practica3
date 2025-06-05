# Lista de Verificación - TEGD Práctica 3

## ✅ Preparación del Entorno

- [x] **Estructura de directorios creada**
  - [x] `docs/` - Documentación
  - [x] `scripts/` - Scripts automatizados
  - [x] `backups/` - Archivos de respaldo
  - [x] `screenshots/` - Capturas de pantalla
  - [x] `presentation/` - Presentación PowerPoint

- [x] **PostgreSQL instalado y configurado**
  - [x] PostgreSQL Server instalado
  - [x] Herramientas de línea de comandos disponibles
  - [x] pgAdmin instalado (opcional)
  - [x] Variables de entorno configuradas

## ✅ Documentación

- [x] **README.md principal** - Punto de entrada al proyecto
- [x] **docs/procedimiento.md** - Procedimiento detallado paso a paso
- [x] **docs/comandos.md** - Referencia de comandos
- [x] **docs/troubleshooting.md** - Solución de problemas
- [x] **docs/checklist.md** - Esta lista de verificación

## ✅ Scripts Automatizados

- [x] **scripts/create_testdb.sql** - Creación de base de datos de prueba
- [x] **scripts/backup.sh** - Script automatizado de backup
- [x] **scripts/restore.sh** - Script automatizado de restore
- [x] **scripts/verificacion.sh** - Script de verificación del proyecto

## 🔄 Proceso de Backup y Restore

### Fase 1: Preparación
- [ ] Ejecutar `psql -U postgres -f scripts/create_testdb.sql`
- [ ] Verificar que la base de datos `testdb_practica3` se creó correctamente
- [ ] Verificar que las tablas contienen datos

### Fase 2: Backup
- [ ] Ejecutar `scripts/backup.sh` para backup automatizado
- [ ] Verificar archivos generados en `backups/backup_sql/`
- [ ] Verificar archivos generados en `backups/backup_custom/`
- [ ] Revisar reporte de backup generado

### Fase 3: Restore
- [ ] Ejecutar `scripts/restore.sh` para restore automatizado
- [ ] Verificar que la base de datos `testdb_restored` se creó
- [ ] Verificar que los datos se restauraron correctamente
- [ ] Comparar datos originales vs restaurados

### Fase 4: Verificación
- [ ] Ejecutar consultas de verificación en ambas bases de datos
- [ ] Comparar conteos de registros
- [ ] Verificar integridad de las relaciones

## 📸 Documentación Visual

### Capturas de Línea de Comandos
- [ ] Ejecución de `pg_dump` con diferentes opciones
- [ ] Ejecución de `pg_restore` 
- [ ] Verificación de datos con `psql`
- [ ] Listado de archivos de backup generados

### Capturas de pgAdmin
- [ ] Backup usando interfaz gráfica
- [ ] Configuración de opciones de backup
- [ ] Restore usando interfaz gráfica
- [ ] Verificación de datos en pgAdmin

## 📊 Presentación PowerPoint

### Diapositivas Requeridas
- [ ] **Portada** - Título, autores, asignatura
- [ ] **Objetivos** - Qué se va a demostrar
- [ ] **Herramientas** - PostgreSQL, pgAdmin, línea de comandos
- [ ] **Procedimiento** - Pasos del proceso
- [ ] **Comandos** - Comandos utilizados con explicaciones
- [ ] **Capturas** - Evidencias visuales del proceso
- [ ] **Resultados** - Verificación de éxito
- [ ] **Conclusiones** - Lecciones aprendidas

## 🧪 Pruebas Adicionales

### Escenarios de Backup
- [ ] Backup completo de base de datos
- [ ] Backup solo de esquema (`pg_dump -s`)
- [ ] Backup solo de datos (`pg_dump -a`)
- [ ] Backup de tablas específicas
- [ ] Backup con compresión

### Escenarios de Restore
- [ ] Restore en base de datos vacía
- [ ] Restore con limpieza previa (`pg_restore -c`)
- [ ] Restore selectivo de objetos
- [ ] Restore con verificación de errores

## 📋 Entregables Finales

- [x] **Código fuente** - Scripts y documentación en repositorio
- [ ] **Capturas de pantalla** - Evidencias del proceso
- [ ] **Presentación PowerPoint** - Explicación completa
- [ ] **Video demostración** (opcional) - Grabación del proceso
- [ ] **Reporte final** - Documento con resultados y conclusiones

## 🔍 Criterios de Evaluación

### Completitud del Proceso
- [ ] Backup realizado exitosamente
- [ ] Restore realizado exitosamente
- [ ] Datos verificados como íntegros
- [ ] Documentación completa y clara

### Calidad Técnica
- [ ] Comandos utilizados correctamente
- [ ] Manejo adecuado de errores
- [ ] Buenas prácticas aplicadas
- [ ] Explicaciones técnicas precisas

### Presentación
- [ ] Documentación clara y profesional
- [ ] Capturas de pantalla de calidad
- [ ] Explicación coherente del proceso
- [ ] Demostración convincente

---

## ✅ Estado Actual

**Documentación:** ✅ COMPLETA  
**Scripts:** ✅ FUNCIONALES  
**Estructura:** ✅ PREPARADA  
**Proceso:** ⏳ LISTO PARA EJECUCIÓN  

**Próximo paso:** Instalar PostgreSQL y ejecutar el proceso completo 