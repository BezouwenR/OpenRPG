**FREE
// Subroutines in a subprocedure: called before they are defined, calling
// each other, using the procedure's locals, and RETURN from one of them.
DCL-PR p;
END-PR;
DCL-PR twice INT(10);
  n INT(10) VALUE;
END-PR;
DCL-PR withExit;
END-PR;

p();
DSPLY %CHAR(twice(21));
withExit();
*INLR = *ON;
RETURN;

DCL-PROC p;
  DCL-S count INT(10) INZ(0);
  EXSR first;
  DSPLY ('count ' + %CHAR(count));
  RETURN;

  BEGSR first;
    count += 1;
    EXSR second;
  ENDSR;
  BEGSR second;
    count += 10;
    DSPLY 'in second';
  ENDSR;
END-PROC;

DCL-PROC twice;
  DCL-PI *N INT(10);
    n INT(10) VALUE;
  END-PI;
  EXSR calc;
  DSPLY 'not reached';
  RETURN 0;
  BEGSR calc;
    RETURN n * 2;
  ENDSR;
END-PROC;

DCL-PROC withExit;
  EXSR sub;
  RETURN;
  BEGSR sub;
    DSPLY 'sub before exit';
  ENDSR;
ON-EXIT;
  DSPLY 'on-exit';
END-PROC;
