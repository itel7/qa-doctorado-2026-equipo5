.PHONY: help run stop health smoke q1 q2 q3 q4 test-all evidence clean lint format quality-gate gaming-drill

# Variables
SHELL := /bin/bash
.SHELLFLAGS := -ec

# Colores para output
YELLOW := \033[1;33m
GREEN := \033[0;32m
BLUE := \033[0;34m
NC := \033[0m # No Color

help:
	@echo ""
	@echo "$(BLUE)╔════════════════════════════════════════════════════════════╗$(NC)"
	@echo "$(BLUE)║  FastAPI RealWorld - QA Doctorado 2026                    ║$(NC)"
	@echo "$(BLUE)║  Makefile - Automatización de Pruebas                     ║$(NC)"
	@echo "$(BLUE)╚════════════════════════════════════════════════════════════╝$(NC)"
	@echo ""
	@echo "$(YELLOW)SISTEMA:$(NC)"
	@echo "  make run              - Iniciar FastAPI + PostgreSQL"
	@echo "  make stop             - Detener servicios"
	@echo "  make health           - Verificar salud del sistema"
	@echo ""
	@echo "$(YELLOW)SMOKE TEST:$(NC)"
	@echo "  make smoke            - Ejecutar verificación rápida (4 checks)"
	@echo ""
	@echo "$(YELLOW)ESCENARIOS (Semana 2):$(NC)"
	@echo "  make q1               - Q1: Crear artículo exitosamente"
	@echo "  make q2               - Q2: Validar artículos duplicados"
	@echo "  make q3               - Q3: Modificar artículo por propietario"
	@echo "  make q4               - Q4: Rechazar modificación no autorizada"
	@echo "  make test-all         - Ejecutar smoke + Q1 + Q2 + Q3 + Q4"
	@echo ""
	@echo "$(YELLOW)PRUEBAS BASADAS EN RIESGO (Semana 3):$(NC)"
	@echo "  make risk-tests       - Ejecutar Top 3 de riesgos identificados"
	@echo ""
	@echo "$(YELLOW)PRUEBAS SISTEMÁTICAS (Semana 4):$(NC)"
	@echo "  make systematic-test  - Ejecutar 12 casos EP+BVA con oráculos"
	@echo "  make week4-report     - Generar reporte metodológico Week 4"
	@echo ""
	@echo "$(YELLOW)QUALITY GATE (Semana 5):$(NC)"
	@echo "  make quality-gate     - Ejecutar gate con evidencia reproducible"
	@echo ""
	@echo "$(YELLOW)GAMING DRILL (Semana 6):$(NC)"
	@echo "  make gaming-drill     - Ejecutar experimento before/after"
	@echo ""
	@echo "$(YELLOW)UTILIDADES:$(NC)"
	@echo "  make evidence         - Ver evidencia de pruebas"
	@echo "  make clean            - Limpiar archivos de evidencia"
	@echo "  make help             - Mostrar esta ayuda"
	@echo ""
	@echo "$(BLUE)DOCUMENTACIÓN:$(NC)"
	@echo "  quality/scenarios.md  - Definición de escenarios"
	@echo "  memos/week2_memo.md   - Reporte de semana 2"
	@echo "  SUT_SELECTION.md      - Selección y justificación del SUT"
	@echo "  AGREEMENTS.md         - Acuerdos de equipo"
	@echo ""

# ============================================================================
# SISTEMA
# ============================================================================

run:
	@echo "$(GREEN)Iniciando SUT...$(NC)"
	@bash setup/run_sut.sh

stop:
	@echo "$(GREEN)Deteniendo SUT...$(NC)"
	@bash setup/stop_sut.sh

health:
	@echo "$(GREEN)Verificando salud del sistema...$(NC)"
	@bash setup/healthcheck_sut.sh --verbose

# ============================================================================
# SMOKE TEST
# ============================================================================

smoke:
	@echo "$(GREEN)Ejecutando Smoke Test...$(NC)"
	@echo "Verificando 4 endpoints críticos..."
	@bash scripts/smoke.sh --verbose

# ============================================================================
# ESCENARIOS (SEMANA 2)
# ============================================================================

q1:
	@echo "$(GREEN)Ejecutando Q1: Crear Artículo Exitosamente$(NC)"
	@bash scripts/q1_create_article.sh

q2:
	@echo "$(GREEN)Ejecutando Q2: Validar Artículos Duplicados$(NC)"
	@bash scripts/q2_duplicate_validation.sh

q3:
	@echo "$(GREEN)Ejecutando Q3: Modificar Artículo por Propietario$(NC)"
	@bash scripts/q3_modify_article.sh

q4:
	@echo "$(GREEN)Ejecutando Q4: Rechazar Modificación No Autorizada$(NC)"
	@bash scripts/q4_unauthorized_modify.sh

# Ejecutar todos los escenarios
test-all: smoke q1 q2 q3 q4
	@echo ""
	@echo "$(GREEN)════════════════════════════════════════$(NC)"
	@echo "$(GREEN)✓ Todos los tests completados$(NC)"
	@echo "$(GREEN)════════════════════════════════════════$(NC)"
	@echo ""
	@echo "Ver evidencia con: make evidence"

# ============================================================================
# EVIDENCIA
# ============================================================================

evidence:
	@echo "$(BLUE)════════════════════════════════════════$(NC)"
	@echo "$(BLUE)EVIDENCIA DE PRUEBAS$(NC)"
	@echo "$(BLUE)════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)Smoke Tests:$(NC)"
	@if [ -d evidence/smoke ]; then \
		ls -lh evidence/smoke/ 2>/dev/null | tail -n +2 || echo "  No hay smoke tests ejecutados"; \
	else \
		echo "  Carpeta no existe aún"; \
	fi
	@echo ""
	@echo "$(YELLOW)Escenarios (Semana 2):$(NC)"
	@if [ -d evidence/week2 ]; then \
		ls -lh evidence/week2/ 2>/dev/null | tail -n +2 || echo "  No hay escenarios ejecutados"; \
	else \
		echo "  Carpeta no existe aún"; \
	fi
	@echo ""
	@echo "$(YELLOW)Quality Gate (Semana 5):$(NC)"
	@if [ -d evidence/week5 ]; then \
		ls -lh evidence/week5/ 2>/dev/null | tail -n +2 || echo "  No hay evidencia week5"; \
	else \
		echo "  Carpeta no existe aún"; \
	fi
	@echo ""

# ============================================================================
# UTILIDADES
# ============================================================================

clean:
	@echo "$(YELLOW)Limpiando evidencia de pruebas...$(NC)"
	@rm -rf evidence/smoke/*.log
	@rm -rf evidence/week2/*.log
	@echo "$(GREEN)✓ Archivos de evidencia eliminados$(NC)"

docs:
	@echo "$(BLUE)════════════════════════════════════════$(NC)"
	@echo "$(BLUE)DOCUMENTACIÓN$(NC)"
	@echo "$(BLUE)════════════════════════════════════════$(NC)"
	@echo ""
	@echo "📋 Escenarios:"
	@echo "   cat quality/scenarios.md"
	@echo ""
	@echo "📝 Memo Semana 2:"
	@echo "   cat memos/week2_memo.md"
	@echo ""
	@echo "🎯 Selección del SUT:"
	@echo "   cat SUT_SELECTION.md"
	@echo ""
	@echo "📋 Acuerdos del Equipo:"
	@echo "   cat AGREEMENTS.md"
	@echo ""

status:
	@echo "$(BLUE)════════════════════════════════════════$(NC)"
	@echo "$(BLUE)ESTADO DEL PROYECTO$(NC)"
	@echo "$(BLUE)════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)Archivos de Semana 1:$(NC)"
	@test -f SUT_SELECTION.md && echo "  ✓ SUT_SELECTION.md" || echo "  ✗ SUT_SELECTION.md"
	@test -f AGREEMENTS.md && echo "  ✓ AGREEMENTS.md" || echo "  ✗ AGREEMENTS.md"
	@echo ""
	@echo "$(YELLOW)Archivos de Semana 2:$(NC)"
	@test -f quality/scenarios.md && echo "  ✓ quality/scenarios.md" || echo "  ✗ quality/scenarios.md"
	@test -f memos/week2_memo.md && echo "  ✓ memos/week2_memo.md" || echo "  ✗ memos/week2_memo.md"
	@test -f scripts/smoke.sh && echo "  ✓ scripts/smoke.sh" || echo "  ✗ scripts/smoke.sh"
	@test -f scripts/q1_create_article.sh && echo "  ✓ scripts/q1_create_article.sh" || echo "  ✗ scripts/q1_create_article.sh"
	@test -f scripts/q2_duplicate_validation.sh && echo "  ✓ scripts/q2_duplicate_validation.sh" || echo "  ✗ scripts/q2_duplicate_validation.sh"
	@test -f scripts/q3_modify_article.sh && echo "  ✓ scripts/q3_modify_article.sh" || echo "  ✗ scripts/q3_modify_article.sh"
	@test -f scripts/q4_unauthorized_modify.sh && echo "  ✓ scripts/q4_unauthorized_modify.sh" || echo "  ✗ scripts/q4_unauthorized_modify.sh"
	@echo ""
	@echo "$(YELLOW)Carpetas:$(NC)"
	@test -d evidence/smoke && echo "  ✓ evidence/smoke/" || echo "  ✗ evidence/smoke/"
	@test -d evidence/week2 && echo "  ✓ evidence/week2/" || echo "  ✗ evidence/week2/"
	@test -d quality && echo "  ✓ quality/" || echo "  ✗ quality/"
	@test -d memos && echo "  ✓ memos/" || echo "  ✗ memos/"
	@echo ""

# ============================================================================
# FLUJO DE TRABAJO TÍPICO
# ============================================================================

# Iniciar todo de una vez
full-test: run
	@sleep 30
	@make health
	@make test-all
	@make evidence

# Script de desarrollo
dev: health smoke
	@echo "$(GREEN)Dev mode ready$(NC)"

# ============================================================================
# QUALITY GATE (SEMANA 5)
# ============================================================================

quality-gate:
	@echo "$(GREEN)Ejecutando Quality Gate (Semana 5)...$(NC)"
	@bash ci/run_quality_gate.sh

# ============================================================================
# GAMING DRILL (SEMANA 6)
# ============================================================================

gaming-drill:
	@echo "$(GREEN)Ejecutando Gaming Drill (Semana 6)...$(NC)"
	@bash ci/run_gate_gaming_drill.sh

# Ejecutar antes de hacer commit
pre-commit: clean test-all
	@echo "$(GREEN)Pre-commit checks complete$(NC)"

# ============================================================================
# SEMANA 4 - PRUEBAS SISTEMÁTICAS
# ============================================================================

systematic-test:
	@echo "$(BLUE)════════════════════════════════════════$(NC)"
	@echo "$(BLUE)CASOS SISTEMÁTICOS (Semana 4)$(NC)"
	@echo "$(BLUE)════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)Endpoint:$(NC) GET /api/articles/{slug}"
	@echo "$(YELLOW)Técnica:$(NC) Equivalence Partitioning + BVA"
	@echo "$(YELLOW)Oráculos:$(NC) 7 reglas formales (OR-01 a OR-07)"
	@echo "$(YELLOW)Casos:$(NC) 12 casos de prueba (TC-01 a TC-12)"
	@echo ""
	@./scripts/systematic_cases.sh
	@echo ""
	@echo "$(GREEN)Evidencia generada en evidence/week4/$(NC)"

week4-report:
	@echo "$(BLUE)════════════════════════════════════════$(NC)"
	@echo "$(BLUE)REPORTE SEMANA 4$(NC)"
	@echo "$(BLUE)════════════════════════════════════════$(NC)"
	@echo ""
	@echo "$(YELLOW)Oráculos:$(NC)           design/oracle_rules.md"
	@cat design/oracle_rules.md | grep "^##" | head -10
	@echo ""
	@echo "$(YELLOW)Casos de Prueba:$(NC)    design/test_cases.md"
	@cat design/test_cases.md | grep "^##" | head -10
	@echo ""
	@echo "$(YELLOW)Evidencia:$(NC)          evidence/week4/"
	@ls -lh evidence/week4/ | tail -5
	@echo ""
	@echo "$(YELLOW)Reporte Completo:$(NC)   reports/week4_report.md"
	@cat reports/week4_report.md | head -30
	@echo ""
	@echo "$(GREEN)Ver reporte completo: cat reports/week4_report.md$(NC)"

.DEFAULT_GOAL := help
