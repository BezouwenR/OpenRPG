**FREE
// %SUBST as an assignment target needs a character field.
DCL-S n INT(10);
%SUBST(n : 1 : 1) = '5';
*INLR = *ON;
RETURN;
