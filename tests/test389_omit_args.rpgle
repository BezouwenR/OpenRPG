**FREE
// An argument for an OPTIONS(*OMIT) parameter: *OMIT, a field of its type
// (by reference, so the procedure's change is seen), or for a CONST
// parameter a literal, a calculation or a field of another type. (*OMIT
// is not valid with VALUE: test395.)
DCL-PR show VARCHAR(30);
  label VARCHAR(10) CONST OPTIONS(*OMIT);
  n INT(10) CONST OPTIONS(*OMIT);
END-PR;
DCL-PR bump;
  counter INT(10) OPTIONS(*OMIT);
END-PR;
DCL-S c CHAR(5) INZ('chr');
DCL-S v VARCHAR(10) INZ('var');
DCL-S k INT(10) INZ(1);
DSPLY show('lit' : 2);
DSPLY show(v : k + 1);
DSPLY show(c : *OMIT);
DSPLY show(*OMIT : 9);
bump(k);
bump(*OMIT);
DSPLY %CHAR(k);
*INLR = *ON;
RETURN;

DCL-PROC show;
  DCL-PI *N VARCHAR(30);
    label VARCHAR(10) CONST OPTIONS(*OMIT);
    n INT(10) CONST OPTIONS(*OMIT);
  END-PI;
  DCL-S r VARCHAR(30);
  IF %OMITTED(label);
    r = '-';
  ELSE;
    r = %TRIMR(label);
  ENDIF;
  IF NOT %OMITTED(n);
    r += ' ' + %CHAR(n);
  ENDIF;
  RETURN r;
END-PROC;

DCL-PROC bump;
  DCL-PI *N;
    counter INT(10) OPTIONS(*OMIT);
  END-PI;
  IF NOT %OMITTED(counter);
    counter += 10;
  ENDIF;
END-PROC;
