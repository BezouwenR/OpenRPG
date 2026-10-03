**FREE
// %INT, %DEC, %FLOAT and the rest take a character operand: optional sign
// before or after, a period or comma as decimal point, blanks anywhere.
// Invalid data is status 105.
DCL-S s VARCHAR(20) INZ('42');
DCL-S n INT(10);
DCL-S p PACKED(9:2);
DCL-S f FLOAT(8);

n = %INT(s);
DSPLY %CHAR(n);
n = %DEC(s:9:0);
DSPLY %CHAR(n);
p = %DEC(' -12.345 ':9:2);
DSPLY %CHAR(p);
p = %DECH('12,345-':9:2);
DSPLY %CHAR(p);
n = %INT('+ 7.9');
DSPLY %CHAR(n);
n = %INTH('7.5');
DSPLY %CHAR(n);
n = %UNS('19');
DSPLY %CHAR(n);
f = %FLOAT('1.5E2');
DSPLY %CHAR(%INT(f));

MONITOR;
  n = %INT('12A');
  DSPLY 'not reached';
ON-ERROR 105;
  DSPLY ('status ' + %CHAR(%STATUS));
ENDMON;
MONITOR;
  p = %DEC('1.2E3':9:2);
  DSPLY 'not reached';
ON-ERROR 105;
  DSPLY 'no exponent in %DEC';
ENDMON;
*INLR = *ON;
RETURN;
