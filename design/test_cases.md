# Systematic Test Cases - Week 4

## Tecnica de diseno
EQ/BV (Equivalencia + Valores Limite) sobre `limit` y `offset`, con clases adicionales para filtros opcionales (`tag`, `author`).

## Casos de prueba (>= 12)

Formato: `TC-ID | Input | Expected (oraculo) | Evidencia esperada`

| TC-ID | Input | Expected (oraculo) | Evidencia esperada |
|---|---|---|---|
| TC-01 | `GET /api/articles` | OR-1, OR-3, OR-4, OR-5 | JSON con `articles` y `articlesCount`; longitud <= 20 |
| TC-02 | `GET /api/articles?limit=1` | OR-1, OR-3, OR-4, OR-5 | longitud <= 1 |
| TC-03 | `GET /api/articles?limit=20` | OR-1, OR-3, OR-4, OR-5 | longitud <= 20 |
| TC-04 | `GET /api/articles?limit=21` | OR-1, OR-3, OR-4, OR-5 | longitud <= 21 |
| TC-05 | `GET /api/articles?limit=0` | OR-2 | error 422 |
| TC-06 | `GET /api/articles?limit=-1` | OR-2 | error 422 |
| TC-07 | `GET /api/articles?limit=abc` | OR-2 | error 422 |
| TC-08 | `GET /api/articles?offset=0` | OR-1, OR-3, OR-4 | JSON base valido |
| TC-09 | `GET /api/articles?offset=1` | OR-1, OR-3, OR-4 | JSON base valido |
| TC-10 | `GET /api/articles?offset=-1` | OR-2 | error 422 |
| TC-11 | `GET /api/articles?offset=abc` | OR-2 | error 422 |
| TC-12 | `GET /api/articles?tag=qa-tag` | OR-1, OR-3, OR-4, OR-6 | si hay resultados, todos incluyen `qa-tag` |
| TC-13 | `GET /api/articles?author=qa-user` | OR-1, OR-3, OR-4, OR-7 | si hay resultados, `author.username == qa-user` |
