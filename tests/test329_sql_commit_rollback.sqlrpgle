**FREE
// Commitment control, the default COMMIT(*CHG): ROLLBACK undoes the
// changes since the last COMMIT, and COMMIT keeps them.
DCL-S connStr VARCHAR(200);
DCL-S age INT(10);

connStr = 'Driver={SQLite3};Database=/tmp/rpgc_test329.sqlite;';
/IF DEFINED(*OPENRPG)
EXEC SQL CONNECT USING :connStr;
/ENDIF
EXEC SQL DROP TABLE IF EXISTS emp329;
EXEC SQL CREATE TABLE emp329 (id INTEGER, age INTEGER);
EXEC SQL INSERT INTO emp329 VALUES(1, 30);
EXEC SQL COMMIT;

EXEC SQL UPDATE emp329 SET age = 1 WHERE id = 1;
EXEC SQL SELECT age INTO :age FROM emp329 WHERE id = 1;
DSPLY ('before rollback ' + %CHAR(age));
EXEC SQL ROLLBACK;
DSPLY ('rollback SQLCOD ' + %CHAR(SQLCOD));
EXEC SQL SELECT age INTO :age FROM emp329 WHERE id = 1;
DSPLY ('after rollback ' + %CHAR(age));

EXEC SQL UPDATE emp329 SET age = 31 WHERE id = 1;
EXEC SQL COMMIT;
EXEC SQL ROLLBACK;
EXEC SQL SELECT age INTO :age FROM emp329 WHERE id = 1;
DSPLY ('after commit ' + %CHAR(age));

EXEC SQL DROP TABLE emp329;
EXEC SQL COMMIT;
/IF DEFINED(*OPENRPG)
EXEC SQL DISCONNECT;
/ENDIF
*INLR = *ON;
RETURN;
