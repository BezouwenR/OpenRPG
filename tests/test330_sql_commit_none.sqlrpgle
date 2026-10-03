**FREE
// SET OPTION COMMIT = *NONE: no commitment control, so each statement is
// committed as it runs and ROLLBACK has nothing to undo.
EXEC SQL SET OPTION COMMIT = *NONE, DATFMT = *ISO;
DCL-S connStr VARCHAR(200);
DCL-S age INT(10);

connStr = 'Driver={SQLite3};Database=/tmp/rpgc_test330.sqlite;';
/IF DEFINED(*OPENRPG)
EXEC SQL CONNECT USING :connStr;
/ENDIF
EXEC SQL DROP TABLE IF EXISTS emp330;
EXEC SQL CREATE TABLE emp330 (id INTEGER, age INTEGER);
EXEC SQL INSERT INTO emp330 VALUES(1, 30);
EXEC SQL UPDATE emp330 SET age = 1 WHERE id = 1;
EXEC SQL ROLLBACK;
EXEC SQL SELECT age INTO :age FROM emp330 WHERE id = 1;
DSPLY ('after rollback ' + %CHAR(age));
EXEC SQL DROP TABLE emp330;
/IF DEFINED(*OPENRPG)
EXEC SQL DISCONNECT;
/ENDIF
*INLR = *ON;
RETURN;
