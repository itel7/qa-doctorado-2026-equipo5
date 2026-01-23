#!/bin/bash

##############################################################################
# q2_duplicate_validation.sh - Q2: Validación de Artículos Duplicados
# 
# Escenario Q2: El sistema rechaza artículos con título duplicado del mismo autor
# Resultado esperado: HTTP 422 Unprocessable Entity
#
# Uso: ./scripts/q2_duplicate_validation.sh [TOKEN] [ARTICLE_SLUG]
##############################################################################

set -e

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_DIR="evidence/week2"
LOG_FILE="$LOG_DIR/q2_duplicate_validation_${TIMESTAMP}.log"

mkdir -p "$LOG_DIR"

API_BASE="http://localhost:8000/api"
TOKEN="${1:-test_token_q2}"
ARTICLE_TITLE="Test Article Q1 - Duplicate Check"  # Mismo título que Q1

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Encabezado
{
    echo "========================================="
    echo "Q2: VALIDACIÓN DE ARTÍCULOS DUPLICADOS"
    echo "========================================="
    echo "Timestamp: $(date)"
    echo "API: $API_BASE"
    echo "Log: $LOG_FILE"
    echo ""
    echo "Parámetros:"
    echo "- Token: ${TOKEN:0:20}..."
    echo "- Título Duplicado: $ARTICLE_TITLE"
    echo ""
} | tee "$LOG_FILE"

# Intentar crear artículo duplicado
echo -e "${YELLOW}Intentando crear artículo con título duplicado...${NC}" | tee -a "$LOG_FILE"

START_TIME=$(date +%s%N)

RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_BASE/articles" \
    -H "Content-Type: application/json" \
    -H "Authorization: Token $TOKEN" \
    -d "{
        \"article\": {
            \"title\": \"$ARTICLE_TITLE\",
            \"description\": \"Duplicate attempt Q2\",
            \"body\": \"This should be rejected as duplicate\"
        }
    }" 2>/dev/null)

END_TIME=$(date +%s%N)
RESPONSE_TIME=$(( (END_TIME - START_TIME) / 1000000 ))

HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | head -n-1)

{
    echo "HTTP Code: $HTTP_CODE"
    echo "Response Time: ${RESPONSE_TIME}ms"
    echo ""
    echo "Response Body:"
    echo "$BODY" | head -c 500
    echo ""
    echo ""
} >> "$LOG_FILE"

# Evaluación
if [ "$HTTP_CODE" = "422" ] || [ "$HTTP_CODE" = "409" ]; then
    {
        echo -e "${GREEN}✓ PASS: Duplicado rechazado correctamente${NC}"
        echo "Status: PASSED"
        echo "Details: HTTP $HTTP_CODE (esperado), Tiempo: ${RESPONSE_TIME}ms"
        echo "Interpretación: El sistema valida correctamente y rechaza duplicados"
    } | tee -a "$LOG_FILE"
    exit 0
else
    {
        echo -e "${RED}✗ FAIL: Duplicado NO fue rechazado${NC}"
        echo "Status: FAILED"
        echo "Details: Esperado HTTP 422/409, recibido $HTTP_CODE"
        echo "Interpretación: Se esperaba rechazo de duplicado pero se aceptó"
    } | tee -a "$LOG_FILE"
    exit 1
fi
