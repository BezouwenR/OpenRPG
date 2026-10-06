**FREE
// Several names in one DCL-S, an OpenRPG extension: DCL-S a b c INT(10)
// declares each the same way, keywords and INZ included -- with a type,
// with LIKE, as arrays, and inside a procedure.
DCL-S a b c INT(10) INZ(7);
DCL-S first last VARCHAR(20);
DCL-S n1 n2 PACKED(7:2) DIM(3);
DCL-S x y LIKE(a);
DCL-S on1 on2 IND INZ(*ON);
a += 1;
first = 'Ada';
last = 'Lovelace';
n2(3) = 12.5;
y = c + 1;
DSPLY (%CHAR(a) + ' ' + %CHAR(b) + ' ' + %CHAR(c));
DSPLY (first + ' ' + last);
DSPLY (%CHAR(n1(3)) + ' ' + %CHAR(n2(3)) + ' ' + %CHAR(%ELEM(n1)));
DSPLY (%CHAR(x) + ' ' + %CHAR(y));
IF on1 AND on2;
  DSPLY 'both on';
ENDIF;
DSPLY %CHAR(sum(2));
*INLR = *ON;
RETURN;

DCL-PROC sum;
  DCL-PI *N INT(10);
    k INT(10) VALUE;
  END-PI;
  DCL-S i j t INT(10);
  FOR i = 1 TO k;
    j = i * 10;
    t += j;
  ENDFOR;
  RETURN t;
END-PROC;
