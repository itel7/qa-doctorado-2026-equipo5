# Gaming Drill - Semana 6

## Tactica elegida
Reducir el conjunto de casos sistematicos en el Check 3 para que el gate pase con
menos evidencia de lo declarado.

## Check afectado
Check 3 - Casos sistematicos EP+BVA (subset)

## Por que haria pasar sin mejorar calidad
Si se ejecuta solo 1 caso (por ejemplo TC-02) y se omiten TC-04 y TC-06, el gate
puede reportar 1/1 PASS aunque la cobertura real sea menor. La calidad no mejora,
pero el gate "pasa" con evidencia incompleta.

## Defensa aplicada
Se agrega un minimo obligatorio de casos sistematicos (MIN_SYSTEMATIC_CASES=3).
Si el total ejecutado es menor, el gate falla y registra posible gaming.

## Como mitiga el gaming
La reduccion silenciosa de casos queda detectada por el conteo minimo. El gate
falla aun cuando los casos ejecutados pasen, bloqueando el intento de gaming.
