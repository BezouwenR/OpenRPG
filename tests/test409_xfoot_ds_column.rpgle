**FREE
// %XFOOT, %MAXARR and IN over ds(*).subfield, an OpenRPG extension.
DCL-DS ord QUALIFIED DIM(3);
  amt PACKED(7:2);
END-DS;
ord(1).amt = 1.5;
ord(2).amt = 10;
ord(3).amt = 2.25;
DSPLY %CHAR(%XFOOT(ord(*).amt));
DSPLY %CHAR(%MAXARR(ord(*).amt));
IF 10 IN ord(*).amt;
  DSPLY 'in';
ENDIF;
*INLR = *ON;
RETURN;
