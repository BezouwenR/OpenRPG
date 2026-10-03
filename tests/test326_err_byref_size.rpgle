**FREE
// A parameter passed by reference takes only a variable declared exactly
// like it: PACKED(7:2) for PACKED(9:2) is RNF7535.
DCL-PR p;
  amt PACKED(9:2);
END-PR;
DCL-S small PACKED(7:2);
p(small);
*INLR = *ON;
RETURN;

DCL-PROC p;
  DCL-PI *N;
    amt PACKED(9:2);
  END-PI;
  amt = 0;
END-PROC;
