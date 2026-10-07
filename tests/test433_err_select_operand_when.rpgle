**FREE
// A SELECT with an operand takes WHEN-IS and WHEN-IN, not WHEN.
DCL-S n INT(10);
SELECT n;
WHEN n = 1;
  DSPLY 'x';
ENDSL;
*INLR = *ON;
RETURN;
