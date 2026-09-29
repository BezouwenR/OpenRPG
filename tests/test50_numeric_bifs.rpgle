**FREE
// Test 50: Numeric BIFs - %UNS, %INTH, %DECH, %DECPOS
DCL-S val PACKED(7:2);
DCL-S result INT(10);
DCL-S uval INT(10);
DCL-S dpos INT(10);
DCL-S z ZONED(9:4) INZ(1.5);
DCL-S line VARCHAR(52);

val = 3.456;

// %INTH - integer with half-adjust (rounding)
result = %INTH(val);
DSPLY %CHAR(result);

// %DECH - decimal with half-adjust
val = %DECH(3.456 : 7 : 1);
DSPLY %CHAR(val);

// %DECPOS - the DECLARED decimal positions of its operand, a constant:
// val is PACKED(7:2), so 2, whatever value it holds. A literal has the
// positions written; + and - the larger of their operands', * the sum.
dpos = %DECPOS(val);
DSPLY %CHAR(dpos);
line = %CHAR(%DECPOS(z)) + ' ' + %CHAR(%DECPOS(1.50)) + ' ' +
       %CHAR(%DECPOS(val + z)) + ' ' + %CHAR(%DECPOS(val * z)) + ' ' +
       %CHAR(%DECPOS(%DEC(val : 9 : 3)));
DSPLY line;

// %UNS - convert to uvaligned integer
uval = %UNS(42);
DSPLY %CHAR(uval);

*INLR = *ON;
