# SUT Selection - QA Doctorado 2026 Equipo X

## 1. Sistema Bajo Prueba (SUT) Elegido

**Nombre**: FastAPI RealWorld Example Application  
**Tipo**: API REST Backend  
**Repositorio Original**: https://github.com/nsidnev/fastapi-realworld-example-app  
**Especificación**: RealWorld API Specification (https://realworld.io/)

### Información del SUT

- **Tecnología**: Python 3.11 + FastAPI 0.79.1
- **Base de Datos**: PostgreSQL 12+
- **Autenticación**: JWT (JSON Web Tokens)
- **Documentación API**: OpenAPI/Swagger
- **Ejecución**: Docker + Docker Compose (reproducible)

---

## 2. Criterios de Selección del SUT ✅

El SUT cumple completamente con los requisitos:

### 2.1 Se Ejecuta Localmente
- ✅ Disponible en Docker (imagen oficial: `postgres:latest`)
- ✅ Docker Compose para orquestación completa
- ✅ Setup reproducible en cualquier máquina con Docker instalado
- ✅ Configuración vía variables de entorno

### 2.2 Interfaz Observable
- ✅ **API REST HTTP**: Múltiples endpoints accesibles
- ✅ **Swagger UI**: Documentación interactiva en `/docs`
- ✅ **ReDoc**: Documentación alternativa en `/redoc`
- ✅ **Base de Datos**: Accesible para verificación de estado
- ✅ Logs estructurados con Loguru para auditoría

### 2.3 Permite Repetir Pruebas y Recolectar Evidencia
- ✅ **90 tests automatizados** preexistentes
- ✅ Suite de pruebas reproducibles
- ✅ Fixtures y data factories para resetear estado
- ✅ Base de datos limpiable entre ejecuciones
- ✅ Logs y reportes generables

### 2.4 Sin Dependencias de Datos Privados
- ✅ **Sin credenciales sensibles** en código
- ✅ Configuración por variables de entorno
- ✅ Base de datos de prueba auto-generada
- ✅ Datos de prueba creables dinámicamente

---

## 3. Por Qué es Adecuado para Pruebas y Medición

### Razón 1: Complejidad Real pero Controlada
- **API real con 30+ endpoints** que cubre casos de uso típicos
- Incluye: autenticación, CRUD, relaciones entre entidades, validaciones
- Permite diseñar test cases variados y significativos para QA
- Suficientemente compleja para demostrar técnicas avanzadas de testing

### Razón 2: Suite de Pruebas Existente como Referencia
- Incluye **90 tests automatizados** ya implementados
- Permite comparar nuestras pruebas con referencia de calidad
- Ayuda a validar la efectividad de nuestras estrategias de testing
- Base para medir cobertura, efectividad de fallos, etc.

### Razón 3: Stack Moderno y Documentado
- **FastAPI** es framework moderno con buena documentación
- **OpenAPI/Swagger** genera documentación automáticamente
- Patrón RESTful estándar facilita diseño de test cases
- Perfecta para investigación en testing de APIs modernas

---

## 4. Riesgos y Limitaciones

### Riesgo 1: Complejidad de Setup Inicial
**Descripción**: Requiere múltiples componentes (Python, Poetry, PostgreSQL, Docker)  
**Impacto**: Potencial barrera de entrada para nuevos team members  
**Mitigación**: 
- Scripts automatizados en `setup/`
- Documentación paso-a-paso en README.md
- Docker Compose simplifica orquestación

### Riesgo 2: Dependencia de PostgreSQL
**Descripción**: Base de datos requiere estado consistente entre pruebas  
**Impacto**: Pruebas pueden fallar por estado de BD no limpio  
**Mitigación**:
- Migraciones automáticas con Alembic
- Fixtures para reset de datos
- Health check automatizado

### Riesgo 3: Cambios en Dependencias
**Descripción**: BCrypt, Passlib, SQLAlchemy son externas y evolucionan  
**Impacto**: Posibles incompatibilidades con Python 3.11+  
**Mitigación**:
- Poetry lock file para versionamiento exacto
- CI/CD pipeline para detectar incompatibilidades
- Documentación de versiones testeadas

### Riesgo 4: Mantenimiento del Repo Original
**Descripción**: Repo original no está activamente mantenido  
**Impacto**: Posibles vulnerabilidades de seguridad en dependencias  
**Mitigación**:
- Fork del repositorio bajo control del equipo
- Parches de seguridad aplicables según sea necesario
- Monitoreo de alertas de dependencias

---

## 5. Alcance de Testing

### Endpoints a Probar (30+)

#### Usuarios (7 endpoints)
- `POST /api/users` - Registro
- `POST /api/users/login` - Login
- `GET /api/user` - Perfil actual
- `PUT /api/user` - Actualizar perfil
- `POST /api/users/change-password` - Cambiar contraseña

#### Artículos (8 endpoints)
- `GET /api/articles` - Listar artículos
- `POST /api/articles` - Crear artículo
- `GET /api/articles/{slug}` - Obtener artículo
- `PUT /api/articles/{slug}` - Actualizar artículo
- `DELETE /api/articles/{slug}` - Eliminar artículo
- `GET /api/articles/feed` - Feed personalizado
- `POST /api/articles/{slug}/favorite` - Marcar favorito
- `DELETE /api/articles/{slug}/favorite` - Desmarcar favorito

#### Comentarios (4 endpoints)
- `GET /api/articles/{slug}/comments` - Listar comentarios
- `POST /api/articles/{slug}/comments` - Crear comentario
- `DELETE /api/articles/{slug}/comments/{id}` - Eliminar comentario

#### Perfiles (3 endpoints)
- `GET /api/profiles/{username}` - Ver perfil
- `POST /api/profiles/{username}/follow` - Seguir usuario
- `DELETE /api/profiles/{username}/follow` - Dejar de seguir

#### Tags (1 endpoint)
- `GET /api/tags` - Listar tags

---

## 6. Arquitectura y Componentes

```
┌─────────────────────────────────────────┐
│      FastAPI Application (Puerto 8000)   │
├─────────────────────────────────────────┤
│ ┌────────────────────────────────────┐  │
│ │  API Routes (30+ endpoints)        │  │
│ │  - Users, Articles, Comments, etc  │  │
│ └────────────────────────────────────┘  │
│ ┌────────────────────────────────────┐  │
│ │  JWT Authentication                │  │
│ │  - Token generation & validation   │  │
│ └────────────────────────────────────┘  │
│ ┌────────────────────────────────────┐  │
│ │  Pydantic Models (Validation)      │  │
│ │  - Request/Response schemas        │  │
│ └────────────────────────────────────┘  │
├─────────────────────────────────────────┤
│  SQLAlchemy ORM + SQLAlchemy Async      │
├─────────────────────────────────────────┤
│  PostgreSQL Database (Puerto 5432)      │
│  - Users, Articles, Comments, Follows  │
└─────────────────────────────────────────┘
```

---

## 7. Modelo de Datos

### Entidades Principales

**Users**
- id, username, email, hashed_password
- bio, image, created_at, updated_at

**Articles**
- id, title, slug, description, body
- author_id (FK), created_at, updated_at

**Comments**
- id, body, article_id (FK)
- author_id (FK), created_at, updated_at

**Follows**
- follower_id (FK), followee_id (FK)

**Favorites**
- user_id (FK), article_id (FK)

---

## 8. Criterios de Aceptación del SUT

El SUT será considerado operativo cuando:

1. ✅ Docker Compose inicia sin errores
2. ✅ API responde en http://localhost:8000
3. ✅ Swagger UI accesible en http://localhost:8000/docs
4. ✅ BD PostgreSQL contiene todas las tablas
5. ✅ Al menos 80 de 90 tests pasan
6. ✅ Health check verifica todos los componentes
7. ✅ Logs muestran ejecución correcta

---

## 9. Métricas a Medir

Durante el doctorado mediremos:

- **Cobertura de Tests**: % de código cubierto por tests
- **Defectos Encontrados**: Cantidad y severidad
- **Tiempo de Ejecución**: Duración de suite completa
- **Confiabilidad**: % de tests pasan consistentemente
- **Repetibilidad**: Exactitud de resultados entre ejecuciones
- **Efectividad**: Defectos reales vs defectos detectados

---

## 10. Documentación de Referencia

- API Specification: https://realworld.io/
- FastAPI Docs: https://fastapi.tiangolo.com/
- PostgreSQL Docs: https://www.postgresql.org/docs/
- Pytest Docs: https://docs.pytest.org/
- Docker Docs: https://docs.docker.com/

---

**Aprobado**: Enero 18, 2026  
**Estado**: ✅ SELECCIONADO COMO SUT  
**Equipo**: QA Doctorado 2026 - Equipo X
