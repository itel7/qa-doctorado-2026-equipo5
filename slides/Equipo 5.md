# Plantilla de Presentación — Semanas 1 y 2 (Máx. 5 slides)

> **Regla:** máximo 5 “slides” (secciones).  
> **Tiempo total presentación:** 8-10 minutos.  

---

## Slide 1 — Semana 1 (Pregunta 1 + Respuesta 1)
**Pregunta 1:** ¿Qué tipo de evidencia de pruebas reduce incertidumbre sobre calidad sin confundir “testing” con “quality assurance”?

**Respuesta 1:**
Para disminuir la incertidumbre asociada a la calidad del producto, es necesario distinguir entre el "testing" como mecanismo de verificación del software y el "quality assurance" como disciplina orientada a la gestión y mejora de los procesos. En este contexto, la evidencia más relevante se obtiene a partir de métricas como la Eficacia de la Detección de Defectos (Defect Detection Effectiveness, DDE) y la Densidad de Defectos, las cuales permiten evaluar de manera objetiva el desempeño del proceso de calidad.

Mientras que el testing aporta información sobre el cumplimiento funcional y la validación de los requisitos del sistema, estas métricas cuantitativas contribuyen a reducir la incertidumbre al reflejar la capacidad del proceso para identificar y eliminar defectos antes de que el producto sea liberado a producción. De este modo, se proporciona evidencia empírica sobre la solidez del sistema de gestión de la calidad.

Asimismo, las mediciones enfocadas en la calidad del producto, como la densidad de defectos y la efectividad en la detección de fallos, constituyen un soporte objetivo para determinar la preparación del software para su liberación y para analizar la eficacia de las prácticas de aseguramiento de la calidad implementadas.

International Software Testing Qualifications Board. (2023). Certified Tester Foundation Level (CTFL) Syllabus Version 4.0. https://www.istqb.org/certifications/certified-tester-foundation-level

---

## Slide 2 — Semana 2 (Pregunta 2 + Respuesta 2)
**Pregunta 2:** ¿Cómo convertir “calidad” en afirmaciones falsables y medibles?

**Respuesta 2:**
-Para convertir la "calidad" en afirmaciones falsables (es decir, que pueden ser puestas a prueba y desmentidas con evidencia) y medibles, es necesario aplicar el concepto de Factores y Métricas de Calidad mediante marcos de trabajo como el estándar ISO/IEC 25010 o el enfoque GQM (Goal-Question-Metric).

1. El proceso de Operacionalización
La calidad no se mide directamente; se mide a través de sus atributos. Para hacer una afirmación falsable, debemos transformar un deseo ambiguo en un Requerimiento No Funcional (RNF) cuantitativo.

Afirmación No Falsable (Ambigua): "El sistema debe ser rápido". (No se puede probar su falsedad porque "rápido" es subjetivo).

Afirmación Falsable (Medible): "El tiempo de respuesta del endpoint 'Login' debe ser menor a 200ms bajo una carga de 500 usuarios concurrentes". (Es falsable: si el cronómetro marca 201ms, la afirmación de calidad es falsa).

2. El método GQM (Goal-Question-Metric)
Propuesto por Victor Basili, este método es la herramienta ideal para esta conversión:

Meta (Goal): Mejorar la eficiencia del sistema.

Pregunta (Question): ¿Cuánto tarda el sistema en procesar una transacción?

Métrica (Metric): Tiempo promedio de CPU por transacción.

3. Uso de Atributos de Calidad (SQUA)
Siguiendo a Sommerville (2016), la calidad se divide en sub-características medibles. Por ejemplo, la usabilidad se vuelve falsable midiendo la "tasa de éxito en la primera tarea" o el "tiempo de aprendizaje" para un usuario nuevo. Si el usuario tarda más de lo definido en el estándar, la meta de calidad no se ha cumplido.

En resumen: La calidad se vuelve medible cuando se define mediante umbrales numéricos y condiciones de entorno específicas. Sin un número y una unidad de medida, no hay calidad evaluable, solo opiniones.

Referencias Bibliográficas
Basili, V. R., Caldiera, G., & Rombach, H. D. (1994). The Goal Question Metric Approach. Encyclopedia of Software Engineering, 528-532.

ISO/IEC 25010:2011. (2011). Systems and software engineering — Systems and software Quality Requirements and Evaluation (SQuaRE) — System and software quality models. International Organization for Standardization.

Pressman, R. S., & Maxim, B. R. (2020). Software Engineering: A Practitioner's Approach (9na ed.). McGraw-Hill Education.

Sommerville, I. (2016). Software Engineering (10ma ed.). Pearson.

