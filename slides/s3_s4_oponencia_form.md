# Guía del Oponente — Revisión bisemanal (Semanas 3 y 4)

**Rol:** realizar una crítica metodológica breve y útil sobre el trabajo del equipo que presenta.  
**Enfoque:** razonamiento, trazabilidad y defendibilidad. **No** evaluar cantidad de pruebas ni cantidad de endpoints.

**Tiempo total:** 6 minutos  
- 1 min: Fortalezas  
- 3 min: Preguntas críticas  
- 2 min: Recomendaciones accionables

---

## 1) Estructura de la intervención (plantilla)

### A. Fortalezas (máx. 2)
- Fortaleza 1: ___ (por qué es defendible)

- Fortaleza 2: ___ (por qué mejora trazabilidad o calidad metodológica)

Endpoint probado, tecnica de diseno utilizado, los casos de prueba, y la evidencia general.

### B. Preguntas críticas (2–3 preguntas)
- Pregunta 1 (Semana 3 - riesgo): ___
- Pregunta 2 (Semana 3 - trazabilidad/evidencia): ___
- Pregunta 3 (Semana 4 - oráculo/diseño): ___

1. Cuántos casos plantearon para un endpoint?
2. Cuál fue el criterio para decidir que 12# casos son suficientes para este endpoint?
3. Qué caso de prueba consideran el mas critico y por que?


### C. Recomendaciones accionables (máx. 2)
- Recomendación 1: ___ (acción concreta y verificable)
Se de be garantizar la participacion de todos los stakeholder clave y debe ser evidenciado mediante actas.

- Recomendación 2: ___ (acción concreta y verificable)
Realizar retrospectiva del ciclo de pruebas actual, y considerar dentro la mejora continua para las futuras iteraciones de prueba. A ser evidenciadas mediante memorias de reunion.


## 2) Lista de verificación rápida (Semanas 3 y 4)

### Semana 3 — Estrategia basada en riesgo
**Verificar en la presentación:**
- [ ] Top 3 riesgos están justificados (impacto/probabilidad/score y razón breve)
- [ ] Existe trazabilidad explícita: **riesgo → escenario → evidencia → oráculo**
- [ ] La evidencia está referenciada con rutas del repo (ej.: `evidence/week3/...`)
- [ ] Se declara el **riesgo residual** (qué queda fuera y por qué)

**Preguntas de ejemplo:**
- ¿Qué evidencia haría **falsa** su afirmación de reducción de riesgo (falsación)?
- ¿Por qué estos 3 riesgos y no otros? ¿Qué criterio del material teórico sustenta esa decisión?
- ¿El riesgo residual está explícitamente aceptado o solo omitido?

---

 ### Semana 4 — Diseño sistemático + oráculos
**Verificar en la presentación:**
- [ ] Se eligió 1 objeto de prueba (endpoint/función) y se justifica
- [ ] Técnica sistemática declarada (EQ/BV o pairwise) y coherente con los casos
- [ ] Hay ≥ 5 reglas de oráculo (mínimas vs estrictas)
- [ ] Casos y oráculos son trazables a evidencia (ej.: `evidence/week4/...`)
- [ ] Se reconoce al menos 1 ambigüedad y cómo se resolvió

**Preguntas de ejemplo:**
- ¿Qué parte del oráculo es “mínima” (segura) y cuál es “estricta”? ¿Por qué?
- ¿Cómo aseguran que sus casos son “sistemáticos” y no ad-hoc?
- ¿Qué escenario/riesgo de Semana 3 motivó (o se relaciona con) el objeto de prueba elegido?

---
