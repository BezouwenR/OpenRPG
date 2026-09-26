**FREE
// A statement that starts with an operation code is that operation: this
// is OUT, not an assignment to the field named OUT. EVAL out = 5 is the
// assignment (IBM: RNF5008, RNF7260).
DCL-S out INT(10);
out = 5;
*INLR = *ON;
