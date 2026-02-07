# Estrategia de Pruebas Basada en Riesgo

## Propósito
Asegurar la calidad del SUT priorizando los riesgos más críticos para la operación y experiencia del usuario, mediante pruebas focalizadas y evidencia reproducible.

## Alcance
Esta estrategia cubre los riesgos de calidad identificados en la matriz, priorizando los Top 3 (disponibilidad, robustez, latencia). No cubre aún riesgos de seguridad avanzada ni escalabilidad extrema.

## Top 3 riesgos priorizados

| Riesgo | Por qué es Top | Escenario | Evidencia | Oráculo | Riesgo residual |
|--------|----------------|-----------|-----------|---------|-----------------|
| R2: Robustez | Inputs maliciosos son probables y pueden causar fallos | Q2 | evidence/week3/robustness.log | Error controlado, sin crash | Puede haber inputs no cubiertos |
| R1: Disponibilidad | API caída afecta a todos los usuarios | Q1 | evidence/week3/api_down.log | HTTP 200 en <1s | Downtime por causas externas |
| R3: Latencia | Respuestas lentas degradan UX | Q3 | evidence/week3/latency.log | 95% <1s | Latencia por red externa |

## Reglas de evidencia
- Toda evidencia en evidence/week3/
- Comando/script reproducible documentado en RUNLOG.md
- Oráculo mínimo: pass/fail según criterio objetivo

## Riesgo residual
A pesar de las pruebas, pueden existir fallos no detectados por inputs no previstos, condiciones de red extremas o fallos de infraestructura fuera del alcance de estas pruebas.

## Validez
- Interna: Pruebas reproducibles en entorno controlado.
- Constructo: Escenarios alineados a riesgos reales del producto.
- Externa: Resultados pueden variar en producción por factores externos.
