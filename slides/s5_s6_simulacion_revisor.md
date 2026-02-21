# Evaluación de Propuesta - Equipo 5
- **Propuesta evaluada:** B 
- **Empresa:** AtlasQA Partners  
- **Veredicto:** Aceptar con condiciones

> Regla: Todo punto debe estar **respaldado por la propuesta**.
> Si algo no está en la propuesta, debe ir en "Vacíos" o "Preguntas", no como afirmación.

---
## Slide 1 — Qué ofrece la propuesta (solo hechos del texto)
- Objetivo declarado:  Implementar en 6 semanas un programa de QA basado orientado a reducir riesgo de manera rápida y sostener calidad continua con automatización progresiva. El enfoque combina escenarios, priorización por riesgo, diseño sistemático de pruebas y quality gate en CI con una transición controlada de checks informativos a bloqueantes.  
  **Referencia:** Sección 1) Resumen Ejecutivo
- Alcance (2+ puntos)
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
   - **Evidencia en propuesta:** Sección 4 (Fases 1–4).
   - **Por qué es valioso (1 frase):** Reduce ambigüedad y permite implementar calidad de forma incremental y controlada en 6 semanas.
- F2: Priorización explícita por riesgo (impacto × probabilidad) con Top 3 y riesgo residual.
  - **Evidencia en propuesta:** Sección 4, Fase 2 (y coherente con Sección 9).
  - **Por qué es valioso:** Enfoca esfuerzo y presupuesto en los riesgos que más afectan al negocio.
- F3: Diseño técnico sólido de pruebas sistemáticas y oráculos mínimos/estrictos.
  - **Evidencia en propuesta:** Sección 3 y Sección 4, Fase 3.
  - **Por qué es valioso:** Mejora cobertura y consistencia de validación, reduciendo falsos positivos en operación.
- F4: Quality gate en CI con transición progresiva de checks informativos a bloqueantes.
  - **Evidencia en propuesta:** Sección 4, Fase 4 y Sección 5.
  - **Por qué es valioso:** Permite adoptar control de calidad sin frenar abruptamente la entrega continua.
- F5: Define gobernanza y registro de cambios del gate.
  - **Evidencia en propuesta:** Sección 7.
  - **Por qué es valioso:** Aporta trazabilidad y disciplina para evolucionar el gate con menor riesgo operativo.

---

## Slide 3 - Debilidades / riesgos (basadas en texto)
> 3-6 debilidades. Marcar severidad: **Crítica / Mayor / Menor**.
> Cada debilidad debe citar una sección de la propuesta.

- D1 (Severidad: Crítica): Política de reintento que puede enmascarar fallos reales.
  - **Texto/Sección relacionada:** Sección 6 (“considerar el segundo resultado como referencia”).
  - **Riesgo/impacto (1 frase):** Puede inflar artificialmente la tasa de éxito del gate y permitir liberar con defectos no resueltos.

- D2 (Severidad: Mayor): Falta de controles explícitos anti-gaming del gate.
  - **Texto/Sección relacionada:** Sección 5 y Sección 9 (definen checks y aceptación, pero no mínimos obligatorios de casos/anti-manipulación).
  - **Riesgo/impacto:** Se podría “mejorar” el indicador reduciendo cobertura o relajando validaciones sin mejorar calidad real.

- D3 (Severidad: Mayor): Probabilidad de riesgo basada en consenso cuando no hay datos históricos.
  - **Texto/Sección relacionada:** Sección 4, Fase 2.
  - **Riesgo/impacto:** La priorización Top 3 puede quedar sesgada y dirigir esfuerzos a riesgos menos relevantes.

- D4 (Severidad: Mayor): Dependencias operativas fuertes no mitigadas.
  - **Texto/Sección relacionada:** Sección 2 (entorno 24/7, disponibilidad de PO y Tech Lead).
  - **Riesgo/impacto:** Si alguna dependencia falla, se retrasa el cronograma y se degrada la calidad de decisiones/validaciones.

- D5 (Severidad: Mayor): Checks no funcionales quedan informativos sin criterio de salida claramente cuantificado.
  - **Texto/Sección relacionada:** Sección 4, Fase 4 y Sección 5.
  - **Riesgo/impacto:** Puede prolongarse indefinidamente una cobertura no bloqueante en aspectos críticos de confiabilidad operativa.

- D6 (Severidad: Menor): Alcance excluye seguridad avanzada y performance a escala producción.
  - **Texto/Sección relacionada:** Sección 3 (Excluye…).
  - **Riesgo/impacto:** Quedan riesgos técnicos relevantes fuera del programa inicial y deben planificarse en una fase posterior.

---

