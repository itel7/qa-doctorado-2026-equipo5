# Evaluación de Propuesta - Equipo 5
**Propuesta evaluada:** B Empresa: AtlasQA Partners  
**Veredicto:** Aceptar con condiciones

> Regla: Todo punto debe estar **respaldado por la propuesta**.
> Si algo no está en la propuesta, debe ir en "Vacíos" o "Preguntas", no como afirmación.

---

## Slide 1 — Qué ofrece la propuesta (solo hechos del texto)
- Objetivo declarado:  Implementar en 6 semanas un programa de QA basado en riesgos orientado a reducir riesgo de manera rápida y sostener calidad continua con automatización progresiva. El enfoque combina escenarios, priorización por riesgo, diseño sistemático de pruebas y quality gate en CI con una transición controlada de checks informativos a bloqueantes.  
  **Referencia:** Sección 1) Resumen Ejecutivo
- Alcance / exclusiones (2+ puntos)
  - **Incluye escenarios (≥8)**, Sección 3) Alcance
  - **oráculos mínimos/estrictos**, Sección 3) Alcance
  - **casos sistemáticos (≥12)**, Sección 3) Alcance
- exclusiones
   - **pruebas avanzadas de seguridad**, Sección 3) Alcance
   - **performance a escala producción**, Sección 3) Alcance
     
- Entregables principales (3+ puntos):  
  - **Los escenarios (≥8)** → Sección 3 (Alcance) y Sección 4, Fase 1.
  - **Matriz impacto×probabilidad + Top 3** → Sección 4, Fase 2.
  - **Estrategia por riesgo + riesgo residual** → Sección 4, Fase 2 y Sección 9.
  - **Pack sistemático (≥12)** → Sección 3 y Sección 4, Fase 3.
  - **Oráculos mínimos/estrictos** → Sección 3 y Sección 4, Fase 3.
  - **Quality gate CI operativo** → Sección 4, Fase 4 y Sección 5.
  - **Artifacts/evidencia de CI** → Sección 3, Sección 4 (Fases 1, 3, 4) y Sección 9.
  - **Guía operativa + gobernanza + cambios del gate** → Sección 3, Sección 6 y Sección 7.
 
 ---

## Slide 2 - Fortalezas (basadas en texto)
> 3-5 fortalezas. Cada una debe citar una sección.
 - F1: Enfoque estructurado y por fases (de definición a operación en CI).
   **Evidencia en propuesta:** Sección 4 (Fases 1–4).
   **Por qué es valioso (1 frase):** Reduce ambigüedad y permite implementar calidad de forma incremental y controlada en 6 semanas.
- F2: Priorización explícita por riesgo (impacto × probabilidad) con Top 3 y riesgo residual.
  **Evidencia en propuesta:** Sección 4, Fase 2 (y coherente con Sección 9).
  **Por qué es valioso:** Enfoca esfuerzo y presupuesto en los riesgos que más afectan al negocio.
- F3: Diseño técnico sólido de pruebas sistemáticas y oráculos mínimos/estrictos.
  **Evidencia en propuesta:** Sección 3 y Sección 4, Fase 3.
  **Por qué es valioso:** Mejora cobertura y consistencia de validación, reduciendo falsos positivos en operación.
- F4: Quality gate en CI con transición progresiva de checks informativos a bloqueantes.
  **Evidencia en propuesta:** Sección 4, Fase 4 y Sección 5.
  **Por qué es valioso:** Permite adoptar control de calidad sin frenar abruptamente la entrega continua.
- F5: Define gobernanza y registro de cambios del gate.
  **Evidencia en propuesta:** Sección 7.
  **Por qué es valioso:** Aporta trazabilidad y disciplina para evolucionar el gate con menor riesgo operativo.

---

## Slide 3 - Debilidades / riesgos (basadas en texto)
> 3-6 debilidades. Marcar severidad: **Crítica / Mayor / Menor**.
> Cada debilidad debe citar una sección de la propuesta.

