**FREE
// The called program need not be RPG: CSQUARE is C (tests/CSQUARE.c),
// built as a shared library, which takes its parameters in IBM i's
// formats like any called program.
DCL-PR cSquare EXTPGM('CSQUARE');
  n INT(10);
  text CHAR(12);
  amount PACKED(5:2);
END-PR;
DCL-S n INT(10) INZ(12);
DCL-S text CHAR(12) INZ('from RPG');
DCL-S amount PACKED(5:2) INZ(123.45);
cSquare(n : text : amount);
DSPLY (%CHAR(n) + ' [' + text + '] ' + %CHAR(amount));
*INLR = *ON;
RETURN;
