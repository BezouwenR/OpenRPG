**FREE
// A procedure's local may share a global's name: it hides the global
// inside the procedure.
DCL-S total INT(10) INZ(5);
DCL-DS cust;
  name CHAR(10) INZ('Ada');
END-DS;
show();
DSPLY %CHAR(total);
DSPLY name;
*INLR = *ON;
RETURN;

DCL-PROC show;
  DCL-S total INT(10) INZ(99);
  DCL-S name CHAR(10) INZ('local');
  DSPLY %CHAR(total);
  DSPLY name;
END-PROC;
