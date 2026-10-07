**FREE
// CHAR with no length, an OpenRPG extension: a string of any length, as
// in Java -- a field, LIKE, a parameter and a return value.
DCL-S text CHAR;
DCL-S greeting CHAR INZ('Hello');
DCL-S i INT(10);
DCL-S copy LIKE(text);
FOR i = 1 TO 100;
  text += 'abcdefghij';
ENDFOR;
DSPLY %CHAR(%LEN(text));
DSPLY %SUBST(text : 991 : 10);
greeting = greeting + ', world';
DSPLY greeting;
copy = %TRIM(text) + '!';
DSPLY %CHAR(%LEN(copy));
DSPLY shout('quiet');
DSPLY ('[' + text + ']' = '[' + text + ']');
*INLR = *ON;
RETURN;

DCL-PROC shout;
  DCL-PI *N CHAR;
    s CHAR CONST;
  END-PI;
  RETURN %UPPER(s) + '!!!';
END-PROC;
