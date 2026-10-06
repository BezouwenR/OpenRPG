**FREE
// %SCANRPL's start and length: only the portion of the source they give is
// scanned, and the rest is kept as it is. A portion outside the source is
// status 100.
DCL-S s VARCHAR(30) INZ('a-b-c-d-e');
DCL-S r VARCHAR(40);
DCL-S st INT(10) INZ(20);
r = %SCANRPL('-' : '+' : s);
DSPLY r;
r = %SCANRPL('-' : '+' : s : 4);
DSPLY r;
r = %SCANRPL('-' : '+' : s : 3 : 4);
DSPLY r;
r = %SCANRPL('-' : '' : s : 1 : 3);
DSPLY r;
r = %SCANRPL('-' : '<->' : s : 6);
DSPLY r;
MONITOR;
  r = %SCANRPL('-' : '+' : s : st);
ON-ERROR;
  DSPLY ('status ' + %CHAR(%STATUS));
ENDMON;
*INLR = *ON;
RETURN;
