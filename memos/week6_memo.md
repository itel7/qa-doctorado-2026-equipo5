# Memo Semana 6

## Objetivos
- Identificar un riesgo de gaming (Goodhart) en el quality gate.
- Demostrarlo con evidencia reproducible before/after.
- Aplicar una defensa tecnica minima y registrarla.

## Logros
- Gaming identificado: reduccion de casos del Check 3.
- Evidencia before/after generada en evidence/week6/.
- Defensa aplicada: minimo obligatorio de casos sistematicos.
- Cambio registrado en ci/gate_change_log.md.

## Evidencia principal
- evidence/week6/before/ y evidence/week6/after/
- evidence/week6/summary.txt
- ci/gaming_drill.md

## Retos / notas
- Mantener el gate simple sin introducir nuevas herramientas.

## Lecciones aprendidas
- Un gate puede ser "optimizado" sin mejorar calidad si no hay controles.
- La gobernanza minima (conteos y cambios registrados) reduce el riesgo de gaming.

## Proximos pasos
- Revisar periodicamente el minimo de casos si cambia el subset.
- Auditar logs del gate en CI para detectar variaciones.
