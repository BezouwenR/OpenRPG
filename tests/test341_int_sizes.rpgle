**FREE
// Integers hold what their size does: INT(20) and UNS(20) are eight bytes,
// and a value outside a field's range -- INT(3) is -128 to 127, INT(5)
// -32768 to 32767 -- is status 103.
DCL-S big INT(20) INZ(9000000000);
DCL-S ubig UNS(20) INZ(18000000000000000000);
DCL-S i3 INT(3);
DCL-S i5 INT(5);
DCL-S i10 INT(10);
DCL-S u5 UNS(5);
DCL-DS rec QUALIFIED;
  id INT(20);
END-DS;
DCL-PR twice INT(20);
  n INT(20) VALUE;
END-PR;

DSPLY %CHAR(big);
big = big * 1000;
DSPLY %CHAR(big);
DSPLY %CHAR(ubig);
rec.id = 123456789012;
DSPLY %CHAR(rec.id);
DSPLY %CHAR(twice(4000000000));

i3 = 127;
MONITOR;
  i3 = i3 + 1;
ON-ERROR 103;
  DSPLY ('INT(3) 128: ' + %CHAR(%STATUS) + ', still ' + %CHAR(i3));
ENDMON;
MONITOR;
  i5 = -32769;
ON-ERROR 103;
  DSPLY 'INT(5) -32769: 103';
ENDMON;
MONITOR;
  i10 = 2147483648;
ON-ERROR 103;
  DSPLY 'INT(10) 2147483648: 103';
ENDMON;
MONITOR;
  u5 = 65536;
ON-ERROR 103;
  DSPLY 'UNS(5) 65536: 103';
ENDMON;
MONITOR;
  ubig = -1;
ON-ERROR 103;
  DSPLY 'UNS(20) -1: 103';
ENDMON;
*INLR = *ON;
RETURN;

DCL-PROC twice;
  DCL-PI *N INT(20);
    n INT(20) VALUE;
  END-PI;
  RETURN n * 2;
END-PROC;
