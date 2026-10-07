**FREE
// A procedure called before it is defined, from the main section and from
// another procedure, with no DCL-PR for it.
DSPLY %CHAR(a(1));
*INLR = *ON;
RETURN;

DCL-PROC a;
  DCL-PI *N INT(10);
    n INT(10) VALUE;
  END-PI;
  RETURN b(n) + 1;
END-PROC;

DCL-PROC b;
  DCL-PI *N INT(10);
    n INT(10) VALUE;
  END-PI;
  RETURN n * 10;
END-PROC;
