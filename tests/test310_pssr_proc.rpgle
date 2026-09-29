**FREE
// A *PSSR in a procedure, run because of an error, that reaches ENDSR:
// the procedure ends in error, and its caller sees that error.
CTL-OPT DFTACTGRP(*NO);
DCL-S line VARCHAR(52);

MONITOR;
  divide();
  DSPLY 'WRONG: divide returned normally';
ON-ERROR;
  line = 'CALLER status ' + %CHAR(%STATUS);
  DSPLY line;
ENDMON;
DSPLY 'CALLER continues';
*INLR = *ON;

DCL-PROC divide;
  DCL-S a INT(10) INZ(0);
  DCL-S b INT(10);
  b = 10 / a;
  DSPLY 'WRONG: after the error';
  RETURN;
  BEGSR *PSSR;
    DSPLY 'PSSR in divide';
  ENDSR;
END-PROC;
