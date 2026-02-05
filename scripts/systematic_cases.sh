#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:8000}"
API_PREFIX="${API_PREFIX:-/api}"
ENDPOINT="${ENDPOINT:-/articles}"
OUT_DIR="evidence/week4"
CASES_DIR="$OUT_DIR/cases"

mkdir -p "$CASES_DIR"

RUNLOG="$OUT_DIR/RUNLOG.md"
SUMMARY="$OUT_DIR/summary.txt"

TIMESTAMP_UTC="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
CMDLINE="BASE_URL=$BASE_URL API_PREFIX=$API_PREFIX ENDPOINT=$ENDPOINT $0 $*"

cat > "$RUNLOG" <<EOF
# RUNLOG Week 4

- timestamp_utc: $TIMESTAMP_UTC
- command: $CMDLINE
- endpoint: ${BASE_URL}${API_PREFIX}${ENDPOINT}
- oraculos_minimos: OR-1, OR-2
- oraculos_estrictos: OR-3, OR-4, OR-5, OR-6, OR-7
EOF

PASS_COUNT=0
FAIL_COUNT=0

declare -a CASES=(
  "TC-01||200|20|||OR-1,OR-3,OR-4,OR-5"
  "TC-02|limit=1|200|1|||OR-1,OR-3,OR-4,OR-5"
  "TC-03|limit=20|200|20|||OR-1,OR-3,OR-4,OR-5"
  "TC-04|limit=21|200|21|||OR-1,OR-3,OR-4,OR-5"
  "TC-05|limit=0|422||||OR-2"
  "TC-06|limit=-1|422||||OR-2"
  "TC-07|limit=abc|422||||OR-2"
  "TC-08|offset=0|200||||OR-1,OR-3,OR-4"
  "TC-09|offset=1|200||||OR-1,OR-3,OR-4"
  "TC-10|offset=-1|422||||OR-2"
  "TC-11|offset=abc|422||||OR-2"
  "TC-12|tag=qa-tag|200||qa-tag||OR-1,OR-3,OR-4,OR-6"
  "TC-13|author=qa-user|200|||qa-user|OR-1,OR-3,OR-4,OR-7"
)

for entry in "${CASES[@]}"; do
  IFS='|' read -r ID QUERY EXPECTED_STATUS LIMIT TAG AUTHOR ORACLES <<< "$entry"

  if [[ -n "$QUERY" ]]; then
    URL="${BASE_URL}${API_PREFIX}${ENDPOINT}?${QUERY}"
  else
    URL="${BASE_URL}${API_PREFIX}${ENDPOINT}"
  fi

  BODY_FILE="$CASES_DIR/${ID}.json"
  META_FILE="$CASES_DIR/${ID}.meta.txt"

  HTTP_STATUS=$(curl -s -o "$BODY_FILE" -w "%{http_code}" "$URL" || true)

  RESULT="PASS"
  REASON=""

  if [[ "$HTTP_STATUS" != "$EXPECTED_STATUS" ]]; then
    RESULT="FAIL"
    REASON="expected_status=$EXPECTED_STATUS actual_status=$HTTP_STATUS"
  else
    if [[ "$HTTP_STATUS" == "200" ]]; then
      PY_RESULT=$(python - "$BODY_FILE" "$LIMIT" "$TAG" "$AUTHOR" <<'PY'
import json
import sys

body_file = sys.argv[1]
limit = sys.argv[2].strip() if len(sys.argv) > 2 else ""
tag = sys.argv[3].strip() if len(sys.argv) > 3 else ""
author = sys.argv[4].strip() if len(sys.argv) > 4 else ""

try:
    with open(body_file, "r", encoding="utf-8") as f:
        data = json.load(f)
except Exception as exc:
    print(f"FAIL: invalid_json {exc}")
    sys.exit(0)

if not isinstance(data, dict):
    print("FAIL: response_not_object")
    sys.exit(0)

if "articles" not in data or "articlesCount" not in data:
    print("FAIL: missing_keys")
    sys.exit(0)

articles = data["articles"]
count = data["articlesCount"]

if not isinstance(articles, list):
    print("FAIL: articles_not_list")
    sys.exit(0)

if not isinstance(count, int) or count < 0:
    print("FAIL: articlesCount_invalid")
    sys.exit(0)

if count != len(articles):
    print("FAIL: count_mismatch")
    sys.exit(0)

if limit:
    try:
        lim = int(limit)
        if len(articles) > lim:
            print("FAIL: limit_exceeded")
            sys.exit(0)
    except Exception:
        pass

if tag and len(articles) > 0:
    for art in articles:
        tags = art.get("tagList", [])
        if tag not in tags:
            print("FAIL: tag_filter_violation")
            sys.exit(0)

if author and len(articles) > 0:
    for art in articles:
        auth = art.get("author", {})
        if auth.get("username") != author:
            print("FAIL: author_filter_violation")
            sys.exit(0)

print("PASS")
PY
)
      if [[ "$PY_RESULT" != "PASS" ]]; then
        RESULT="FAIL"
        REASON="$PY_RESULT"
      fi
    fi
  fi

  if [[ "$RESULT" == "PASS" ]]; then
    PASS_COUNT=$((PASS_COUNT+1))
  else
    FAIL_COUNT=$((FAIL_COUNT+1))
  fi

  cat > "$META_FILE" <<EOF
id: $ID
url: $URL
expected_status: $EXPECTED_STATUS
actual_status: $HTTP_STATUS
oracles: $ORACLES
result: $RESULT
reason: $REASON
EOF

done

cat > "$SUMMARY" <<EOF
summary
pass: $PASS_COUNT
fail: $FAIL_COUNT
EOF

printf "Done. Pass=%s Fail=%s\n" "$PASS_COUNT" "$FAIL_COUNT"
