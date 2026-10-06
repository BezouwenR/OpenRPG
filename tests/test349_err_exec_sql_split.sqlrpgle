**FREE
// EXEC and SQL must be on the same line: EXEC alone is read as a name,
// which is not defined (IBM: RNF7030).
DCL-S n INT(10);
EXEC
  SQL INSERT INTO t349 VALUES(1);
*INLR = *ON;
RETURN;
