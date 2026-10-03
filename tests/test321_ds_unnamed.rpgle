**FREE
// DCL-DS *N: an unnamed data structure, its subfields reached by name.
DCL-DS *N;
  a CHAR(2) INZ('AB');
END-DS;
DCL-DS *N;
  stamp CHAR(8);
  yyyy CHAR(4) OVERLAY(stamp);
  mmdd CHAR(4) OVERLAY(stamp:5);
END-DS;
DCL-S total INT(10) INZ(3);
DSPLY a;
stamp = '20241231';
DSPLY (yyyy + '/' + mmdd);
total = total*2;
DSPLY %CHAR(total);
*INLR = *ON;
RETURN;
