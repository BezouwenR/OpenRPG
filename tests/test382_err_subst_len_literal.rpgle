**FREE
// A %SUBST length written as a number must fit the field (IBM: RNF0365).
DCL-S s CHAR(10);
DCL-S t CHAR(5);
t = %SUBST(s : 9 : 5);
*INLR = *ON;
RETURN;
