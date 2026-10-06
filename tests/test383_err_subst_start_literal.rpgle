**FREE
// A %SUBST start written as a number must be in the field.
DCL-S s CHAR(10);
DCL-S t CHAR(5);
t = %SUBST(s : 11 : 1);
*INLR = *ON;
RETURN;
