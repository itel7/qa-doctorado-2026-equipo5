#!/bin/bash

##############################################################################
# smoke.sh - Smoke Test: Verificación rápida de servicios críticos
# 
# Verifica que los endpoints principales estén funcionando correctamente
# Registra evidencia en la carpeta evidence/smoke
#
# Uso: ./scripts/smoke.sh [--verbose]
##############################################################################

set -e

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_DIR="evidence/smoke"
LOG_FILE="$LOG_DIR/smoke_test_${TIMESTAMP}.log"

# Crear directorio de evidencia si no existe
mkdir -p "$LOG_DIR"

# Variables
API_BASE="http://localhost:8000/api"
RESULTS=0
PASSED=0
FAILED=0
VERBOSE=false

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Parse arguments
if [ "$1" = "--verbose" ]; then
    VERBOSE=true
fi

# Función para loguear
log_message() {
    echo -e "$1" | tee -a "$LOG_FILE"
}

# Encabezado
log_message "${BLUE}========================================${NC}"
log_message "${BLUE}SMOKE TEST - FastAPI RealWorld${NC}"
log_message "${BLUE}Timestamp: $(date)${NC}"
log_message "${BLUE}========================================${NC}"
log_message "API Base URL: $API_BASE"
log_message "Log file: $LOG_FILE\n"

# Test 1: Health Check / API Status
log_message "${YELLOW}[TEST 1/4] Verificando disponibilidad de API...${NC}"
if curl -s -o /dev/null -w "%{http_code}" "$API_BASE/" 2>/dev/null | grep -qE "200|404|405"; then
    log_message "${GREEN}✓ PASS: API disponible${NC}\n"
    ((PASSED++))
else
    log_message "${RED}✗ FAIL: API no responde${NC}\n"
    ((FAILED++))
fi

# Test 2: Endpoint de Artículos (GET)
log_message "${YELLOW}[TEST 2/4] GET /articles - Listado de artículos${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" "$API_BASE/articles" 2>/dev/null)
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n-1)

if [ "$HTTP_CODE" = "200" ]; then
    log_message "${GREEN}✓ PASS: Endpoint /articles funcional (HTTP $HTTP_CODE)${NC}\n"
    [ "$VERBOSE" = true ] && log_message "Response preview: $(echo "$BODY" | head -c 100)...\n"
    ((PASSED++))
else
    log_message "${RED}✗ FAIL: Endpoint /articles retorna HTTP $HTTP_CODE${NC}\n"
    ((FAILED++))
fi

# Test 3: Endpoint de Autenticación
log_message "${YELLOW}[TEST 3/4] POST /users/login - Autenticación${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_BASE/users/login" \
    -H "Content-Type: application/json" \
    -d '{"user":{"email":"test@example.com","password":"password"}}' 2>/dev/null)
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)

if [ "$HTTP_CODE" = "422" ] || [ "$HTTP_CODE" = "401" ] || [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "404" ]; then
    log_message "${GREEN}✓ PASS: Endpoint /users/login responde (HTTP $HTTP_CODE)${NC}\n"
    ((PASSED++))
else
    log_message "${RED}✗ FAIL: Endpoint /users/login retorna HTTP $HTTP_CODE${NC}\n"
    ((FAILED++))
fi

# Test 4: Documentación Swagger
log_message "${YELLOW}[TEST 4/4] GET /docs - Documentación Swagger${NC}"
RESPONSE=$(curl -s -w "\n%{http_code}" "http://localhost:8000/docs" 2>/dev/null)
HTTP_CODE=$(echo "$RESPONSE" | tail -n1)

if [ "$HTTP_CODE" = "200" ]; then
    log_message "${GREEN}✓ PASS: Documentación Swagger disponible (HTTP $HTTP_CODE)${NC}\n"
    ((PASSED++))
else
    log_message "${RED}✗ FAIL: Documentación no disponible (HTTP $HTTP_CODE)${NC}\n"
    ((FAILED++))
fi

# Resumen
log_message "${BLUE}========================================${NC}"
log_message "${BLUE}RESUMEN${NC}"
log_message "${BLUE}========================================${NC}"
log_message "Total Tests: $((PASSED + FAILED))"
log_message "${GREEN}Pasados: $PASSED${NC}"
log_message "${RED}Fallidos: $FAILED${NC}"
log_message "\nReporte guardado en: $LOG_FILE"

# Exit code
if [ $FAILED -gt 0 ]; then
    exit 1
else
    exit 0
fi
