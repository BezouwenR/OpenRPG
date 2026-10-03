**FREE
// A subfield of a CONST LIKEDS parameter cannot be changed.
DCL-DS t QUALIFIED TEMPLATE;
  n INT(10);
END-DS;
DCL-PR p;
  parm LIKEDS(t) CONST;
END-PR;
DCL-DS x LIKEDS(t);
p(x);
*INLR = *ON;
RETURN;

DCL-PROC p;
  DCL-PI *N;
    parm LIKEDS(t) CONST;
  END-PI;
  parm.n = 5;
END-PROC;
