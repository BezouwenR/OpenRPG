**FREE
// *EMPTY, an OpenRPG extension: the empty string, exactly as '' -- returned,
// assigned (a CHAR field becomes blanks, a VARCHAR empty), compared, and in
// a concatenation.
DCL-S v VARCHAR(10) INZ('abc');
DCL-S c CHAR(3) INZ('xyz');
v = *EMPTY;
DSPLY %CHAR(%LEN(v));
c = *EMPTY;
DSPLY ('[' + c + ']');
IF v = *EMPTY AND c = *EMPTY;
  DSPLY 'both empty';
ENDIF;
DSPLY ('[' + none() + *EMPTY + ']');
DSPLY %CHAR(%LEN(none()));
*INLR = *ON;
RETURN;

DCL-PROC none;
  DCL-PI *N VARCHAR(10);
  END-PI;
  RETURN *EMPTY;
END-PROC;
