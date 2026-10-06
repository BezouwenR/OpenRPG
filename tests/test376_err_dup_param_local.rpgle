**FREE
// A procedure's local cannot share a name with one of its parameters.
p(1);
*INLR = *ON;
RETURN;

DCL-PROC p;
  DCL-PI *N;
    n INT(10) VALUE;
  END-PI;
  DCL-S n CHAR(5);
  DSPLY n;
END-PROC;
