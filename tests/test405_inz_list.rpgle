**FREE
// INZ(%LIST(...)) on an array, an OpenRPG extension: each element its own
// initial value, those past the list blank or zero, for a fixed array and
// a varying one (its elements are the list), and RESET back to them.
DCL-S allowed INT(10) DIM(4) INZ(%LIST(1 : 2 : 3 : 4));
DCL-S codes CHAR(3) DIM(5) INZ(%LIST('A' : 'BB' : 'CCC'));
DCL-S rates PACKED(5:2) DIM(3) INZ(%LIST(1.5 : 2.25));
DCL-S names VARCHAR(10) DIM(*VAR : 10) INZ(%LIST('Ada' : 'Grace'));
DCL-S i INT(10);
FOR i = 1 TO %ELEM(allowed);
  DSPLY %CHAR(allowed(i));
ENDFOR;
FOR i = 1 TO %ELEM(codes);
  DSPLY ('[' + codes(i) + ']');
ENDFOR;
DSPLY (%CHAR(rates(1)) + ' ' + %CHAR(rates(2)) + ' ' + %CHAR(rates(3)));
DSPLY (%CHAR(%ELEM(names)) + ' ' + names(1) + ' ' + names(2));
IF 3 IN allowed;
  DSPLY '3 allowed';
ENDIF;
allowed(1) = 99;
RESET allowed;
DSPLY %CHAR(allowed(1));
*INLR = *ON;
RETURN;
