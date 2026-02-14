# Quality Gate - Semana 5

## Objetivo del gate
Operacionalizar un gate minimo, confiable y reproducible que reduzca riesgos Top 3 del SUT
(disponibilidad y robustez). El gate valida contrato accesible y respuestas estables en
endpoints publicos, mas comportamiento esperado ante entradas invalidas. No pretende asegurar
performance ni escalabilidad; la latencia solo se registra si aparece, pero no bloquea el gate.

## Checks del gate (max 4)

### Check 1: Contrato accesible (OpenAPI)
- Claim: el SUT responde y expone el contrato OpenAPI.
- Oraculo (pass/fail): HTTP 200 y el contenido incluye "openapi".
- Evidencia: evidence/week5/openapi.json, evidence/week5/openapi_http_code.txt
- Trazabilidad: risk/risk_matrix.csv (R1), risk/test_strategy.md (disponibilidad)

### Check 2: Listado de articulos (endpoint publico)
- Claim: el SUT expone listado de articulos sin autenticacion.
- Oraculo (pass/fail): HTTP 200 y respuesta JSON con clave "articles".
- Evidencia: evidence/week5/articles_list.json, evidence/week5/articles_list_http_code.txt
- Trazabilidad: risk/risk_matrix.csv (R1), risk/test_strategy.md (disponibilidad)

### Check 3: Casos sistematicos EP+BVA (subset)
- Claim: el endpoint GET /api/articles/{slug} responde con codigos esperados en clases
  invalidas y no existentes.
- Oraculo (pass/fail): cada caso cumple el codigo esperado (404 o 404/422 segun caso).
- Evidencia: evidence/week5/systematic_results.csv, evidence/week5/systematic_summary.txt
- Trazabilidad: design/test_cases.md (TC-02, TC-04, TC-06), design/oracle_rules.md
  (OR-01, OR-04, OR-05)

## Por que estos checks son alta senal / bajo ruido
- Determinismo: oraculos basados en codigos HTTP y presencia de contrato; sin metricas
  variables como latencia.
- Repetibilidad: crea datos propios (usuario/articulo) y usa slugs controlados.
- Oraculos claros: pass/fail directo, evidencia en archivos exactos para auditoria.

## Nota de diseno
El gate no falla por metricas inestables (latencia). Si se observa latencia, queda como
registro informativo en [RUNLOG](../evidence/week5/RUNLOG.md), pero no bloquea el gate.
