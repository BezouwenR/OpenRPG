**FREE
// %TOHEX (or %HEX) and %FROMHEX, OpenRPG extensions: each byte as two hex
// digits, and back, as the C functions cvthc and cvtch. The bytes are the
// host's: 'AB' is X'4142' here. Bad hex digits are status 100.
DCL-S s VARCHAR(10) INZ('AB');
DCL-S h VARCHAR(20);
DCL-S bad VARCHAR(5) INZ('4G');
h = %TOHEX(s);
DSPLY h;
DSPLY %HEX(X'00FF10');
DSPLY %FROMHEX('4869' + '21');
IF %FROMHEX('4869') = 'Hi';
  DSPLY 'round trip';
ENDIF;
DSPLY %CHAR(%LEN(%FROMHEX('00ff')));
MONITOR;
  h = %FROMHEX(bad);
ON-ERROR;
  DSPLY ('status ' + %CHAR(%STATUS));
ENDMON;
*INLR = *ON;
RETURN;
