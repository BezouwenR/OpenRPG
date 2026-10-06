**FREE
// %SCANRPL with an empty scan string is status 100.
DCL-S s VARCHAR(10) INZ('abc');
DCL-S e VARCHAR(5);
DCL-S r VARCHAR(20);
MONITOR;
  r = %SCANRPL(e : 'x' : s);
  DSPLY ('[' + r + ']');
ON-ERROR;
  DSPLY ('status ' + %CHAR(%STATUS));
ENDMON;
*INLR = *ON;
RETURN;
