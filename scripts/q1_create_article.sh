#!/bin/bash

##############################################################################
# q1_create_article.sh - Q1: Crear Artículo Exitosamente
# 
# Escenario Q1: Verificar que un usuario autenticado puede crear un artículo
# Resultado esperado: HTTP 201 Created con slug generado
#
# Uso: ./scripts/q1_create_article.sh [TOKEN]
##############################################################################

set -e

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_DIR="evidence/week2"
LOG_FILE="$LOG_DIR/q1_create_article_${TIMESTAMP}.log"

mkdir -p "$LOG_DIR"

API_BASE="http://localhost:8000/api"
TOKEN="${1:-test_token_q1}"  # Token por defecto o como argumento

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Encabezado
{
    echo "========================================="
    echo "Q1: CREAR ARTÍCULO EXITOSAMENTE"
    echo "========================================="
    echo "Timestamp: $(date)"
    echo "API: $API_BASE"
    echo "Log: $LOG_FILE"
    echo ""
    echo "Parámetros:"
    echo "- Token: ${TOKEN:0:20}..."
    echo ""
} | tee "$LOG_FILE"

# Crear artículo
echo -e "${YELLOW}Creando artículo...${NC}" | tee -a "$LOG_FILE"

START_TIME=$(date +%s%N)

RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$API_BASE/articles" \
    -H "Content-Type: application/json" \
    -H "Authorization: Token $TOKEN" \
    -d "{
        \"article\": {
            \"title\": \"Test Article Q1 - $(date +%s)\",
            \"description\": \"Test description for Q1 scenario\",
            \"body\": \"Test body content for scenario Q1\",
            \"tagList\": [\"test\", \"q1\"]
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
if [ "$HTTP_CODE" = "201" ]; then
    {
        echo -e "${GREEN}✓ PASS: Artículo creado exitosamente${NC}"
        echo "Status: PASSED"
        echo "Details: HTTP 201, Tiempo: ${RESPONSE_TIME}ms"
    } | tee -a "$LOG_FILE"
    exit 0
else
    {
        echo -e "${RED}✗ FAIL: Error creando artículo${NC}"
        echo "Status: FAILED"
        echo "Details: Esperado HTTP 201, recibido $HTTP_CODE"
    } | tee -a "$LOG_FILE"
    exit 1
fi
