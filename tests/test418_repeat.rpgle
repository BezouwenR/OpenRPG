**FREE
// %REPEAT(string : count), an OpenRPG extension: the string count times
// over, as SQL's REPEAT; 0 times is empty, and a negative count status 100.
DCL-S line VARCHAR(40);
DCL-S n INT(10) INZ(3);
DCL-S c CHAR(2) INZ('ab');
line = %REPEAT('-' : 20);
DSPLY line;
DSPLY ('[' + %REPEAT('ab' : n) + ']');
DSPLY ('[' + %REPEAT(c : 2) + ']');
DSPLY ('[' + %REPEAT('x' : 0) + ']');
DSPLY %CHAR(%LEN(%REPEAT(' ' : 7)));
n = -1;
MONITOR;
  line = %REPEAT('x' : n);
ON-ERROR;
  DSPLY ('status ' + %CHAR(%STATUS));
ENDMON;
*INLR = *ON;
RETURN;
