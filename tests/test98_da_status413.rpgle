**FREE
// Test 98: Data area status 413 - cannot write to data area
// (Test runner creates a read-only file with chmod 444 before running this.)
// OUT needs the data area locked first (IN *LOCK); (E) turns the error into
// a status to test, where without it the error would end the program.
DCL-S da CHAR(10) DTAARA('RPGCT98DA');

IN(E) *LOCK da;
da = 'TEST DATA ';
OUT(E) da;
IF %STATUS() = 413;
  DSPLY 'STATUS 413 OK';
ELSE;
  DSPLY 'STATUS 413 FAIL';
ENDIF;

*INLR = *ON;
