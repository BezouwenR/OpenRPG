**FREE
// EXTPGM with the program's name in a variable: PGMTYPES (built with
// rpgc -shared) is found when it is called, and each parameter goes to it
// and comes back in IBM i's format for its type. A CONST one goes but
// does not come back.
DCL-DS rec_t QUALIFIED TEMPLATE;
  code CHAR(3);
  qty INT(10);
  amt PACKED(7:2);
END-DS;
DCL-S pgm CHAR(10) INZ('PGMTYPES');
DCL-PR callTypes EXTPGM(pgm);
  c CHAR(8);
  v VARCHAR(20);
  i5 INT(5);
  i10 INT(10);
  i20 INT(20);
  u UNS(10);
  p PACKED(9:2);
  z ZONED(7:2);
  f FLOAT(8);
  flag IND;
  d DATE;
  t TIME;
  ts TIMESTAMP;
  rec LIKEDS(rec_t);
  k CHAR(4) CONST;
END-PR;
DCL-S c CHAR(8) INZ('abc');
DCL-S v VARCHAR(20) INZ('hello');
DCL-S i5 INT(5) INZ(123);
DCL-S i10 INT(10) INZ(-40000);
DCL-S i20 INT(20) INZ(900000);
DCL-S u UNS(10) INZ(4000000000);
DCL-S p PACKED(9:2) INZ(1234.56);
DCL-S z ZONED(7:2) INZ(-12.34);
DCL-S f FLOAT(8) INZ(10);
DCL-S flag IND INZ(*ON);
DCL-S d DATE INZ(D'2024-02-28');
DCL-S t TIME INZ(T'23.15.00');
DCL-S ts TIMESTAMP INZ(Z'2024-12-31-23.59.59.000000');
DCL-DS rec LIKEDS(rec_t);

flag = *ON;
rec.code = 'OLD';
rec.qty = 10;
rec.amt = 99.5;
callTypes(c : v : i5 : i10 : i20 : u : p : z : f : flag : d : t : ts : rec : 'KEY1');
DSPLY ('c=[' + c + '] v=[' + v + ']');
DSPLY ('i5=' + %CHAR(i5) + ' i10=' + %CHAR(i10) + ' i20=' + %CHAR(i20));
DSPLY ('u=' + %CHAR(u) + ' p=' + %CHAR(p) + ' z=' + %CHAR(z));
DSPLY ('f=' + %CHAR(%INT(f * 100)));
IF NOT flag;
  DSPLY 'flag turned off';
ENDIF;
DSPLY ('d=' + %CHAR(d) + ' t=' + %CHAR(t));
DSPLY ('ts=' + %CHAR(ts));
DSPLY ('rec=' + rec.code + ' ' + %CHAR(rec.qty) + ' ' + %CHAR(rec.amt));
*INLR = *ON;
RETURN;
