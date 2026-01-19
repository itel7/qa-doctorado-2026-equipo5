# Setup Scripts - QA Doctorado 2026

Scripts de automatización para ejecutar, detener y verificar la salud del SUT (Sistema Bajo Prueba).

## 📋 Descripción de Scripts

### `run_sut.sh` - Iniciar el Sistema

Inicia todos los servicios necesarios del SUT (FastAPI + PostgreSQL).

**Uso**:
```bash
./setup/run_sut.sh [opciones]
```

**Opciones**:
- `--rebuild`: Reconstruir imágenes Docker sin caché
- `-h, --help`: Mostrar ayuda

**Ejemplo**:
```bash
# Iniciar SUT
./setup/run_sut.sh

# Iniciar con imágenes reconstruidas
./setup/run_sut.sh --rebuild
```

**Qué hace**:
1. ✅ Verifica Docker y Docker Compose instalados
2. ✅ Crea archivo `.env` si no existe
3. ✅ Detiene contenedores previos
4. ✅ Inicia servicios con `docker-compose up`
5. ✅ Espera a que PostgreSQL esté listo
6. ✅ Ejecuta migraciones de base de datos
7. ✅ Muestra URLs de acceso

**URLs Disponibles Después**:
- API: http://localhost:8000
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc
- PostgreSQL: localhost:5432

---

### `stop_sut.sh` - Detener el Sistema

Detiene los servicios del SUT de manera segura.

**Uso**:
```bash
./setup/stop_sut.sh [opciones]
```

**Opciones**:
- `--remove`: Remover contenedores después de detener
- `--volumes`: Remover volúmenes (CUIDADO: borra datos)
- `-h, --help`: Mostrar ayuda

**Ejemplos**:
```bash
# Solo detener (preserva datos)
./setup/stop_sut.sh

# Detener y remover contenedores
./setup/stop_sut.sh --remove

# Limpiar todo (incluyendo datos)
./setup/stop_sut.sh --volumes
```

**Casos de Uso**:
- `stop_sut.sh`: Pausa rápida, reiniciar después
- `stop_sut.sh --remove`: Limpiar después de terminar trabajo
- `stop_sut.sh --volumes`: Reset completo de BD

---

### `healthcheck_sut.sh` - Verificar Salud del Sistema

Ejecuta una batería de checks para verificar que el SUT está funcionando correctamente.

**Uso**:
```bash
./setup/healthcheck_sut.sh [opciones]
```

**Opciones**:
- `--verbose`: Mostrar todos los detalles
- `--deep`: Realizar checks profundos (incluye tests)
- `-h, --help`: Mostrar ayuda

**Ejemplo**:
```bash
# Check básico
./setup/healthcheck_sut.sh

# Check detallado
./setup/healthcheck_sut.sh --verbose

# Check con pruebas
./setup/healthcheck_sut.sh --deep
```

**Qué Verifica**:

1. **Docker**
   - Docker instalado
   - Docker daemon respondiendo

2. **Contenedores**
   - PostgreSQL container corriendo
   - FastAPI app container corriendo

3. **PostgreSQL**
   - Base de datos respondiendo
   - Base de datos `rwdb` accesible
   - Tablas creadas (migraciones ejecutadas)

4. **API**
   - API respondiendo en http://localhost:8000
   - Swagger UI disponible
   - Endpoints accesibles

5. **Red**
   - Puerto 8000 escuchando (API)
   - Puerto 5432 escuchando (PostgreSQL)

6. **Logs**
   - Sin errores en logs de PostgreSQL
   - Sin errores en logs de app

7. **Tests** (si `--deep`)
   - Tests básicos pasando

**Output del Health Check**:
```
✓ Docker instalado
✓ Docker daemon respondiendo
✓ PostgreSQL container ejecutándose
✓ FastAPI app container ejecutándose
✓ PostgreSQL respondiendo
✓ Base de datos 'rwdb' accesible
✓ Base de datos contiene 6 tablas
✓ API respondiendo en http://localhost:8000
✓ Swagger UI disponible
✓ Puerto 8000 escuchando
✓ Puerto 5432 escuchando
✓ Sin errores en logs de PostgreSQL
✓ Sin errores en logs de app

✓ ESTADO: SALUDABLE
```

---

## 🚀 Workflow Típico

### Iniciar Proyecto

```bash
# 1. Iniciar servicios
./setup/run_sut.sh

# 2. Verificar que todo funciona
./setup/healthcheck_sut.sh
```

### Trabajar en Tests

```bash
# 1. Ejecutar tests
poetry run pytest tests/

# 2. Ver logs si hay problemas
docker-compose logs app

# 3. Verificar salud en detalle
./setup/healthcheck_sut.sh --verbose
```

### Terminar Sesión

```bash
# Opción 1: Solo detener (puedo reiniciar después)
./setup/stop_sut.sh

# Opción 2: Limpiar completamente
./setup/stop_sut.sh --volumes
```

### Problemas Comunes

**Puerto 8000 ya en uso**:
```bash
# Liberar puerto o usar otro
lsof -i :8000
kill -9 <PID>

# Luego reiniciar
./setup/run_sut.sh
```

**PostgreSQL no responde**:
```bash
# Ver logs
docker-compose logs db

# Reiniciar con rebuild
./setup/run_sut.sh --rebuild
```

**Tests fallando**:
```bash
# Health check detallado
./setup/healthcheck_sut.sh --verbose

# Verificar base de datos
docker-compose exec db psql -U postgres -d rwdb -c "SELECT COUNT(*) FROM users"
```

---

## 📊 Estados Posibles

### ✓ SALUDABLE
- Todos los checks pasan
- Sistema listo para testing
- API respondiendo correctamente

### ⚠ PARCIALMENTE SALUDABLE
- Algunos checks con advertencias
- Sistema funcional pero con limitaciones
- Revisar logs para detalles

### ✗ CON PROBLEMAS
- Fallos críticos detectados
- Sistema no usable para testing
- Ejecutar: `./setup/run_sut.sh --rebuild`

---

## 🔧 Personalización

### Variables de Entorno

Puedes modificar en `.env`:

```bash
# Puerto de API
API_PORT=8000

# Puerto de PostgreSQL
DB_PORT=5432

# Credenciales
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres

# Configuración de app
APP_ENV=dev
SECRET_KEY=tu-clave-secreta
```

### Migraciones Personalizadas

Para ejecutar migraciones específicas:

```bash
# Aplicar todas las migraciones
docker-compose exec app poetry run alembic upgrade head

# Ver estado actual
docker-compose exec app poetry run alembic current

# Revertir última migración
docker-compose exec app poetry run alembic downgrade -1
```

---

## 📝 Notas

- Los scripts requieren **bash** (no sh)
- Necesita **Docker y Docker Compose** instalados
- Requiere permisos para ejecutar Docker
- En macOS, necesita Docker Desktop corriendo

---

## 🆘 Soporte

Si tienes problemas:

1. Ejecuta: `./setup/healthcheck_sut.sh --verbose --deep`
2. Revisa logs: `docker-compose logs -f`
3. Limpia y reinicia: `./setup/stop_sut.sh --volumes && ./setup/run_sut.sh`

---

**Última actualización**: Enero 18, 2026  
**Compatible con**: Docker 20.10+, Docker Compose 2.0+
