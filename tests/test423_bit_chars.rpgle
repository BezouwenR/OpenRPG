**FREE
// %BITAND, %BITOR, %BITXOR and %BITNOT of character operands work on their
// bytes, as on IBM i: the result as long as the longest operand, a shorter
// one padded with X'FF' for %BITAND and X'00' for %BITOR; and more than two
// operands.
DCL-S r VARCHAR(4);
r = %BITAND(X'F0F0' : X'3C3C');
IF r = X'3030';
  DSPLY 'and ok';
ENDIF;
r = %BITOR(X'F000' : X'0F0F');
IF r = X'FF0F';
  DSPLY 'or ok';
ENDIF;
r = %BITXOR(X'FFFF' : X'0F0F');
IF r = X'F0F0';
  DSPLY 'xor ok';
ENDIF;
r = %BITNOT(X'0F');
IF r = X'F0';
  DSPLY 'not ok';
ENDIF;
r = %BITAND(X'FFFF' : X'0F');
DSPLY ('and len ' + %CHAR(%LEN(r)));
IF r = X'0FFF';
  DSPLY 'and pads X''FF''';
ELSEIF r = X'0F00';
  DSPLY 'and pads X''00''';
ELSEIF r = X'0F';
  DSPLY 'and is short';
ENDIF;
r = %BITOR(X'0000' : X'F0');
DSPLY ('or len ' + %CHAR(%LEN(r)));
IF r = X'F000';
  DSPLY 'or pads X''00''';
ELSEIF r = X'F0FF';
  DSPLY 'or pads X''FF''';
ELSEIF r = X'F0';
  DSPLY 'or is short';
ENDIF;
r = %BITAND(X'FF' : X'F0' : X'3C');
IF r = X'30';
  DSPLY 'three ok';
ENDIF;
*INLR = *ON;
RETURN;
