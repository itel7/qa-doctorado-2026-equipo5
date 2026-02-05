# Week 4 Report - Diseno sistematico y oraculos

## Endpoint elegido y motivacion
Se eligio `GET /api/articles` porque expone parametros opcionales (`limit`, `offset`, `tag`, `author`) que permiten aplicar diseno sistematico y observar variabilidad sin depender de autenticacion. Es un punto de lectura central y de alto uso, por lo que errores en paginacion o filtros impactan la experiencia y la confiabilidad de resultados.

## Tecnica de diseno
Se aplico EQ/BV (equivalencia + valores limite) sobre `limit` y `offset`, y clases adicionales para filtros (`tag`, `author`). Esta tecnica es adecuada porque el comportamiento esperado se divide en clases claras (validos/invalidos) y limites (0/1 para `limit`, 0 para `offset`, y tipos no enteros).

## Oraculos (minimos vs estrictos)
- **Minimos:**
  - OR-1 (HTTP 200 para solicitudes validas).
  - OR-2 (HTTP 422 para entradas invalidas en `limit`/`offset`).
- **Estricto:**
  - OR-3 (respuesta JSON con `articles` y `articlesCount`).
  - OR-4 (consistencia `articlesCount == len(articles)`).
  - OR-5 (respeto de `limit`).
  - OR-6 (consistencia del filtro `tag` cuando hay resultados).
  - OR-7 (consistencia del filtro `author` cuando hay resultados).

Los oraculos estrictos se aplican solo cuando el resultado permite verificar la propiedad (por ejemplo, si no hay articulos, OR-6/OR-7 son vacuamente verdaderos).

## Cobertura y limites
Cobertura afirmada:
- Paginacion por `limit` y `offset` (valores limite y clases invalidas).
- Estructura basica de la respuesta JSON y consistencia del conteo.
- Coherencia de filtros `tag` y `author` en resultados no vacios.

Cobertura NO afirmada:
- Ordenamiento y estabilidad de resultados.
- Correctitud semantica del contenido de cada articulo.
- Interacciones con autenticacion o filtros `favorited`.
- Rendimiento o tiempos de respuesta.

## Amenazas a la validez
- **Interna:** Los datos iniciales de la BD pueden cambiar; si el dataset se modifica, algunos resultados pueden variar y afectar comparabilidad entre ejecuciones.
- **Constructo:** Se valida principalmente estructura, conteo y propiedades simples; no se valida la semantica completa del contenido del articulo ni reglas de negocio ocultas.
- **Externa:** Los casos estan centrados en un endpoint y en un entorno local; la generalizacion a otros endpoints o a despliegues productivos es limitada.

## Evidencia
La evidencia reproducible se encuentra en `evidence/week4/` con salidas por caso, resumen y `RUNLOG.md`.
