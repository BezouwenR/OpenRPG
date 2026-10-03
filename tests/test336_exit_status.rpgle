**FREE
// The exit status: rpg_set_exit_status (an OpenRPG extension) sets it, and
// a halt indicator left on ends the program in error with status n for
// *Hn, which wins over a status set.
/IF DEFINED(*OPENRPG)
DCL-PR SetExitStatus EXTPROC('rpg_set_exit_status');
  status INT(10) VALUE;
END-PR;
SetExitStatus(16);
/ENDIF
DSPLY 'set 16';
EXSR finish;
DSPLY 'not reached';

BEGSR finish;
  *INH3 = *ON;
  *INLR = *ON;
  RETURN;
ENDSR;
