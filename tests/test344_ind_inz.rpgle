**FREE
// INZ on an indicator: *ON, *OFF, '1' and '0', on a field, an array and
// a subfield, and RESET back to it.
DCL-S flag IND INZ(*ON);
DCL-S off IND INZ(*OFF);
DCL-S c1 IND INZ('1');
DCL-S c0 IND INZ('0');
DCL-S arr IND DIM(3) INZ(*ON);
DCL-DS ds QUALIFIED;
  f IND INZ(*ON);
END-DS;
IF flag;
  DSPLY 'flag on';
ENDIF;
IF NOT off;
  DSPLY 'off off';
ENDIF;
IF c1 AND NOT c0;
  DSPLY 'char inz ok';
ENDIF;
IF arr(2);
  DSPLY 'arr on';
ENDIF;
IF ds.f;
  DSPLY 'ds.f on';
ENDIF;
flag = *OFF;
RESET flag;
IF flag;
  DSPLY 'reset on';
ENDIF;
*INLR = *ON;
RETURN;
