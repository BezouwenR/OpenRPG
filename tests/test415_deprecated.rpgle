**FREE
// DEPRECATED, an OpenRPG extension: on a DCL-PR after its return type, or
// on a DCL-PROC, with a message or without. A call compiles, with a
// warning; DEPRECATED is still a name too.
DCL-PR oldTax PACKED(7:2) DEPRECATED('use tax() instead');
  amt PACKED(7:2) VALUE;
END-PR;
DCL-S deprecated INT(10) INZ(1);
DSPLY %CHAR(oldTax(100));
DSPLY %CHAR(tax(100));
legacy();
DSPLY %CHAR(deprecated);
*INLR = *ON;
RETURN;

DCL-PROC oldTax;
  DCL-PI *N PACKED(7:2);
    amt PACKED(7:2) VALUE;
  END-PI;
  RETURN tax(amt);
END-PROC;

DCL-PROC tax;
  DCL-PI *N PACKED(7:2);
    amt PACKED(7:2) VALUE;
  END-PI;
  RETURN amt * 0.07;
END-PROC;

DCL-PROC legacy DEPRECATED;
  DSPLY 'legacy';
END-PROC;
