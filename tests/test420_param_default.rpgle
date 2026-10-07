**FREE
// DEFAULT(value), an OpenRPG extension: what a *NOPASS parameter not passed,
// or an *OMIT one omitted, holds in the procedure -- given on the DCL-PI, or
// on the DCL-PR alone (pad). %PARMS and %OMITTED still say what was passed.
DCL-PR line VARCHAR(40);
  text VARCHAR(20) CONST;
  width INT(10) VALUE OPTIONS(*NOPASS) DEFAULT(10);
  fill CHAR(1) CONST OPTIONS(*NOPASS) DEFAULT('.');
END-PR;
DCL-PR greet VARCHAR(30);
  name VARCHAR(10) CONST OPTIONS(*OMIT) DEFAULT('world');
  punct CHAR(1) CONST OPTIONS(*NOPASS) DEFAULT('!');
END-PR;
DCL-PR pad VARCHAR(10);
  n INT(10) VALUE;
  width INT(10) VALUE OPTIONS(*NOPASS) DEFAULT(5);
END-PR;
DSPLY line('ab');
DSPLY line('ab' : 5);
DSPLY line('ab' : 6 : '*');
DSPLY pad(7);
DSPLY pad(7 : 3);
DSPLY greet('Ada');
DSPLY greet(*OMIT);
DSPLY greet(*OMIT : '?');
*INLR = *ON;
RETURN;

DCL-PROC line;
  DCL-PI *N VARCHAR(40);
    text VARCHAR(20) CONST;
    width INT(10) VALUE OPTIONS(*NOPASS) DEFAULT(10);
    fill CHAR(1) CONST OPTIONS(*NOPASS) DEFAULT('.');
  END-PI;
  RETURN text + %REPEAT(fill : width - %LEN(text)) + '|' + %CHAR(%PARMS);
END-PROC;

DCL-PROC greet;
  DCL-PI *N VARCHAR(30);
    name VARCHAR(10) CONST OPTIONS(*OMIT) DEFAULT('world');
    punct CHAR(1) CONST OPTIONS(*NOPASS) DEFAULT('!');
  END-PI;
  RETURN 'hello ' + name + punct + %IF(%OMITTED(name) : ' (omitted)' : '');
END-PROC;

DCL-PROC pad;
  DCL-PI *N VARCHAR(10);
    n INT(10) VALUE;
    width INT(10) VALUE OPTIONS(*NOPASS);
  END-PI;
  RETURN %SUBST(%REPEAT('0' : 10) + %CHAR(n) : 11 + %LEN(%CHAR(n)) - width);
END-PROC;
