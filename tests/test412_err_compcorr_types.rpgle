**FREE
// %COMPCORR compares corresponding subfields of compatible types.
DCL-DS a QUALIFIED;
  f CHAR(5);
END-DS;
DCL-DS b QUALIFIED;
  f INT(10);
END-DS;
IF %COMPCORR(a : b);
  DSPLY 'x';
ENDIF;
*INLR = *ON;
RETURN;
