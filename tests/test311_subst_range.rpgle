**FREE
// %SUBST(string : start {: length}): a start outside the string, or a length
// that runs past its end, is an error (status 100), not a shorter result.
// The start and length are variables, so the compiler cannot check them.
DCL-S src VARCHAR(10) INZ('ABCDE');
DCL-S st INT(10);
DCL-S ln INT(10);
DCL-S line VARCHAR(52);

st = 2;
ln = 3;
line = '[' + %SUBST(src : st : ln) + ']';
st = 3;
line += ' [' + %SUBST(src : st) + ']';
st = 5;
ln = 1;
line += ' [' + %SUBST(src : st : ln) + ']';
st = 2;
ln = 0;
line += ' [' + %SUBST(src : st : ln) + ']';
DSPLY line;

st = 6;
MONITOR;
  line = 'START6 [' + %SUBST(src : st) + ']';
ON-ERROR;
  line = 'START6 status ' + %CHAR(%STATUS);
ENDMON;
DSPLY line;

st = 6;
ln = 0;
MONITOR;
  line = 'START6 LEN0 [' + %SUBST(src : st : ln) + ']';
ON-ERROR;
  line = 'START6 LEN0 status ' + %CHAR(%STATUS);
ENDMON;
DSPLY line;

st = 4;
ln = 3;
MONITOR;
  line = 'PAST END [' + %SUBST(src : st : ln) + ']';
ON-ERROR;
  line = 'PAST END status ' + %CHAR(%STATUS);
ENDMON;
DSPLY line;

st = 0;
ln = 1;
MONITOR;
  line = 'START0 [' + %SUBST(src : st : ln) + ']';
ON-ERROR;
  line = 'START0 status ' + %CHAR(%STATUS);
ENDMON;
DSPLY line;

*INLR = *ON;
