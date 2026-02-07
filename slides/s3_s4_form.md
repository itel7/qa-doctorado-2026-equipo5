# Presentación Equipo 5 — Revisión Semanas 3 y 4 (Máx. 6 slides)

---

## Slide 1 — Semana 3: Top 3 riesgos (priorización)
**SUT:** Swagger Petstore (Petstore v3) 
**Fuente (repo):** `risk/risk_matrix.csv`

# Estrategia de Pruebas Basada en Riesgo

## Propósito
Asegurar la calidad del SUT priorizando los riesgos más críticos para la operación y experiencia del usuario, mediante pruebas focalizadas y evidencia reproducible.

## Alcance
Esta estrategia cubre los riesgos de calidad identificados en la matriz, priorizando los Top 3 (disponibilidad, robustez, latencia). No cubre aún riesgos de seguridad avanzada ni escalabilidad extrema.

## Top 3 riesgos priorizados

|risk_id|quality_attribute|description|cause|impact_1_5|probability_1_5|score|why_this_score|scenario_ref|evidence_ref|status|
|---|---|---|---|---|---|---|---|---|---|---|
|R1|Disponibilidad|API no responde|Crash del servidor|5|3|15|"Impacto alto posible por bugs"|quality/scenarios.md#Q1|evidence/week3/api_down.log|TOP3|
|R2|Robustez|Error 500 en endpoint cri­tico|Inputs inesperados|4|4|16|"Inputs maliciosos son probables"|quality/scenarios.md#Q2|evidence/week3/robustness.log|TOP3|
|R3|Latencia|Respuestas lentas (>1s)|Carga alta|4|3|12|"Puede ocurrir bajo stress"|quality/scenarios.md#Q3|evidence/week3/latency.log|TOP3
|R4|Consistencia|Datos inconsistentes|Condiciones de carrera|3|2|6|"No muy probable pero grave"|quality/scenarios.md#Q4||
|R5|Seguridad|Acceso no autorizado|Fallo en auth|5|2|10|"Impacto alto baja probabilidad"|quality/scenarios.md#Q5||
|R6|Integridad|Datos corruptos|Fallo en transacciones|4|2|8|"Impacto medio poco frecuente"|quality/scenarios.md#Q6||
|R7|Escalabilidad|Degradacion bajo carga|Recursos limitados|3|3|9|"Puede ocurrir en picos"|quality/scenarios.md#Q7||
|R8|Mantenibilidad|Dificultad para actualizar|Codigo acoplado|2|3|6|"Impacto bajo posible"|quality/scenarios.md#Q8||


**Qué decisión de priorización tomamos (1 frase):** ___

---

## Slide 2 — Semana 3: trazabilidad (Riesgo → Escenario → Evidencia → Oráculo → Residual)
**Fuente (repo):** `risk/test_strategy.md` y `evidence/week3/`


### Test 1: Disponibilidad (R1) - Escenario Q1
**Comando ejecutado:**
curl -w "@curl-format.txt" -o /dev/null -s http://localhost:8000/api/articles > evidence/week3/api_down.log

**Oráculo aplicado:** HTTP 200 en <1s
**Resultado esperado:** PASS si responde 200 y tiempo <1s
**Evidencia:** evidence/week3/api_down.log

**Resultado:** ✅ PASS
- HTTP Code: 200 ✓
- Tiempo respuesta: 34.641ms ✓ (< 1000ms)

---

### Test 2: Robustez (R2) - Escenario Q2
**Comando ejecutado:**
curl -X POST http://localhost:8000/api/articles -H "Content-Type: application/json" -d '{"title":123}' -i > evidence/week3/robustness.log

**Oráculo aplicado:** Error controlado (4xx/5xx) sin caída del servicio
**Resultado esperado:** PASS si responde error controlado
**Evidencia:** evidence/week3/robustness.log

**Resultado:** ✅ PASS
- HTTP Code: 403 Forbidden (error controlado) ✓
- Mensaje: "authentication required" ✓
- Sin crash del servidor ✓

---

### Test 3: Latencia (R3) - Escenario Q3
**Comando ejecutado:**
ab -n 100 -c 10 http://localhost:8000/api/articles > evidence/week3/latency.log

