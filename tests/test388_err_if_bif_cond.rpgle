**FREE
// The first operand of %IF must be a condition.
DCL-S n INT(10) INZ(1);
n = %IF(n : 1 : 2);
*INLR = *ON;
RETURN;
