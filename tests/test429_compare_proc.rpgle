**FREE
// A comparison procedure for SORTA and %LOOKUPxx, an OpenRPG extension:
// SORTA array %PADDR(proc), %LOOKUPxx(arg : array {: start : count} :
// %PADDR(proc)). The procedure returns below 0, 0 or above 0, as qsort's.
DCL-DS item QUALIFIED TEMPLATE;
  name CHAR(10);
  qty INT(10);
END-DS;
DCL-DS items LIKEDS(item) DIM(4);
DCL-DS want LIKEDS(item);
DCL-S words VARCHAR(10) DIM(4);
DCL-S i INT(10);
items(1).name = 'pear';
items(1).qty = 5;
items(2).name = 'Apple';
items(2).qty = 9;
items(3).name = 'fig';
items(3).qty = 1;
items(4).name = 'BANANA';
items(4).qty = 3;
SORTA items %PADDR(byQty);
FOR i = 1 TO 4;
  DSPLY (%CHAR(items(i).qty) + ' ' + items(i).name);
ENDFOR;
want.qty = 9;
DSPLY %CHAR(%LOOKUP(want : items : 1 : 4 : %PADDR(byQty)));
want.qty = 4;
DSPLY %CHAR(%LOOKUPLT(want : items : 1 : 4 : %PADDR(byQty)));
words(1) = 'pear';
words(2) = 'Apple';
words(3) = 'fig';
words(4) = 'BANANA';
SORTA words %PADDR(noCase);
DSPLY (words(1) + ' ' + words(2) + ' ' + words(3) + ' ' + words(4));
DSPLY %CHAR(%LOOKUP('apple' : words : %PADDR(noCase)));
*INLR = *ON;
RETURN;

DCL-PROC byQty;
  DCL-PI *N INT(10);
    a LIKEDS(item) CONST;
    b LIKEDS(item) CONST;
  END-PI;
  IF a.qty < b.qty;
    RETURN -1;
  ELSEIF a.qty > b.qty;
    RETURN 1;
  ENDIF;
  RETURN 0;
END-PROC;

DCL-PROC noCase;
  DCL-PI *N INT(10);
    a VARCHAR(10) CONST;
    b VARCHAR(10) CONST;
  END-PI;
  IF %UPPER(a) < %UPPER(b);
    RETURN -1;
  ELSEIF %UPPER(a) > %UPPER(b);
    RETURN 1;
  ENDIF;
  RETURN 0;
END-PROC;
