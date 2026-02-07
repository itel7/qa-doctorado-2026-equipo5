# Guía del Oponente — Revisión bisemanal (Semanas 3 y 4)

**Rol:** realizar una crítica metodológica breve y útil sobre el trabajo del equipo que presenta.  
**Enfoque:** razonamiento, trazabilidad y defendibilidad. **No** evaluar cantidad de pruebas ni cantidad de endpoints.

**Tiempo total:** 6 minutos  
- 1 min: Fortalezas  
- 3 min: Preguntas críticas  
- 2 min: Recomendaciones accionables

**Grupo al que se presentó oponencia**
- Grupo 4

---

## 1) Estructura de la intervención (plantilla)

### A. Fortalezas (máx. 2)
- Fortaleza 1: 
Se han considerado los Aspectos de Seguridad más importantes para el análisis de riesgos.
- Fortaleza 2:
Apropiado planteamiento de la metodología de diseño de pruebas y oráculos.

### B. Preguntas críticas (2–3 preguntas)

1. Qué caso de prueba consideran el mas critico y por que, tiene relacion con el top 3 de riesgos?
2. Cuántos casos plantearon para un endpoint?
3. Cuál fue el criterio para decidir que 15 casos son suficientes para este endpoint?

### C. Recomendaciones accionables (máx. 2)
- Recomendación 1:
Se de be garantizar la participacion de todos los stakeholder clave y debe ser evidenciado mediante actas.

- Recomendación 2:
Realizar retrospectiva del ciclo de pruebas actual, y considerar dentro la mejora continua para las futuras iteraciones de prueba. A ser evidenciadas mediante memorias de reunion.


## 2) Lista de verificación rápida (Semanas 3 y 4)

### Semana 3 — Estrategia basada en riesgo
**Verificar en la presentación:**
- [x] Top 3 riesgos están justificados (impacto/probabilidad/score y razón breve)
- [ ] Existe trazabilidad explícita: **riesgo → escenario → evidencia → oráculo**
- [ ] La evidencia está referenciada con rutas del repo (ej.: `evidence/week3/...`)
- [x] Se declara el **riesgo residual** (qué queda fuera y por qué)


---

 ### Semana 4 — Diseño sistemático + oráculos
**Verificar en la presentación:**
- [x] Se eligió 1 objeto de prueba (endpoint/función) y se justifica
- [x] Técnica sistemática declarada (EQ/BV o pairwise) y coherente con los casos
- [x] Hay ≥ 5 reglas de oráculo (mínimas vs estrictas)
- [ ] Casos y oráculos son trazables a evidencia (ej.: `evidence/week4/...`)
- [ ] Se reconoce al menos 1 ambigüedad y cómo se resolvió

**Pregunta**
Se notó que a pesar de los riesgos identificados, el endpoint seleccionado para el diseño y oráculos no tiene relacion.

**Respuesta**
Porque era el endpoint más crítico desde el punto de vista de frecuencia de uso.