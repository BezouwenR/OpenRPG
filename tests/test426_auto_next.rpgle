**FREE
// arr(*NEXT) = value: a DIM(*AUTO) array grows by one element to hold it.
// Past the array's maximum, it is status 124.
DCL-S names VARCHAR(10) DIM(*AUTO : 3);
names(*NEXT) = 'Ada';
names(*NEXT) = 'Grace';
DSPLY (%CHAR(%ELEM(names)) + ' ' + names(2));
names(*NEXT) = 'Alan';
DSPLY (%CHAR(%ELEM(names)) + ' ' + names(3));
MONITOR;
  names(*NEXT) = 'Barbara';
ON-ERROR;
  DSPLY ('status ' + %CHAR(%STATUS));
ENDMON;
DSPLY %CHAR(%ELEM(names));
*INLR = *ON;
RETURN;
