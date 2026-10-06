**FREE
// *TRUE and *FALSE, an OpenRPG extension: other names for *ON and *OFF --
// as an initial value, assigned, compared, and returned.
DCL-S done IND INZ(*TRUE);
DCL-S failed IND INZ(*FALSE);
IF done = *TRUE AND failed = *FALSE;
  DSPLY 'true and false';
ENDIF;
done = *FALSE;
IF NOT done;
  DSPLY 'done is off';
ENDIF;
IF isEven(4) = *ON AND isEven(3) = *FALSE;
  DSPLY 'isEven works';
ENDIF;
*INLR = *TRUE;
RETURN;

DCL-PROC isEven;
  DCL-PI *N IND;
    n INT(10) VALUE;
  END-PI;
  IF %REM(n : 2) = 0;
    RETURN *TRUE;
  ENDIF;
  RETURN *FALSE;
END-PROC;
