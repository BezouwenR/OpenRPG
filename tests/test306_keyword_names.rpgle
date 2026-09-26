**FREE
// IBM i reserves almost no words: fields may be named IND, TAG, TYPE,
// VALUE, CHAR, DATE -- or even IN, OUT and READ, which are operation
// codes. Such a name works everywhere, with two exceptions IBM makes: a
// statement that starts with an operation code is that operation, so
// assigning to OUT or IN(2) needs EVAL; and a subfield named like an
// operation code needs DCL-SUBF. Only NOT is refused outright.
DCL-S ind INT(10);
DCL-S tag CHAR(5) INZ('LBL');
DCL-S out INT(10);
DCL-S read INT(10);
DCL-S type CHAR(1);
DCL-S value PACKED(5:2);
DCL-S char VARCHAR(10);
DCL-S date DATE INZ(D'2026-09-26');
DCL-S in INT(10) DIM(3);
DCL-DS rec QUALIFIED;
  type CHAR(1);
  value INT(10);
  DCL-SUBF read INT(10);
  DCL-SUBF out CHAR(3);
END-DS;
DCL-S line VARCHAR(52);
ind = 7;
type = 'A';
value = 1.25;
char = 'txt';
EVAL out = 6;
EVAL read = 9;
EVAL in(2) = 4;
rec.type = 'B';
rec.read = 11;
rec.out = 'xyz';
rec.value = in(2) + read;
line = %CHAR(ind) + tag + %CHAR(out) + type + %CHAR(value) + char;
DSPLY line;
line = rec.type + %CHAR(rec.read) + rec.out + %CHAR(rec.value) + %CHAR(date);
DSPLY line;
IF type = 'A' AND ind > 0;
  DSPLY 'if ok';
ENDIF;
*INLR = *ON;
