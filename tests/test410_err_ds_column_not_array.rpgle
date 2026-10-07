**FREE
// x(*).subfield needs a data structure array.
DCL-DS d QUALIFIED;
  a INT(10);
END-DS;
DSPLY %CHAR(%LOOKUP(1 : d(*).a));
*INLR = *ON;
RETURN;