## Slide 4 - Cobertura explícita vs vacíos
### A) Lo que la propuesta sí define (3-5 puntos)
 - Programa por fases con actividades por semana (escenarios, riesgo, pack sistemático, gate). Ref: Sección 4
 - Alcance mínimo de entregables técnicos (≥8 escenarios, ≥12 casos, oráculos, gate y guía). Ref: Sección 3
 - Estructura del quality gate con checks críticos e informativos. Ref: Sección 5
 - Gobernanza y registro de cambios del gate. Ref: Sección 7
 - Criterios de aceptación generales del servicio. Ref: Sección 9
### B) Vacíos/ambigüedades que impiden evaluar bien (3-5 puntos)
 - Vacío 1: Criterios cuantitativos del gate incompletos.
   - **Qué falta exactamente:** Umbrales numéricos, mínimo de casos ejecutados, reglas de skip/xfail y condición de fallo por evidencia incompleta.
   - **Por qué importa (1 frase):** Sin reglas medibles, el gate puede aprobar con cobertura insuficiente.

 - Vacío 2: Política de intermitencia ambigua para aprobar pipelines.
   - **Qué falta exactamente:** Regla formal de rerun (cuándo aplica, cuántas veces, cuál resultado cuenta, cómo se audita).
   - **Por qué importa:** Puede normalizar falsos verdes y ocultar defectos reales.

- Vacío 3: Transición informativo→bloqueante sin criterio de salida definido.
   - **Qué falta exactamente:** Condiciones objetivas de baseline y fecha/umbral para endurecer checks no funcionales.
   - **Por qué importa:** Riesgo de dejar controles importantes en modo informativo indefinidamente.

- Vacío 4: Manejo de dependencias críticas sin plan de contingencia.
   - **Qué falta exactamente:** Plan alterno si no hay PO/Tech Lead o si el entorno 24/7 no está disponible.
   - **Por qué importa:** Afecta cronograma y validez de resultados.

### C) Preguntas de aclaración al proveedor (2-4 preguntas)
 - P1: ¿Qué umbrales exactos (pass rate, mínimo de casos, política de skips) definen PASS/FAIL de cada check crítico?
 - P2: ¿Cuál es la regla oficial de rerun y cómo quedará trazado en artifacts para evitar sesgo?
 - P3: ¿Qué condiciones numéricas habilitan pasar checks no funcionales de informativos a bloqueantes?
 - P4: ¿Qué controles anti-gaming proponen para evitar reducción de suite o relajación de oráculos sin aprobación?

---

## Slide 5 — Goodhart / Gaming (solo si se deriva del texto)
> Debe basarse en señales explícitas del documento (ej.: "mantener gate verde", "ajustar umbrales", "excepciones", "reruns", etc.)
- Señal en la propuesta (citar): “Ante fallos aislados, reejecutar una vez… considerar el segundo resultado como referencia”.
   **Referencia:** Sección 6
- Riesgo de gaming (1 frase): Reintentar hasta obtener verde puede inflar el éxito sin corregir la causa raíz.
- Consecuencia probable (1 frase): Liberaciones con defectos intermitentes y falsa percepción de estabilidad.
- Mitigación/condición (1 frase): Permitir rerun solo con trazabilidad obligatoria del primer fallo y regla fija de aprobación definida antes de ejecutar.
---

## Slide 6 - Condiciones para aceptar (solo si el veredicto lo requiere)
> 2-4 condiciones **verificables**. Deben apuntar a corregir debilidades o llenar vacíos.

- C1: Definir contrato de quality gate con umbrales y mínimos obligatorios por check.
  **Cómo se verifica:** Documento versionado + validación en CI (falla si casos ejecutados < mínimo o evidencia incompleta).  
  **Motivo (D# o Vacío #):** D2 / Vacío 1

- C2: Formalizar política anti-flakiness y rerun auditable.
  **Cómo se verifica:** Artifacts muestran intento 1 e intento 2, causa, ticket y regla de decisión aplicada.
  **Motivo:** D1 / Vacío 2

- C3: Definir criterio de salida para checks no funcionales (informativo→bloqueante).
  **Cómo se verifica:** Baseline con métricas y fecha objetivo aprobada en acta de gobernanza.
  **Motivo:** D5 / Vacío 3

- C4: Incluir plan de contingencia para dependencias operativas.
  **Cómo se verifica:** RACI + procedimiento alterno documentado para PO/Tech Lead/entorno no disponible.
  **Motivo:** D4 / Vacío 4

---

## Slide 7 - Veredicto (decisión final)
- Decisión: Aceptar con condiciones.
- Justificación (máximo 3 puntos, conectados a D# o Vacíos):
  1) La propuesta tiene base metodológica sólida y entregables útiles, pero faltan reglas cuantitativas del gate (Vacío 1).
  2) La política de rerun puede inducir falsos verdes si no se acota formalmente (D1 / Vacío 2).
  3) La transición de checks no funcionales requiere criterio objetivo para evitar estancamiento en modo informativo (D5 / Vacío 3).
