**FREE
// A procedure inside another can be called only from inside that one.
DSPLY %CHAR(inner(1));
*INLR = *ON;
RETURN;
DCL-PROC outer;
  DCL-PROC inner;
    DCL-PI *N INT(10);
      x INT(10) VALUE;
    END-PI;
    RETURN x;
  END-PROC;
END-PROC;
