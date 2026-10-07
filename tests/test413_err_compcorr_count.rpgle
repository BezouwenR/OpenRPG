**FREE
// %COMPCORR cannot compare more subfields than correspond.
DCL-DS a QUALIFIED;
  f CHAR(5);
  g INT(10);
END-DS;
DCL-DS b QUALIFIED;
  f CHAR(5);
END-DS;
IF %COMPCORR(a : b : 2);
  DSPLY 'x';
ENDIF;
*INLR = *ON;
RETURN;
