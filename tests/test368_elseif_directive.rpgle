**FREE
// /ELSEIF after an /IF that is not taken: its condition is tested, and the
// /ELSE is not taken when it holds.
/DEFINE YES
/IF DEFINED(NOPE)
DSPLY 'wrong 1';
/ELSEIF NOT DEFINED(NOPE)
DSPLY 'elseif not taken';
/ELSE
DSPLY 'wrong 2';
/ENDIF
/IF DEFINED(NOPE)
DSPLY 'wrong 3';
/ELSEIF DEFINED(ALSO_NOPE)
DSPLY 'wrong 4';
/ELSEIF DEFINED(YES)
DSPLY 'second elseif';
/ELSE
DSPLY 'wrong 5';
/ENDIF
*INLR = *ON;
RETURN;
