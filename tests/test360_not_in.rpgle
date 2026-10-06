**FREE
// x NOT IN list, an OpenRPG extension: NOT (x IN list), with %LIST,
// %RANGE, an array and an enum, combined with AND and in a WHEN.
DCL-ENUM color;
  red 1;
  green 2;
  blue 3;
END-ENUM;
DCL-S val INT(10) INZ(4);
DCL-S code CHAR(1) INZ('X');
DCL-S codes CHAR(1) DIM(3) INZ('A');
DCL-S c INT(10) INZ(9);

IF val NOT IN %LIST(1 : 3 : 5 : 7);
  DSPLY '4 not in odd list';
ENDIF;
IF NOT (val NOT IN %RANGE(1 : 10));
  DSPLY '4 in 1-10';
ENDIF;
IF code NOT IN codes AND val NOT IN %RANGE(5 : 9);
  DSPLY 'X not in codes, 4 not in 5-9';
ENDIF;
IF c NOT IN color;
  DSPLY '9 is no color';
ENDIF;
SELECT;
  WHEN val NOT IN %LIST(4 : 8);
    DSPLY 'wrong';
  OTHER;
    DSPLY '4 in 4,8';
ENDSL;
*INLR = *ON;
RETURN;
