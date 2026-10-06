**FREE
// A positional argument cannot follow a keyword one.
DCL-PR f INT(10);
  a INT(10) VALUE;
  b INT(10) VALUE;
END-PR;
DSPLY %CHAR(f(a => 1 : 2));
*INLR = *ON;
RETURN;

DCL-PROC f;
  DCL-PI *N INT(10);
    a INT(10) VALUE;
    b INT(10) VALUE;
  END-PI;
  RETURN a + b;
END-PROC;
