**FREE
// %CHAR(number : *ZEROSUPPRESS | *NOZEROSUPPRESS), an OpenRPG extension:
// *NOZEROSUPPRESS keeps every digit the field is declared with, as
// %EDITC(n : 'X') does, with a decimal point and minus sign.
DCL-S p PACKED(7:2) INZ(123.4);
DCL-S neg PACKED(7:2) INZ(-5);
DCL-S zip ZONED(5:0) INZ(2134);
DCL-S i INT(10) INZ(42);
DCL-S u UNS(5) INZ(7);
DCL-S zero PACKED(5:2);
DSPLY %CHAR(p : *NOZEROSUPPRESS);
DSPLY %CHAR(p : *ZEROSUPPRESS);
DSPLY %CHAR(neg : *NOZEROSUPPRESS);
DSPLY %CHAR(zip : *NOZEROSUPPRESS);
DSPLY %CHAR(i : *NOZEROSUPPRESS);
DSPLY %CHAR(u : *NOZEROSUPPRESS);
DSPLY %CHAR(zero : *NOZEROSUPPRESS);
DSPLY %CHAR(zero);
*INLR = *ON;
RETURN;
