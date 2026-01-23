#!/bin/bash

##############################################################################
# q4_unauthorized_modify.sh - Q4: Rechazar Modificación No Autorizada
# 
# Escenario Q4: Usuario NO-propietario NO puede modificar artículo ajeno
# Resultado esperado: HTTP 403 Forbidden
#
# Uso: ./scripts/q4_unauthorized_modify.sh [OTHER_USER_TOKEN] [ARTICLE_SLUG]
##############################################################################

set -e

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_DIR="evidence/week2"
LOG_FILE="$LOG_DIR/q4_unauthorized_modify_${TIMESTAMP}.log"

mkdir -p "$LOG_DIR"

API_BASE="http://localhost:8000/api"
OTHER_USER_TOKEN="${1:-different_user_token_q4}"
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
    echo "Q4: RECHAZAR MODIFICACIÓN NO AUTORIZADA"
    echo "========================================="
    echo "Timestamp: $(date)"
    echo "API: $API_BASE"
    echo "Log: $LOG_FILE"
    echo ""
    echo "Parámetros:"
    echo "- Usuario Diferente Token: ${OTHER_USER_TOKEN:0:20}..."
    echo "- Article Slug: $ARTICLE_SLUG"
    echo ""
} | tee "$LOG_FILE"

# Intentar modificar artículo ajeno
echo -e "${YELLOW}Intentando modificar artículo con usuario diferente...${NC}" | tee -a "$LOG_FILE"

START_TIME=$(date +%s%N)

RESPONSE=$(curl -s -w "\n%{http_code}" -X PUT "$API_BASE/articles/$ARTICLE_SLUG" \
    -H "Content-Type: application/json" \
    -H "Authorization: Token $OTHER_USER_TOKEN" \
    -d "{
        \"article\": {
            \"title\": \"Hacked Title Q4\",
            \"body\": \"Hacked content - This should be rejected\"
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
if [ "$HTTP_CODE" = "403" ] || [ "$HTTP_CODE" = "422" ]; then
    {
        echo -e "${GREEN}✓ PASS: Acceso no autorizado rechazado${NC}"
        echo "Status: PASSED"
        echo "Details: HTTP $HTTP_CODE (esperado), Tiempo: ${RESPONSE_TIME}ms"
        echo "Interpretación: Protección contra modificación no autorizada ACTIVA"
    } | tee -a "$LOG_FILE"
    exit 0
else
    {
        echo -e "${RED}✗ FAIL: Usuario NO-propietario pudo modificar artículo${NC}"
        echo "Status: FAILED"
        echo "Details: Esperado HTTP 403, recibido $HTTP_CODE"
        echo "Interpretación: VULNERABILIDAD: Sin autorización debería rechazarse"
    } | tee -a "$LOG_FILE"
    exit 1
fi
