#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

EVIDENCE_DIR="$PROJECT_ROOT/evidence/week5"
RUNLOG="$EVIDENCE_DIR/RUNLOG.md"
SUMMARY="$EVIDENCE_DIR/SUMMARY.md"
OPENAPI_URL="http://localhost:8000/openapi.json"
OPENAPI_JSON="$EVIDENCE_DIR/openapi.json"
OPENAPI_HTTP="$EVIDENCE_DIR/openapi_http_code.txt"
ARTICLES_LIST_BODY="$EVIDENCE_DIR/articles_list.json"
ARTICLES_LIST_HTTP="$EVIDENCE_DIR/articles_list_http_code.txt"
SYSTEMATIC_CSV="$EVIDENCE_DIR/systematic_results.csv"
SYSTEMATIC_SUMMARY="$EVIDENCE_DIR/systematic_summary.txt"

STARTED_SUT=false
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0

mkdir -p "$EVIDENCE_DIR"

# Clean stale evidence from previous gate versions
rm -f "$EVIDENCE_DIR/register_user.json" \
    "$EVIDENCE_DIR/register_user_http_code.txt" \
    "$EVIDENCE_DIR/create_article.json" \
    "$EVIDENCE_DIR/create_article_http_code.txt"

log_line() {
    echo "$1" | tee -a "$RUNLOG"
}

record_check() {
    local name="$1"
    local status="$2"
    local detail="$3"

    TOTAL_CHECKS=$((TOTAL_CHECKS + 1))
    if [ "$status" = "PASS" ]; then
        PASSED_CHECKS=$((PASSED_CHECKS + 1))
    else
        FAILED_CHECKS=$((FAILED_CHECKS + 1))
    fi

    log_line "- $name: $status - $detail"
}

cleanup() {
    if [ "$STARTED_SUT" = true ]; then
        bash "$PROJECT_ROOT/setup/stop_sut.sh" --remove || true
    fi
}

trap cleanup EXIT

cat > "$RUNLOG" <<EOF
# RUNLOG - Semana 5: Quality Gate

Fecha/hora: $(date "+%Y-%m-%d %H:%M:%S")
Comando local: bash ci/run_quality_gate.sh
Evidencia generada en: $EVIDENCE_DIR

EOF

if [ "${SKIP_SUT_START:-false}" != "true" ]; then
    if curl -s --max-time 3 "$OPENAPI_URL" > /dev/null 2>&1; then
        log_line "SUT ya esta arriba."
    else
        log_line "Iniciando SUT via setup/run_sut.sh..."
        bash "$PROJECT_ROOT/setup/run_sut.sh"
        STARTED_SUT=true
    fi
else
    log_line "SKIP_SUT_START=true, no se inicia SUT."
fi

# Esperar a que OpenAPI responda
for _ in $(seq 1 20); do
    if curl -s --max-time 3 "$OPENAPI_URL" > /dev/null 2>&1; then
        break
    fi
    sleep 2
done

log_line ""
log_line "Checks ejecutados:"

# Check 1: OpenAPI accesible
openapi_code=$(curl -s -o "$OPENAPI_JSON" -w "%{http_code}" "$OPENAPI_URL" || echo "000")
echo "$openapi_code" > "$OPENAPI_HTTP"

if [ "$openapi_code" = "200" ] && grep -q '"openapi"' "$OPENAPI_JSON"; then
    record_check "Check 1 - OpenAPI" "PASS" "HTTP 200 y contrato presente"
else
    record_check "Check 1 - OpenAPI" "FAIL" "HTTP $openapi_code o contrato ausente"
fi

# Check 2: Listado de articulos (endpoint publico)
articles_code=$(curl -s -o "$ARTICLES_LIST_BODY" -w "%{http_code}" "http://localhost:8000/api/articles" || echo "000")
echo "$articles_code" > "$ARTICLES_LIST_HTTP"

if [ "$articles_code" = "200" ] && grep -q '"articles"' "$ARTICLES_LIST_BODY"; then
    record_check "Check 2 - Listado de articulos" "PASS" "HTTP 200 y clave articles"
else
    record_check "Check 2 - Listado de articulos" "FAIL" "HTTP $articles_code o clave ausente"
fi

# Check 3: Casos sistematicos EP+BVA (subset)
SYSTEMATIC_PASS=0
SYSTEMATIC_FAIL=0

cat > "$SYSTEMATIC_CSV" <<EOF
case_id,slug,expected,actual,result
EOF

run_case() {
    local case_id="$1"
    local slug="$2"
    local expected="$3"

    local http_code
    http_code=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:8000/api/articles/$slug" || echo "000")

    local result="FAIL"
    if [ "$expected" = "200" ] && [ "$http_code" = "200" ]; then
        result="PASS"
    elif [ "$expected" = "404" ] && [ "$http_code" = "404" ]; then
        result="PASS"
    elif [ "$expected" = "404|422" ] && { [ "$http_code" = "404" ] || [ "$http_code" = "422" ]; }; then
        result="PASS"
    fi

    if [ "$result" = "PASS" ]; then
        SYSTEMATIC_PASS=$((SYSTEMATIC_PASS + 1))
    else
        SYSTEMATIC_FAIL=$((SYSTEMATIC_FAIL + 1))
    fi

    echo "$case_id,$slug,$expected,$http_code,$result" >> "$SYSTEMATIC_CSV"
}

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
run_case "TC-02" "non-existent-${TIMESTAMP}" "404"
run_case "TC-04" "invalid%20slug" "404|422"
LONG_SLUG=$(printf 'a%.0s' {1..255})
run_case "TC-06" "$LONG_SLUG" "404|422"

cat > "$SYSTEMATIC_SUMMARY" <<EOF
Systematic Cases Summary (Week 5 Gate)
======================================
Date: $(date "+%Y-%m-%d %H:%M:%S")
Total: $((SYSTEMATIC_PASS + SYSTEMATIC_FAIL))
PASS:  $SYSTEMATIC_PASS
FAIL:  $SYSTEMATIC_FAIL
Evidence: $SYSTEMATIC_CSV
EOF

if [ "$SYSTEMATIC_FAIL" -eq 0 ]; then
    record_check "Check 3 - Casos sistematicos" "PASS" "$SYSTEMATIC_PASS/$((SYSTEMATIC_PASS + SYSTEMATIC_FAIL)) casos"
else
    record_check "Check 3 - Casos sistematicos" "FAIL" "$SYSTEMATIC_FAIL fallas"
fi

cat > "$SUMMARY" <<EOF
Quality Gate Summary
====================
Date: $(date "+%Y-%m-%d %H:%M:%S")

Checks:
- Total: $TOTAL_CHECKS
- PASS:  $PASSED_CHECKS
- FAIL:  $FAILED_CHECKS

Evidence Directory: $EVIDENCE_DIR
EOF

log_line ""
log_line "Resumen final: PASS=$PASSED_CHECKS FAIL=$FAILED_CHECKS"
log_line "SUMMARY: $SUMMARY"

if [ "$FAILED_CHECKS" -gt 0 ]; then
    exit 1
fi
