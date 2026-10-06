**FREE
// CTL-OPT OPTION(*NOLENCHK), an OpenRPG extension: a %SUBST length past the
// end of the data gives the rest of it, a length of 0 nothing, and a start
// just past the end nothing; a start further out is still status 100.
CTL-OPT OPTION(*SRCSTMT : *NOLENCHK);
DCL-S s VARCHAR(10) INZ('200 OK');
DCL-S empty VARCHAR(10);
DCL-S fixed CHAR(4) INZ('ab');
DSPLY ('[' + %SUBST(s : 1 : 3) + ']');
DSPLY ('[' + %SUBST(s : 5 : 20) + ']');
DSPLY ('[' + %SUBST(s : 1 : 0) + ']');
DSPLY ('[' + %SUBST(empty : 1 : 3) + ']');
DSPLY ('[' + %SUBST(fixed : 2 : 9) + ']');
MONITOR;
  DSPLY ('[' + %SUBST(s : 9 : 1) + ']');
ON-ERROR;
  DSPLY ('start outside: ' + %CHAR(%STATUS));
ENDMON;
*INLR = *ON;
RETURN;
