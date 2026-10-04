**FREE
// INT(20) host variables are bound as BIGINT, so a value past 32 bits
// goes into the database and comes back whole.
DCL-S connStr VARCHAR(200);
DCL-S big INT(20) INZ(9000000000);
DCL-S back INT(20);

connStr = 'Driver={SQLite3};Database=/tmp/rpgc_test342.sqlite;';
/IF DEFINED(*OPENRPG)
EXEC SQL CONNECT USING :connStr;
/ENDIF
EXEC SQL DROP TABLE IF EXISTS big342;
EXEC SQL CREATE TABLE big342 (n BIGINT);
EXEC SQL INSERT INTO big342 VALUES(:big);
EXEC SQL SELECT n * 2 INTO :back FROM big342;
DSPLY %CHAR(back);
EXEC SQL DROP TABLE big342;
/IF DEFINED(*OPENRPG)
EXEC SQL DISCONNECT;
/ENDIF
*INLR = *ON;
RETURN;
