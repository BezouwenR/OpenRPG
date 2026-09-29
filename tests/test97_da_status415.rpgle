**FREE
// Test 97: Data area status 415 - file exists but cannot be read
// (Test runner sets up the file with chmod 000 before running this.) The
// (E) extender turns the error into a status to test: without it, as on
// IBM i, the error would end the program.
DCL-S da CHAR(10) DTAARA('RPGCT97DA');

IN(E) da;
IF %STATUS() = 415;
  DSPLY 'STATUS 415 OK';
ELSE;
  DSPLY 'STATUS 415 FAIL';
ENDIF;

*INLR = *ON;
