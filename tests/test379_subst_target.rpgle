**FREE
// %SUBST as an assignment target: the value goes into that part of the
// field, padded with blanks or cut to the length; without a length, to the
// end. A field, a VARCHAR, an array element and a subfield, with EVAL and
// without; a start or length outside the field is status 100.
DCL-S s CHAR(10) INZ('abcdefghij');
DCL-S v VARCHAR(10) INZ('hello');
DCL-S arr CHAR(5) DIM(2) INZ('xxxxx');
DCL-DS ds QUALIFIED;
  f CHAR(6) INZ('......');
END-DS;
DCL-S i INT(10) INZ(2);
%SUBST(s : 2 : 3) = 'XYZ';
DSPLY s;
%SUBST(s : 1 : 4) = 'Q';
DSPLY s;
%SUBST(s : 8 : 3) = 'LONGER';
DSPLY s;
%SUBST(s : 9) = '12';
DSPLY s;
%SUBST(v : 1 : 1) = 'J';
DSPLY v;
%SUBST(arr(i) : 2 : 2) = 'ab';
DSPLY arr(2);
%SUBST(ds.f : i + 1 : 2) = '**';
DSPLY ds.f;
EVAL %SUBST(s : 1 : 2) = 'ev';
DSPLY s;
MONITOR;
  %SUBST(s : i + 7 : 5) = 'x';
ON-ERROR;
  DSPLY ('status ' + %CHAR(%STATUS));
ENDMON;
*INLR = *ON;
RETURN;
