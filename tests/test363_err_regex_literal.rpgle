**FREE
// A pattern written as a literal must be a valid regular expression.
DCL-S s VARCHAR(10) INZ('abc');
IF %MATCHES(s : '[a-');
  DSPLY 'x';
ENDIF;
*INLR = *ON;
RETURN;