**Oráculo aplicado:** p95 < 1s
**Resultado esperado:** PASS si p95 < 1s
**Evidencia:** evidence/week3/latency.log

**Resultado:** ✅ PASS
- Tiempo p95: 59ms ✓ (< 1000ms)
- Tiempo p99: 65ms ✓ (< 1000ms)
- Requests: 100/100 completadas ✓
- Failed requests: 0 ✓
- Throughput: 199.79 req/s ✓

---

| Riesgo | Por qué es Top | Escenario | Evidencia | Oráculo | Riesgo residual |
|--------|----------------|-----------|-----------|---------|-----------------|
| R2: Robustez | Inputs maliciosos son probables y pueden causar fallos | Q2 | evidence/week3/robustness.log | Error controlado, sin crash | Puede haber inputs no cubiertos |
| R1: Disponibilidad | API caída afecta a todos los usuarios | Q1 | evidence/week3/api_down.log | HTTP 200 en <1s | Downtime por causas externas |
| R3: Latencia | Respuestas lentas degradan UX | Q3 | evidence/week3/latency.log | 95% <1s | Latencia por red externa |

---

## Slide 3 — Semana 3: riesgo residual (qué queda fuera y por qué)

## Reglas de evidencia
- Toda evidencia en evidence/week3/
- Comando/script reproducible documentado en RUNLOG.md
- Oráculo mínimo: pass/fail según criterio objetivo

## Riesgo residual
A pesar de las pruebas, pueden existir:
- Fallos no detectados por inputs no previstos
- Condiciones de red extremas
- Fallos de infraestructura fuera del alcance de estas pruebas.

## Validez
- Interna: Pruebas reproducibles en entorno controlado.
- Constructo: Escenarios alineados a riesgos reales del producto.
- Externa: Resultados pueden variar en producción por factores externos.



---

## Slide 4 — Semana 4: objeto de prueba + técnica sistemática
**Objeto de prueba (endpoint/función):** GET /api/articles/{slug} 
**Fuente (repo):** `design/test_cases.md`

**Por qué es buen candidato (al menos 2 razones):**
1. Criticidad funcional (core de consulta de artículos)
2. Superficie de entrada amplia (formatos diversos de slug)
3. Valores límite claros (longitud, caracteres especiales)
4. Comportamiento diferenciado (200, 404, 422)
5. Sin autenticación (simplifica ejecución)

## Técnica Aplicada

**Equivalence Partitioning (EP):**
- Divide el dominio de entrada en clases de equivalencia
- Reduce casos de prueba sin sacrificar cobertura
- Identifica valores representativos por clase

**Boundary Value Analysis (BVA):**
- Enfoca en valores límite de cada clase
- Detecta errores en condiciones de borde
- Complementa EP con casos críticos

## Ejecución

**Script:** `scripts/systematic_cases.sh`

**Comando:**
```bash
make systematic-test
```

**Evidencia:**
- `evidence/week4/RUNLOG.md`: Log de ejecución con validación de oráculos
- `evidence/week4/TC-XX.json`: Evidencia JSON por cada caso

**Reporte:**
```bash
make week4-report
```

# Métricas

- **Casos totales:** 12
- **Oráculos formales:** 7
- **Clases de equivalencia:** 12 (100% cobertura)
- **Valores límite:** 4 (100% cobertura)
- **Success rate:** 50% (6 PASS, 6 FAIL)

---

## Slide 5 — Semana 4: oráculos defendibles (mínimos vs estrictos)
**Fuente (repo):** `design/oracle_rules.md` y `evidence/week4/`

### OR-01: Código HTTP válido
**Tipo:** Débil (mínimo)
**Regla:** La respuesta debe devolver un código HTTP válido (200, 404, 422, 500)
**Criterio PASS:** HTTP status code ∈ {200, 404, 422, 500}
**Criterio FAIL:** Timeout, conexión rechazada, o código fuera del conjunto esperado

---

### OR-02: Estructura JSON válida
**Tipo:** Fuerte
**Regla:** Si la respuesta es exitosa (200), debe devolver JSON bien formado con estructura `{"article": {...}}`
**Criterio PASS:** 
- HTTP 200 
- Body es JSON válido
- Tiene clave "article"
**Criterio FAIL:** JSON malformado, falta clave "article", o estructura incorrecta

