# Casos de Prueba Sistemáticos - GET /api/articles/{slug}

## Endpoint bajo prueba
**GET /api/articles/{slug}**

## Técnica de diseño
**Equivalence Partitioning (EP) + Boundary Value Analysis (BVA)**

### Particiones identificadas:
1. **Slug válido existente** (clase válida)
2. **Slug válido no existente** (clase válida pero sin datos)
3. **Slug vacío** (clase inválida)
4. **Slug con caracteres especiales** (clase límite)
5. **Slug muy largo** (clase límite)
6. **Slug muy corto** (clase límite)

---

## Casos de Prueba

### TC-01: Slug válido existente
**Partición:** Slug válido existente
**Input:** `GET /api/articles/how-to-train-your-dragon`
**Precondición:** Artículo "how-to-train-your-dragon" existe en BD
**Expected (Oráculos):** OR-01, OR-02, OR-03, OR-06, OR-07
- HTTP 200
- JSON válido con estructura `{"article": {...}}`
- `article.slug` = "how-to-train-your-dragon"
- Tiempo < 500ms
**Evidencia esperada:** `evidence/week4/TC-01.json`

---

### TC-02: Slug válido no existente
**Partición:** Slug válido no existente
**Input:** `GET /api/articles/non-existent-article-slug`
**Precondición:** Artículo "non-existent-article-slug" NO existe
**Expected (Oráculos):** OR-01, OR-04, OR-06
- HTTP 404
- Body contiene mensaje de error
- Tiempo < 500ms
**Evidencia esperada:** `evidence/week4/TC-02.json`

---

### TC-03: Slug vacío
**Partición:** Slug inválido (vacío)
**Input:** `GET /api/articles/`
**Precondición:** Ninguna
**Expected (Oráculos):** OR-01, OR-05
- HTTP 422 o 404 (según implementación)
- Body contiene error de validación
**Evidencia esperada:** `evidence/week4/TC-03.json`

---

### TC-04: Slug con espacios
**Partición:** Slug inválido (caracteres no permitidos)
**Input:** `GET /api/articles/my article slug`
**Precondición:** Ninguna
**Expected (Oráculos):** OR-01, OR-05
- HTTP 422 o 404
- Error de validación
**Evidencia esperada:** `evidence/week4/TC-04.json`

---

### TC-05: Slug con caracteres especiales válidos
**Partición:** Slug límite (guiones múltiples)
**Input:** `GET /api/articles/my-article-with-many-dashes`
**Precondición:** Artículo existe
**Expected (Oráculos):** OR-01, OR-02, OR-03
- HTTP 200
- Artículo válido retornado
**Evidencia esperada:** `evidence/week4/TC-05.json`

---

### TC-06: Slug muy largo (límite superior)
**Partición:** Slug límite (longitud máxima)
**Input:** `GET /api/articles/{slug de 255 caracteres}`
**Precondición:** Ninguna
**Expected (Oráculos):** OR-01, OR-05 o OR-04
- HTTP 422 o 404
- Error de validación o no encontrado
**Evidencia esperada:** `evidence/week4/TC-06.json`

---

### TC-07: Slug muy corto (1 carácter)
**Partición:** Slug límite (longitud mínima)
**Input:** `GET /api/articles/a`
**Precondición:** Artículo "a" no existe
**Expected (Oráculos):** OR-01, OR-04
- HTTP 404
- Artículo no encontrado
**Evidencia esperada:** `evidence/week4/TC-07.json`

---

### TC-08: Slug con números válidos
**Partición:** Slug válido (números)
**Input:** `GET /api/articles/article-123-test`
**Precondición:** Artículo existe
**Expected (Oráculos):** OR-01, OR-02, OR-03
- HTTP 200
- Artículo válido
**Evidencia esperada:** `evidence/week4/TC-08.json`

---

### TC-09: Slug con caracteres Unicode
**Partición:** Slug inválido (caracteres especiales)
**Input:** `GET /api/articles/artículo-español`
**Precondición:** Ninguna
**Expected (Oráculos):** OR-01, OR-05 o OR-04
- HTTP 422 o 404
- Error de validación
**Evidencia esperada:** `evidence/week4/TC-09.json`

---

### TC-10: Slug que comienza con guión
**Partición:** Slug límite (formato)
**Input:** `GET /api/articles/-invalid-start`
**Precondición:** Ninguna
**Expected (Oráculos):** OR-01, OR-05 o OR-04
- HTTP 422 o 404
- Error
**Evidencia esperada:** `evidence/week4/TC-10.json`

---

### TC-11: Slug que termina con guión
**Partición:** Slug límite (formato)
**Input:** `GET /api/articles/invalid-end-`
**Precondición:** Ninguna
**Expected (Oráculos):** OR-01, OR-05 o OR-04
- HTTP 422 o 404
- Error
**Evidencia esperada:** `evidence/week4/TC-11.json`

---

### TC-12: Slug con mayúsculas
**Partición:** Slug límite (case sensitivity)
**Input:** `GET /api/articles/My-Article-Title`
**Precondición:** Artículo "my-article-title" existe (lowercase)
**Expected (Oráculos):** OR-01, OR-04 (si es case-sensitive)
- HTTP 404 si es case-sensitive
- HTTP 200 si normaliza a lowercase
**Evidencia esperada:** `evidence/week4/TC-12.json`

---

## Cobertura

### Particiones cubiertas:
- ✅ Slug válido existente (TC-01, TC-05, TC-08)
- ✅ Slug válido no existente (TC-02, TC-07)
- ✅ Slug vacío (TC-03)
- ✅ Slug con caracteres inválidos (TC-04, TC-09)
- ✅ Slug en límites de longitud (TC-06, TC-07)
- ✅ Slug con formato límite (TC-10, TC-11, TC-12)

### Oráculos aplicados:
- OR-01: 12/12 casos
- OR-02: 4/12 casos (solo 200)
- OR-03: 3/12 casos (solo existentes)
- OR-04: 6/12 casos (no existentes)
- OR-05: 6/12 casos (inválidos)
- OR-06: 12/12 casos
- OR-07: 1/12 casos (TC-01)

### Cobertura NO incluida:
- Autenticación (requiere token)
- Concurrencia
- Estados transitorios
- Carga extrema
