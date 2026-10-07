**FREE
// WHEN-IS-NOT and WHEN-NOT-IN in a SELECT with an operand, OpenRPG
// extensions: taken when the operand is not equal to the value, or not in
// the list or range.
DCL-S status CHAR(1);
DCL-S i INT(10);
FOR i = 1 TO 3;
  status = %SUBST('AXZ' : i : 1);
  SELECT status;
  WHEN-IS 'A';
    DSPLY 'active';
  WHEN-NOT-IN %LIST('X' : 'Y');
    DSPLY (status + ': neither active nor X/Y');
  WHEN-IS-NOT 'Q';
    DSPLY (status + ': not Q');
  ENDSL;
ENDFOR;
*INLR = *ON;
RETURN;