---

### OR-03: Artículo existente devuelve 200
**Tipo:** Fuerte
**Regla:** Si el slug existe en la BD, debe devolver HTTP 200 con el artículo
**Criterio PASS:**
- HTTP 200
- `article.slug` coincide con el slug solicitado
- Campos obligatorios presentes: `title`, `description`, `body`, `author`
**Criterio FAIL:** HTTP != 200 para slug existente, o campos obligatorios faltantes

---

### OR-04: Artículo inexistente devuelve 404
**Tipo:** Fuerte
**Regla:** Si el slug no existe, debe devolver HTTP 404
**Criterio PASS:**
- HTTP 404
- Body contiene mensaje de error
**Criterio FAIL:** HTTP 200 para slug inexistente, o sin mensaje de error

---

### OR-05: Slug inválido devuelve 422
**Tipo:** Fuerte
**Regla:** Si el slug tiene formato inválido (caracteres no permitidos, muy largo), debe devolver HTTP 422
**Criterio PASS:**
- HTTP 422
- Body contiene detalles del error de validación
**Criterio FAIL:** HTTP 200 para slug inválido, o sin detalles de error

---

### OR-06: Tiempo de respuesta aceptable
**Tipo:** Débil (performance)
**Regla:** La respuesta debe completarse en < 500ms (percentil 95)
**Criterio PASS:** Tiempo de respuesta < 500ms en p95
**Criterio FAIL:** Tiempo de respuesta >= 500ms consistentemente

---

### OR-07: Consistencia de datos
**Tipo:** Fuerte
**Regla:** Si un artículo existe, sus datos deben ser consistentes entre llamadas consecutivas (dentro de la misma sesión)
**Criterio PASS:** 
- Dos GET consecutivos devuelven el mismo `title`, `body`, `createdAt`
**Criterio FAIL:** Datos inconsistentes entre llamadas sin modificación

---

## Matriz de Aplicación

| Caso de Prueba | OR-01 | OR-02 | OR-03 | OR-04 | OR-05 | OR-06 | OR-07 |
|----------------|-------|-------|-------|-------|-------|-------|-------|
| TC-01 (slug válido existente) | ✓ | ✓ | ✓ | - | - | ✓ | ✓ |
| TC-02 (slug inexistente) | ✓ | - | - | ✓ | - | ✓ | - |
| TC-03 (slug vacío) | ✓ | - | - | - | ✓ | ✓ | - |
| TC-04 (slug con caracteres especiales) | ✓ | ✓/- | ✓/- | ✓/- | ✓ | ✓ | - |
| TC-05 (slug muy largo) | ✓ | - | - | - | ✓ | ✓ | - |

**Leyenda:** ✓ = aplica, - = no aplica, ✓/- = depende del caso


**Evidencia clave (2 archivos):**
- `evidence/week4/cases`
- `evidence/week4/TC-01.json`
- `evidence/week4/TC-02.json`
- `evidence/week4/TC-03.json`
- ...

---

## Slide 6 — Validez + mejora concreta

6. **Amenazas a la validez:**
   - **Construcción:** Falta de fixtures, codificación URL
   - **Interna:** Comportamiento de framework (redirect), oráculos ambiguos
   - **Externa:** Un único endpoint, oráculos sin casos de infraestructura
   - **Conclusión:** Interpretación de success rate 50%

7. **Conclusiones:** 
   - La Semana 4 se logró aplicar técnicas de diseño sistemático (EP+BVA) con oráculos formales, generando **evidencia reproducible** de 12 casos de prueba.
   - A pesar del 50% de success rate, se identificaron **causas raíz reales** (falta de fixtures, comportamiento de framework, codificación URL) que demuestran la efectividad de los oráculos para detectar tanto bugs del SUT como problemas de setup de pruebas.
   - El reporte metodológico de 2 páginas documenta amenazas a la validez, justifica selecciones técnicas, y establece trabajo futuro, cumpliendo con estándares de rigor académico para un doctorado en QA.