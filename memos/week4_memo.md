# Memo Semanal - Semana 4

**De:** Ocean Jungle  
**Para:** Equipo de Doctorado en QA  
**Asunto:** Entregables Semana 4 - Diseño Sistemático de Pruebas con Oráculos  
**Fecha:** 4 de febrero de 2026

---

## Objetivo de la Semana

Aplicar técnicas de diseño sistemático de casos de prueba (Equivalence Partitioning y Boundary Value Analysis) con reglas de oráculo formales para validar el comportamiento del endpoint `GET /api/articles/{slug}` del sistema FastAPI RealWorld Example App.

---

## Logros Completados

### 1. Definición de Reglas de Oráculo ✅

**Entregable:** [design/oracle_rules.md](../design/oracle_rules.md)

Se definieron **7 reglas de oráculo** formales para el endpoint seleccionado:

- **OR-01:** Código HTTP válido (200, 404, 422, 500)
- **OR-02:** Estructura JSON correcta
- **OR-03:** Slug existente → HTTP 200 + body.article ≠ null
- **OR-04:** Slug no existente → HTTP 404
- **OR-05:** Slug inválido → HTTP 422
- **OR-06:** Tiempo de respuesta < 1000ms
- **OR-07:** Consistencia de datos (article.slug == slug_solicitado)

**Métricas:**
- 7 oráculos definidos
- Criterios PASS/FAIL objetivos para cada regla
- Cobertura: HTTP codes, JSON structure, performance, data consistency

---

### 2. Diseño de Casos Sistemáticos ✅

**Entregable:** [design/test_cases.md](../design/test_cases.md)

Se diseñaron **12 casos de prueba** derivados de Equivalence Partitioning + BVA:

| Casos | Técnica | Clases de Equivalencia | Valores Límite |
|-------|---------|------------------------|----------------|
| 12 | EP + BVA | 12 CE identificadas | Longitud: 0, 1, 255 chars |

**Casos diseñados:**
- TC-01: Slug válido existente (CE-01)
- TC-02: Slug válido no existente (CE-02)
- TC-03: Slug vacío (CE-03, BV: longitud 0)
- TC-04: Slug con espacios (CE-04)
- TC-05: Slug con guiones múltiples (CE-05)
- TC-06: Slug muy largo 255 chars (CE-06, BV: max length)
- TC-07: Slug muy corto 1 char (CE-07, BV: min length)
- TC-08: Slug con números (CE-08)
- TC-09: Slug con Unicode (CE-09)
- TC-10: Slug inicia con guión (CE-10, BV: start boundary)
- TC-11: Slug termina con guión (CE-11, BV: end boundary)
- TC-12: Slug con mayúsculas (CE-12)

**Cobertura:**
- 12/12 clases de equivalencia cubiertas (100%)
- 4/4 valores límite cubiertos (100%)

---

### 3. Script de Ejecución Automatizado ✅

**Entregable:** [scripts/systematic_cases.sh](../scripts/systematic_cases.sh)

Script bash de **213 líneas** que:
- Ejecuta los 12 casos de prueba contra el SUT
- Aplica oráculos automáticamente (OR-01 a OR-07)
- Genera evidencia en formato JSON para cada caso
- Crea RUNLOG con validación PASS/FAIL
- Calcula métricas de success rate

**Funcionalidades clave:**
```bash
run_test_case() {
  # Ejecuta curl con medición de tiempo
  # Parsea HTTP code, body, response time
  # Valida oráculos aplicables
  # Genera evidencia JSON
  # Retorna PASS/FAIL
}
```

---

### 4. Ejecución y Evidencia Generada ✅

**Evidencia:** [evidence/week4/](../evidence/week4/)

**Fecha de ejecución:** 4 de febrero de 2026, 22:26:21

**Resultados:**
| Métrica | Valor |
|---------|-------|
| Casos totales | 12 |
| Casos PASS | 6 |
| Casos FAIL | 6 |
| Success Rate | 50.0% |
| Tiempo total | ~1s |

**Evidencia generada:**
- `RUNLOG.md`: Log de ejecución con validación de oráculos por caso
- `TC-01.json` a `TC-12.json`: Evidencia JSON con HTTP code, body, tiempo, resultado

