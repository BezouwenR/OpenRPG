**FREE
// *NOZEROSUPPRESS shows a field's declared digits, so an expression,
// which has none declared, is an error.
DCL-S p PACKED(7:2) INZ(1);
DSPLY %CHAR(p * 2 : *NOZEROSUPPRESS);
*INLR = *ON;
RETURN;
