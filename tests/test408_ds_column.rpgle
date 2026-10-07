**FREE
// ds(*).subfield, a data structure array's subfield across its elements:
// SORTA orders the elements by it, and %LOOKUP searches it. And %CHAR of
// %XFOOT of a PACKED array has the array's decimal places.
DCL-DS ord QUALIFIED DIM(4);
  id INT(10);
  cust CHAR(5);
  amt PACKED(7:2);
END-DS;
DCL-S i INT(10);
DCL-S pk PACKED(7:2) DIM(2) INZ(1.5);
ord(1).id = 40;
ord(1).cust = 'DD';
ord(1).amt = 12.50;
ord(2).id = 10;
ord(2).cust = 'BB';
ord(2).amt = 100;
ord(3).id = 30;
ord(3).cust = 'AA';
ord(3).amt = 7.25;
ord(4).id = 20;
ord(4).cust = 'CC';
ord(4).amt = 30;
DSPLY %CHAR(%LOOKUP('AA' : ord(*).cust));
DSPLY %CHAR(%LOOKUP(99 : ord(*).id));
SORTA ord(*).id;
FOR i = 1 TO %ELEM(ord);
  DSPLY (%CHAR(ord(i).id) + ' ' + ord(i).cust);
ENDFOR;
SORTA ord(*).cust;
DSPLY (ord(1).cust + ' ' + ord(4).cust);
DSPLY %CHAR(%XFOOT(pk));
*INLR = *ON;
RETURN;
