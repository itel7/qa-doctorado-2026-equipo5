# Oracle Rules - Week 4

## Endpoint bajo prueba
`GET /api/articles`

## Reglas de oraculo (pass/fail)

### Minimas (oraculo debil pero seguro)
- **OR-1 (HTTP 200 valido):** Si la solicitud es valida, el servidor responde `200`.
  - Pass: HTTP 200.
  - Fail: cualquier otro codigo.
- **OR-2 (HTTP 422 invalido):** Si `limit` o `offset` son invalidos (no entero o fuera de rango), el servidor responde `422`.
  - Pass: HTTP 422.
  - Fail: cualquier otro codigo.

### Estrictas (oraculo fuerte cuando aplica)
- **OR-3 (Formato JSON base):** Respuesta contiene `articles` (array) y `articlesCount` (entero >= 0).
  - Pass: ambos campos existen y tienen tipo correcto.
  - Fail: falta algun campo o tipo incorrecto.
- **OR-4 (Conteo consistente):** `articlesCount == len(articles)`.
  - Pass: el conteo coincide.
  - Fail: diferencia entre conteo y longitud real.
- **OR-5 (Limite respetado):** Si se envia `limit`, entonces `len(articles) <= limit`.
  - Pass: longitud no supera el limite.
  - Fail: longitud mayor al limite.
- **OR-6 (Filtro tag consistente):** Si se envia `tag` y hay articulos, cada articulo incluye ese tag en `tagList`.
  - Pass: todos los articulos contienen el tag.
  - Fail: algun articulo no contiene el tag.
- **OR-7 (Filtro author consistente):** Si se envia `author` y hay articulos, cada articulo tiene `author.username == author`.
  - Pass: todos los articulos del resultado coinciden.
  - Fail: algun articulo no coincide.
