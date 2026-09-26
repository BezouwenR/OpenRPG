**FREE
// ON-ERROR lists the errors it handles: status codes, named constants,
// *PROGRAM (status 100-999), *FILE (1000-9999) or *ALL; none means *ALL.
// The first clause that lists the error handles it. An error no clause
// lists is not handled by that MONITOR: it goes on up, here to an
// enclosing one.
DCL-C DIVZERO 102;
DCL-S a INT(10) INZ(0);
DCL-S b INT(10);
DCL-S arr INT(10) DIM(3);
DCL-S i INT(10) INZ(4);
DCL-S d DATE;
DCL-S line VARCHAR(52);

MONITOR;
  b = 10 / a;
ON-ERROR 121;
  DSPLY 'WRONG: 121 clause';
ON-ERROR 102;
  DSPLY 'RESULT:CODE=102';
ENDMON;

MONITOR;
  b = 10 / a;
ON-ERROR 121 : DIVZERO;
  DSPLY 'RESULT:CONST=DIVZERO';
ENDMON;

MONITOR;
  b = arr(i);
ON-ERROR *FILE;
  DSPLY 'WRONG: *FILE clause';
ON-ERROR *PROGRAM;
  line = 'RESULT:PROGRAM=' + %CHAR(%STATUS);
  DSPLY line;
ENDMON;

MONITOR;
  MONITOR;
    d = %DATE('2026-13-45');
  ON-ERROR 102;
    DSPLY 'WRONG: inner clause';
  ENDMON;
  DSPLY 'WRONG: continued after the inner MONITOR';
ON-ERROR;
  line = 'RESULT:OUTER=' + %CHAR(%STATUS);
  DSPLY line;
ENDMON;

MONITOR;
  b = arr(i);
ON-ERROR 102 : *FILE;
  DSPLY 'WRONG: first clause';
ON-ERROR *ALL;
  DSPLY 'RESULT:ALL';
ENDMON;
*INLR = *ON;