**Evidencias planeadas (cada uno con oráculo + archivo):**
-  create_article → Oráculo: ___ → Evidencia: `evidence/week2/q1_create_article_20260124_123835.log`
- duplicate_validation → Oráculo: ___ → Evidencia: `evidence/week2/q2_duplicate_validation_20260124_123841.log`
- modify_article → Oráculo: ___ → Evidencia: `evidence/week2/q3_modify_article_20260124_123850.log`
- unauthorized_modify → Oráculo: ___ → Evidencia: `evidence/week2/q4_unauthorized_modify_20260124_123903.log`


**Límite (1 línea):**  
- No se esta validando el cifrado de datos en las operaciones de comunicacion y tampoco el Nivel de pruebas de carga.


**Escenarios S2 (elige 2 “estrella”):**

| Escenario | HTTP | Estado | Performance |
|-----------|------|--------|-------------|
| Q1 | 201 | ✅ PASS | < 500ms |
| Q2 | 422 | ✅ PASS | < 200ms |
| Q3 | 200 | ✅ PASS | < 500ms |
| Q4 | 403 | ✅ PASS | < 100ms |
| **Smoke** | 200+ | ✅ PASS | < 2s |

**Mini-tabla (obligatoria):**
## 📊 Matriz de Trazabilidad

| Q | Escenario | Función | Archivo | Tipo | Criticidad |
|---|-----------|---------|---------|------|-----------|
| Q1 | Crear artículo | `get_slug_for_article()` | `app/services/articles.py` | Flujo Positivo | 🔴 Alta |
| Q2 | Validar duplicados | `create_article()` | `app/db/repositories/articles.py` | Validación | 🔴 Alta |
| Q3 | Modificar artículo | `check_user_can_modify_article()` | `app/services/articles.py` | Performance | 🔴 Alta |
| Q4 | Autorización | `check_user_can_modify_article()` | `app/services/articles.py` | Seguridad | 🔴 Crítica |


### Matriz de Éxito


---

## Slide 3 — Método formalizado (¿cómo trabajamos para definir escenarios?.)
**Proceso aplicado:**
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

## Slide 4 — Amenazas a la validez 
**Amenazas a la validez (mínimo 3) + mitigación futura:**


### Riesgo 1: Complejidad de Setup Inicial - Interno
**Descripción**: Requiere múltiples componentes (Python, Poetry, PostgreSQL, Docker)  
**Impacto**: Potencial barrera de entrada para nuevos team members  
**Mitigación**: 
- Scripts automatizados en `setup/`
- Documentación paso-a-paso en README.md
- Docker Compose simplifica orquestación

### Riesgo 2: Dependencia de PostgreSQL - Externa
**Descripción**: Base de datos requiere estado consistente entre pruebas  
**Impacto**: Pruebas pueden fallar por estado de BD no limpio  
**Mitigación**:
- Migraciones automáticas con Alembic
- Fixtures para reset de datos
- Health check automatizado

### Riesgo 3: Cambios en Dependencias - Externa
**Descripción**: BCrypt, Passlib, SQLAlchemy son externas y evolucionan  
**Impacto**: Posibles incompatibilidades con Python 3.11+  
**Mitigación**:
- Poetry lock file para versionamiento exacto
- CI/CD pipeline para detectar incompatibilidades
- Documentación de versiones testeadas

### Riesgo 4: Mantenimiento del Repo Original - Interno
**Descripción**: Repo original no está activamente mantenido  
**Impacto**: Posibles vulnerabilidades de seguridad en dependencias  
**Mitigación**:
- Fork del repositorio bajo control del equipo
- Parches de seguridad aplicables según sea necesario
- Monitoreo de alertas de dependencias


---

## Slide 5 — Cierre (2 conclusiones)

### Puntos Positivos
✅ Sistema responde correctamente a crear artículos  
✅ Validación de duplicados funciona  
✅ Performance aceptable en operaciones básicas  
✅ Protección de autorización implementada  

### Áreas para Investigar
⚠️ Performance bajo carga (no testeado en esta semana)  
⚠️ Manejo de errores detallado  
⚠️ Validaciones de input (campos vacíos, XSS, etc.)

### Recomendaciones
📌 Próxima semana: Agregar escenarios de carga  
📌 Próxima semana: Test de validación de inputs  
📌 Próxima semana: Test de concurrencia  

## 🎓 Conclusiones

La Tarea Grupal 2 ha sido completada exitosamente. El proyecto cuenta con:

1. **Smoke test funcional** para verificación rápida
2. **4 escenarios bien definidos** cubriendo funcionalidad, validación y seguridad
3. **Scripts automatizados** listos para ejecución
4. **Estructura de evidencia** para registro de pruebas
5. **Documentación completa** para facilitar ejecución por otros miembros

---