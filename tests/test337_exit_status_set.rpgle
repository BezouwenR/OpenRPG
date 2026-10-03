**FREE
// rpg_set_exit_status: the program ends normally, with that status.
/IF DEFINED(*OPENRPG)
DCL-PR SetExitStatus EXTPROC('rpg_set_exit_status');
  status INT(10) VALUE;
END-PR;
SetExitStatus(16);
/ENDIF
DSPLY 'set 16';
*INLR = *ON;
RETURN;
