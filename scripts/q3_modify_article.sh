#!/bin/bash

##############################################################################
# q3_modify_article.sh - Q3: Modificar Artículo por Propietario
# 
# Escenario Q3: El autor puede actualizar su artículo exitosamente
# Resultado esperado: HTTP 200 OK con cambios persistidos
#
# Uso: ./scripts/q3_modify_article.sh [TOKEN] [ARTICLE_SLUG]
##############################################################################

set -e

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_DIR="evidence/week2"
LOG_FILE="$LOG_DIR/q3_modify_article_${TIMESTAMP}.log"

mkdir -p "$LOG_DIR"

API_BASE="http://localhost:8000/api"
TOKEN="${1:-test_token_q3}"
ARTICLE_SLUG="${2:-test-article-q1}"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Encabezado
{
    echo "========================================="
    echo "Q3: MODIFICAR ARTÍCULO POR PROPIETARIO"
    echo "========================================="
    echo "Timestamp: $(date)"
    echo "API: $API_BASE"
    echo "Log: $LOG_FILE"
    echo ""
    echo "Parámetros:"
    echo "- Token: ${TOKEN:0:20}..."
    echo "- Article Slug: $ARTICLE_SLUG"
    echo ""
} | tee "$LOG_FILE"

# Modificar artículo
echo -e "${YELLOW}Modificando artículo...${NC}" | tee -a "$LOG_FILE"

START_TIME=$(date +%s%N)

RESPONSE=$(curl -s -w "\n%{http_code}" -X PUT "$API_BASE/articles/$ARTICLE_SLUG" \
    -H "Content-Type: application/json" \
    -H "Authorization: Token $TOKEN" \
    -d "{
        \"article\": {
            \"title\": \"Updated Article Title Q3\",
            \"body\": \"Updated content for Q3 scenario - $(date)\",
            \"description\": \"Updated description Q3\"
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
if [ "$HTTP_CODE" = "200" ]; then
    if [ "$RESPONSE_TIME" -lt 500 ]; then
        {
            echo -e "${GREEN}✓ PASS: Artículo modificado exitosamente${NC}"
            echo "Status: PASSED"
            echo "Details: HTTP 200, Tiempo: ${RESPONSE_TIME}ms (< 500ms)"
            echo "Interpretación: Modificación exitosa con performance aceptable"
        } | tee -a "$LOG_FILE"
        exit 0
    else
        {
            echo -e "${YELLOW}⚠ WARNING: Artículo modificado pero con performance baja${NC}"
            echo "Status: PASSED (con advertencia)"
            echo "Details: HTTP 200, Tiempo: ${RESPONSE_TIME}ms (> 500ms)"
            echo "Interpretación: Modificación exitosa pero tiempo de respuesta alto"
        } | tee -a "$LOG_FILE"
        exit 0
    fi
else
    {
        echo -e "${RED}✗ FAIL: Error modificando artículo${NC}"
        echo "Status: FAILED"
        echo "Details: Esperado HTTP 200, recibido $HTTP_CODE"
        echo "Interpretación: No se pudo modificar el artículo"
    } | tee -a "$LOG_FILE"
    exit 1
fi
