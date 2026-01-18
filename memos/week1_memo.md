# Memo de Progreso - Semana 1

**Fecha**: 17/01/2026  \
**Equipo**: Equipo X  \
**Semana**: 1 de 8

## Objetivos de la semana
- Seleccionar y documentar el SUT.
- Preparar scripts básicos para levantar, verificar y detener el SUT.
- Publicar instrucciones mínimas de uso en el README y facilitar su ejecución con Makefile.
- Registrar acuerdos de colaboración del equipo.

## Logros
- SUT seleccionado: Swagger Petstore (Petstore v3) y documentado en SUT_SELECTION.md.
- Scripts de entorno creados en setup/: run_sut.sh, healthcheck_sut.sh y stop_sut.sh para gestionar el contenedor Docker y validar su disponibilidad vía openapi.json.
- Makefile añadido para orquestar setup, arranque, detención y verificación del SUT.
- README actualizado con estructura del repositorio y pasos básicos para ejecutar el proyecto.
- Acuerdos iniciales del equipo registrados en AGREEMENTS.md.

## Evidencia principal
- Selección y motivación del SUT: SUT_SELECTION.md.
- Ejecución y control del SUT: setup/run_sut.sh, setup/healthcheck_sut.sh, setup/stop_sut.sh.
- Operaciones unificadas: Makefile.
- Instrucciones de uso y estructura: README.md.
- Normas de colaboración: AGREEMENTS.md.

## Retos y notas
- Dependencia en Docker: es requisito previo para ejecutar los scripts; se deja indicado en README.
- Permisos de ejecución: se usan chmod en la tarea setup del Makefile para evitar fallos al invocar los scripts.
- El contenedor expone OpenAPI en /api/v3/openapi.json, usado como punto de salud en healthcheck.

## Lecciones aprendidas
- Estandarizar comandos en Makefile agiliza la adopción del entorno y reduce errores manuales.
- Verificar salud mediante el contrato OpenAPI es un chequeo rápido y estable para detectar caídas tempranas.
- Mantener la documentación breve y localizada (README + SUT_SELECTION) ayuda a nuevos integrantes a involucraser rápidamente en el proyecto.

## Próximos pasos (Semana 2) - (Potenciales pasos, a ser discutidos con el equipo)
- Elaborar casos de prueba detallados y reglas de oráculo (design/test_cases.md y design/oracle_rules.md).
- Extender scripts de pruebas (smoke y systematic_cases) para cubrir endpoints clave del Petstore.
- Definir métricas básicas de ejecución (latencia, disponibilidad) y registrar evidencias en evidence/week2/.
- Afinar estrategia de riesgos y pruebas en risk/test_strategy.md a la luz del SUT seleccionado.

---

**Preparado por**: Equipo X  \
**Próxima revisión**: Semana 2
