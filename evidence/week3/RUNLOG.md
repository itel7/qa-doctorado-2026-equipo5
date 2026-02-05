# RUNLOG - Evidencia Semana 3

## 2026-01-31 16:43

### Test 1: Disponibilidad (R1) - Escenario Q1
**Comando ejecutado:**
curl -w "@curl-format.txt" -o /dev/null -s http://localhost:8000/api/articles > evidence/week3/api_down.log

**Oráculo aplicado:** HTTP 200 en <1s
**Resultado esperado:** PASS si responde 200 y tiempo <1s
**Evidencia:** evidence/week3/api_down.log

**Resultado:** ✅ PASS
- HTTP Code: 200 ✓
- Tiempo respuesta: 34.641ms ✓ (< 1000ms)

---

### Test 2: Robustez (R2) - Escenario Q2
**Comando ejecutado:**
curl -X POST http://localhost:8000/api/articles -H "Content-Type: application/json" -d '{"title":123}' -i > evidence/week3/robustness.log

**Oráculo aplicado:** Error controlado (4xx/5xx) sin caída del servicio
**Resultado esperado:** PASS si responde error controlado
**Evidencia:** evidence/week3/robustness.log

**Resultado:** ✅ PASS
- HTTP Code: 403 Forbidden (error controlado) ✓
- Mensaje: "authentication required" ✓
- Sin crash del servidor ✓

---

### Test 3: Latencia (R3) - Escenario Q3
**Comando ejecutado:**
ab -n 100 -c 10 http://localhost:8000/api/articles > evidence/week3/latency.log

**Oráculo aplicado:** p95 < 1s
**Resultado esperado:** PASS si p95 < 1s
**Evidencia:** evidence/week3/latency.log

**Resultado:** ✅ PASS
- Tiempo p95: 59ms ✓ (< 1000ms)
- Tiempo p99: 65ms ✓ (< 1000ms)
- Requests: 100/100 completadas ✓
- Failed requests: 0 ✓
- Throughput: 199.79 req/s ✓

---

## Resumen
✅ 3/3 tests PASS - Todos los riesgos Top 3 tienen evidencia de mitigation.
