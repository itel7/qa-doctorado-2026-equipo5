# Memo Semana 4

## Objetivos
Disenar pruebas sistematicas para un endpoint del SUT, definir oraculos defendibles y generar evidencia reproducible versionada.

## Logros
- Oraculos definidos para `GET /api/articles` (minimos y estrictos)
- Casos sistematicos (EQ/BV) documentados
- Ejecucion reproducible implementada en `scripts/systematic_cases.sh`
- Evidencia generada en `evidence/week4/` con RUNLOG y resumen
- Reporte metodologico producido

## Evidencia principal
Ver `evidence/week4/` (RUNLOG, summary y salidas por caso).

## Retos/Notas
- El entorno local no tenia bash; la ejecucion se realizo via contenedor para asegurar reproducibilidad.

## Lecciones aprendidas
- La trazabilidad entre oraculos y casos simplifica la evaluacion.
- Documentar el comando exacto de ejecucion facilita replicacion.

## Proximos pasos
- Extender la tecnica a filtros adicionales como `favorited`.
- Incorporar pruebas de ordenamiento y paginacion mas profunda.
