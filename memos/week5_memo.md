# Memo Semana 5

## Objetivos
- Operacionalizar un quality gate en CI con alta senal/bajo ruido.
- Asegurar trazabilidad con riesgos (Semana 3) y oraculos/casos (Semana 4).

## Logros
- Quality gate definido en ci/quality_gates.md.
- Gate ejecutable local y en CI via ci/run_quality_gate.sh.
- Evidencia week5 generada y publicada como artifact en CI.
- Trazabilidad con risk/risk_matrix.csv, risk/test_strategy.md y design/*.

## Evidencia principal
- evidence/week5/ (openapi, resultados sistematicos, SUMMARY, RUNLOG).
- Workflow CI: .github/workflows/ci.yml.

## Retos / notas
- Evitar metricas inestables (latencia) como criterio de bloqueo.
- Asegurar que el gate cree sus propios datos para determinismo.

## Lecciones aprendidas
- Un gate pequeno pero confiable reduce riesgo antes que volumen de pruebas.
- Evidencia clara facilita la defendibilidad del gate.

## Proximos pasos
- Ajustar casos sistematicos si se agregan nuevos oraculos.
- Automatizar limpieza de datos de prueba si crece el set.
