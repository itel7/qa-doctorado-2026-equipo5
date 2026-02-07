# Week 4 Explanation (para presentacion)

## Resumen ejecutivo
Se realizo un diseno sistematico de pruebas para `GET /api/articles`, con oraculos defendibles y evidencia reproducible versionada. Se aplico EQ/BV para entradas (`limit`, `offset`) y clases de equivalencia para filtros (`tag`, `author`). Se documentaron reglas de oraculo, casos, ejecucion y evidencia.

## 1) Preparacion
- Estructura creada/verificada: `design/`, `reports/`, `evidence/week4/`, `memos/`, `scripts/`.
- Objetivo: asegurar trazabilidad y almacenamiento de evidencia.

## 2) Objeto de prueba
- Endpoint: `GET /api/articles`.
- Motivo: expone parametros opcionales y limites que permiten pruebas sistematicas sin autenticacion.

## 3) Tecnica de diseno
- Tecnica: EQ/BV (Equivalencia + Valores Limite).
- Justificacion: parametros con dominios claros (validos/invalidos) y limites naturales.

## 4) Oraculos (reglas pass/fail)
- Minimos: validacion de codigos HTTP (200 para validos, 422 para invalidos).
- Estrictos: estructura JSON (`articles`, `articlesCount`), consistencia del conteo, respeto de `limit`, coherencia de filtros.
- Documento: `design/oracle_rules.md`.

## 5) Casos sistematicos
- 13 casos derivados de EQ/BV, incluyendo limites, clases invalidas y filtros.
- Documento: `design/test_cases.md`.

## 6) Ejecucion reproducible
- Script: `scripts/systematic_cases.sh`.
- Funciones: ejecutar casos, aplicar oraculo minimo, guardar evidencia, generar resumen.

## 7) Evidencia
- `evidence/week4/` contiene:
  - `RUNLOG.md` con fecha, comando, endpoint, oraculos.
  - `summary.txt` con pass/fail.
  - `cases/` con JSON y metadatos por caso.

## 8) Reporte metodologico
- Documento: `reports/week4_report.md`.
- Incluye motivacion, tecnica, oraculos, cobertura/no cobertura y amenazas a la validez.

## 9) Memo semanal
- Documento: `memos/week4_memo.md`.
- Incluye objetivos, logros, evidencia principal, retos, lecciones y proximos pasos.

## Resultado esperado
- Oraculos defendibles y trazables.
- Casos sistematicos (no ad-hoc).
- Evidencia reproducible versionada.
- Reporte con limites y amenazas a la validez.
