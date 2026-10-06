**FREE
// Regular-expression BIFs, an OpenRPG extension: %MATCHES(string : regex),
// %FIND(regex : string) and %COUNTMATCHES(regex : string). A pattern that
// is not valid, made at run time, is status 100.
DCL-S email VARCHAR(50) INZ('ada@example.com');
DCL-S code CHAR(10) INZ('AB-1234');
DCL-S text VARCHAR(50) INZ('one 1, two 22, three 333');
DCL-S pat VARCHAR(20) INZ('[0-9]+');
DCL-S badpat VARCHAR(10) INZ('(abc');
IF %MATCHES(email : '^[^@ ]+@[^@ ]+\.[a-z]+$');
  DSPLY 'email ok';
ENDIF;
IF NOT %MATCHES('not an email' : '^[^@ ]+@[^@ ]+$');
  DSPLY 'not an email';
ENDIF;
IF %MATCHES(code : '^[A-Z]{2}-[0-9]{4} *$');
  DSPLY 'code ok, blanks allowed';
ENDIF;
DSPLY %CHAR(%FIND(pat : text));
DSPLY %CHAR(%FIND('[0-9]{3}' : text));
DSPLY %CHAR(%FIND('x' : text));
DSPLY %CHAR(%COUNTMATCHES(pat : text));
DSPLY %CHAR(%COUNTMATCHES('o' : text));
MONITOR;
  DSPLY %CHAR(%FIND(badpat : 'abc'));
ON-ERROR;
  DSPLY ('status ' + %CHAR(%STATUS));
ENDMON;
*INLR = *ON;
RETURN;
