**FREE
// SELECT with an operand: WHEN-IS compares it for equality, WHEN-IN with
// %LIST or %RANGE; the first that holds is taken, else OTHER. Character
// operands compare blank-padded; the operand may be an expression.
DCL-S age INT(10);
DCL-S code CHAR(3) INZ('B');
DCL-S r INT(10);
DCL-S i INT(10);
FOR i = 1 TO 5;
  age = %INT(%SUBST('0201151730' : i * 2 - 1 : 2));
  SELECT age;
  WHEN-IN %LIST(2 : 5 : 17);
    r = 1;
  WHEN-IS 1;
    r = 2;
  WHEN-IN %RANGE(10 : 20);
    r = 3;
  OTHER;
    r = 4;
  ENDSL;
  DSPLY (%CHAR(age) + ' -> ' + %CHAR(r));
ENDFOR;
SELECT code;
WHEN-IS 'A';
  DSPLY 'is A';
WHEN-IS 'B';
  DSPLY 'is B (padded)';
ENDSL;
SELECT %LEN(%TRIMR(code)) + 1;
WHEN-IS 2;
  DSPLY 'two';
ENDSL;
*INLR = *ON;
RETURN;
