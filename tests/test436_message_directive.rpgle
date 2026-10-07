**FREE
// /MESSAGE, an OpenRPG extension: a warning, or with *ERROR an error that
// fails the compile -- only where code is compiled, so an *ERROR in an
// /IF branch not taken says nothing. The program here compiles and runs.
/MESSAGE 'Built with the test settings'
/IF NOT DEFINED(*OPENRPG)
/MESSAGE *ERROR 'never: OpenRPG is defined'
/ENDIF
/MESSAGE *WARNING 'it''s a warning'
DSPLY 'ran';
*INLR = *ON;
RETURN;
