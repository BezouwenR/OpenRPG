**FREE
// OPTIONS(*TRIM): a CONST or VALUE character argument arrives with its
// leading and trailing blanks trimmed, then fitted to the parameter -- so a
// CHAR one is padded again on the right.
DCL-PR show VARCHAR(20);
  t CHAR(8) CONST OPTIONS(*TRIM);
  v VARCHAR(8) VALUE OPTIONS(*TRIM);
END-PR;
DCL-S raw VARCHAR(10) INZ('  keep  ');
DSPLY show('  x ' : '  y  ');
DSPLY show(raw : raw);
DSPLY ('[' + raw + ']');
*INLR = *ON;
RETURN;

DCL-PROC show;
  DCL-PI *N VARCHAR(20);
    t CHAR(8) CONST OPTIONS(*TRIM);
    v VARCHAR(8) VALUE OPTIONS(*TRIM);
  END-PI;
  RETURN '[' + t + '][' + v + ']';
END-PROC;
