#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

EVIDENCE_DIR="$PROJECT_ROOT/evidence/week6"
BEFORE_DIR="$EVIDENCE_DIR/before"
AFTER_DIR="$EVIDENCE_DIR/after"
RUNLOG="$EVIDENCE_DIR/RUNLOG.md"
SUMMARY="$EVIDENCE_DIR/summary.txt"
GATE_SCRIPT="$PROJECT_ROOT/ci/run_quality_gate.sh"

export GATE_PROJECT_ROOT="$PROJECT_ROOT"

rm -rf "$BEFORE_DIR" "$AFTER_DIR"
mkdir -p "$BEFORE_DIR" "$AFTER_DIR"

log_line() {
    echo "$1" | tee -a "$RUNLOG"
}

run_gate_variant() {
    local label="$1"
    local gate_path="$2"
    local dest_dir="$3"

    log_line ""
    log_line "[$label] Ejecutando gate: $gate_path"

    if bash "$gate_path" > "$dest_dir/gate_stdout.log" 2>&1; then
        echo "PASS" > "$dest_dir/gate_exit.txt"
    else
        echo "FAIL" > "$dest_dir/gate_exit.txt"
    fi

    mkdir -p "$dest_dir/evidence_week6"
    if [ -d "$PROJECT_ROOT/evidence/week6" ]; then
        cp -R "$PROJECT_ROOT/evidence/week6/." "$dest_dir/evidence_week6/" || true
    fi
}

cat > "$RUNLOG" <<EOF
# RUNLOG - Semana 6: Gaming Drill

Fecha/hora: $(date "+%Y-%m-%d %H:%M:%S")
Comando: bash ci/run_gate_gaming_drill.sh
Tactica: reducir casos del Check 3 sin declararlo

EOF

TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

# BEFORE: gate vulnerable (sin defensa) + casos reducidos
BEFORE_GATE="$TMP_DIR/gate_before.sh"
cp "$GATE_SCRIPT" "$BEFORE_GATE"

sed -i.bak '/run_case "TC-04"/d' "$BEFORE_GATE"
sed -i.bak '/run_case "TC-06"/d' "$BEFORE_GATE"
sed -i.bak '/ANTI_GAMING_START/,/ANTI_GAMING_END/d' "$BEFORE_GATE"
sed -i.bak '/ANTI_GAMING_ENFORCE_START/,/ANTI_GAMING_ENFORCE_END/d' "$BEFORE_GATE"
rm -f "$BEFORE_GATE.bak"

log_line "[before] Se removieron TC-04 y TC-06 y se desactivo la defensa." 
run_gate_variant "before" "$BEFORE_GATE" "$BEFORE_DIR"

# AFTER: gate endurecido + misma tactica de reduccion
AFTER_GATE="$TMP_DIR/gate_after.sh"
cp "$GATE_SCRIPT" "$AFTER_GATE"

sed -i.bak '/run_case "TC-04"/d' "$AFTER_GATE"
sed -i.bak '/run_case "TC-06"/d' "$AFTER_GATE"
rm -f "$AFTER_GATE.bak"

log_line "[after] Se removieron TC-04 y TC-06, defensa activa." 
run_gate_variant "after" "$AFTER_GATE" "$AFTER_DIR"

before_result=$(cat "$BEFORE_DIR/gate_exit.txt" 2>/dev/null || echo "NA")
after_result=$(cat "$AFTER_DIR/gate_exit.txt" 2>/dev/null || echo "NA")

cat > "$SUMMARY" <<EOF
Gaming Drill Summary
====================
Date: $(date "+%Y-%m-%d %H:%M:%S")
Tactica: reducir casos del Check 3
Before: $before_result
After:  $after_result
Evidence: $EVIDENCE_DIR/{before,after}
EOF

log_line ""
log_line "Resumen: before=$before_result, after=$after_result"
log_line "SUMMARY: $SUMMARY"
