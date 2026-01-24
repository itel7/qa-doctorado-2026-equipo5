# Glosario de términos para discusión: Testing y QA (base ISTQB)

Este documento resume términos mínimos para discutir evidencia de pruebas, como tambien evitar confusiones entre **testing** y **quality assurance (QA)**.

---

## A) Glosario (términos recuperados desde ISTQB)

| Término (ISTQB) | Definición breve |
|---|---|
| **Testing** | Proceso para evaluar un componente o sistema (y productos relacionados) con el fin de obtener evidencia sobre su calidad, verificar requisitos y detectar defectos. |
| **Quality assurance (QA)** | Actividades enfocadas en dar confianza de que se cumplirán los requisitos de calidad, con énfasis preventivo/orientado al proceso. |
| **Error** | Acción humana que produce un resultado incorrecto o que puede introducir un defecto. |
| **Defect** | Imperfección/deficiencia en un producto de trabajo que no cumple requisitos o especificaciones y puede causar fallos. |
| **Failure** | Desviación observada del comportamiento/servicio esperado durante la ejecución. |
| **Test objective** | Razón o propósito de probar; lo que se pretende demostrar o lograr con una prueba. |
| **Test case** | Conjunto de condiciones, entradas/acciones (si aplica) y resultados esperados diseñado para evaluar una condición u objetivo de prueba. |
| **Test oracle** | Fuente o criterio que permite determinar el resultado esperado y decidir “pasó/falló” comparándolo con lo observado. |
| **Pass/fail criteria** | Criterios que definen cuándo un ítem de prueba debe considerarse “pasó” o “falló”. |
| **Regression testing** | Pruebas para detectar efectos no deseados de cambios y confirmar que lo que funcionaba antes sigue funcionando. |
| **Test level** | Agrupación de actividades de prueba por el alcance o “dónde” se prueba (p.ej., unidad, integración, sistema, aceptación). |
| **Test type** | Categoría de pruebas según el objetivo/atributo evaluado (p.ej., funcional, no funcional), aplicable en uno o más niveles. |
| **Verification** | Confirmación, mediante evidencia objetiva, de que se han cumplido requisitos especificados. |
| **Validation** | Confirmación, mediante evidencia objetiva, de que se han cumplido requisitos para un uso previsto o necesidad del usuario. |

---

## B) Otros términos / ideas complementarias (no-ISTQB)

Estos conceptos son útiles para evaluar “calidad de pruebas”, aunque no forman parte del glosario ISTQB que estamos usando como base.

- **Evidencia defendible:** evidencia que puede justificarse con un objetivo claro, un criterio verificable y resultados observables/repetibles.
- **Señal/ruido (signal-to-noise):** proporción entre fallos que indican problemas reales vs fallos espurios o irrelevantes.
- **Determinismo:** la prueba produce el mismo resultado dadas las mismas condiciones (evita “flakiness”).
- **Aislamiento:** la prueba minimiza dependencias externas (red, reloj real, datos cambiantes) para reducir variabilidad.
- **Pruebas frágiles (brittle):** fallan por cambios irrelevantes o por detalles de implementación, generando ruido y alto costo de mantenimiento.
- **Claridad (Given/When/Then o Arrange/Act/Assert):** estructura que hace explícito qué se prepara, qué se ejecuta y qué se verifica.
- **Aserciones útiles:** verificaciones que apuntan al comportamiento importante y facilitan diagnóstico (mensajes claros, condiciones precisas).
