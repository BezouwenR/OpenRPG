**FREE
// FOR-EACH INDEX needs a numeric field.
DCL-S a INT(10) DIM(2);
DCL-S x INT(10);
DCL-S c CHAR(1);
FOR-EACH x IN a INDEX(c);
ENDFOR;
*INLR = *ON;
RETURN;
