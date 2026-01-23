# Escenarios de Prueba - QA Doctorado 2026

## 📋 Descripción General

Esta es la definición de los **4 escenarios principales** para pruebas del SUT (FastAPI RealWorld). Cada escenario prueba funcionalidad crítica del servicio de artículos.

---

## 🎯 Escenario Q1: Crear Artículo Exitosamente

**Descripción**: Verificar que un usuario autenticado puede crear un artículo con título y contenido válidos.

**Tipo**: Flujo Positivo  
**Criticidad**: 🔴 Alta  
**Función Testeada**: `app/services/articles.py::get_slug_for_article()`

### Precondiciones
- Sistema ejecutado y accesible en `http://localhost:8000`
- Usuario registrado y autenticado
- Token JWT válido disponible

### Pasos Ejecución
1. POST a `http://localhost:8000/api/articles`
2. Headers:
   - `Content-Type: application/json`
   - `Authorization: Token {JWT_TOKEN}`
3. Body:
   ```json
   {
     "article": {
       "title": "Test Article Q1",
       "description": "Valid description",
       "body": "Valid body content",
       "tagList": ["test"]
     }
   }
   ```

### Resultado Esperado
- ✅ HTTP 201 Created
- ✅ Respuesta contiene: `slug`, `createdAt`, `author`
- ✅ Slug generado correctamente (lowercase, slugified)
- ✅ Artículo visible en GET `/api/articles`
- ✅ Tiempo de respuesta < 500ms

### Criterios de Aceptación
- [x] HTTP Status: 201
- [x] Slug único generado
- [x] Timestamp createdAt registrado
- [x] Author correctamente asignado

### Automatización
```bash
./scripts/q1_create_article.sh [TOKEN]
```

---

## 🎯 Escenario Q2: Validación de Artículos Duplicados

**Descripción**: El sistema rechaza artículos con título duplicado del mismo autor.

**Tipo**: Validación  
**Criticidad**: 🔴 Alta  
**Función Testeada**: `app/db/repositories/articles.py::create_article()`

### Precondiciones
- Artículo del Escenario Q1 ya creado
- Usuario autenticado con el mismo token

### Pasos Ejecución
1. Intentar crear nuevo artículo
2. POST a `http://localhost:8000/api/articles`
3. Usar MISMO título que el artículo Q1
4. Body:
   ```json
   {
     "article": {
       "title": "Test Article Q1",
       "description": "Duplicate attempt",
       "body": "Different body"
     }
   }
   ```

### Resultado Esperado
- ✅ HTTP 422 Unprocessable Entity (Validación)
- ✅ Mensaje de error indicando conflicto/duplicado
- ✅ Artículo NO es creado
- ✅ No hay registro duplicado en BD

### Criterios de Aceptación
- [x] HTTP Status: 422
- [x] Mensaje de error en response
- [x] Único artículo en BD (no duplicado)

### Automatización
```bash
./scripts/q2_duplicate_validation.sh [TOKEN]
```

---

## 🎯 Escenario Q3: Modificar Artículo por Propietario

**Descripción**: El autor puede actualizar su artículo exitosamente.

**Tipo**: Flujo Positivo + Performance  
**Criticidad**: 🔴 Alta  
**Función Testeada**: `app/services/articles.py::check_user_can_modify_article()`

### Precondiciones
- Artículo Q1 ya creado
- Usuario autenticado como propietario
- Token JWT válido del autor

### Pasos Ejecución
1. PUT a `http://localhost:8000/api/articles/{slug}`
   - slug obtenido del artículo Q1
2. Headers:
   - `Authorization: Token {SAME_USER_TOKEN}`
3. Body con cambios:
   ```json
   {
     "article": {
       "title": "Updated Title",
       "body": "Updated content"
     }
   }
   ```

### Resultado Esperado
- ✅ HTTP 200 OK
- ✅ Campo `updatedAt` se actualiza
- ✅ Cambios persistidos en GET subsecuente
- ✅ Tiempo de respuesta < 500ms
- ✅ Author sigue siendo el mismo

### Criterios de Aceptación
- [x] HTTP Status: 200
- [x] updatedAt modificado
- [x] Cambios visibles inmediatamente
- [x] Performance < 500ms

### Automatización
```bash
./scripts/q3_modify_article.sh [TOKEN] [ARTICLE_SLUG]
```

---

## 🎯 Escenario Q4: Rechazar Modificación No Autorizada

**Descripción**: Usuario NO-propietario NO puede modificar artículo ajeno.

**Tipo**: Seguridad  
**Criticidad**: 🔴 Alta (Crítica de Seguridad)  
**Función Testeada**: `app/services/articles.py::check_user_can_modify_article()`

### Precondiciones
- Dos usuarios diferentes registrados:
  - Usuario A: Propietario del artículo Q1
  - Usuario B: Usuario diferente
- Artículo del Usuario A ya creado
- Token JWT válido del Usuario B

### Pasos Ejecución
1. Autenticarse como Usuario B
2. Intentar PUT a `http://localhost:8000/api/articles/{slug}`
   - slug del artículo del Usuario A
3. Headers:
   - `Authorization: Token {USER_B_TOKEN}`
4. Body intentando modificar:
   ```json
   {
     "article": {
       "title": "Hacked Title"
     }
   }
   ```

### Resultado Esperado
- ✅ HTTP 403 Forbidden (Acceso Denegado)
- ✅ Mensaje: "No tiene permiso para modificar este artículo"
- ✅ Artículo NO es modificado
- ✅ Contenido original preservado en BD

### Criterios de Aceptación
- [x] HTTP Status: 403
- [x] Acceso rechazado
- [x] Artículo no modificado
- [x] Protección activa

### Automatización
```bash
./scripts/q4_unauthorized_modify.sh [OTHER_USER_TOKEN] [ARTICLE_SLUG]
```

---

## 📊 Matriz de Trazabilidad

| Q | Escenario | Función | Archivo | Tipo | Criticidad |
|---|-----------|---------|---------|------|-----------|
| Q1 | Crear artículo | `get_slug_for_article()` | `app/services/articles.py` | Flujo Positivo | 🔴 Alta |
| Q2 | Validar duplicados | `create_article()` | `app/db/repositories/articles.py` | Validación | 🔴 Alta |
| Q3 | Modificar artículo | `check_user_can_modify_article()` | `app/services/articles.py` | Performance | 🔴 Alta |
| Q4 | Autorización | `check_user_can_modify_article()` | `app/services/articles.py` | Seguridad | 🔴 Crítica |

---

## 🚀 Ejecución Rápida

### Ejecutar un escenario
```bash
./scripts/q1_create_article.sh [TOKEN]
```

### Ejecutar todos (con Makefile)
```bash
make test-all
```

### Ver evidencia
```bash
ls -la evidence/week2/
```

---

## 📈 Métricas de Éxito

| Métrica | Q1 | Q2 | Q3 | Q4 |
|---------|----|----|----|----|
| HTTP Code | 201 | 422 | 200 | 403 |
| Response Time | < 500ms | < 200ms | < 500ms | < 100ms |
| Tasa Éxito | 100% | 100% | 100% | 100% |

---

## 🔄 Estado de Implementación

- [x] Q1: Crear Artículo - ✅ Implementado
- [x] Q2: Validación - ✅ Implementado
- [x] Q3: Modificar Artículo - ✅ Implementado
- [x] Q4: Autorización - ✅ Implementado

---

**Última Actualización**: Enero 20, 2026  
**Responsable**: Equipo QA Doctorado  
**Estado**: Listo para Ejecución
