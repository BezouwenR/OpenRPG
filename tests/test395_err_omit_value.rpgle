**FREE
// OPTIONS(*OMIT) is not valid for a parameter passed by value.
DCL-PR p;
  n INT(10) VALUE OPTIONS(*OMIT);
END-PR;
p(*OMIT);
*INLR = *ON;
RETURN;

DCL-PROC p;
  DCL-PI *N;
    n INT(10) VALUE OPTIONS(*OMIT);
  END-PI;
END-PROC;
