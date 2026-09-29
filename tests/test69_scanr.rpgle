**FREE
// %SCAN and %SCANR search a portion of the source: from `start` (default
// 1) for `length` characters (default: to the end). A match must lie
// wholly inside the portion. %SCAN returns the first, %SCANR the last,
// numbered from the start of the whole source; 0 if none. So a start does
// not end a %SCANR search: it is where the searched portion begins.
DCL-S text VARCHAR(50);
DCL-S line VARCHAR(52);
DCL-S empty VARCHAR(10);

text = 'Hello World Hello';

line = %CHAR(%SCANR('Hello' : text)) + ' ' + %CHAR(%SCANR('o' : text)) + ' ' +
       %CHAR(%SCANR('xyz' : text));
DSPLY line;

// A start begins the searched portion.
line = %CHAR(%SCANR('Hello' : text : 10)) + ' ' +
       %CHAR(%SCANR('Hello' : text : 14)) + ' ' +
       %CHAR(%SCAN('Hello' : text : 2));
DSPLY line;

// A length ends it; a match must fit inside.
line = %CHAR(%SCANR('Hello' : text : 1 : 10)) + ' ' +
       %CHAR(%SCANR('o' : text : 1 : 10)) + ' ' +
       %CHAR(%SCANR('Hello' : text : 1 : 16)) + ' ' +
       %CHAR(%SCAN('World' : text : 1 : 10)) + ' ' +
       %CHAR(%SCAN('o' : text : 6 : 5));
DSPLY line;

// A start just past the end, one beyond that, and a length past the end.
MONITOR;
  line = 'END ' + %CHAR(%SCANR('o' : text : 18));
ON-ERROR;
  line = 'END status ' + %CHAR(%STATUS);
ENDMON;
DSPLY line;
MONITOR;
  line = 'BEYOND ' + %CHAR(%SCANR('o' : text : 19));
ON-ERROR;
  line = 'BEYOND status ' + %CHAR(%STATUS);
ENDMON;
DSPLY line;
MONITOR;
  line = 'LENGTH ' + %CHAR(%SCANR('o' : text : 10 : 20));
ON-ERROR;
  line = 'LENGTH status ' + %CHAR(%STATUS);
ENDMON;
DSPLY line;
MONITOR;
  line = 'SCAN BEYOND ' + %CHAR(%SCAN('o' : text : 19));
ON-ERROR;
  line = 'SCAN BEYOND status ' + %CHAR(%STATUS);
ENDMON;
DSPLY line;

// With no start given, an empty source is simply not found.
line = 'EMPTY ' + %CHAR(%SCAN('o' : empty)) + ' ' + %CHAR(%SCANR('o' : empty));
DSPLY line;

*INLR = *ON;
