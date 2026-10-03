**FREE
// Data structure subfields as host variables: :ds.subfield for a QUALIFIED
// data structure, :subfield for one that isn't, as INTO targets and as
// input values. A host structure leaves out its OVERLAY subfields.
DCL-S connStr VARCHAR(200);
DCL-DS rec QUALIFIED;
  txt CHAR(4);
  num ZONED(4:0) OVERLAY(txt);
END-DS;
DCL-DS u;
  code CHAR(3);
  qty INT(10);
END-DS;
DCL-DS whole QUALIFIED;
  id INT(10);
  name CHAR(8);
  first CHAR(1) OVERLAY(name);
END-DS;

connStr = 'Driver={SQLite3};Database=/tmp/rpgc_test328.sqlite;';
/IF DEFINED(*OPENRPG)
EXEC SQL CONNECT USING :connStr;
/ENDIF
EXEC SQL DROP TABLE IF EXISTS sf328;
EXEC SQL CREATE TABLE sf328 (id INTEGER, code CHAR(3), name VARCHAR(8), qty INTEGER);
EXEC SQL INSERT INTO sf328 VALUES(1, 'ABC', 'Widget', 42);

EXEC SQL SELECT '0042' INTO :rec.txt FROM sf328;
DSPLY rec.txt;
DSPLY %CHAR(rec.num);

EXEC SQL SELECT code, qty INTO :code, :qty FROM sf328 WHERE id = 1;
DSPLY (code + ' ' + %CHAR(qty));

qty = 7;
EXEC SQL UPDATE sf328 SET qty = :qty WHERE code = :code;
rec.txt = '0001';
EXEC SQL SELECT qty INTO :u.qty FROM sf328 WHERE id = :rec.num;
DSPLY %CHAR(qty);

EXEC SQL SELECT id, name INTO :whole FROM sf328;
DSPLY (%CHAR(whole.id) + ' ' + whole.name + ' ' + whole.first);

EXEC SQL DROP TABLE sf328;
/IF DEFINED(*OPENRPG)
EXEC SQL DISCONNECT;
/ENDIF
*INLR = *ON;
RETURN;
