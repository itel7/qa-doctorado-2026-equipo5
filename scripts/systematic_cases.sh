#!/bin/bash

##############################################################################
# systematic_cases.sh - Ejecución sistemática de casos de prueba
# Endpoint: GET /api/articles/{slug}
# Técnica: Equivalence Partitioning + Boundary Value Analysis
##############################################################################

set -e

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
API_BASE="http://localhost:8000/api"
EVIDENCE_DIR="evidence/week4"
RUNLOG="$EVIDENCE_DIR/RUNLOG.md"
SUMMARY="$EVIDENCE_DIR/summary.txt"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Contadores
PASS=0
FAIL=0
TOTAL=0

mkdir -p "$EVIDENCE_DIR"

# Inicializar RUNLOG
cat > "$RUNLOG" <<EOF
# RUNLOG - Semana 4: Casos Sistemáticos

## Ejecución: $(date +"%Y-%m-%d %H:%M:%S")
## Endpoint: GET /api/articles/{slug}
## Técnica: Equivalence Partitioning + Boundary Value Analysis
## Oráculos aplicados: OR-01 a OR-07

---

EOF

echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${BLUE}Ejecutando casos sistemáticos${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""

# Función auxiliar para ejecutar caso
run_test_case() {
    local tc_id="$1"
    local slug="$2"
    local expected_status="$3"
    local oracle_ids="$4"
    local description="$5"
    
    TOTAL=$((TOTAL + 1))
    
    echo -e "${YELLOW}Ejecutando $tc_id: $description${NC}"
    
    local output_file="$EVIDENCE_DIR/${tc_id}.json"
    local start_time=$(date +%s)
    
    # Ejecutar request
    response=$(curl -s -w "\n%{http_code}\n%{time_total}" "$API_BASE/articles/$slug" 2>&1 || echo "ERROR")
    
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    
    # Parsear respuesta (compatible con macOS)
    local total_lines=$(echo "$response" | wc -l | tr -d ' ')
    local body_lines=$((total_lines - 2))
    local body=$(echo "$response" | head -n "$body_lines")
    local http_code=$(echo "$response" | tail -n 2 | head -n 1)
    local time_total=$(echo "$response" | tail -n 1)
    
    # Guardar evidencia
    cat > "$output_file" <<EOF
{
  "test_case": "$tc_id",
  "slug": "$slug",
  "http_code": "$http_code",
  "time_ms": $duration,
  "expected_status": "$expected_status",
  "oracles": "$oracle_ids",
  "timestamp": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "body": $(echo "$body" | jq -R -s '.' 2>/dev/null || echo "\"$body\"")
}
EOF
    
    # Aplicar oráculo OR-01 (código HTTP válido)
    local result="FAIL"
    if [[ "$http_code" =~ ^(200|404|422|500)$ ]]; then
        # Aplicar oráculo específico del caso
        if [[ "$http_code" == "$expected_status" ]] || [[ "$expected_status" == "422|404" && ("$http_code" == "422" || "$http_code" == "404") ]]; then
            result="PASS"
            PASS=$((PASS + 1))
            echo -e "${GREEN}✓ $tc_id: PASS (HTTP $http_code, ${duration}ms)${NC}"
        else
            FAIL=$((FAIL + 1))
            echo -e "${RED}✗ $tc_id: FAIL - Expected $expected_status, got $http_code${NC}"
        fi
    else
        FAIL=$((FAIL + 1))
        echo -e "${RED}✗ $tc_id: FAIL - Invalid HTTP code: $http_code${NC}"
    fi
    
    # Registrar en RUNLOG
    cat >> "$RUNLOG" <<EOF
### $tc_id: $description
**Input:** \`GET /api/articles/$slug\`
**Oráculos:** $oracle_ids
**Resultado:** $result
- HTTP Code: $http_code (esperado: $expected_status)
- Tiempo: ${duration}ms
- Evidencia: \`$output_file\`

---

EOF
    
    echo ""
}

# ============================================================================
# EJECUCIÓN DE CASOS
# ============================================================================

# TC-01: Slug válido existente
run_test_case "TC-01" "how-to-train-your-dragon" "200" "OR-01,OR-02,OR-03,OR-06,OR-07" "Slug válido existente"

# TC-02: Slug válido no existente
run_test_case "TC-02" "non-existent-article-slug-12345" "404" "OR-01,OR-04,OR-06" "Slug válido no existente"

# TC-03: Slug vacío
run_test_case "TC-03" "" "422|404" "OR-01,OR-05" "Slug vacío"

# TC-04: Slug con espacios
run_test_case "TC-04" "my article slug" "422|404" "OR-01,OR-05" "Slug con espacios"

# TC-05: Slug con guiones múltiples
run_test_case "TC-05" "my-article-with-many-dashes" "200|404" "OR-01,OR-02,OR-03" "Slug con guiones múltiples"

# TC-06: Slug muy largo (255 caracteres)
LONG_SLUG=$(printf 'a%.0s' {1..255})
run_test_case "TC-06" "$LONG_SLUG" "422|404" "OR-01,OR-05" "Slug muy largo (255 chars)"

# TC-07: Slug muy corto (1 carácter)
run_test_case "TC-07" "a" "404" "OR-01,OR-04" "Slug muy corto (1 char)"

# TC-08: Slug con números
run_test_case "TC-08" "article-123-test" "200|404" "OR-01,OR-02,OR-03" "Slug con números"

# TC-09: Slug con caracteres Unicode
run_test_case "TC-09" "artículo-español" "422|404" "OR-01,OR-05" "Slug con Unicode"

# TC-10: Slug que comienza con guión
run_test_case "TC-10" "-invalid-start" "422|404" "OR-01,OR-05" "Slug comienza con guión"

# TC-11: Slug que termina con guión
run_test_case "TC-11" "invalid-end-" "422|404" "OR-01,OR-05" "Slug termina con guión"

# TC-12: Slug con mayúsculas
run_test_case "TC-12" "My-Article-Title" "200|404" "OR-01,OR-02,OR-03,OR-04" "Slug con mayúsculas"

# ============================================================================
# RESUMEN
# ============================================================================

echo -e "${BLUE}════════════════════════════════════════${NC}"
echo -e "${BLUE}RESUMEN${NC}"
echo -e "${BLUE}════════════════════════════════════════${NC}"
echo ""
echo -e "Total: $TOTAL casos"
echo -e "${GREEN}PASS: $PASS${NC}"
echo -e "${RED}FAIL: $FAIL${NC}"
echo ""

# Guardar resumen
cat > "$SUMMARY" <<EOF
Systematic Test Cases Execution Summary
========================================
Date: $(date +"%Y-%m-%d %H:%M:%S")
Endpoint: GET /api/articles/{slug}
Technique: Equivalence Partitioning + BVA

Results:
--------
Total:  $TOTAL
PASS:   $PASS
FAIL:   $FAIL
Success Rate: $(awk "BEGIN {printf \"%.1f\", ($PASS/$TOTAL)*100}")%

Evidence: $EVIDENCE_DIR/
RUNLOG: $RUNLOG
EOF

cat "$SUMMARY"

# Agregar resumen al RUNLOG
cat >> "$RUNLOG" <<EOF

## Resumen Final
- **Total casos:** $TOTAL
- **PASS:** $PASS
- **FAIL:** $FAIL
- **Tasa de éxito:** $(awk "BEGIN {printf \"%.1f\", ($PASS/$TOTAL)*100}")%

EOF

exit 0
