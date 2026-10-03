**FREE
// Called by test339: ends normally, in an error, or with a halt indicator
// on, as its caller asks.
DCL-PI *N;
  mode CHAR(1);
  n INT(10);
END-PI;
DCL-S zero INT(10) INZ(0);
SELECT;
  WHEN mode = 'Z';
    n = n / zero;
  WHEN mode = 'H';
    *INH1 = *ON;
  OTHER;
    n += 1;
ENDSL;
RETURN;
