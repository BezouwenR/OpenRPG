**FREE
// TEST(DE) on a qualified subfield, an unqualified subfield and an
// array element.
DCL-DS d QUALIFIED;
  txt CHAR(8);
END-DS;
DCL-DS u;
  utxt CHAR(10);
END-DS;
DCL-S arr CHAR(8) DIM(2);

d.txt = '20240231';
TEST(DE) *ISO0 d.txt;
IF %ERROR;
  DSPLY 'd.txt: bad date';
ENDIF;
d.txt = '20240229';
TEST(DE) *ISO0 d.txt;
IF NOT %ERROR;
  DSPLY 'd.txt: good date';
ENDIF;

utxt = '2024-13-01';
TEST(DE) utxt;
IF %ERROR;
  DSPLY 'utxt: bad date';
ENDIF;

arr(2) = '20241231';
TEST(DE) *ISO0 arr(2);
IF NOT %ERROR;
  DSPLY 'arr(2): good date';
ENDIF;
*INLR = *ON;
RETURN;
