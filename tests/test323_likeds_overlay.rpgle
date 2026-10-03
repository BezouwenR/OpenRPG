**FREE
// OVERLAY subfields reached through a LIKEDS parameter and through a
// LIKEDS subfield: read and written.
DCL-DS t QUALIFIED TEMPLATE;
  txt CHAR(4);
  num ZONED(4:0) OVERLAY(txt);
END-DS;
DCL-DS outer QUALIFIED;
  inner LIKEDS(t);
END-DS;
DCL-PR p;
  parm LIKEDS(t);
END-PR;
DCL-DS x LIKEDS(t);

x.txt = '0042';
p(x);
DSPLY x.txt;
outer.inner.txt = '0007';
DSPLY %CHAR(outer.inner.num);
outer.inner.num = 123;
DSPLY outer.inner.txt;
*INLR = *ON;
RETURN;

DCL-PROC p;
  DCL-PI *N;
    parm LIKEDS(t);
  END-PI;
  DCL-S n ZONED(4:0);
  n = parm.num;
  DSPLY %CHAR(n);
  parm.num = n + 1;
END-PROC;
