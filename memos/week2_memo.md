# Memo de Progreso - Semana 2

**Fecha**: 24/01/2026  \
**Equipo**: Equipo X  \
**Semana**: 2 de 8

## Objetivos de la semana
- Convertir “calidad” en afirmaciones **falsables y medibles** mediante escenarios (estímulo–entorno–respuesta–medida).
- Definir un conjunto mínimo de **4 escenarios de calidad** aplicables al SUT (Petstore).
- Implementar scripts para recolectar evidencia reproducible (contrato, latencia y robustez).
- Generar y versionar evidencias (CSV/JSON/TXT) con trazabilidad a comandos.

## Logros
- Escenarios de calidad definidos y documentados en `quality/scenarios.md` (Q1–Q4).
- Script de captura del contrato OpenAPI e inventario implementado para respaldar disponibilidad mínima y forma básica de datos.
- Medición de latencia implementada en 30 repeticiones con salida a CSV.
- Pruebas de robustez ante entradas inválidas realizadas sobre `/pet/{id}` con registro de códigos HTTP y respuestas.
- Evidencias generadas y organizadas en `evidence/week2/` para revisión reproducible.

## Evidencia principal
- Escenarios y métricas: `quality/scenarios.md`.
- Evidencia del contrato y “sanity” de respuesta:
  - `scripts/capture_contract_and_inventory.sh`
  - `evidence/week2/openapi.json`, `evidence/week2/openapi_http_code.txt`
  - `evidence/week2/inventory.json`, `evidence/week2/inventory_http_code.txt`
- Evidencia de latencia:
  - `scripts/measure_latency.sh`
  - `evidence/week2/latency.csv`, `evidence/week2/latency_summary.txt`
- Evidencia de robustez:
  - `scripts/invalid_inputs.sh`
  - `evidence/week2/invalid_ids.csv` + `evidence/week2/invalid_pet_<id>.json`

## Retos y notas
- Variabilidad de latencia: las mediciones dependen del entorno local (máquina, carga, Docker), por lo que los resultados no se generalizan a producción sin controles adicionales.
- Oráculos en endpoints inválidos: la expectativa principal se definió como “HTTP != 200” para evitar asumir códigos específicos que pueden variar (400/404) según enrutamiento/implementación.
- Persistencia/estado: ejecuciones consecutivas pueden verse afectadas por warm-up/caché; se deja registrado como amenaza a la validez.

## Lecciones aprendidas
- “Calidad” se vuelve operable cuando se expresa como **escenarios con métricas**; sin medida explícita el requisito no es verificable.
- Guardar evidencia (CSV/JSON/TXT) junto al script que la genera permite auditoría y réplica por terceros.
- Definir oráculos mínimos (p. ej., “no 200” en entradas inválidas) reduce falsos debates por diferencias de implementación y mantiene el foco en falsabilidad.

## Próximos pasos (Semana 3) - (Potenciales pasos, a ser discutidos con el equipo)
- Elaborar una matriz de riesgo y derivar cobertura priorizada (riesgo → pruebas → evidencia).
- Formalizar reglas de oráculo y casos de prueba en `design/test_cases.md` y `design/oracle_rules.md`.
- Definir criterios de aceptación (entry/exit) y una estrategia de pruebas ligera basada en riesgo.
- Extender la evidencia para incluir estabilidad (repeticiones) o disponibilidad básica (múltiples checks) si el equipo lo considera relevante.

---

**Preparado por**: Equipo X  \
**Próxima revisión**: Semana 3
