**FREE
// A NULL fetched into a host variable with no null indicator is SQLCODE
// -305, SQLSTATE 22002, and leaves the variable as it was. With an
// indicator it is -1 and the fetch succeeds.
DCL-S connStr VARCHAR(200);
DCL-S d CHAR(10) INZ('XXXXXXXXXX');
DCL-S n INT(10) INZ(99);
DCL-S ind INT(5);
DCL-S id INT(10);

connStr = 'Driver={SQLite3};Database=/tmp/rpgc_test331.sqlite;';
/IF DEFINED(*OPENRPG)
EXEC SQL CONNECT USING :connStr;
/ENDIF
EXEC SQL DROP TABLE IF EXISTS nul331;
EXEC SQL CREATE TABLE nul331 (id INTEGER, txt VARCHAR(10), num INTEGER);
EXEC SQL INSERT INTO nul331 VALUES(1, 'one', 10);
EXEC SQL INSERT INTO nul331 VALUES(2, NULL, NULL);

EXEC SQL SELECT txt INTO :d FROM nul331 WHERE id = 2;
DSPLY ('char: [' + d + '] ' + %CHAR(SQLCOD) + ' ' + SQLSTT);
EXEC SQL SELECT num INTO :n FROM nul331 WHERE id = 2;
DSPLY ('int: ' + %CHAR(n) + ' ' + %CHAR(SQLCOD) + ' ' + SQLSTT);
EXEC SQL SELECT num INTO :n :ind FROM nul331 WHERE id = 2;
DSPLY ('ind: ' + %CHAR(n) + ' ' + %CHAR(ind) + ' ' + %CHAR(SQLCOD));

EXEC SQL DECLARE c1 CURSOR FOR SELECT id, num FROM nul331 ORDER BY id;
EXEC SQL OPEN c1;
EXEC SQL FETCH c1 INTO :id, :n;
DOW SQLCOD = 0;
  DSPLY ('row ' + %CHAR(id) + ': ' + %CHAR(n));
  EXEC SQL FETCH c1 INTO :id, :n;
ENDDO;
DSPLY ('fetch ended ' + %CHAR(SQLCOD) + ' at row ' + %CHAR(id));
EXEC SQL CLOSE c1;

EXEC SQL DROP TABLE nul331;
/IF DEFINED(*OPENRPG)
EXEC SQL DISCONNECT;
/ENDIF
*INLR = *ON;
RETURN;
