**FREE
// A procedure inside a procedure, an OpenRPG extension: it sees its
// parent's locals and parameters, recurses, nests, takes parameters by
// reference, may shadow a parent local, and is called from subroutines.
DCL-S total INT(10) INZ(1000);
DSPLY %CHAR(outer(5));
DSPLY %CHAR(total);
*INLR = *ON;
RETURN;

DCL-PROC outer;
  DCL-PI *N INT(10);
    n INT(10) VALUE;
  END-PI;
  DCL-S total INT(10);
  DCL-S label VARCHAR(20) INZ('outer');
  bump(total);
  bump(total);
  DSPLY (label + ' ' + %CHAR(total));
  rename();
  DSPLY label;
  EXSR show;
  RETURN fact(n) + deep(1);

  BEGSR show;
    DSPLY ('sr sees ' + %CHAR(fact(3)));
  ENDSR;

  DCL-PROC fact;
    DCL-PI *N INT(10);
      k INT(10) VALUE;
    END-PI;
    IF k <= 1;
      RETURN 1;
    ENDIF;
    RETURN k * fact(k - 1);
  END-PROC;

  DCL-PROC bump;
    DCL-PI *N;
      v INT(10);
    END-PI;
    v += 7;
  END-PROC;

  DCL-PROC rename;
    DCL-S label VARCHAR(20) INZ('inner');
    DSPLY ('inner local: ' + label);
  END-PROC;

  DCL-PROC deep;
    DCL-PI *N INT(10);
      x INT(10) VALUE;
    END-PI;
    RETURN deeper(x) + n;

    DCL-PROC deeper;
      DCL-PI *N INT(10);
        y INT(10) VALUE;
      END-PI;
      RETURN y + total;
    END-PROC;
  END-PROC;
END-PROC;
