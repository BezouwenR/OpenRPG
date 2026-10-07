**FREE
// %PROGNAME, an OpenRPG extension: the running program's name, as the PSDS
// has it -- here the test executable's, TEST422 -- with or without ().
DSPLY %PROGNAME;
DSPLY ('[' + %PROGNAME() + ']');
show();
*INLR = *ON;
RETURN;

DCL-PROC show;
  DSPLY ('in ' + %PROGNAME);
END-PROC;
