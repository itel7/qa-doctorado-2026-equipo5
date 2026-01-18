# Escenarios de Calidad

## Descripción General

Este documento define los escenarios de calidad utilizados para evaluar la aplicación Pet Store. Los escenarios de calidad ayudan a establecer criterios medibles para los requisitos no funcionales.

# Semana 2 — Escenarios de calidad (falsables y medibles)

Referencia de formato:
- Un escenario debe tener: Estímulo, Entorno, Respuesta, Medida, Evidencia.

## Escenario Q1 — Disponibilidad mínima del contrato (Contract Availability)
- Estímulo: un consumidor solicita el contrato OpenAPI
- Entorno: ejecución local, SUT recién iniciado
- Respuesta: el SUT entrega el documento OpenAPI
- Medida (falsable): HTTP 200 y el cuerpo contiene el campo "openapi"
- Evidencia: evidence/week2/openapi.json (captura) y openapi_http_code.txt

## Escenario Q2 — Latencia básica del endpoint de inventario (Performance - Local)
- Estímulo: se solicita GET /store/inventory
- Entorno: ejecución local, sin carga externa, 30 repeticiones consecutivas
- Respuesta: el SUT responde con HTTP 200
- Medida (falsable): registrar time_total por ejecución; (opcional) p95 <= 1.0s
- Evidencia: evidence/week2/latency.csv y evidence/week2/latency_summary.txt

## Escenario Q3 — Robustez ante IDs inválidos en /pet/{id} (Robustness / Error Handling)
- Estímulo: se solicita GET /pet/{id} con valores inválidos (e.g., -1, 0, 999999, abc)
- Entorno: ejecución local, sin carga, 1 vez por caso
- Respuesta: el SUT NO debe responder 200 para entradas inválidas
- Medida (falsable): para cada caso, HTTP != 200 (se registra el código)
- Evidencia: evidence/week2/invalid_ids.csv + evidence/week2/pet_<id>.json

## Escenario Q4 — Respuesta “bien formada” en inventario (Data Shape Sanity)
- Estímulo: se solicita GET /store/inventory
- Entorno: ejecución local, sin carga, 1 vez
- Respuesta: el cuerpo es JSON (no HTML / texto inesperado)
- Medida (falsable): el cuerpo comienza con '{' y el request devuelve HTTP 200
- Evidencia: evidence/week2/inventory.json y inventory_http_code.txt


## Criterios de Éxito

Cada escenario incluye criterios de éxito específicos y medibles que serán evaluados durante las fases de prueba. Los resultados serán documentados en las carpetas de evidencia para cada semana de pruebas.