**Casos PASS:**
- TC-02: Slug válido no existente (404) ✓
- TC-06: Slug muy largo (404) ✓
- TC-07: Slug muy corto (404) ✓
- TC-09: Slug con Unicode (404) ✓
- TC-10: Slug inicia con guión (404) ✓
- TC-11: Slug termina con guión (404) ✓

**Casos FAIL:**
- TC-01: Esperaba 200, obtuvo 404 (no existe artículo en DB)
- TC-03: Esperaba 422, obtuvo 307 (redirect de FastAPI)
- TC-04: Error curl por espacios sin codificar (000)
- TC-05: Esperaba validar 200/404, solo obtuvo 404
- TC-08: Esperaba validar 200/404, solo obtuvo 404
- TC-12: Esperaba validar 200/404, solo obtuvo 404

---

### 5. Reporte Metodológico ✅

**Entregable:** [reports/week4_report.md](../reports/week4_report.md)

Reporte de **2 páginas** con:

1. **Justificación de endpoint seleccionado:** GET /api/articles/{slug} por criticidad, superficie de entrada amplia, valores límite claros, sin autenticación.

2. **Aplicación de técnica EP+BVA:** 12 clases de equivalencia identificadas, 4 valores límite, tabla de casos diseñados.

3. **Diseño de oráculos:** 7 reglas formales con criterios PASS/FAIL objetivos.

4. **Resultados de ejecución:** Tabla de 12 casos con HTTP code, tiempo, resultado, observaciones.

5. **Análisis de cobertura:** 100% CE, 100% BV, cobertura de oráculos por caso.

6. **Amenazas a la validez:**
   - **Construcción:** Falta de fixtures, codificación URL
   - **Interna:** Comportamiento de framework (redirect), oráculos ambiguos
   - **Externa:** Un único endpoint, oráculos sin casos de infraestructura
   - **Conclusión:** Interpretación de success rate 50%

7. **Conclusiones:** Logros, limitaciones, trabajo futuro (fixtures, extensión de oráculos, aplicación a múltiples endpoints).

---

## Evidencia Reproducible

**Comando para reproducir:**

```bash
# 1. Asegurar SUT corriendo
docker-compose up -d

# 2. Ejecutar casos sistemáticos
./scripts/systematic_cases.sh

# 3. Ver evidencia
cat evidence/week4/RUNLOG.md
ls evidence/week4/*.json
```

**Ubicación de entregables:**
```
design/
  oracle_rules.md       # 7 oráculos formales
  test_cases.md         # 12 casos EP+BVA

scripts/
  systematic_cases.sh   # Script ejecutable

evidence/week4/
  RUNLOG.md             # Log de ejecución
  TC-01.json            # Evidencia caso 1
  ...
  TC-12.json            # Evidencia caso 12

reports/
  week4_report.md       # Reporte metodológico

memos/
  week4_memo.md         # Este memo
```

---

## Desafíos Encontrados

### 1. Falta de Fixtures de Datos

**Problema:** TC-01 (slug válido existente) requiere que el artículo `how-to-train-your-dragon` exista en la DB, pero la base está vacía tras levantar el SUT.

**Impacto:** 1 caso FAIL por falta de precondiciones, no por bug del sistema.

**Lección aprendida:** El diseño sistemático de pruebas requiere gestión explícita de precondiciones (fixtures). Es necesario crear un script `setup_fixtures.sh` que inserte datos de prueba conocidos antes de ejecutar casos.

**Acción futura:** Implementar `scripts/setup_fixtures.sh` con:
- Registro de usuario de prueba
- Creación de 3-5 artículos con slugs conocidos
- Verificación de que los fixtures existen antes de ejecutar casos

---

### 2. Comportamiento de FastAPI con Rutas Vacías

**Problema:** TC-03 (slug vacío) retorna HTTP 307 (Temporary Redirect) en lugar de HTTP 422 esperado.

**Impacto:** El oráculo OR-05 marca FAIL porque esperaba validación de slug inválido (422), pero FastAPI maneja la ruta antes de llegar al endpoint.

**Lección aprendida:** Los frameworks web tienen comportamientos por defecto (redirects, trailing slash) que pueden interferir con la validación de entrada. Es necesario documentar si estos comportamientos son "correctos" según la especificación del sistema.

**Acción futura:** Clarificar especificación con stakeholders: ¿El sistema debe validar slug vacío (422) o es aceptable el redirect (307)?

---

### 3. Codificación de URL en Casos con Espacios

