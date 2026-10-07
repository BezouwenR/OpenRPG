**FREE
// Binary literals, an OpenRPG extension: B'10100001' is X'A1' -- eight
// binary digits to each byte -- in comparisons, assignments and %BITAND.
DCL-S c CHAR(2);
DCL-S flags CHAR(1) INZ(X'A5');
IF B'10100001' = X'A1';
  DSPLY 'B = X';
ENDIF;
IF b'0100000101000010' = 'AB';
  DSPLY 'two bytes';
ENDIF;
c = B'0100100001001001';
DSPLY c;
DSPLY %CHAR(%LEN(B'00000000'));
IF %BITAND(flags : B'00001111') = X'05';
  DSPLY 'mask ok';
ENDIF;
*INLR = *ON;
RETURN;
