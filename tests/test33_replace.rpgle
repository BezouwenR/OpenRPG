**FREE
// %REPLACE(replacement : source {: start {: length}}): `length` characters
// of the source, from `start`, give way to the replacement. The start
// defaults to 1 and the length to the replacement's own length, cut off at
// the end of the source -- so without a length it replaces, it does not
// insert. A length of 0 inserts. A start outside the source, or a length
// given that runs past its end, is an error (status 100). Brackets show
// trailing blanks.
DCL-S str VARCHAR(50);
DCL-S result VARCHAR(50);

str = 'Hello World';

result = %REPLACE('RPG' : str : 7 : 5);
DSPLY ('[' + result + ']');

// No length: as many characters as the replacement has, to the end at most.
result = %REPLACE('Beautiful ' : str : 7);
DSPLY ('[' + result + ']');

result = %REPLACE('Goodbye' : str : 1 : 5);
DSPLY ('[' + result + ']');

// A length of 0 inserts.
result = %REPLACE('Big ' : str : 7 : 0);
DSPLY ('[' + result + ']');

// No start: from position 1.
result = %REPLACE('J' : str);
DSPLY ('[' + result + ']');

// Just past the end appends.
result = %REPLACE('!' : str : 12 : 0);
DSPLY ('[' + result + ']');

// A length given that runs past the end is an error.
MONITOR;
  result = %REPLACE('Earth' : str : 7 : 20);
  DSPLY ('[' + result + ']');
ON-ERROR;
  DSPLY ('status ' + %CHAR(%STATUS));
ENDMON;

// A start beyond the source is an error.
MONITOR;
  result = %REPLACE('x' : str : 13);
  DSPLY ('[' + result + ']');
ON-ERROR;
  DSPLY ('status ' + %CHAR(%STATUS));
ENDMON;

*INLR = *ON;