- D1 (Severidad: Crítica): Política de reintento que puede enmascarar fallos reales.
  **Texto/Sección relacionada:** Sección 6 (“considerar el segundo resultado como referencia”).
  **Riesgo/impacto (1 frase):** Puede inflar artificialmente la tasa de éxito del gate y permitir liberar con defectos no resueltos.

- D2 (Severidad: Mayor): Falta de controles explícitos anti-gaming del gate.
  **Texto/Sección relacionada:** Sección 5 y Sección 9 (definen checks y aceptación, pero no mínimos obligatorios de casos/anti-manipulación).
  **Riesgo/impacto:** Se podría “mejorar” el indicador reduciendo cobertura o relajando validaciones sin mejorar calidad real.

- D3 (Severidad: Mayor): Probabilidad de riesgo basada en consenso cuando no hay datos históricos.
  **Texto/Sección relacionada:** Sección 4, Fase 2.
  **Riesgo/impacto:** La priorización Top 3 puede quedar sesgada y dirigir esfuerzos a riesgos menos relevantes.

- D4 (Severidad: Mayor): Dependencias operativas fuertes no mitigadas.
  **Texto/Sección relacionada:** Sección 2 (entorno 24/7, disponibilidad de PO y Tech Lead).
  **Riesgo/impacto:** Si alguna dependencia falla, se retrasa el cronograma y se degrada la calidad de decisiones/validaciones.

- D5 (Severidad: Mayor): Checks no funcionales quedan informativos sin criterio de salida claramente cuantificado.
  **Texto/Sección relacionada:** Sección 4, Fase 4 y Sección 5.
  **Riesgo/impacto:** Puede prolongarse indefinidamente una cobertura no bloqueante en aspectos críticos de confiabilidad operativa.

- D6 (Severidad: Menor): Alcance excluye seguridad avanzada y performance a escala producción.
  **Texto/Sección relacionada:** Sección 3 (Excluye…).
  **Riesgo/impacto:** Quedan riesgos técnicos relevantes fuera del programa inicial y deben planificarse en una fase posterior.

---

## Slide 4 - Cobertura explícita vs vacíos
### A) Lo que la propuesta sí define (3-5 puntos)
- ___ **Ref:** Sección ___
- ___ **Ref:** Sección ___
- ___ **Ref:** Sección ___

### B) Vacíos/ambigüedades que impiden evaluar bien (3-5 puntos)
- Vacío 1: ___  
  **Qué falta exactamente:** ___  
  **Por qué importa (1 frase):** ___
- Vacío 2: ___  
  **Qué falta exactamente:** ___  
  **Por qué importa:** ___
- Vacío 3: ___  
  **Qué falta exactamente:** ___  
  **Por qué importa:** ___

### C) Preguntas de aclaración al proveedor (2-4 preguntas)
- P1: ___
- P2: ___
- (Opcional) P3/P4: ___

---

## Slide 5 — Goodhart / Gaming (solo si se deriva del texto)
> Debe basarse en señales explícitas del documento (ej.: "mantener gate verde", "ajustar umbrales", "excepciones", "reruns", etc.)

- Señal en la propuesta (citar): ___  
  **Referencia:** Sección ___
- Riesgo de gaming (1 frase): ___
- Consecuencia probable (1 frase): ___
- Mitigación/condición (1 frase): ___

---

## Slide 6 - Condiciones para aceptar (solo si el veredicto lo requiere)
> 2-4 condiciones **verificables**. Deben apuntar a corregir debilidades o llenar vacíos.

- C1: ___  
  **Cómo se verifica:** ___  
  **Motivo (D# o Vacío #):** ___
- C2: ___  
  **Cómo se verifica:** ___  
  **Motivo:** ___
- (Opcional) C3/C4: ___ 

---

## Slide 7 - Veredicto (decisión final)
- Decisión: ___
- Justificación (máximo 3 puntos, conectados a D# o Vacíos):
  1) ___ (D# / Vacío #)
  2) ___ (D# / Vacío #)
  3) ___ (D# / Vacío #)
