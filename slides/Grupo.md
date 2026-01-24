# Plantilla de Presentación — Semanas 1 y 2 (Máx. 5 slides)

> **Regla:** máximo 5 “slides” (secciones).  
> **Tiempo total presentación:** 8-10 minutos.  

---

## Slide 1 — Semana 1 (Pregunta 1 + Respuesta 1)
**Pregunta 1:** ¿Qué tipo de evidencia de pruebas reduce incertidumbre sobre calidad sin confundir “testing” con “quality assurance”?

**Respuesta 1:**
Para disminuir la incertidumbre asociada a la calidad del producto, es necesario distinguir entre el "testing" como mecanismo de verificación del software y el "quality assurance" como disciplina orientada a la gestión y mejora de los procesos. En este contexto, la evidencia más relevante se obtiene a partir de métricas como la Eficacia de la Detección de Defectos (Defect Detection Effectiveness, DDE) y la Densidad de Defectos, las cuales permiten evaluar de manera objetiva el desempeño del proceso de calidad.

Mientras que el testing aporta información sobre el cumplimiento funcional y la validación de los requisitos del sistema, estas métricas cuantitativas contribuyen a reducir la incertidumbre al reflejar la capacidad del proceso para identificar y eliminar defectos antes de que el producto sea liberado a producción. De este modo, se proporciona evidencia empírica sobre la solidez del sistema de gestión de la calidad.

Asimismo, las mediciones enfocadas en la calidad del producto, como la densidad de defectos y la efectividad en la detección de fallos, constituyen un soporte objetivo para determinar la preparación del software para su liberación y para analizar la eficacia de las prácticas de aseguramiento de la calidad implementadas.

International Software Testing Qualifications Board. (2023). Certified Tester Foundation Level (CTFL) Syllabus Version 4.0. https://www.istqb.org/certifications/certified-tester-foundation-level

---

## Slide 2 — Semana 2 (Pregunta 2 + Respuesta 2)
**Pregunta 2:** ¿Cómo convertir “calidad” en afirmaciones falsables y medibles?

**Respuesta 2:**
-Para convertir la "calidad" en afirmaciones falsables (es decir, que pueden ser puestas a prueba y desmentidas con evidencia) y medibles, es necesario aplicar el concepto de Factores y Métricas de Calidad mediante marcos de trabajo como el estándar ISO/IEC 25010 o el enfoque GQM (Goal-Question-Metric).

1. El proceso de Operacionalización
La calidad no se mide directamente; se mide a través de sus atributos. Para hacer una afirmación falsable, debemos transformar un deseo ambiguo en un Requerimiento No Funcional (RNF) cuantitativo.

Afirmación No Falsable (Ambigua): "El sistema debe ser rápido". (No se puede probar su falsedad porque "rápido" es subjetivo).

Afirmación Falsable (Medible): "El tiempo de respuesta del endpoint 'Login' debe ser menor a 200ms bajo una carga de 500 usuarios concurrentes". (Es falsable: si el cronómetro marca 201ms, la afirmación de calidad es falsa).

2. El método GQM (Goal-Question-Metric)
Propuesto por Victor Basili, este método es la herramienta ideal para esta conversión:

Meta (Goal): Mejorar la eficiencia del sistema.

Pregunta (Question): ¿Cuánto tarda el sistema en procesar una transacción?

Métrica (Metric): Tiempo promedio de CPU por transacción.

3. Uso de Atributos de Calidad (SQUA)
Siguiendo a Sommerville (2016), la calidad se divide en sub-características medibles. Por ejemplo, la usabilidad se vuelve falsable midiendo la "tasa de éxito en la primera tarea" o el "tiempo de aprendizaje" para un usuario nuevo. Si el usuario tarda más de lo definido en el estándar, la meta de calidad no se ha cumplido.

En resumen: La calidad se vuelve medible cuando se define mediante umbrales numéricos y condiciones de entorno específicas. Sin un número y una unidad de medida, no hay calidad evaluable, solo opiniones.

Referencias Bibliográficas
Basili, V. R., Caldiera, G., & Rombach, H. D. (1994). The Goal Question Metric Approach. Encyclopedia of Software Engineering, 528-532.

ISO/IEC 25010:2011. (2011). Systems and software engineering — Systems and software Quality Requirements and Evaluation (SQuaRE) — System and software quality models. International Organization for Standardization.

Pressman, R. S., & Maxim, B. R. (2020). Software Engineering: A Practitioner's Approach (9na ed.). McGraw-Hill Education.

Sommerville, I. (2016). Software Engineering (10ma ed.). Pearson.

**Evidencias planeadas (cada uno con oráculo + archivo):**
-  create_article → Oráculo: ___ → Evidencia: `evidence/week2/q1_create_article_20260124_123835.log`
- duplicate_validation → Oráculo: ___ → Evidencia: `evidence/week2/q2_duplicate_validation_20260124_123841.log`
- modify_article → Oráculo: ___ → Evidencia: `evidence/week2/q3_modify_article_20260124_123850.log`
- unauthorized_modify → Oráculo: ___ → Evidencia: `evidence/week2/q4_unauthorized_modify_20260124_123903.log`


**Límite (1 línea):**  
- ___ (qué NO demuestra esta evidencia) TBD


**Escenarios S2 (elige 2 “estrella”):**
- Escenario A: E: ___ | Entorno: ___ | R: ___ | Medida: ___ | Evidencia: `evidence/week2/...` | Falsación: ___  
- Escenario B: E: ___ | Entorno: ___ | R: ___ | Medida: ___ | Evidencia: `evidence/week2/...` | Falsación: ___  

**Mini-tabla (obligatoria):**
| Claim | Escenario | Métrica | Evidencia (archivo) | Oráculo (pass/fail) |
|---|---|---|---|---|
| ___ | ___ | ___ | ___ | ___ |
| ___ | ___ | ___ | ___ | ___ |

---

## Slide 3 — Método formalizado (¿cómo trabajamos para definir escenarios?.)
**Proceso aplicado:**
1) . 
2) . 
3) . 
4) . 

**Fuentes para definición de método:**
- ...
- ...


---

## Slide 4 — Amenazas a la validez 
**Amenazas a la validez (mínimo 3) + mitigación futura:**
- Interna: ___ → Mitigación: ___  
- Constructo: ___ → Mitigación: ___  
- Externa: ___ → Mitigación: ___  

*Revisar artículo: "Amenazas a la validez"*


---

## Slide 5 — Cierre (2 conclusiones)
- **Evidencia más fuerte:** ___ (por qué reduce incertidumbre)  
- **Límite más crítico:** ___ (por qué impide generalizar)  
- **Siguiente mejora concreta:** ___ (sin implementar hoy)

---