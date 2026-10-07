**FREE
// %COMPCORR(ds1 : ds2 {: n}), an OpenRPG extension: *ON when the subfields
// of the same name in both are equal -- or the first n of them -- character
// ones compared as RPG compares them; subfields only one has are skipped.
DCL-DS key1 QUALIFIED;
  cust CHAR(5);
  ord INT(10);
  line INT(5);
  note VARCHAR(20);
END-DS;
DCL-DS key2 QUALIFIED;
  cust VARCHAR(8);
  ord INT(10);
  extra CHAR(1);
  line INT(5);
  note VARCHAR(20);
END-DS;
key1.cust = 'AB';
key1.ord = 7;
key1.line = 1;
key1.note = 'x';
key2.cust = 'AB';
key2.ord = 7;
key2.extra = 'Z';
key2.line = 1;
key2.note = 'y';
IF %COMPCORR(key1 : key2);
  DSPLY 'all equal';
ELSE;
  DSPLY 'not all equal';
ENDIF;
IF %COMPCORR(key1 : key2 : 3);
  DSPLY 'first 3 equal';
ENDIF;
key2.note = 'x';
DSPLY %IF(%COMPCORR(key1 : key2) : 'now equal' : 'still not');
*INLR = *ON;
RETURN;
