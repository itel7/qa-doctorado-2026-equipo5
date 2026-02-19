# Gate Change Log

## 2026-02-18
- Cambio: Se agrega MIN_SYSTEMATIC_CASES y verificacion de conteo en el Check 3.
- Motivo: Detectar reduccion silenciosa de casos (gaming) en el subset sistematico.
- Impacto: El gate falla si ejecuta menos de 3 casos, aun si todos pasan.
