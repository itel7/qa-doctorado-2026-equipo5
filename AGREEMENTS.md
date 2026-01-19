# Team Agreements - QA Doctorado 2026 Equipo X

## 1. Objetivo del Documento

Este documento establece los acuerdos fundamentales del equipo para el desarrollo y mantenimiento del repositorio del proyecto QA Doctorado 2026. Todos los miembros del equipo deben comprometerse con estos acuerdos.

---

## 2. Roles y Responsabilidades

### 2.1 Project Lead / Coordinador
- Responsable de deadlines y entregas
- Facilita reuniones semanales
- Resuelve conflictos de decisión

### 2.2 Quality Assurance Engineers
- Diseño e implementación de test cases
- Ejecución de pruebas
- Reporte de defectos

### 2.3 DevOps / Infrastructure
- Mantenimiento del SUT
- Configuración de CI/CD
- Monitoreo de salud del sistema

### 2.4 Documentación
- Redacción de documentos requeridos
- Mantenimiento de README y wikis
- Generación de reportes

### 2.5 Investigación
- Análisis de técnicas de testing
- Revisión de literatura
- Publicación de findings

---

## 3. Normas del Repositorio

### 3.1 Estructura de Branches

```
main          - Rama de producción (solo PRs aprobados)
dev           - Rama de desarrollo (base para features)
feature/*     - Nuevas características
bugfix/*      - Corrección de bugs
docs/*        - Cambios de documentación
test/*        - Cambios en tests
```

### 3.2 Política de Commits

**Formato de Mensaje**:
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types permitidos**:
- `feat`: Nueva funcionalidad
- `fix`: Corrección de bug
- `test`: Cambios en tests
- `docs`: Documentación
- `style`: Cambios de formato
- `refactor`: Refactorización
- `ci`: Cambios en CI/CD
- `chore`: Tareas mantenimiento

**Ejemplo**:
```
test(articles): add validation tests for article creation

- Add test for missing required fields
- Add test for slug uniqueness validation
- Add test for character limits

Fixes #42
```

### 3.3 Policy de Pull Requests

**Requisitos Antes de Hacer PR**:
- ✅ Tests locales pasan (`make test`)
- ✅ Linting pasa (`make lint`)
- ✅ Documentación actualizada si aplica
- ✅ Branch actualizada con `main`

**Requisitos de Aprobación**:
- ✅ Mínimo 2 aprobaciones
- ✅ Todas las pruebas automáticas pasan
- ✅ Sin conflictos de merge
- ✅ Al menos 1 aprobación de QA

**Template de PR**:
```markdown
## Descripción
[Descripción clara de los cambios]

## Tipo de Cambio
- [ ] Test
- [ ] Feature
- [ ] Bug Fix
- [ ] Documentation

## Testing Realizado
- [ ] Unit Tests
- [ ] Integration Tests
- [ ] Manual Testing

## Checklist
- [ ] Código formateado
- [ ] Documentación actualizada
- [ ] Cambios en CHANGELOG.md
```

---

## 4. Comunicación y Reuniones

### 4.1 Reuniones Programadas

| Reunión | Frecuencia | Duración | Asistentes |
|---------|-----------|----------|-----------|
| Daily Standup | Diaria | 15 min | Todos |
| Weekly Review | Semanal | 1 hora | Todos |
| Planning | Bi-semanal | 1.5 horas | Todos |
| Retro | Bi-semanal | 1 hora | Todos |

### 4.2 Canales de Comunicación

- **Urgente**: Slack #qa-doctorado-urgent
- **General**: Slack #qa-doctorado-2026
- **Documentación**: GitHub Discussions
- **Decisiones**: Email formales archivadas
- **Código**: GitHub Comments en PRs

### 4.3 Horario de Disponibilidad

- **Zona Horaria**: [Especificar zona]
- **Horas Core**: [Especificar horario]
- **Respuesta Esperada**: 24 horas para no-urgente

---

## 5. Estándares de Calidad

### 5.1 Estándares de Código

- **Lenguaje**: Python 3.11+
- **Style Guide**: PEP 8
- **Formatter**: Black
- **Linter**: Flake8 + Wemake
- **Type Hints**: Mypy con `strict_optional=True`

### 5.2 Cobertura de Tests

- **Mínima**: 80% cobertura
- **Target**: 90%+ cobertura
- **Crítico**: 100% en autenticación y datos

### 5.3 Documentación

**Requerida para**:
- Nuevas funciones/métodos
- Cambios en API
- Nuevos test cases
- Decisiones arquitectónicas

**Formato**:
- Docstrings en Python (Google style)
- README.md para cambios de usuarios
- CHANGELOG.md para todas las changes
- ADRs (Architecture Decision Records) para decisiones

---

## 6. Versionamiento y Releases

### 6.1 Semantic Versioning

Formato: `MAJOR.MINOR.PATCH`

- `MAJOR`: Cambios incompatibles
- `MINOR`: Nuevas features compatibles
- `PATCH`: Bug fixes

### 6.2 Release Process

1. Actualizar CHANGELOG.md
2. Crear tag: `v1.2.3`
3. Crear GitHub Release con notas
4. Anunciar en Slack

