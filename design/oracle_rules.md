# Reglas de Oráculo - GET /api/articles/{slug}

## Endpoint bajo prueba
**GET /api/articles/{slug}**
- Propósito: Obtener un artículo específico por su slug (identificador único)
- Parámetros: `slug` (string, path parameter)

---

## Reglas de Oráculo

### OR-01: Código HTTP válido
**Tipo:** Débil (mínimo)
**Regla:** La respuesta debe devolver un código HTTP válido (200, 404, 422, 500)
**Criterio PASS:** HTTP status code ∈ {200, 404, 422, 500}
**Criterio FAIL:** Timeout, conexión rechazada, o código fuera del conjunto esperado

---

### OR-02: Estructura JSON válida
**Tipo:** Fuerte
**Regla:** Si la respuesta es exitosa (200), debe devolver JSON bien formado con estructura `{"article": {...}}`
**Criterio PASS:** 
- HTTP 200 
- Body es JSON válido
- Tiene clave "article"
**Criterio FAIL:** JSON malformado, falta clave "article", o estructura incorrecta

---

### OR-03: Artículo existente devuelve 200
**Tipo:** Fuerte
**Regla:** Si el slug existe en la BD, debe devolver HTTP 200 con el artículo
**Criterio PASS:**
- HTTP 200
- `article.slug` coincide con el slug solicitado
- Campos obligatorios presentes: `title`, `description`, `body`, `author`
**Criterio FAIL:** HTTP != 200 para slug existente, o campos obligatorios faltantes

---

### OR-04: Artículo inexistente devuelve 404
**Tipo:** Fuerte
**Regla:** Si el slug no existe, debe devolver HTTP 404
**Criterio PASS:**
- HTTP 404
- Body contiene mensaje de error
**Criterio FAIL:** HTTP 200 para slug inexistente, o sin mensaje de error

---

### OR-05: Slug inválido devuelve 422
**Tipo:** Fuerte
**Regla:** Si el slug tiene formato inválido (caracteres no permitidos, muy largo), debe devolver HTTP 422
**Criterio PASS:**
- HTTP 422
- Body contiene detalles del error de validación
**Criterio FAIL:** HTTP 200 para slug inválido, o sin detalles de error

---

### OR-06: Tiempo de respuesta aceptable
**Tipo:** Débil (performance)
**Regla:** La respuesta debe completarse en < 500ms (percentil 95)
**Criterio PASS:** Tiempo de respuesta < 500ms en p95
**Criterio FAIL:** Tiempo de respuesta >= 500ms consistentemente

---

### OR-07: Consistencia de datos
**Tipo:** Fuerte
**Regla:** Si un artículo existe, sus datos deben ser consistentes entre llamadas consecutivas (dentro de la misma sesión)
**Criterio PASS:** 
- Dos GET consecutivos devuelven el mismo `title`, `body`, `createdAt`
**Criterio FAIL:** Datos inconsistentes entre llamadas sin modificación

---

## Matriz de Aplicación

| Caso de Prueba | OR-01 | OR-02 | OR-03 | OR-04 | OR-05 | OR-06 | OR-07 |
|----------------|-------|-------|-------|-------|-------|-------|-------|
| TC-01 (slug válido existente) | ✓ | ✓ | ✓ | - | - | ✓ | ✓ |
| TC-02 (slug inexistente) | ✓ | - | - | ✓ | - | ✓ | - |
| TC-03 (slug vacío) | ✓ | - | - | - | ✓ | ✓ | - |
| TC-04 (slug con caracteres especiales) | ✓ | ✓/- | ✓/- | ✓/- | ✓ | ✓ | - |
| TC-05 (slug muy largo) | ✓ | - | - | - | ✓ | ✓ | - |

**Leyenda:** ✓ = aplica, - = no aplica, ✓/- = depende del caso
