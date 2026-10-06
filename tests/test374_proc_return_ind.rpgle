**FREE
// A procedure can return an indicator, DCL-PI *N IND, with a prototype
// or without.
DCL-PR isOdd IND;
  n INT(10) VALUE;
END-PR;

IF isEven(4) AND NOT isEven(3);
  DSPLY 'isEven works';
ENDIF;
IF isOdd(7);
  DSPLY 'isOdd works';
ENDIF;
*INLR = *ON;
RETURN;

DCL-PROC isEven;
  DCL-PI *N IND;
    n INT(10) VALUE;
  END-PI;
  RETURN %REM(n : 2) = 0;
END-PROC;

DCL-PROC isOdd;
  DCL-PI *N IND;
    n INT(10) VALUE;
  END-PI;
  RETURN NOT isEven(n);
END-PROC;