### 6.3 Cadencia de Releases

- **Estable**: Mensual
- **Beta**: Semanal
- **Dev**: Continuo

---

## 7. Manejo de Conflictos

### 7.1 Decisiones Técnicas

**Proceso**:
1. Proposición en GitHub Discussion
2. Debate asincrónico (máx 3 días)
3. Votación si no hay consenso
4. Decisión por mayoría (Project Lead desempata)

### 7.2 Conflictos Interpersonales

1. **Privado**: Conversación 1-1
2. **Facilitado**: Project Lead medía
3. **Escalación**: Profesor supervisor

### 7.3 No-Bloqueos

- Nadie puede bloquear indefinidamente un PR
- Project Lead decide después de 5 días sin consenso
- Se documenta la decisión

---

## 8. Propiedad Intelectual y Atribución

### 8.1 Licencia

- **Repositorio**: MIT
- **Documentación**: Creative Commons BY-SA 4.0
- **Papers**: Derechos del autor (equipo)

### 8.2 Atribución

- Todos los commits deben ser atribuibles
- Git blame debe mostrar autor original
- Papers incluyen contribuidores en orden alfabético

### 8.3 External Code

- Agradecer explícitamente el SUT original
- Mencionar modificaciones en CHANGELOG
- Respetar licencias originales

---

## 9. Seguridad y Privacidad

### 9.1 Credenciales

- **NUNCA** commitear credenciales
- Usar `.env.example` para ejemplos
- Rotar credenciales mensualmente

### 9.2 Datos Sensibles

- No usar datos reales en tests
- Usar fixtures/factories para datos dummy
- Anonymizar en reportes si necesario

### 9.3 Acceso al Repositorio

- Colaboradores requieren aprobación
- 2FA requerido para administradores
- Acceso revocado al terminar doctorado

---

## 10. Deuda Técnica y Mantenimiento

### 10.1 Deuda Técnica

**Permitida hasta**:
- 5% de cobertura bajo 80%
- 3 TODOs comentados en código
- Máximo 2 issues de bajo severity sin resolver

### 10.2 Refactorización

- Dedicar 20% del tiempo a refactorización
- No refactorizar sin tests previos
- PR separado de cambios funcionales

### 10.3 Dependencias

- Actualizar semanalmente
- Revisar changelogs de updates
- Mantener `poetry.lock` actualizado

---

## 11. Escalabilidad y Evolución

### 11.1 Agregar Nuevos Tests

**Aprobación requerida para**:
- Tests que usan >50% resources
- Tests con duración >5 segundos
- Tests no determinísticos

### 11.2 Cambios al SUT

- Cambios de configuración: Todos aprueban
- Parches críticos: Lead decide
- Upgrades de versiones: Team meeting

### 11.3 Extensiones

- Nuevas herramientas: Propuesta + votación
- Cambios en estructura: ADR requerido
- Breaking changes: Anuncio 1 semana antes

---

## 12. Compromisos de Cada Miembro

### Checklist de Compromisos

Cada miembro del equipo se compromete a:

- [ ] Cumplir con deadlines acordados
- [ ] Respetar estándares de código
- [ ] Revisar PRs en 48 horas
- [ ] Documentar cambios significativos
- [ ] Asistir a reuniones core
- [ ] Comunicar bloqueos inmediatamente
- [ ] Apoyar a otros miembros
- [ ] Mantener ambiente profesional y respetuoso

---

## 13. Resolución de Desacuerdos

### Proceso Escalado

1. **Discusión**: Equipo en reunión semanal
2. **Votación**: Mayoría simple decide (sin Project Lead)
3. **Project Lead Break-tie**: Si hay empate
4. **Documentation**: Decisión se documenta en ADR

---

## 14. Revisión de Acuerdos

### 14.1 Frecuencia de Revisión

- **Inicial**: Semana 1 de doctorado
- **Periódica**: Cada mes
- **Ad-hoc**: Cuando 3+ miembros lo soliciten

### 14.2 Proceso de Enmienda

1. Propuesta con justificación
2. Discusión en reunión semanal
3. Votación (mayoría 2/3)
4. Actualizar documento y communicar

---

## 15. Firmas de Acuerdo

**Certifico que he leído, entendido y acepto estos acuerdos:**

| Nombre | Rol | Firma | Fecha |
|--------|-----|-------|-------|
| [Miembro 1] | Project Lead | _____ | _____ |
| [Miembro 2] | QA Engineer | _____ | _____ |
| [Miembro 3] | QA Engineer | _____ | _____ |
| [Miembro 4] | DevOps/QA | _____ | _____ |

---

## Appendix A: Glosario

- **PR**: Pull Request - solicitud de cambios
- **SUT**: System Under Test - sistema a probar
- **CI/CD**: Continuous Integration/Continuous Deployment
- **ADR**: Architecture Decision Record
- **Lead**: Project Lead / Coordinador del equipo

---

**Documento Versión**: 1.0  
**Fecha de Efectividad**: Enero 18, 2026  
**Próxima Revisión**: Febrero 18, 2026
