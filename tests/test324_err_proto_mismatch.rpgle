**FREE
// A character argument for an INT(10) parameter passed by reference is
// rejected by rpgc, not left to the C++ compiler (IBM: RNF7535).
DCL-PR p;
  n INT(10);
END-PR;
DCL-S s CHAR(10);
p(s);
*INLR = *ON;
RETURN;

DCL-PROC p;
  DCL-PI *N;
    n INT(10);
  END-PI;
  DSPLY %CHAR(n);
END-PROC;
