**FREE
// A %KDS key subfield must be a subfield of the array's elements.
DCL-DS a QUALIFIED DIM(2);
  x INT(10);
END-DS;
DCL-DS k QUALIFIED;
  y INT(10);
END-DS;
DSPLY %CHAR(%LOOKUP(%KDS(k) : a(*)));
*INLR = *ON;
RETURN;
