**FREE
// An indicator is character data, '1' or '0': concatenated, assigned to
// and from a character field, and compared with one -- a field, an array
// element, a subfield and *INnn.
DCL-S flag IND INZ(*ON);
DCL-S c1 CHAR(1);
DCL-S c5 CHAR(5);
DCL-S arr IND DIM(3) INZ(*ON);
DCL-DS ds QUALIFIED;
  f IND INZ(*ON);
END-DS;
DSPLY ('flag=' + flag);
DSPLY (flag + '=flag');
c1 = flag;
DSPLY c1;
IF flag = '1';
  DSPLY 'eq';
ENDIF;
IF '0' <> flag;
  DSPLY 'ne';
ENDIF;
IF c1 = flag;
  DSPLY 'c1';
ENDIF;
flag = '0';
DSPLY ('now ' + flag);
*IN50 = *ON;
c5 = *IN50;
DSPLY ('[' + c5 + ']');
DSPLY ('arr=' + arr(2) + ' ds.f=' + ds.f + ' in50=' + *IN50 + ' lr=' + *INLR);
arr(1) = '0';
IF arr(1) = '0' AND *IN50 = '1';
  DSPLY 'ok';
ENDIF;
*INLR = *ON;
RETURN;
