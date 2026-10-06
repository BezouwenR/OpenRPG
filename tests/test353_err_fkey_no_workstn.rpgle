**FREE
// %FKEY needs a WORKSTN file: it tells which function key ended the last
// EXFMT or READ of one.
DCL-S k INT(10);
k = %FKEY;
DSPLY %CHAR(k);
*INLR = *ON;
RETURN;
