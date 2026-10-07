**FREE
// DEFAULT is for a parameter that can be left out.
DCL-PR p;
  n INT(10) VALUE DEFAULT(1);
END-PR;
p(2);
*INLR = *ON;
RETURN;

DCL-PROC p;
  DCL-PI *N;
    n INT(10) VALUE DEFAULT(1);
  END-PI;
END-PROC;
