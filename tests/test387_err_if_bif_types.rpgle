**FREE
// The values of %IF must be of the same type.
DCL-S c VARCHAR(10);
DCL-S n INT(10) INZ(1);
c = %IF(n > 0 : 'yes' : 0);
*INLR = *ON;
RETURN;
