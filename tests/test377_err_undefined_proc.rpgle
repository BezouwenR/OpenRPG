**FREE
// Calling a procedure that has no DCL-PROC or prototype is an error.
DCL-S x INT(10);
x = nosuch(1);
*INLR = *ON;
RETURN;