**Problema:** TC-04 (slug con espacios "invalid slug") falló con HTTP 000 porque curl no codificó automáticamente los espacios en la URL.

**Impacto:** Error de ejecución (no del SUT), pero el oráculo OR-01 correctamente identificó que HTTP 000 es inválido.

**Lección aprendida:** Los scripts de prueba deben manejar codificación de caracteres especiales en URLs antes de enviar requests.

**Acción futura:** Aplicar `printf %s "$slug" | jq -sRr @uri` en el script para codificar slugs antes de construir la URL.

---

### 4. Dependencia de Datos en Múltiples Casos

**Problema:** TC-05, TC-08, TC-12 esperaban poder validar "slug existe (200) o no existe (404)", pero al no haber fixtures, siempre retornan 404.

**Impacto:** 3 casos FAIL porque no pudieron validar ambos escenarios. Sin embargo, la validación de "slug no existe → 404" es correcta.

**Lección aprendida:** Los casos de prueba que esperan validar múltiples comportamientos (200 o 404) deben separarse en dos variantes:
- Variante A (con fixture): Validar HTTP 200
- Variante B (sin fixture): Validar HTTP 404

**Acción futura:** Refactorizar casos ambiguos en dos versiones: `TC-08a` (slug-with-numbers-123 existe → 200) y `TC-08b` (slug-with-numbers-999 no existe → 404).

---

## Lecciones Aprendidas

### Técnicas

1. **Equivalence Partitioning es escalable:** Identificar clases de equivalencia reduce exponencialmente el número de casos respecto a testing exhaustivo.

2. **Boundary Value Analysis encuentra bugs:** Los valores límite (longitud 0, 1, 255) son donde históricamente se encuentran más defectos.

3. **Oráculos formales previenen subjetividad:** Definir criterios PASS/FAIL antes de ejecutar elimina interpretación ad-hoc de resultados.

4. **Evidencia automatizada es auditable:** JSON + RUNLOG permite reproducibilidad y trazabilidad para auditorías.

### Proceso

1. **El diseño precede a la ejecución:** Crear oracle_rules.md y test_cases.md ANTES de escribir el script evita sesgos en la validación.

2. **Los fixtures son ciudadanos de primera clase:** El setup de datos de prueba debe diseñarse con el mismo rigor que los casos de prueba.

3. **Las amenazas a la validez deben documentarse:** Reconocer limitaciones del estudio aumenta credibilidad metodológica.

4. **La automatización requiere manejo de errores:** Scripts robustos deben manejar URL encoding, timeouts, errores de red, etc.

---

## Próximos Pasos (Semana 5)

1. **Implementar `scripts/setup_fixtures.sh`:**
   - Crear usuario de prueba
   - Insertar artículos con slugs conocidos
   - Verificar fixtures antes de ejecutar casos

2. **Extender cobertura de oráculos:**
   - OR-08: Disponibilidad de infraestructura (DB down)
   - OR-09: Idempotencia (múltiples requests retornan mismo resultado)
   - OR-10: Concurrencia (requests simultáneos)

3. **Aplicar EP+BVA a 3 endpoints adicionales:**
   - `POST /api/articles` (crear artículo)
   - `PUT /api/articles/{slug}` (actualizar artículo)
   - `GET /api/profiles/{username}` (consultar perfil)

4. **Integrar en CI/CD:**
   - Agregar `make systematic-test` al Makefile
   - Configurar GitHub Actions para ejecutar casos en PR
   - Generar reporte de cobertura automático

---

## Conclusión

La Semana 4 logró aplicar rigurosamente técnicas de diseño sistemático (EP+BVA) con oráculos formales, generando **evidencia reproducible** de 12 casos de prueba.

A pesar del 50% de success rate, se identificaron **causas raíz reales** (falta de fixtures, comportamiento de framework, codificación URL) que demuestran la efectividad de los oráculos para detectar tanto bugs del SUT como problemas de setup de pruebas.

El reporte metodológico de 2 páginas documenta amenazas a la validez, justifica selecciones técnicas, y establece trabajo futuro, cumpliendo con estándares de rigor académico para un doctorado en QA.

**Entregables completados: 5/5** ✅

---

**Atentamente,**  
Ocean Jungle  
Estudiante de Doctorado en QA, 2026  
Proyecto: FastAPI RealWorld Example App
