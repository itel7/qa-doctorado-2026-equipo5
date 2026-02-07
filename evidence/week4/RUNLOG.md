# RUNLOG - Semana 4: Casos Sistemáticos

## Ejecución: 2026-02-04 22:36:22
## Endpoint: GET /api/articles/{slug}
## Técnica: Equivalence Partitioning + Boundary Value Analysis
## Oráculos aplicados: OR-01 a OR-07

---

### TC-01: Slug válido existente
**Input:** `GET /api/articles/how-to-train-your-dragon`
**Oráculos:** OR-01,OR-02,OR-03,OR-06,OR-07
**Resultado:** FAIL
- HTTP Code: 404 (esperado: 200)
- Tiempo: 0ms
- Evidencia: `evidence/week4/TC-01.json`

---

### TC-02: Slug válido no existente
**Input:** `GET /api/articles/non-existent-article-slug-12345`
**Oráculos:** OR-01,OR-04,OR-06
**Resultado:** PASS
- HTTP Code: 404 (esperado: 404)
- Tiempo: 0ms
- Evidencia: `evidence/week4/TC-02.json`

---

### TC-03: Slug vacío
**Input:** `GET /api/articles/`
**Oráculos:** OR-01,OR-05
**Resultado:** FAIL
- HTTP Code: 307 (esperado: 422|404)
- Tiempo: 0ms
- Evidencia: `evidence/week4/TC-03.json`

---

### TC-04: Slug con espacios
**Input:** `GET /api/articles/my article slug`
**Oráculos:** OR-01,OR-05
**Resultado:** FAIL
- HTTP Code: 000 (esperado: 422|404)
- Tiempo: 1ms
- Evidencia: `evidence/week4/TC-04.json`

---

### TC-05: Slug con guiones múltiples
**Input:** `GET /api/articles/my-article-with-many-dashes`
**Oráculos:** OR-01,OR-02,OR-03
**Resultado:** FAIL
- HTTP Code: 404 (esperado: 200|404)
- Tiempo: 0ms
- Evidencia: `evidence/week4/TC-05.json`

---

### TC-06: Slug muy largo (255 chars)
**Input:** `GET /api/articles/aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa`
**Oráculos:** OR-01,OR-05
**Resultado:** PASS
- HTTP Code: 404 (esperado: 422|404)
- Tiempo: 0ms
- Evidencia: `evidence/week4/TC-06.json`

---

