# RUNLOG - Evidencia Semana 3

## 2026-01-28

### Comando: curl -w "@curl-format.txt" -o /dev/null -s http://localhost:8000/api/articles > evidence/week3/api_down.log
- Riesgo: Disponibilidad (R1), Escenario: Q1, Oráculo: HTTP 200 en <1s

### Comando: curl -X POST http://localhost:8000/api/articles -H "Content-Type: application/json" -d '{"title":123}' -i > evidence/week3/robustness.log
- Riesgo: Robustez (R2), Escenario: Q2, Oráculo: Error controlado

### Comando: ab -n 100 -c 10 http://localhost:8000/api/articles > evidence/week3/latency.log
- Riesgo: Latencia (R3), Escenario: Q3, Oráculo: 95% <1s
