**FREE
// Test 96: Data area status 401 - data area not found. Without (E) or a
// MONITOR the error ends the program, as on IBM i.
DCL-S missing CHAR(10) DTAARA('NOSUCHDA96');
DCL-S line VARCHAR(52);

IN(E) missing;
line = 'IN(E) error ' + %CHAR(%ERROR) + ' status ' + %CHAR(%STATUS);
DSPLY line;

MONITOR;
  IN missing;
  DSPLY 'FOUND';
ON-ERROR;
  DSPLY ('MONITOR status ' + %CHAR(%STATUS));
ENDMON;

*INLR = *ON;
